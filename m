Return-Path: <linux-pci+bounces-22339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF623A43F62
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1A5172E02
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663B266EF4;
	Tue, 25 Feb 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6/PcmnM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177819309E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486473; cv=none; b=SBDqsqr8lI4RTKszoO0VLsSiFzOGJM4Eg931DgmKku/UVtLWhYkz/h8mUMQMzaw4gEY/aoovTQZtQ8Osed7ESKtieUGnx0LMe2B11zoKuJSk2osYQsTBVhEFW6VhIXv+kBdi34xx16pNtNqaoI0IFGP2DE/b4Xwp1iQT7JY2SDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486473; c=relaxed/simple;
	bh=2ncFbmwvUgcbSappvhge9nJXN6LJwl6EsNRd1xDptck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoBzjZXwQRJ5W7A8XbJFUXDeVgab5tTLxwWB5AKzQWlP7E4dXOqVAtSdSGWFDGC+0lrwgfc7rgxuI391YKgHVc68Z1SANy98NvHzCEiW9brzBHHYtH7BXk6iNta3jQsFL8ARzDtQcB9PUtslLysJkH3IsALlMqS/CLYl9W6n5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6/PcmnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E52C4CEDD;
	Tue, 25 Feb 2025 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486473;
	bh=2ncFbmwvUgcbSappvhge9nJXN6LJwl6EsNRd1xDptck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6/PcmnM0ttEbTSsdffPDQRNk95br50C45yPJLrv44lgxoyS89N6KrJTnU+hdEVny
	 Gglujib8J6ld8Esi7AubTzFM2cz/2mTZ2Z4Ye9Et64G+bUBW9iaWl9z1Ms7kNtqEhD
	 v3i1Oz8Gde7IBiGBcsRm6a9UpaRLs3lYbdbTLAiXFUqbdPQjOoOm/ROHYmLT8UrSKa
	 oMreYhsCZgbAYQ0z9hWhBQ6v3SvoaW0w97yfwCHutoIa4T0fqQI+2v7CyYaRBac6Zh
	 axoAN6V4Xa4VSQRn87pHDcHDNA/wk4821aRwXHfr7Rhqj8GZq8ZOfLfqGTZbjyvd0k
	 DKTkcnrcsrcag==
Date: Tue, 25 Feb 2025 13:27:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <Z723RNjC2pYYqAHn@ryzen>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250221202646.395252-4-cassel@kernel.org>
 <93cdce39-1ae6-4939-a3fc-db10be7564e5@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93cdce39-1ae6-4939-a3fc-db10be7564e5@rock-chips.com>

Hello Shawn,

On Tue, Feb 25, 2025 at 09:35:22AM +0800, Shawn Lin wrote:
> On 2025/2/22 4:26, Niklas Cassel wrote:
> > When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> > enabled, the host side prints:
> > DMAR: VT-d detected Invalidation Time-out Error: SID 0
> > 
> > When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> > enabled, the host side prints:
> > iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> > 
> > Usually, to handle these issues, we add a quirk for the PCI vendor and
> > device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> > we cannot usually modify the capabilities on the EP side.
> > 
> > In this case, we can modify the capabilties on the EP side. Thus, hide the
> > broken ATS capability on rk3588 when running in EP mode. That way,
> 
> Niklas, Thanks for reporting this issue. It's been a while before
> getting confirmation from the design team. Now I can confirm the ATS support
> for RK3588 is only available running as RC but I'm still
> requesting erratum about this issue if possible.
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Thank you for confirming!

Considering that rock5b running in RC mode:
# lspci -vvvs 0000:00:00.0 | grep Capa
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=16/32 Maskable+ 64bit+
        Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 8
        Capabilities: [b0] MSI-X: Enable- Count=128 Masked-
        Capabilities: [100 v2] Advanced Error Reporting
        Capabilities: [148 v1] Secondary PCI Express
        Capabilities: [190 v1] L1 PM Substates
        Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
        Capabilities: [2d0 v1] Vendor Specific Information: ID=0006 Rev=0 Len=018 <?>

and rock5b running in EP mode:
# lspci -vvvs 0000:01:00.0 | grep Capa
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=32/32 Maskable+ 64bit+
        Capabilities: [70] Express (v2) Endpoint, IntMsgNum 8
        Capabilities: [b0] MSI-X: Enable- Count=2048 Masked-
        Capabilities: [100 v2] Advanced Error Reporting
        Capabilities: [148 v1] Secondary PCI Express
        Capabilities: [178 v1] Page Request Interface (PRI)
                Page Request Capacity: 00000001, Page Request Allocation: 00000000
        Capabilities: [188 v1] Latency Tolerance Reporting
        Capabilities: [190 v1] L1 PM Substates
        Capabilities: [1a0 v1] Dynamic Power Allocation <?>
        Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
        Capabilities: [2d0 v1] Vendor Specific Information: ID=0006 Rev=0 Len=018 <?>
        Capabilities: [2e8 v1] Physical Resizable BAR

already exposes different Capabilities (depending on the mode the PCIe
controller is running in), I would say that it slightly confusing that
Synopsys chose not to hide the ATS Capability when the PCIe controller
is running in EP mode.
So, I would guess that there is an errata for this.

But I think that your confirmation is enough.
Will take a while before I can send out a V2 though, but quite confident
that we can get something merged in time for 6.15.


Kind regards,
Niklas

