Return-Path: <linux-pci+bounces-5719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD489837D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216A91C21989
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6373514;
	Thu,  4 Apr 2024 08:51:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0971B40;
	Thu,  4 Apr 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220707; cv=none; b=XFd/g9fCpxuGGElR/KUe+MQeoWbM1ziXrtlJqfmvJqLaSjkqAS7R+IYPL733Q3gmBaP0/UFZuxrxRCtzlKaY3O7OXGQXDMfVhoTIXqOms9gR00eMrC/+dhJgGD+FQ+LLxF8orT/m2OPT1y+Uy95vPmYWerCbWYAfmJZEizg51i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220707; c=relaxed/simple;
	bh=NRX4u4aBi9RRKb5GnKffOgmpqSNRU11Djm5FO+o7j3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgdHWghrSIVNuMC1za7r1P5ro/SYIYqOo5IWePn8fgLQZ7MIfSS6wd5yvHz/0W6Uwbz26K9M/DTOM5hae5kJkyBKbZL849rrw0xEo1AcjB6BiUEL2sp1pTpXCQN4wZiejmgM2t7aNf4ZqT2YOX/Vnd1VCkao9laKAjToVrtIVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 681F43000222C;
	Thu,  4 Apr 2024 10:51:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 61A7D1D17E; Thu,  4 Apr 2024 10:51:36 +0200 (CEST)
Date: Thu, 4 Apr 2024 10:51:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <Zg5qGJCAZJWY4xy9@wunner.de>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-5-dave.jiang@intel.com>
 <20240403163257.000060e1@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403163257.000060e1@Huawei.com>

On Wed, Apr 03, 2024 at 04:32:57PM +0100, Jonathan Cameron wrote:
> On Tue, 2 Apr 2024 16:45:32 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
> Why not pass the info on what reset was done down from the PCI core?
> I see Bjorn commented it would be *possible* to do it in the PCI core
> but raised other concerns that needed addressing first (I think you've
> dealt with those now).  Doesn't look that hard to me (I've not coded it
> up yet though).
> 
> The core code knows how far it got down the list reset_methods before
> it succeeded in resetting.  So...
> 
> Modify __pci_reset_function_locked() to return the index of the reset
> method that succeeded. Then pass that to pci_dev_restore().
> Finally push it into a reset_done2() that takes that as an extra
> parameter and the driver can see if it is FLR or SBR.

The reset types to distinguish per PCIe r6.2 sec 6.6 are
Conventional Reset and Function Level Reset.

Secondary Bus Reset is a Conventional Reset.

The spec subdivides Conventional Reset into Cold, Warm and Hot,
but that distinction is probably irrelevant for the kernel.

I think a more generalized (and therefore better) approach would be
to store the reset type the device has undergone in struct pci_dev,
right next to error_state, so that not just the ->reset_done()
callback benefits from the information.  The reset type applied has
consequences beyond the individual driver:  E.g. an FLR does not
affect CMA-SPDM session state, but a Conventional Reset does.
So there may be consumers of that information in the PCI core as well.

It's worth noting that we already have an enum pcie_reset_state in
<linux/pci.h> which distinguishes between deassert, warm and hot reset.
It is currently only used by PowerPC EEH to convey to the platform
which type of reset it should apply.  It might be possible to extend
the enum so that it can be used to store the reset type that *was*
applied to a device in struct pci_dev.

That all being said, checking for the *symptoms* of a Conventional Reset,
as Dave has done here, may actually be more robust than just relying on
what type of reset was applied.  E.g. after an FLR was handled, the device
may experience a DPC-induced Hot Reset.  By checking for the *symptoms*,
the driver may be able to catch that the device has undergone a
Conventional Reset immediately after an FLR.  Also, who knows if all
devices are well-behaved and retain their state during an FLR, as they
should per the spec?  Maybe there are broken devices which do not respect
that rule.  Checking for symptoms of a Conventional Reset would catch
those devices as well.

Thanks,

Lukas

