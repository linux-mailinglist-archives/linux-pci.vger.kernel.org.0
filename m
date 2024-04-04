Return-Path: <linux-pci+bounces-5725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4389889A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2441F234EF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA43126F0F;
	Thu,  4 Apr 2024 13:13:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970586D1B4;
	Thu,  4 Apr 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236414; cv=none; b=OphJdZHpBXJWL/598WJD6MBlEst0Ew7SLhg2F8Y3ThVUAGtldTMaqgmCGosuJzv6JW0tPF5xp+jUD/D1cc4STAxh2Bkx0T4hJ6lkArTQDFL158SlJaG6BLhNW4gkfQKABWBe2sBvb9R2kMOPwOVersk/wEYAMjA0YG0Wi8nHFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236414; c=relaxed/simple;
	bh=buqFv+bNFbev75CYpit17rTZgn40/FqRyaV31Axucp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQckA5GOeME5MUriEL0fT732qkJOFvJLebkOYk6Rf2c+6kUANmcY09SfQ0zkNyPnqSoFHYDzdYEV1Ppvj7byBQubYnQSU4gUqIleY8WjNrHD6kcUM7EQZzybUu0ULD4tj3MF09Gm6ju1LG6ZskQsxWi+TWldZv2kDqWfdx9zpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9MPl4gmTz6J7DZ;
	Thu,  4 Apr 2024 21:08:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1B1E140C72;
	Thu,  4 Apr 2024 21:13:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:13:22 +0100
Date: Thu, 4 Apr 2024 14:13:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <20240404141321.00005943@Huawei.com>
In-Reply-To: <Zg5qGJCAZJWY4xy9@wunner.de>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
	<20240402234848.3287160-5-dave.jiang@intel.com>
	<20240403163257.000060e1@Huawei.com>
	<Zg5qGJCAZJWY4xy9@wunner.de>
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

On Thu, 4 Apr 2024 10:51:36 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Wed, Apr 03, 2024 at 04:32:57PM +0100, Jonathan Cameron wrote:
> > On Tue, 2 Apr 2024 16:45:32 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> > Why not pass the info on what reset was done down from the PCI core?
> > I see Bjorn commented it would be *possible* to do it in the PCI core
> > but raised other concerns that needed addressing first (I think you've
> > dealt with those now).  Doesn't look that hard to me (I've not coded it
> > up yet though).
> > 
> > The core code knows how far it got down the list reset_methods before
> > it succeeded in resetting.  So...
> > 
> > Modify __pci_reset_function_locked() to return the index of the reset
> > method that succeeded. Then pass that to pci_dev_restore().
> > Finally push it into a reset_done2() that takes that as an extra
> > parameter and the driver can see if it is FLR or SBR.  
> 
> The reset types to distinguish per PCIe r6.2 sec 6.6 are
> Conventional Reset and Function Level Reset.
> 
> Secondary Bus Reset is a Conventional Reset.
> 
> The spec subdivides Conventional Reset into Cold, Warm and Hot,
> but that distinction is probably irrelevant for the kernel.

Agreed. SBR is only called out explicitly here because it's the one
with a handy triggering mechamism.

> 
> I think a more generalized (and therefore better) approach would be
> to store the reset type the device has undergone in struct pci_dev,
> right next to error_state, so that not just the ->reset_done()
> callback benefits from the information.  The reset type applied has
> consequences beyond the individual driver:  E.g. an FLR does not
> affect CMA-SPDM session state, but a Conventional Reset does.
> So there may be consumers of that information in the PCI core as well.

That makes sense if we do go the route of enhancing the information
provided for a reset.

> 
> It's worth noting that we already have an enum pcie_reset_state in
> <linux/pci.h> which distinguishes between deassert, warm and hot reset.
> It is currently only used by PowerPC EEH to convey to the platform
> which type of reset it should apply.  It might be possible to extend
> the enum so that it can be used to store the reset type that *was*
> applied to a device in struct pci_dev.
> 
> That all being said, checking for the *symptoms* of a Conventional Reset,
> as Dave has done here, may actually be more robust than just relying on
> what type of reset was applied.  E.g. after an FLR was handled, the device
> may experience a DPC-induced Hot Reset.  

This sounds like a plausible reason for doing it by symptom checking.

> By checking for the *symptoms*,
> the driver may be able to catch that the device has undergone a
> Conventional Reset immediately after an FLR.  Also, who knows if all
> devices are well-behaved and retain their state during an FLR, as they
> should per the spec?  Maybe there are broken devices which do not respect
> that rule.  Checking for symptoms of a Conventional Reset would catch
> those devices as well.

I'm not particularly keen on complexity additions to the kernel for
possible broken devices. For CXL devices the rules are very clear 
and the HDM decoder must not be reset.  If not chances are host OS will
take out BIOS setup memory and that isn't healthy.

Perhaps the key point here is that the patch title is misleading / simplistic.
The patch only warns if a reset happened that caused a configuration mismatch
for the address decoders.  SBR at other times is fine.

So even if we had a reset_type available, the driver would still need
to see if it mattered.

So I've ended up arguing myself into the fact all this code is needed anyway.
Perhaps change the patch title to

cxl: Add post reset warning if reset results in loss of previously committed HDM decoders.

If something along those lines..

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> 
> Thanks,
> 
> Lukas


