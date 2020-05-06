Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380881C7C02
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgEFVKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 17:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbgEFVKU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 17:10:20 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6682076D;
        Wed,  6 May 2020 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588799420;
        bh=zki508vDte8jI4EKebOmcvesA3luXzs60n8vNDoAJj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=edtLBBPcqWjnDxL5cTONTtcf0+s4af1kkpqPbPXwjFev7IJhxQbnABP2Vp6OxVH15
         djW1S/4/Az8Gy2EDn9MC6IHzl/lpbCzO8BMKyVzuXmIHt/S0pugN+RTLYK6m6O91Km
         ufexdmpugeboApXPZ5DSguh/+4Px+1Zdv85P9ojc=
Date:   Wed, 6 May 2020 16:10:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [RFC 1/2] PCI/IOV: Introduce pci_iov_sysfs_link() function
Message-ID: <20200506211018.GA454697@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506154139.90609-2-schnelle@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 05:41:38PM +0200, Niklas Schnelle wrote:
> currently pci_iov_add_virtfn() scans the SR-IOV bars, adds the VF to the
> bus and also creates the sysfs links between the newly added VF and its
> parent PF.

s/currently/Currently/
s/bars/BARs/

> With pdev->no_vf_scan fencing off the entire pci_iov_add_virtfn() call
> s390 as the sole pdev->no_vf_scan user thus ends up missing these sysfs
> links which are required for example by QEMU/libvirt.
> Instead of duplicating the code introduce a new pci_iov_sysfs_link()
> function for establishing sysfs links.

This looks like two paragraphs missing the blank line between.

This whole thing is not "introducing" any new functionality; it's
"refactoring" to move existing functionality around and make it
callable separately.

> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

With the fixes above and a few below:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/iov.c   | 36 ++++++++++++++++++++++++------------
>  include/linux/pci.h |  8 ++++++++
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4d1f392b05f9..d0ddf5f5484c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -113,7 +113,6 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>  static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  {
>  	struct pci_dev *physfn = virtfn->physfn;
> -
>  	/*
>  	 * Some config registers are the same across all associated VFs.
>  	 * Read them once from VF0 so we can skip reading them from the
> @@ -133,12 +132,34 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  			     &physfn->sriov->subsystem_device);
>  }
>  
> +int pci_iov_sysfs_link(struct pci_dev *dev,
> +		struct pci_dev *virtfn, int id)
> +{
> +	int rc;
> +	char buf[VIRTFN_ID_LEN];

Swap the order so these are declared in the order they're used below.

> +	sprintf(buf, "virtfn%u", id);
> +	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
> +	if (rc)
> +		goto failed;
> +	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
> +	if (rc)
> +		goto failed1;
> +
> +	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
> +
> +	return 0;

Add a blank link here to separate the "success" return from the error
paths.

> +failed1:
> +	sysfs_remove_link(&dev->dev.kobj, buf);
> +failed:
> +	return rc;
> +}
> +
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	int i;
>  	int rc = -ENOMEM;
>  	u64 size;
> -	char buf[VIRTFN_ID_LEN];
>  	struct pci_dev *virtfn;
>  	struct resource *res;
>  	struct pci_sriov *iov = dev->sriov;
> @@ -182,23 +203,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	}
>  
>  	pci_device_add(virtfn, virtfn->bus);
> -
> -	sprintf(buf, "virtfn%u", id);
> -	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
> +	rc = pci_iov_sysfs_link(dev, virtfn, id);
>  	if (rc)
>  		goto failed1;
> -	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
> -	if (rc)
> -		goto failed2;
> -
> -	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>  
>  	pci_bus_add_device(virtfn);
>  
>  	return 0;
>  
> -failed2:
> -	sysfs_remove_link(&dev->dev.kobj, buf);
>  failed1:
>  	pci_stop_and_remove_bus_device(virtfn);
>  	pci_dev_put(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 83ce1cdf5676..e97d27ac350a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2048,6 +2048,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>  
>  int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>  void pci_disable_sriov(struct pci_dev *dev);
> +
> +int pci_iov_sysfs_link(struct pci_dev *dev, struct pci_dev *virtfn, int id);
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id);
>  void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
>  int pci_num_vf(struct pci_dev *dev);
> @@ -2073,6 +2075,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
>  }
>  static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>  { return -ENODEV; }
> +
> +static inline int pci_iov_sysfs_link(struct pci_dev *dev,
> +		struct pci_dev *virtfn, int id)

Align the second line with the args in the first line, as the rest of
this file does.

> +{
> +	return -ENODEV;
> +}
>  static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	return -ENOSYS;
> -- 
> 2.17.1
> 
