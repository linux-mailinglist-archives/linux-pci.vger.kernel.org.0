Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1425E7BA97D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjJESxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjJESxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:53:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7D98;
        Thu,  5 Oct 2023 11:53:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D027C433C7;
        Thu,  5 Oct 2023 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531997;
        bh=chYFievT/u2R2Xpv24rtGTlpheFGgMYWE/+zxnqxkdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RrzGi5/URDgDNTXjNM5T2qbqstYXXCkWKLk/hQALtR15Na0VYXcuRRnBSrL4bgKR0
         tgXsaksM2u/HeVdwbBR+p6xdFxOkIGpFMSnqRez4j31QSA7CJD+1OOZejWJeVjpsNZ
         w7K9D2Nd/3ZnOinKGaunyb2FFSu8Mq8mWmeWZuMGaFubwvhW1Zz5uUBxvEk6B9TtqJ
         zq5qo7/lSKtLXIGUtY5vUhihWKRFFnhXH7XshwH4X7tYYwXGAoxQ6OW1e/6BwEFdzJ
         mGCquss2yWEWZPeq5wfR+N8Rnh4hALOKnfXtTsaSGmufhHMyDjVNoQAF9YTXhk61Os
         shl7rhcepBH3w==
Date:   Thu, 5 Oct 2023 13:53:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: Make d3cold_allowed sysfs attribute read only
Message-ID: <20231005185315.GA785324@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004144731.158342-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 04, 2023 at 09:47:31AM -0500, Mario Limonciello wrote:
> Before d3cold was stable userspace was allowed to influence the kernel's
> decision of whether to enable d3cold for a device by a sysfs file
> `d3cold_allowed`.  This potentially allows userspace to break the suspend
> for the system.

Is "Before d3cold was stable" referring to a "d3cold" read-only
variable, or to Linux functionality of using D3cold, or ...?

In what sense does the `d3cold_allowed` sysfs file break suspend?

> For debugging purposes `pci_port_pm=` can be used to control whether
> a PCI port will go into D3cold and runtime PM can be turned off by
> sysfs on PCI end points.

I guess this should be "pcie_port_pm=", which affects *all* PCIe
ports?

Which sysfs file turns off runtime PM for endpoints?

> Change the sysfs attribute to a noop that ignores the input when written
> and shows a warning. Simplify the internal kernel logic to drop
> `d3cold_allowed`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Leave R/W and show a warning instead
>  * Mark deprecated in sysfs file
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
>  drivers/pci/pci-acpi.c                  |  2 +-
>  drivers/pci/pci-sysfs.c                 | 14 ++------------
>  drivers/pci/pci.c                       |  3 +--
>  include/linux/pci.h                     |  1 -
>  5 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..b5db141dfee6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -283,8 +283,8 @@ Description:
>  		device will never be put into D3Cold state.  If it is set, the
>  		device may be put into D3Cold state if other requirements are
>  		satisfied too.  Reading this attribute will show the current
> -		value of d3cold_allowed bit.  Writing this attribute will set
> -		the value of d3cold_allowed bit.
> +		value of no_d3cold bit.
> +		Writing to this attribute is deprecated and will do nothing.
>  
>  What:		/sys/bus/pci/devices/.../sriov_totalvfs
>  Date:		November 2012
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 05b7357bd258..a05350a4e49c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	int acpi_state, d_max;
>  
> -	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> +	if (pdev->no_d3cold)
>  		d_max = ACPI_STATE_D3_HOT;
>  	else
>  		d_max = ACPI_STATE_D3_COLD;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5e741a05cf2c..52ed5a55a371 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -523,17 +523,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	unsigned long val;
> -
> -	if (kstrtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> -
> -	pdev->d3cold_allowed = !!val;
> -	pci_bridge_d3_update(pdev);
> -
> -	pm_runtime_resume(dev);
> -
> +	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
>  	return count;
>  }
>  
> @@ -541,7 +531,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
> +	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
>  }
>  static DEVICE_ATTR_RW(d3cold_allowed);
>  #endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..8c5a6f68f63d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  	bool *d3cold_ok = data;
>  
>  	if (/* The device needs to be allowed to go D3cold ... */
> -	    dev->no_d3cold || !dev->d3cold_allowed ||
> +	    dev->no_d3cold ||
>  
>  	    /* ... and if it is wakeup capable to do so from D3cold. */
>  	    (device_may_wakeup(&dev->dev) &&
> @@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
>  	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
>  	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
> -	dev->d3cold_allowed = true;
>  
>  	dev->d1_support = false;
>  	dev->d2_support = false;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8c7c2c3c6c65..5f4ed71d31f5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,7 +376,6 @@ struct pci_dev {
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
> -	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>  						   decoding during BAR sizing */
>  	unsigned int	wakeup_prepared:1;
> -- 
> 2.34.1
> 
