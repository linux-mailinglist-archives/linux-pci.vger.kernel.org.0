Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF41C7C0E
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgEFVMR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 17:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgEFVMQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 17:12:16 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24BC2075E;
        Wed,  6 May 2020 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588799536;
        bh=LHfljle6cEyxnYKirXiuZPRTdcB4po4vvn7PQ093hKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h1we/HgRwNZMpzSWYzK19H6htYEff1g/pAAVOLu8ux6MY0BNciptGD7hXpiRrbEvS
         E/Q8UYl8yC7QXUGthU6Wq+baxM8CAXsk8EomP6NNTVhZ66wLu2Q0TN9P8rj6h0TYAY
         /vYeSx1GoCyFex4n+LYQaeRFj1z7Jda/cGZ66ZlM=
Date:   Wed, 6 May 2020 16:12:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [RFC 2/2] s390/pci: create links between PFs and VFs
Message-ID: <20200506211213.GA454947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506154139.90609-3-schnelle@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 05:41:39PM +0200, Niklas Schnelle wrote:
> On s390 PCI Virtual Functions (VFs) are scanned by firmware and are made
> available to Linux via the hot-plug interface. As such the common code
> path of doing the scan directly using the parent Physical Function (PF)
> is not used and fenced off with the no_vf_scan attribute.
> 
> Even if the partition created the VFs itself e.g. using the sriov_numvfs
> attribute of a PF, the PF/VF links thus need to be established after the
> fact. To do this when a VF is plugged we scan through all functions on
> the same zbus and test whether they are the parent PF in which case we
> establish the necessary links.
> 
> With these links established there is now no more need to fence off
> pci_iov_remove_virtfn() for pdev->no_vf_scan as the common code now
> works fine.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume these will go via the s390 tree.

> ---
>  arch/s390/include/asm/pci.h     |  3 +-
>  arch/s390/include/asm/pci_clp.h |  3 +-
>  arch/s390/pci/pci_bus.c         | 69 ++++++++++++++++++++++++++++++++-
>  arch/s390/pci/pci_clp.c         |  1 +
>  drivers/pci/iov.c               |  3 --
>  5 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c1558cf071b8..99b92c3e46b0 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -131,7 +131,8 @@ struct zpci_dev {
>  	u8		port;
>  	u8		rid_available	: 1;
>  	u8		has_hp_slot	: 1;
> -	u8		reserved	: 6;
> +	u8		is_physfn	: 1;
> +	u8		reserved	: 5;
>  	unsigned int	devfn;		/* DEVFN part of the RID*/
>  
>  	struct mutex lock;
> diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
> index 896ee41e23e3..1651b5610b0f 100644
> --- a/arch/s390/include/asm/pci_clp.h
> +++ b/arch/s390/include/asm/pci_clp.h
> @@ -95,7 +95,8 @@ struct clp_rsp_query_pci {
>  	u16 vfn;			/* virtual fn number */
>  	u16			:  3;
>  	u16 rid_avail		:  1;
> -	u16			:  2;
> +	u16 is_physfn		:  1;
> +	u16 reserved		:  1;
>  	u16 mio_addr_avail	:  1;
>  	u16 util_str_avail	:  1;	/* utility string available? */
>  	u16 pfgid		:  8;	/* pci function group id */
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 542c6b8f56df..52d79a2f6722 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -126,6 +126,64 @@ static struct zpci_bus *zpci_bus_alloc(int pchid)
>  	return zbus;
>  }
>  
> +#ifdef CONFIG_PCI_IOV
> +static int zpci_bus_link_virtfn(struct pci_dev *pdev,
> +		struct pci_dev *virtfn, int vfid)
> +{
> +	int rc;
> +
> +	virtfn->physfn = pci_dev_get(pdev);
> +	rc = pci_iov_sysfs_link(pdev, virtfn, vfid);
> +	if (rc) {
> +		pci_dev_put(pdev);
> +		virtfn->physfn = NULL;
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +static int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
> +		struct pci_dev *virtfn, int vfn)
> +{
> +	int i, cand_devfn;
> +	struct zpci_dev *zdev;
> +	struct pci_dev *pdev;
> +	int vfid = vfn - 1; /* Linux' vfid's start at 0 vfn at 1*/
> +	int rc = 0;
> +
> +	virtfn->is_virtfn = 1;
> +	virtfn->multifunction = 0;
> +	WARN_ON(vfid < 0);
> +	/* If the parent PF for the given VF is also configured in the
> +	 * instance, it must be on the same zbus.
> +	 * We can then identify the parent PF by checking what
> +	 * devfn the VF would have if it belonged to that PF using the PF's
> +	 * stride and offset. Only if this candidate devfn matches the
> +	 * actual devfn will we link both functions.
> +	 */
> +	for (i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
> +		zdev = zbus->function[i];
> +		if (zdev && zdev->is_physfn) {
> +			pdev = pci_get_slot(zbus->bus, zdev->devfn);
> +			cand_devfn = pci_iov_virtfn_devfn(pdev, vfid);
> +			if (cand_devfn == virtfn->devfn) {
> +				rc = zpci_bus_link_virtfn(pdev, virtfn, vfid);
> +				break;
> +			}
> +		}
> +	}
> +	return rc;
> +}
> +#else
> +static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
> +		struct pci_dev *virtfn, int vfn)
> +{
> +	virtfn->is_virtfn = 1;
> +	virtfn->multifunction = 0;
> +	return 0;
> +}
> +#endif
> +
>  static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
>  {
>  	struct pci_bus *bus;
> @@ -157,11 +215,20 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
>  
>  	pdev = pci_scan_single_device(bus, zdev->devfn);
>  	if (pdev) {
> -		pdev->multifunction = 1;
> +		if (!zdev->is_physfn) {
> +			rc = zpci_bus_setup_virtfn(zbus, pdev, zdev->vfn);
> +			if (rc)
> +				goto failed_with_pdev;
> +		}
>  		pci_bus_add_device(pdev);
>  	}
>  
>  	return 0;
> +
> +failed_with_pdev:
> +	pci_stop_and_remove_bus_device(pdev);
> +	pci_dev_put(pdev);
> +	return rc;
>  }
>  
>  static void zpci_bus_add_devices(struct zpci_bus *zbus)
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index 9b318824a134..d7bd3c287cf7 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -159,6 +159,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>  	zdev->uid = response->uid;
>  	zdev->fmb_length = sizeof(u32) * response->fmb_len;
>  	zdev->rid_available = response->rid_avail;
> +	zdev->is_physfn = response->is_physfn;
>  	if (!s390_pci_no_rid && zdev->rid_available)
>  		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
>  
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index d0ddf5f5484c..d932495b0407 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -569,9 +569,6 @@ static void sriov_del_vfs(struct pci_dev *dev)
>  	struct pci_sriov *iov = dev->sriov;
>  	int i;
>  
> -	if (dev->no_vf_scan)
> -		return;
> -
>  	for (i = 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
>  }
> -- 
> 2.17.1
> 
