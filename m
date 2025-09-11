Return-Path: <linux-pci+bounces-35930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D9B53ACC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975911C242DA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA11362092;
	Thu, 11 Sep 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ9KJYfA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437C35FC3C;
	Thu, 11 Sep 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613380; cv=none; b=AM8YpnkOW6zB7WT4zkh8FCWI4SFo+Pak5qZt08uHxA4ZhwgLz4liIlw7H73rL5KrMnaoOCFO9w6Ob8/CNYoyiUI9FbrJ/QgpmbN1fWhBWraZicHWFPZExjZh7vHW+s+J6nVIeyuK5mUZt+x1YHVM3WSyx2ud6FS5E+x8MIVJbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613380; c=relaxed/simple;
	bh=OCHmyyyREP4+Sk7q9SH4hwADD3BC7U5F+hODRDkJinA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFUqZyw0E42IfyurjfDXRYSX0noUNlyzFDhcgGCFLzCAflstY7zHT5K9viKnbGmobbh3aiStJoskqNVPMzkJHK3S5C7yfdqOu2ZQ52TJATWFOWVHD1FtE1Kw0THIrOoVSXpvpYxxXM1kMMFkcnAS2inLLmaHna2kUHXRm90egC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ9KJYfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15A9C4CEF0;
	Thu, 11 Sep 2025 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757613379;
	bh=OCHmyyyREP4+Sk7q9SH4hwADD3BC7U5F+hODRDkJinA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJ9KJYfAa+ZHiVzHuni8+5wVh1groCL0QGr8j3o6M1YeaKgZ/1CEvx5mJ9rxghYcP
	 U9MnU8ubpuf/eQ1Efabg0aZvOqKQzkzNp/ssxhkYZpC4FTcG+8Bd9KhP3OfxSE40gK
	 +u5g8JMipzDx0UyWtOEOMk9KX76a9PHoRTM+2icbAcQqrNjldgtfUUQkGLsKPXqXho
	 LSL3in6LySimo1PemYXe77fKK59k4Y/zllA7P4lIlgntSNPzTFvbpN/rFNtCMBVOYA
	 Pf0+wI9N4jhc/Z5qlMvQF8CiDWxDQyAjT8Q85Z9LP38x2rg6rhQlR/jUvtdvs5RhQ6
	 Q3+LsdkDAP12A==
Date: Thu, 11 Sep 2025 23:26:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v3 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after
 DTS fix ranges
Message-ID: <chsfhg3u5akllpggnjnld5uv2jauwfaccuaoodcmzlpv2nou4s@czb4swbr3she>
References: <1757298848-15154-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <20250908215510.GA1467223@bhelgaas>
 <aMGi4smALwIJS8Tc@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMGi4smALwIJS8Tc@lizhi-Precision-Tower-5810>

On Wed, Sep 10, 2025 at 12:10:10PM GMT, Frank Li wrote:
> On Mon, Sep 08, 2025 at 04:55:10PM -0500, Bjorn Helgaas wrote:
> > In subject, s/PCI: dwc: visconti:/PCI: visconti:/ to match previous
> > history.
> >
> > On Mon, Sep 08, 2025 at 11:34:08AM +0900, Nobuhiro Iwamatsu wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Remove cpu_addr_fix() since it is no longer needed. The PCIe ranges
> > > property has been corrected in the DTS, and the DesignWare common code now
> > > handles address translation properly without requiring this workaround.
> >
> > As Mani pointed out, the driver has to continue working correctly with
> > any old DTs in the field.
> 
> DTS should be merged first, then after some linux release cycle, then PCI
> can merge this change.
> 
> The similar case happen at other area, which broken back compatible. But
> we still need move forward.
> 

Absolutely not! DT is a firmware. Even though the firmware turns out to be
buggy, we should not regress platforms that were using the old firmware.

We can surely remove the check after some time. Maybe when all the stable
kernels stop supporting older DTs. But not until then.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

