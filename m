Return-Path: <linux-pci+bounces-5726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA98988A2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FDA283213
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6286245;
	Thu,  4 Apr 2024 13:16:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0628689;
	Thu,  4 Apr 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236602; cv=none; b=sH/8xHmWn99L5RnpW5aHJhkf4QZ1YjKVigInoYt8EauWXgO1TINZD4ZJE7IrY19H7Yo0SVmJ9UwEOuAe7/IqAEmTVPjfqZSedDqJJbXFEOKbhJzce+lBMdPHdUhIBEH8bc/cFA7d3e7aB5tdPlxnJOTbhDTCWJURm93feLF43hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236602; c=relaxed/simple;
	bh=TR7WvF23rSs9wEWaykqODmnHFhPeoYBmYviUs6Ehl2A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqvspCP/4NHsk8waGBnCJXhWFU7DPl0qHBRxpJTqM1WOgFGh32Lzf3p3ed0qD3acAdLR3f5wmujUH2GQX4pR6nCeYizIJQqfQFXmRoV4vEqB9pj2nhKvwLLPr8/ZWLt/B9edmR4rqxpeORq8NleSLaSzYA4YPddnFCStcEn2brg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9MYF484Hz6HJZV;
	Thu,  4 Apr 2024 21:15:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CCA4E140CF4;
	Thu,  4 Apr 2024 21:16:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:16:35 +0100
Date: Thu, 4 Apr 2024 14:16:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <20240404141634.00003872@Huawei.com>
In-Reply-To: <660d83708993_2459629416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-5-dave.jiang@intel.com>
	<20240403163257.000060e1@Huawei.com>
	<660d83708993_2459629416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 09:27:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Tue, 2 Apr 2024 16:45:32 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > SBR is equivalent to a device been hot removed and inserted again. Doing a
> > > SBR on a CXL type 3 device is problematic if the exported device memory is
> > > part of system memory that cannot be offlined. The event is equivalent to
> > > violently ripping out that range of memory from the kernel. While the
> > > hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> > > register and the kernel currently does not unmask it, user can unmask
> > > this bit via setpci or similar tool.
> > > 
> > > The driver does not have a way to detect whether a reset coming from the
> > > PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> > > detect is to note if a decoder is marked as enabled in software but the
> > > decoder control register indicates it's not committed.
> > > 
> > > A helper function is added to find discrepancy between the decoder
> > > software state versus the hardware register state.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > As I said way back on v1, this smells hacky.
> > 
> > Why not pass the info on what reset was done down from the PCI core?
> > I see Bjorn commented it would be *possible* to do it in the PCI core
> > but raised other concerns that needed addressing first (I think you've
> > dealt with thosenow).  Doesn't look that hard to me (I've not coded it
> > up yet though).
> > 
> > The core code knows how far it got down the list reset_methods before
> > it succeeded in resetting.  So...
> > 
> > Modify __pci_reset_function_locked() to return the index of the reset
> > method that succeeded. Then pass that to pci_dev_restore().
> > Finally push it into a reset_done2() that takes that as an extra
> > parameter and the driver can see if it is FLR or SBR.
> > The extended reset_done is to avoid modifying lots of drivers.
> > However a quick grep suggests it's not that heavily used (15ish?)
> > so maybe just add the parameter.
> > 
> > There are a few other paths, but non look that problematic at
> > first glance...
> > 
> > So Bjorn, now the rest of this is hopefully close to what you'll be
> > happey with, which way do you prefer?  
> 
> I will defer to Bjorn, but I am not fan of this reset_done2() proposal.
> "Revalidate after reset" is a common driver pattern and all that
> plumbing the effective-reset-type does is make cxl_reset_done() more
> precise for no discernible value.

As per other thread branch, I think you are right, but key is this is not
detecting the SBR at all, it's detecting HDM decoders not being in expected
state. If they weren't setup before SBR, then we don't warn.  So SBR is
the cause, but not what is being detected (which is a subset of SBR results)
  
> 


