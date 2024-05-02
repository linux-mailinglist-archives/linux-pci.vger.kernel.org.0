Return-Path: <linux-pci+bounces-7030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B134C8BA312
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B5328164D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4082557CA8;
	Thu,  2 May 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyxNU25I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38657CA6
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688597; cv=none; b=cZc/xbke5pQTenG3JJsA4CrJi2N8uUJpQd3GgptvgaYNMccYOLTA+JjvtdOO1kFpt0oMOutQ1jLBykocGAhy9PPQh0ea/jcr9SftFTC5r7cDok9DvyMUwwJLpyOpzkx2Qs11aThhcVX5E7WmNdA3N5v3WnhxoqfVh6x9oz4/rMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688597; c=relaxed/simple;
	bh=IpBFcW1jJONB0iN90VAM3TRGReE2ehMF245N2+SFLXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SoyMa6oUNcp3LPA/TL3k/OQDI7jwaBFlNm0zICpbLQoWZ3RP2wW49SdCdZjvLA0C26g72m9lVwu0I4CC5goqFwClQYmMBTugNlmx0PdMDGWOU8l1uInnqvTlP4pBA8tDrgsl0BHBOOpaAjmJhrQn4imQBDkekeOKJdPFqukIAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyxNU25I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A8DC113CC;
	Thu,  2 May 2024 22:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714688596;
	bh=IpBFcW1jJONB0iN90VAM3TRGReE2ehMF245N2+SFLXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NyxNU25IJfyCSFsaw467hY8F769TsuC14bRypUxs3gipGs1ckUH35oFQJDjHoltUU
	 UdzKFcJimp0mvD2H3MacJgIJRi/Xm0A7FXFun0GmcSxwYP1WjQ+2v2UaOb6vDHiI1q
	 yILXErECd7ywUQ5tVqbrWQ8b8C29blWpuLOj5EVtJTX2QfJMtuedEHO8aVYpfmw0ed
	 kW1Gn1PLVEejqI36FHYYRpfSS4X/cgQkNEicXfmUBWhvXHtYE+MRsDbxuwHM3CxUTk
	 IUA06YENl/eQp/xqHkaAFdo9gX7EnBxtHBR16q58xyDIaqiyV8X84F/TB1Tost8Czk
	 AoIl4duEgwfxQ==
Date: Thu, 2 May 2024 17:23:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josselin Mouette <josselin.mouette@exaion.com>
Cc: linux-pci@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] Revert "PCI/VPD: Allow access to valid parts of VPD
 if some is invalid"
Message-ID: <20240502222315.GA1551408@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307223606.GA658427@bhelgaas>

On Thu, Mar 07, 2024 at 04:36:06PM -0600, Bjorn Helgaas wrote:
> [+cc Hannes, who did a lot of related VPD work and reviewed the
> original posting at
> https://lore.kernel.org/r/20210715215959.2014576-6-helgaas@kernel.org/]
> 
> On Thu, Mar 07, 2024 at 05:09:27PM +0100, Josselin Mouette wrote:
> > When a device returns invalid VPD data, it can be misused by other
> > code paths in kernel space or user space, and there are instances
> > in which this seems to cause memory corruption.
> 
> More of the background from Josselin at
> https://lore.kernel.org/r/aaea0b30c35bb73b947727e4b3ec354d6b5c399c.camel@exaion.com
> 
> This is a regression, and obviously needs to be fixed somehow, but I'm
> a bit hesitant to revert this until we understand the problem better.
> If there's a memory corruption lurking and a revert hides the
> corruption so we never fix it, I'm not sure that's an improvement
> overall.

I don't want to drop this, but we're kind of stuck here:

  - I'd still like to understand the problem better.

  - Trivially, I can't apply patches lacking the appropriate
    signed-off-by; see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.6#n396

> > There is no sensible reason why the kernel would provide userspace
> > or drivers with invalid and potentially dangerous data.
> > 
> > This reverts commit 5fe204eab174fd474227f23fd47faee4e7a6c000.
> > ---
> >  drivers/pci/vpd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index 485a642b9304..daaa208c9d9c 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -68,7 +68,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
> >                         if (pci_read_vpd_any(dev, off + 1, 2,
> > &header[1]) != 2) {
> >                                 pci_warn(dev, "failed VPD read at
> > offset %zu\n",
> >                                          off + 1);
> > -                               return off ?: PCI_VPD_SZ_INVALID;
> > +                               return PCI_VPD_SZ_INVALID;
> >                         }
> >                         size = pci_vpd_lrdt_size(header);
> >                         if (off + size > PCI_VPD_MAX_SIZE)
> > @@ -87,13 +87,13 @@ static size_t pci_vpd_size(struct pci_dev *dev)
> >                                 return off;
> >                 }
> >         }
> > -       return off;
> > +       return PCI_VPD_SZ_INVALID;
> >  
> >  error:
> >         pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset
> > %zu%s\n",
> >                  header[0], size, off, off == 0 ?
> >                  "; assume missing optional EEPROM" : "");
> > -       return off ?: PCI_VPD_SZ_INVALID;
> > +       return PCI_VPD_SZ_INVALID;
> >  }
> >  
> >  static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
> > -- 
> > 2.39.2
> > 

