Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711AA2B84D4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 20:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKRTTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 14:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgKRTTr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:47 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57492220B;
        Wed, 18 Nov 2020 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605727186;
        bh=+vCg2cTrD1FXbmMLSvG1YF4SqbXakoCgibjeJ3KjlP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=poiuzvtHd/JMBekZ2gJQCGvhVMGOID7A9y5s/zmLnmpix57OBUrI3gXFZ7mU+gWto
         J4fVU1IzX9TPZQhAhUThZd6Xb/2s0rIzIbbw8tV9xw6bcWZHPoCA1Mqo1RYX7L4aki
         O2CaL8ZJQcvkyQiAs5Jc0VKFlQcV46cUi8OnszEA=
Date:   Wed, 18 Nov 2020 13:19:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
Message-ID: <20201118191944.GA74259@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102141520.831630-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof, Rafael in case you have a suggestion about the
filename (or anythnig else :))]

On Mon, Nov 02, 2020 at 03:15:20PM +0100, Maximilian Luz wrote:
> While most PCI power-states can be queried from user-space via lspci,
> this has some limits. Specifically, lspci fails to provide an accurate
> value when the device is in D3cold as it has to resume the device before
> it can access its power state via the configuration space, leading to it
> reporting D0 or another on-state. Thus lspci can, for example, not be
> used to diagnose power-consumption issues for devices that can enter
> D3cold or to ensure that devices properly enter D3cold at all.
> 
> To alleviate this issue, introduce a new sysfs device attribute for the
> PCI power state, showing the current power state as seen by the kernel.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Applied as below to pci/pm for v5.11.

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 450296cc7948..881040af2611 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -360,3 +360,12 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
>  Description:	If ASPM is supported for an endpoint, these files can be
>  		used to disable or enable the individual power management
>  		states. Write y/1/on to enable, n/0/off to disable.
> +
> +What:		/sys/bus/pci/devices/.../power_state

I guess this will be alongside the existing "power/" directory.
Rafael, is there any precedent we should be following here?

> +Date:		November 2020
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This file contains the current PCI power state of the device.
> +		The value comes from the PCI kernel device state and can be one
> +		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
> +		The file is read only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d15c881e2e7e..b15f754e6346 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -124,6 +124,17 @@ static ssize_t cpulistaffinity_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(cpulistaffinity);
>  
> +/* PCI power state */
> +static ssize_t power_state_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	pci_power_t state = READ_ONCE(pci_dev->current_state);
> +
> +	return sprintf(buf, "%s\n", pci_power_name(state));
> +}
> +static DEVICE_ATTR_RO(power_state);
> +
>  /* show resources */
>  static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
> @@ -581,6 +592,7 @@ static ssize_t driver_override_show(struct device *dev,
>  static DEVICE_ATTR_RW(driver_override);
>  
>  static struct attribute *pci_dev_attrs[] = {
> +	&dev_attr_power_state.attr,
>  	&dev_attr_resource.attr,
>  	&dev_attr_vendor.attr,
>  	&dev_attr_device.attr,

commit 9f1c0ebea21a ("PCI: Add sysfs attribute for device power state")
Author: Maximilian Luz <luzmaximilian@gmail.com>
Date:   Mon Nov 2 15:15:20 2020 +0100

    PCI: Add sysfs attribute for device power state
    
    While PCI power states D0-D3hot can be queried from user-space via lspci,
    D3cold cannot.  lspci cannot provide an accurate value when the device is
    in D3cold as it has to restore the device to D0 before it can access its
    power state via the configuration space, leading to it reporting D0 or
    another on-state. Thus lspci cannot be used to diagnose power consumption
    issues for devices that can enter D3cold or to ensure that devices properly
    enter D3cold at all.
    
    Add a new sysfs device attribute for the PCI power state, showing the
    current power state as seen by the kernel.
    
    [bhelgaas: drop READ_ONCE(), see discussion at the link]
    Link: https://lore.kernel.org/r/20201102141520.831630-1-luzmaximilian@gmail.com
    Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 450296cc7948..881040af2611 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -360,3 +360,12 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
 Description:	If ASPM is supported for an endpoint, these files can be
 		used to disable or enable the individual power management
 		states. Write y/1/on to enable, n/0/off to disable.
+
+What:		/sys/bus/pci/devices/.../power_state
+Date:		November 2020
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This file contains the current PCI power state of the device.
+		The value comes from the PCI kernel device state and can be one
+		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
+		The file is read only.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d15c881e2e7e..fb072f4b3176 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -124,6 +124,15 @@ static ssize_t cpulistaffinity_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cpulistaffinity);
 
+static ssize_t power_state_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%s\n", pci_power_name(pdev->current_state));
+}
+static DEVICE_ATTR_RO(power_state);
+
 /* show resources */
 static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -581,6 +590,7 @@ static ssize_t driver_override_show(struct device *dev,
 static DEVICE_ATTR_RW(driver_override);
 
 static struct attribute *pci_dev_attrs[] = {
+	&dev_attr_power_state.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
