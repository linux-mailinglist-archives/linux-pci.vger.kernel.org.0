Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5BE8A7B8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfHLUCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfHLUCE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:02:04 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C37920673;
        Mon, 12 Aug 2019 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640123;
        bh=1iKPUhavK+MTlJHimlDdhQ34FNEfPRzTef/ZKKFlY8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXbh/SS1CNOxRcoTvY/X66kQa5gNO40wsduM/MWkUacZmBkbblzM1kal0xoLJIHGc
         M3solCyVw/ZDqwSMkN7Bt5WCjB6IpIVKaIt1Wv7yui1mj1iktCnmyE2EW72CkdDefc
         +nRrrfbf+0cogykcRNu/O65ccQliGCur4HsENoYc=
Date:   Mon, 12 Aug 2019 15:02:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
Message-ID: <20190812200201.GC11785@google.com>
References: <20190811150802.2418-1-efremov@linux.com>
 <20190811150802.2418-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811150802.2418-3-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 06:07:57PM +0300, Denis Efremov wrote:
> This patch replaces local define PCI_BAR_COUNT with global
> PCI_STD_NUM_BARS.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  arch/s390/include/asm/pci.h     |  5 +----
>  arch/s390/include/asm/pci_clp.h |  6 +++---
>  arch/s390/pci/pci.c             | 16 ++++++++--------
>  arch/s390/pci/pci_clp.c         |  6 +++---
>  4 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index a2399eff84ca..3a06c264ea53 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -2,9 +2,6 @@
>  #ifndef __ASM_S390_PCI_H
>  #define __ASM_S390_PCI_H
>  
> -/* must be set before including pci_clp.h */
> -#define PCI_BAR_COUNT	6
> -
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
>  #include <linux/iommu.h>
> @@ -138,7 +135,7 @@ struct zpci_dev {
>  
>  	char res_name[16];
>  	bool mio_capable;
> -	struct zpci_bar_struct bars[PCI_BAR_COUNT];
> +	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
>  
>  	u64		start_dma;	/* Start of available DMA addresses */
>  	u64		end_dma;	/* End of available DMA addresses */
> diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
> index 50359172cc48..bd2cb4ea7d93 100644
> --- a/arch/s390/include/asm/pci_clp.h
> +++ b/arch/s390/include/asm/pci_clp.h
> @@ -77,7 +77,7 @@ struct mio_info {
>  	struct {
>  		u64 wb;
>  		u64 wt;
> -	} addr[PCI_BAR_COUNT];
> +	} addr[PCI_STD_NUM_BARS];
>  	u32 reserved[6];
>  } __packed;
>  
> @@ -98,9 +98,9 @@ struct clp_rsp_query_pci {
>  	u16 util_str_avail	:  1;	/* utility string available? */
>  	u16 pfgid		:  8;	/* pci function group id */
>  	u32 fid;			/* pci function id */
> -	u8 bar_size[PCI_BAR_COUNT];
> +	u8 bar_size[PCI_STD_NUM_BARS];
>  	u16 pchid;
> -	__le32 bar[PCI_BAR_COUNT];
> +	__le32 bar[PCI_STD_NUM_BARS];
>  	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
>  	u32			: 16;
>  	u8 fmb_len;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index b0e3b9a0e488..c57ccac25c02 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -43,7 +43,7 @@ static DECLARE_BITMAP(zpci_domain, ZPCI_NR_DEVICES);
>  static DEFINE_SPINLOCK(zpci_domain_lock);
>  
>  #define ZPCI_IOMAP_ENTRIES						\
> -	min(((unsigned long) ZPCI_NR_DEVICES * PCI_BAR_COUNT / 2),	\
> +	min(((unsigned long) ZPCI_NR_DEVICES * PCI_STD_NUM_BARS / 2),	\
>  	    ZPCI_IOMAP_MAX_ENTRIES)
>  
>  static DEFINE_SPINLOCK(zpci_iomap_lock);
> @@ -294,7 +294,7 @@ static void __iomem *pci_iomap_range_mio(struct pci_dev *pdev, int bar,
>  void __iomem *pci_iomap_range(struct pci_dev *pdev, int bar,
>  			      unsigned long offset, unsigned long max)
>  {
> -	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
> +	if (!pci_resource_len(pdev, bar) || bar >= PCI_STD_NUM_BARS)

The two conditions in this test should be reversed so we bounds check
"bar" before using it, i.e.,:

        if (bar >= PCI_STD_NUM_BARS || !pci_resource_len(pdev, bar))

That's not strictly related to the purpose of this patch, but it's so
trivial that I don't think it's worth splitting to a separate patch.

>  		return NULL;
>  
>  	if (static_branch_likely(&have_mio))
> @@ -324,7 +324,7 @@ static void __iomem *pci_iomap_wc_range_mio(struct pci_dev *pdev, int bar,
>  void __iomem *pci_iomap_wc_range(struct pci_dev *pdev, int bar,
>  				 unsigned long offset, unsigned long max)
>  {
> -	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
> +	if (!pci_resource_len(pdev, bar) || bar >= PCI_STD_NUM_BARS)

Same here.

>  		return NULL;
>  
>  	if (static_branch_likely(&have_mio))
> @@ -416,7 +416,7 @@ static void zpci_map_resources(struct pci_dev *pdev)
>  	resource_size_t len;
>  	int i;
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		len = pci_resource_len(pdev, i);
>  		if (!len)
>  			continue;

There's a loop just below here that should be rewritten in the typical
style:

        i = PCI_IOV_RESOURCES;
        for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
                len = pci_resource_len(pdev, i);

Again, not strictly related to this patch, but probably trivial enough
to do in the same patch.

> @@ -451,7 +451,7 @@ static void zpci_unmap_resources(struct pci_dev *pdev)
>  	if (zpci_use_mio(zdev))
>  		return;
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		len = pci_resource_len(pdev, i);
>  		if (!len)
>  			continue;

Completely unrelated to this patch, but the fact that
zpci_map_resources() deals with both standard BARs and SR-IOV BARs
while zpci_unmap_resources() only deals with standard BARs makes me
wonder why they're not symmetric.

It is true that zpci_map_resources() doesn't handle standard and
SR-IOV BARs similarly, so maybe this is intended.  Maybe the s390
folks know.

> @@ -514,7 +514,7 @@ static int zpci_setup_bus_resources(struct zpci_dev *zdev,
>  	snprintf(zdev->res_name, sizeof(zdev->res_name),
>  		 "PCI Bus %04x:%02x", zdev->domain, ZPCI_BUS_NR);
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (!zdev->bars[i].size)
>  			continue;
>  		entry = zpci_alloc_iomap(zdev);
> @@ -551,7 +551,7 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (!zdev->bars[i].size || !zdev->bars[i].res)
>  			continue;
>  
> @@ -573,7 +573,7 @@ int pcibios_add_device(struct pci_dev *pdev)
>  	pdev->dev.dma_ops = &s390_pci_dma_ops;
>  	zpci_map_resources(pdev);
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		res = &pdev->resource[i];
>  		if (res->parent || !res->flags)
>  			continue;
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index 9bdff4defef1..8b729b5f2972 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -145,7 +145,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>  {
>  	int i;
>  
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		zdev->bars[i].val = le32_to_cpu(response->bar[i]);
>  		zdev->bars[i].size = response->bar_size[i];
>  	}
> @@ -164,8 +164,8 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
>  		       sizeof(zdev->util_str));
>  	}
>  	zdev->mio_capable = response->mio_addr_avail;
> -	for (i = 0; i < PCI_BAR_COUNT; i++) {
> -		if (!(response->mio.valid & (1 << (PCI_BAR_COUNT - i - 1))))
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (!(response->mio.valid & (1 << (PCI_STD_NUM_BARS - i - 1))))
>  			continue;
>  
>  		zdev->bars[i].mio_wb = (void __iomem *) response->mio.addr[i].wb;
> -- 
> 2.21.0
> 
