Return-Path: <linux-pci+bounces-21524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63EA366F6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12813AADBA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAFC1C84B2;
	Fri, 14 Feb 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMdBlqwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4919F495;
	Fri, 14 Feb 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565433; cv=none; b=I6cPSlMxKzKJaO5QYbYPPEOCfluV1qG5PFw56+6ZWE55XjJwnQX2HPs6ILO3Y2QiTYibxDlWB+tIY7f+AjszmrVJPQShEv3dEJIPn0jMl9n0IYzYxYgqhZslprQLDAEuYHcNqW8jNP2k1S3Bi/g+QrNXok+TiycncEpJQn48wcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565433; c=relaxed/simple;
	bh=/LU7fG6fgTEGf5K0K6dF6/L6VDooN37auBZ/6PWAfYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UOo0a9u5FRgG4OpGy++ECjW35bMcUj9ykXI+9VC2UcusEvCEghyul2mb7gNnT9oKuZJVECSmRHeFkakDbAvkfl35/INTu4L6UPjSDutEYMomrcxtcCes6gkuZ6I/W2tyeBaX6xHfuTtDJiH8Q2WLGlnueD3vCiwvFD6ue2osMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMdBlqwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB2C4CED1;
	Fri, 14 Feb 2025 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739565432;
	bh=/LU7fG6fgTEGf5K0K6dF6/L6VDooN37auBZ/6PWAfYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hMdBlqwGc2H7N1TnwmMXRJNYx0EIanM22MVTDYCeJeX3jw7QlBu6+XuTTgpBrdEIO
	 51F1leCo+ow8sLbKMoFmAsx26twOKBpYcbhtLngAxHMQgQDUNzwoACUJTx8AaqKpUc
	 ocoRt7DK/PQ+T85TnRKutoXYL0JMLHjqzRYQnFwA6KhjMK4j6XMAVkOQQfmvf3ybhg
	 vwB+nZ4E5XxNBAesc4x0fBj5bD+38hy85Mu4WERGSaNhtxt4XheGjw6kpo/I4bg8zJ
	 B7QC1rV8MXrSwUTf66UxopOaM02v36cFMxhUdZAcbTtvRwzfapEtxcizzgw1d1nYVT
	 D4U3M0tfHIPIg==
Date: Fri, 14 Feb 2025 14:37:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] PCI: Descope pci_printk() to aer_printk()
Message-ID: <20250214203710.GA162892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91014487-c584-af8c-9810-48291a16b643@linux.intel.com>

On Fri, Feb 14, 2025 at 01:56:47PM +0200, Ilpo Järvinen wrote:
> On Thu, 13 Feb 2025, Bjorn Helgaas wrote:
> > On Mon, Dec 16, 2024 at 06:10:12PM +0200, Ilpo Järvinen wrote:
> > > include/linux/pci.h provides low-level pci_printk() interface that is
> > > only used by AER because it needs to print the same message with
> > > different levels depending on the error severity. No other PCI code
> > > uses that functionality and calls pci_<level>() logging functions
> > > directly with the appropriate level.
> > > 
> > > Descope pci_printk() into AER as aer_printk().
> > > 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > I applied this patch by itself on pci/aer for v6.15.
> > 
> > We also have some work-in-progress on rate limiting errors, which
> > might conflict, but this is simple and shouldn't be hard to reconcile.

> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index db9b47ce3eef..02d23e795915 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -2685,9 +2685,6 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> > >  
> > >  #include <linux/dma-mapping.h>
> > >  
> > > -#define pci_printk(level, pdev, fmt, arg...) \
> > > -	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> 
> Both shpchp and aer do use pci_printk() before this series (it seems LKP 
> has also catched it already).
> 
> If you split this series into different branches, this removal of 
> pci_printk() has to be postponed until the next kernel release (fine for 
> me if that's what you want to do, just remove this part from this patch 
> and perhaps adjust the commit message to say it's to prepare for removal 
> of the pci_printk()).

OK.  I dropped the pci_printk() removal for now.  I'm anticipating
more AER changes this cycle, so I'm trying to keep those isolated.

Bjorn

