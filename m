Return-Path: <linux-pci+bounces-26236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D7A93AE0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920C017C80E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221871C57B2;
	Fri, 18 Apr 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui/c38Nb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6E433C4;
	Fri, 18 Apr 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994044; cv=none; b=gcX2UCTghwg7tRQZFi8zzoOtTrRps9fUEYvGD8KA8XsIvu7Vq7i3PhNxU16M3EULnvb80nL8NuO0U/h/DaOYv9EPGvTZnBt+bX42DHpa1Gat+JrKQXjIbR58YrRhVSsATxDccjd6eXrvCm4CmAjINCreAfMP7S2duJYFBRk81Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994044; c=relaxed/simple;
	bh=ed3FOAzpZAREOk5SHpU5+5vpIY0q3AAD2Ue6wKBsD4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AAxiJK0qlHlp2ICQnGcYduetg4zv/W642frOFcMkRwxzD11R4TzlDikUzGyP0XT/MAEcwt4r5Ziuln9cVfp2YDHkxj9YoSj2zBrAQXvBYHV6wpSoizlODifAH2oBY7q7h2NWhMyoDoH5OFM9J1OuFaC330CtcNO33i8D7WfuTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui/c38Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E0BC4CEE2;
	Fri, 18 Apr 2025 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994043;
	bh=ed3FOAzpZAREOk5SHpU5+5vpIY0q3AAD2Ue6wKBsD4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ui/c38NbH9ruZHxr8vvOvTLlkpoR0fAjRPRj/AoBYuFSyPo6Bdg4oK2pwjR9+lDbV
	 97EHazWSbHuoTN7bNvnbWYCV2MiXK4ccaJ11/MLxaAnYjCg3AqZCxjduTZzZoG+Z3m
	 wrH0kqYAkGSn0p4oIT+ICPA6wHS+iQ4gJ1EdSgjpmLC+Sx6L8fLJ7B1EJmj8bfwSwZ
	 L5VJcVcEZQ88MjuWWjeMpLoZ+7uciEZPY/a8W97aDd8Sq8k7/5afqK0f06OVrtvVyq
	 bOJvNJw6ZerlcwDQufJKpCEiA6PpXmEBOa9JjbI9zH+NxjhelDieZrRhDoBgF/9eks
	 PJdzC2yUBwupg==
Date: Fri, 18 Apr 2025 11:34:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: huaqian.li@siemens.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	baocheng.su@siemens.com, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, diogo.ivo@siemens.com,
	jan.kiszka@siemens.com, kristo@kernel.org, krzk+dt@kernel.org,
	kw@linux.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s-vadapalli@ti.com,
	ssantosh@kernel.org, vigneshr@ti.com, iommu@lists.linux.dev
Subject: Re: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Message-ID: <20250418163401.GA159541@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418134324.ewsfnze2btnx2r2w@country>

On Fri, Apr 18, 2025 at 08:43:24AM -0500, Nishanth Menon wrote:
> On 15:30-20250418, huaqian.li@siemens.com wrote:
> > 
> > Jan Kiszka (7):
> >   dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
> >   dt-bindings: PCI: ti,am65: Extend for use with PVU
> >   soc: ti: Add IOMMU-like PVU driver
> >   PCI: keystone: Add support for PVU-based DMA isolation on AM654
> >   arm64: dts: ti: k3-am65-main: Add PVU nodes
> >   arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
> >   arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
> >     behind PCI RC
> > 
> > Li Hua Qian (1):
> >   swiotlb: Make IO_TLB_SEGSIZE configurable
> 
> I see at least 3 or 4 maintainers needing to co-ordinate, gets
> complicated as I am not sure which maintainer needs to pick up what
> patches in what dependency order. This looks like a mixed bag. Can
> we split this patch into independent series for each maintainer with
> clear indication of dependencies that is spread around a couple of
> kernel windows (maybe dts comes in last?)

The keystone patch ("[4/8] PCI: keystone: Add support for PVU-based
DMA isolation on AM654") depends on interfaces added by "[3/8] soc:
ti: Add IOMMU-like PVU driver", so I can't really take 4/8 by itself.

But I've acked 4/8, so it can be merged along with the rest of the
series.  I assumed the easiest would be via the drivers/soc/ti/
maintainer, i.e., you, Nisanth :)

Let me know if I can do anything.

Bjorn

