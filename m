Return-Path: <linux-pci+bounces-40529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62150C3CE19
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010C31898732
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1E340A74;
	Thu,  6 Nov 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKZnoXF2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894F32C938;
	Thu,  6 Nov 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450735; cv=none; b=BIiOsYa2RgVt1ERYKSPqbEYJekVwknjsKsEe/qHhASvmBHRDGWFdGNIIuPFuh7BXA+82NQkaXEyVeJmD6NApAEF2vd1zeFc22Zpx0nEBdEevkJmZKzpctQnrrB5J9tUGWfsIVVAUUeEPczEJYp8r4WhmVHcji+TfeC0aCZUmYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450735; c=relaxed/simple;
	bh=KT4NxU4wzZtWzjzdNyOaIb2J5xsI7ldg+J7TbPIxc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gxU/b0VnoJMqRnnuQw2/KTh+PA2965lLM9rUPm55VlFOk7Wnl+YhMjTzPmuLddHzoGYqy3hR/AJeyMIR2TeyzQxX9z+DZrkIseRtOIs5eZnLfM7Qf1JPCaZfbJxESQ6FWCTs9xKDediFuX7GO1IhhnsGhtie9Tm57/bzOE2+GgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKZnoXF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CEEC16AAE;
	Thu,  6 Nov 2025 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450734;
	bh=KT4NxU4wzZtWzjzdNyOaIb2J5xsI7ldg+J7TbPIxc2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RKZnoXF2yCM0esJy0nNdLPHb5DCoMw2//OUPJtCchG/Cd8esCy4W7xNGUF9NZtym8
	 HKyyWeEERf8/AN3v7TvGd/1muy/vbounHttD2Uc0onBdB+RQRKH1NUJ7jKOVP9HDn9
	 Udy27sHloM66hl2xBTgbs2TbZwUcZ/Q/PVqMKc69O8gNSxB2HEzAvcW+p+ri7OXkGT
	 iDCXL8yE6hySjYsZIRNmC+WnR8BqEOjSREVal8M5UEwfGbaZgVEj0BLT7kUkRl9utH
	 HiSeM77VN+qtG1pvUMbvDqQqHVhWrp8g3W6VLu1wLV7rMErYylWqQWpoGbikP1WMgS
	 8EdbtQuGnnPDg==
Date: Thu, 6 Nov 2025 11:38:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <20251106173853.GA1959661@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC87w7RVSDAXWXRX1sjgo4s=_Z_k62+mfTXrMZwmkEpFg@mail.gmail.com>

[+cc Senchuan]

On Thu, Nov 06, 2025 at 09:09:01AM +0100, Vincent Guittot wrote:
> On Thu, 6 Nov 2025 at 08:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > > Describe the PCIe host controller available on the S32G platforms.

> > > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> >
> > PHY is a Root Port specific resource, not Root Complex. So it
> > should be moved to the Root Port node and the controller driver
> > should parse the Root Port node and control PHY. Most of the
> > existing platforms still specify PHY and other Root Port
> > properties in controller node, but they are wrong.
> 
> Yeah, we had similar discussion on v1 and as designware core code
> doesn't support it, the goal was to follow other implementations
> until designware core is able to parse root port nodes.  I can add a
> root port node for the phy and parse it in s32 probe function but
> then If I need to restrict the number of lane to 1 instead of the
> default 2 with num-lanes then I have to put it the controller node
> otherwise designware core node will not get it.

I think it's better to put the PHY info, including num-lanes, in Root
Port DT nodes now even thought the DWC core doesn't explicitly support
that yet because it's much easier to change the DWC core and the
driver code than it is to change the DT structure.

That will mean a little extra code in the s32g driver now, but we will
be able to remove that eventually.  If we leave the PHY in the DT
controller node, we may eventually end up having to support two s32g
DT structures: the single RP style with PHY in the controller, and a
multiple RP style with PHY in the RP.

We'll likely have both structures for many existing drivers, but I
think it will be simpler if new drivers can avoid the old one.

The eic7700 driver is an example of num-lanes support in the driver:
https://lore.kernel.org/linux-pci/20251030083143.1341-1-zhangsenchuan@eswincomputing.com/

Bjorn

