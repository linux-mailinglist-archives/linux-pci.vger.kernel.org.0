Return-Path: <linux-pci+bounces-24847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA2A73373
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 14:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E221890D4B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D5215F47;
	Thu, 27 Mar 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLNemgbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00094215F41;
	Thu, 27 Mar 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082680; cv=none; b=QgM7EQP3X2flbzVD5A4Lr+gdp5cGgK4W8yM7tt2xVwIO8GdSvnapnOZXGRZ8v/dXAIk0cqQ4Mcy4VarCDDTRrkLMMTRboBWvHYtC+b79q4Wk5osVXqQ1mpDZzu65m8xSMQMBJ8CMutYH1mp8l9MlhbqMUGkskJIeRlpPq3zoUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082680; c=relaxed/simple;
	bh=g48C53wIQ9kisIJ+mo4pQeIIjGFozOXYfFQ82UEzKlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n6lWIHmIeiK4Kb8rTXbopwjmLevz9F2OMF2uMk/XjnBFwnXRnYpoZpfGRAdvzz4/WO9SI0+wVFwsQFEey50c3Ro47dNDRhTPA5CLbcpLK3hugaOYUMB2/aBuFYkClgZZ/gE+CL8vXgjD0lt/6T+Ac7VdbOyheIpwt66cvSoDuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLNemgbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E16C4CEE8;
	Thu, 27 Mar 2025 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743082679;
	bh=g48C53wIQ9kisIJ+mo4pQeIIjGFozOXYfFQ82UEzKlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LLNemgbX3Dbf1Fl+6thM/M9H7JJ9frLa7+skx8wrLVDCvgnKmttz6zOUNF78Hwiq5
	 AGus3LLTH3l0HzwgLhsQ/Zvjy3HMHuIroNgx3MvJFwsSjtjdI4oo7xEwsPftIx9dHv
	 VpkD3xWaHRXNfMtDU4lc6VE7T3LwVHvckeUd8diJRvFVJ4/uM5S/579OLvm1CR6VZe
	 La1xzac8qD9p0Gm9N9yv+qJPlLYdFi8jWvOEhZKipvIPD9Vv9u3Hux9kiXevTKR6rL
	 2ZHuPN5E7NTBjLfUoqi9OhVlrivDEqADyhN6U+GLByJGH5QmuNY2droaNwdUOv511F
	 txJvP0ELte/6g==
Date: Thu, 27 Mar 2025 08:37:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add MUCSE vendor ID to pci_ids.h
Message-ID: <20250327133757.GA1432088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1835B10BD36E99AC+20250327112426.GB468890@nic-Precision-5820-Tower>

On Thu, Mar 27, 2025 at 07:24:26PM +0800, Yibo Dong wrote:
> On Wed, Mar 26, 2025 at 11:57:28AM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 25, 2025 at 02:57:18PM +0800, Yibo Dong wrote:
> > > Add MUCSE as a vendor ID (0x8848) for PCI devices so we can use
> > > the macro for future drivers.
> > > 
> > > Signed-off-by: Yibo Dong <dong100@mucse.com>
> > 
> > Please post this in the series where you add the future drivers.
> > 
> > We don't add new things to pci_ids.h unless they are actually used by
> > more than one driver because it complicates life for people who
> > backport things (there's a note at the top of the file about this).
> 
> Thanks for the reminder; the drivers maybe use 'the define' are
> netdev drivers, so, I should first send patches to netdev subsystem,
> and re-send this patch to pci subsystem after my patches is applied
> by netdev subsytem? or I should send this to netdev subsystem along
> with the drivers?

Just include it with your netdev series and cc me.  I'll ack it and
the whole series can be merged together via netdev.

> > > +#define PCI_VENDOR_ID_MUCSE		0x8848
> > 
> > https://pcisig.com/membership/member-companies?combine=8848 says this
> > Vendor ID belongs to:
> > 
> >   Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd
> > 
> > I suppose "MUCSE" connects with that somehow.
> > 
> > It's nice if people can connect PCI_VENDOR_ID_MUCSE with a name used
> > in marketing the product.  Maybe "MUCSE" is the name under which
> > Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd markets
> > products?
> 
> Yes, MUCSE is just abbreviation for “Wuxi Micro Innovation Integrated Circuit
> Design Co.,Ltd”

Perfect.  I see you've already added it to the lspci database along
with several devices:

  https://admin.pci-ids.ucw.cz/read/PC/8848

All looks good!  I'll watch for your netdev patches.

Bjorn

