Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A317C2830
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfI3VGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 17:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731976AbfI3VFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000C6224F0;
        Mon, 30 Sep 2019 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569872852;
        bh=RglR3ukwElynROQk+l4tg76X5Ve88igj5T4s3Uya3V4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AyhBGW2BD8aoBuP8uHPkEU0pNoy10LWHB1/Mi7A+TITCzHVAlpX8Lj3Dlm63Y1V34
         6GGm/gY/wdQwWVAs00lQOhTGcoWnItLl9B2B+/x89Udz2h7QquvnhFoawikAOeCFB2
         riwbdSExN2h7g1dZIQFBR2OsETDegxL6VHjmzQuI=
Date:   Mon, 30 Sep 2019 14:47:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3 06/26] s390/pci: Use PCI_STD_NUM_BARS
Message-ID: <20190930194724.GA188464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918085805.GY9720@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 18, 2019 at 09:58:06AM +0100, Andrew Murray wrote:
> On Mon, Sep 16, 2019 at 11:41:38PM +0300, Denis Efremov wrote:
> > Remove local definition PCI_BAR_COUNT for the number of PCI BARs and use
> > global one PCI_STD_NUM_BARS instead.
> > 
> > Acked-by: Sebastian Ott <sebott@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> >  arch/s390/include/asm/pci.h     |  5 +----
> >  arch/s390/include/asm/pci_clp.h |  6 +++---
> >  arch/s390/pci/pci.c             | 16 ++++++++--------
> >  arch/s390/pci/pci_clp.c         |  6 +++---
> >  4 files changed, 15 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > index a2399eff84ca..3a06c264ea53 100644
> > --- a/arch/s390/include/asm/pci.h
> > +++ b/arch/s390/include/asm/pci.h
> > @@ -2,9 +2,6 @@
> >  #ifndef __ASM_S390_PCI_H
> >  #define __ASM_S390_PCI_H
> >  
> > -/* must be set before including pci_clp.h */
> > -#define PCI_BAR_COUNT	6
> > -
> >  #include <linux/pci.h>
> >  #include <linux/mutex.h>
> >  #include <linux/iommu.h>
> > @@ -138,7 +135,7 @@ struct zpci_dev {
> >  
> >  	char res_name[16];
> >  	bool mio_capable;
> > -	struct zpci_bar_struct bars[PCI_BAR_COUNT];
> > +	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
> >  
> >  	u64		start_dma;	/* Start of available DMA addresses */
> >  	u64		end_dma;	/* End of available DMA addresses */
> > diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
> > index 50359172cc48..bd2cb4ea7d93 100644
> > --- a/arch/s390/include/asm/pci_clp.h
> > +++ b/arch/s390/include/asm/pci_clp.h
> > @@ -77,7 +77,7 @@ struct mio_info {
> >  	struct {
> >  		u64 wb;
> >  		u64 wt;
> > -	} addr[PCI_BAR_COUNT];
> > +	} addr[PCI_STD_NUM_BARS];
> >  	u32 reserved[6];
> >  } __packed;
> >  
> > @@ -98,9 +98,9 @@ struct clp_rsp_query_pci {
> >  	u16 util_str_avail	:  1;	/* utility string available? */
> >  	u16 pfgid		:  8;	/* pci function group id */
> >  	u32 fid;			/* pci function id */
> > -	u8 bar_size[PCI_BAR_COUNT];
> > +	u8 bar_size[PCI_STD_NUM_BARS];
> >  	u16 pchid;
> > -	__le32 bar[PCI_BAR_COUNT];
> > +	__le32 bar[PCI_STD_NUM_BARS];
> >  	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
> >  	u32			: 16;
> >  	u8 fmb_len;
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index b0e3b9a0e488..aca372c8e34f 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -43,7 +43,7 @@ static DECLARE_BITMAP(zpci_domain, ZPCI_NR_DEVICES);
> >  static DEFINE_SPINLOCK(zpci_domain_lock);
> >  
> >  #define ZPCI_IOMAP_ENTRIES						\
> > -	min(((unsigned long) ZPCI_NR_DEVICES * PCI_BAR_COUNT / 2),	\
> > +	min(((unsigned long) ZPCI_NR_DEVICES * PCI_STD_NUM_BARS / 2),	\
> >  	    ZPCI_IOMAP_MAX_ENTRIES)
> >  
> >  static DEFINE_SPINLOCK(zpci_iomap_lock);
> > @@ -294,7 +294,7 @@ static void __iomem *pci_iomap_range_mio(struct pci_dev *pdev, int bar,
> >  void __iomem *pci_iomap_range(struct pci_dev *pdev, int bar,
> >  			      unsigned long offset, unsigned long max)
> >  {
> > -	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
> > +	if (bar >= PCI_STD_NUM_BARS || !pci_resource_len(pdev, bar))
> >  		return NULL;
> >  
> >  	if (static_branch_likely(&have_mio))
> > @@ -324,7 +324,7 @@ static void __iomem *pci_iomap_wc_range_mio(struct pci_dev *pdev, int bar,
> >  void __iomem *pci_iomap_wc_range(struct pci_dev *pdev, int bar,
> >  				 unsigned long offset, unsigned long max)
> >  {
> > -	if (!pci_resource_len(pdev, bar) || bar >= PCI_BAR_COUNT)
> > +	if (bar >= PCI_STD_NUM_BARS || !pci_resource_len(pdev, bar))
> >  		return NULL;
> 
> This looks like a latent bug fix here. If 'bar' is out of range we return
> NULL instead accessing an invalid item of an array. Should this not be
> a separate patch and tagged as stable?

Sharp eyes!  I didn't think of this as accessing an invalid item, but
indeed it does (if 'bar' is out of range).  But I doubt it's worth the
hassle of a separate patch, since we return failure anyway.
