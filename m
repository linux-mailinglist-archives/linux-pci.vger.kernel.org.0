Return-Path: <linux-pci+bounces-19478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962AA04D27
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E2C1888681
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB81E47A6;
	Tue,  7 Jan 2025 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOXT9/e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E01DE4CA;
	Tue,  7 Jan 2025 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291187; cv=none; b=RzCASB4muGVw/4wm+i7TWDLnZtyOdBCaeSkjeDWQywM8OomXrpwqM+Ss3WSQ9vcdLlnqJ2YkriLLFJIvuUZDz/RxObTLuDKg1XWv4nywP9459pyRcUl7rUDyIvsAptuSyF16aiBki951cidaD90+ROgUr5zXo2hUuZu1TIBpL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291187; c=relaxed/simple;
	bh=VfAnBfuX08F+R34YGFjPDdCZbCRXPGtckNSQu09Cp8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X62tLZzg8AVmN7wxDX4LzblRvqmRBrDuGie5xfTQJlZKxSjbzfGgPnpXBkIYla7Pu8Rlba+DBZV+cebkM/+pW83ZGJRIsPtQmbVknHvTWoD5+8vFpgxIk/C719zx9V31asddeobR4TsvWO7umg84tIesRExyILwdKXmUilYkhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOXT9/e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46902C4CEDF;
	Tue,  7 Jan 2025 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736291185;
	bh=VfAnBfuX08F+R34YGFjPDdCZbCRXPGtckNSQu09Cp8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cOXT9/e9xxyBFaU6ZRyl43N5yOhkdSW3pm+L4KFDvPaD4x4bhaPDx6vsx/+XK15JB
	 ufQhgPuoW8HeB5VsOY57a1OQnNFYyGITDl/MGXWbZcc8V+rKTVX7tK4/fNWSL5cRJT
	 YtgV0laPpn4XfecnAbcURnxone1ng/4plt6Eiae1K14ASLBiDClGM0r/kZMxZNAJx8
	 B8rJG874PHgtYWGEiEBgv8D2hwmFL2CI3yGqY+uirRMi1sBDWdPxXwGN9CofAI4udG
	 MkB8aA5vkzdhC9sPCpCx7WjD3gUDWyW00nopCYQjAS9Xqe7QR07g3Aplq0O/3ma3Yw
	 VlpA8jCaUFgFQ==
Date: Tue, 7 Jan 2025 17:06:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Xavier Chang =?utf-8?B?KOW8teeNu+aWhyk=?= <Xavier.Chang@mediatek.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Message-ID: <20250107230623.GA189234@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b7b0d1bca5088bda46a651481b9a42f3be1a75d.camel@mediatek.com>

On Tue, Jan 07, 2025 at 02:44:37AM +0000, Jianjun Wang (王建军) wrote:
> On Fri, 2025-01-03 at 13:15 -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 03, 2025 at 02:00:13PM +0800, Jianjun Wang wrote:
> > > Disable ASPM L0s support because it does not significantly save
> > > power but impacts performance.
> > 
> > This seems like a user/administrator decision, not a driver
> > decision.
> > 
> > L0s reduces power at the cost of performance for *all* PCIe
> > devices, although the actual numbers may vary.
> 
> We have encountered some compatibility issues when connected with
> some PCIe EPs, these issues are probabilistic and disabling the L0s
> can fix them.

This sounds like either a software problem in ASPM or a hardware
problem in one of the devices.  If it's a Linux ASPM issue, obviously
we should find and fix that.  If it's an endpoint hardware issue, we
should fix the driver or quirk it to avoid L0s on all platforms, not
just this one.

If it's a mediatek-gen3 hardware issue, we should disable L0s as you
do here.  But if the reason is to work around a hardware erratum, we
should describe it as such.

Justifying it as "L0s really doesn't save much power, so disable it"
is an invitation for somebody to come back and ask why L0s doesn't
work when the lspci output claims it *should* work.

> Users may not be aware of these issues, so I think disabling L0s
> through the driver might be the better way, since it does not
> significantly save power and we usually use L1ss for power-saving
> when the link is idle.

Users should not need to be aware of probabilistic behavior problems
related to ASPM.  It's *our* problem to make sure users never see
issues like that :)

Bjorn

