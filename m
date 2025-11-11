Return-Path: <linux-pci+bounces-40915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FCC4E484
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8CA189DABA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DEF2E0412;
	Tue, 11 Nov 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOszoN0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5892DCC04;
	Tue, 11 Nov 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869654; cv=none; b=epU+6RJ2W2Na4cbNE1FUaBVHMPNqo4V1LqlemU1ReJlMV5IrrYebVw145z2m9ryikwnMASgEFzukHMw3DsJ/t/HRftrNF3vbCPC/gwXlwyidJIt9CptFCRAUW0okDIsOicMjcIBHR2yBM/BnQp4ILQWpp2LYYyPms0oC5/lcvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869654; c=relaxed/simple;
	bh=f2fo/lMwwwTFs05IRMmwp7u2nd3gJMMvyXczqFBKzc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRqDbzn+RmgUDjBP6nhC5d5x0kGlpndhuKaHR+p+0vhV11G+29+e8IT4XdTRF7xHZk+TCkm85TjomMd7XLoMXfTJp7cfptGBLZgbCbuN1uMI7g/hJy2yFq1BsnsO+ZtxhTrd4kXt/VD71Hod5etZicm5aE4q5E+EWBhbTPAQM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOszoN0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F89C116D0;
	Tue, 11 Nov 2025 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869654;
	bh=f2fo/lMwwwTFs05IRMmwp7u2nd3gJMMvyXczqFBKzc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOszoN0EVkDNaWiWT/dOfBVBREwWsaVPDEGgezj7eMzfFJ9X1OoM3t/4ldDkESoI0
	 9vdP4ZBbU1P0o79MbD0CLokJBT4Sh1gjMWlCF/3sNJGOfaaoIbYpd8VN5GaP3Cl5Q0
	 1cjXs4XF7MgSNYKXDpDh0yI7t0wMSXlR06GHCXg2gK0YRozBI/hDD2+SeeAJZM9Yud
	 8qLnNKy86+Ne+HzRkTrRuaYLfL142/T49KYaGGKIbIog7L81ls5n9iI5bT3/GM1LMG
	 JfZomoFK8p5IRHGgHnQELr0Sggxf4YmETL8BhtOim0JVGLBiJNjcLl1ksNgX+rZV1+
	 iIcsfjVsSbScQ==
Date: Tue, 11 Nov 2025 19:30:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?B?V2lsY3p577+9P3NraQ==?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <admktutwz6542najyyo5vlrci5euqlxnwueaqxixxy7pruqoe5@6qbbejnn5gpb>
References: <20251111105100.869997-8-cassel@kernel.org>
 <aRMZS3EUYx189Xup@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRMZS3EUYx189Xup@wunner.de>

On Tue, Nov 11, 2025 at 12:08:59PM +0100, Lukas Wunner wrote:
> On Tue, Nov 11, 2025 at 11:51:00AM +0100, Niklas Cassel wrote:
> > Revert all patches related to pcie-designware Root Complex Link Up IRQ
> > support.
> > 
> > While this fake hotplugging was a nice idea, it has shown that this feature
> > does not handle PCIe switches correctly:
> [...]
> > During the initial scan, PCI core doesn't see the switch and since the Root
> > Port is not hot plug capable, the secondary bus number gets assigned as the
> > subordinate bus number. This means, the PCI core assumes that only one bus
> > will appear behind the Root Port since the Root Port is not hot plug
> > capable.
> > 
> > This works perfectly fine for PCIe endpoints connected to the Root Port,
> > since they don't extend the bus. However, if a PCIe switch is connected,
> > then there is a problem when the downstream busses starts showing up and
> > the PCI core doesn't extend the subordinate bus number after initial scan
> > during boot.
> 
> In principle it is possible to set the is_hotplug_bridge flag on the
> bridge to force allocation of more buses.  We've already got a quirk
> to set the flag on a Conventional PCI bridge whose hotplug capability
> cannot be discovered otherwise (see quirk_hotplug_bridge() in
> drivers/pci/quirks.c).

But here, the bridges are not hotplug capable at all. They do not support the
PCI Hot-Plug Specification. So setting the flag would be incorrect.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

