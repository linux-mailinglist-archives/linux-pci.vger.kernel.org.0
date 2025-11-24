Return-Path: <linux-pci+bounces-41934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11740C7FBAF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7E10349B35
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040AA2FC013;
	Mon, 24 Nov 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIk56rAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092D2F7ABA;
	Mon, 24 Nov 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977835; cv=none; b=EkMdUuo55g6Zx9RaucCarsKJH4goKPVU/zzKwbcverzy0k5XUjl47kjo9DT05JUDTKuzuYAoPEWWu80uzEkEgyEzJFCG45P2UgkWvmeVhjkSgS0uSxdXpshkHQyTWMK9Ebl30UiMiI7lc33WcSPQorBE2U0Dk6qShvgB7NiY5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977835; c=relaxed/simple;
	bh=bASfff82Xxt7ngaVSFG9avx6FhFPZUj+QtmErTDg24A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHJ/rfi135fkEi9oWf4rAuhjRt1vayUD/xd5AVg4pDVedZt8TEJOoFkjyMKo29JFK6f2KuCSllDtMEcptTJLqIPk1kq5B5+aEKNTAt/6wxbcQKU2TMyn579XTBEbC7PVZ0moe8Y40tOODFT+0NfNmE3UDXHlA/flkhRUBP48oqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIk56rAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7DFC16AAE;
	Mon, 24 Nov 2025 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977835;
	bh=bASfff82Xxt7ngaVSFG9avx6FhFPZUj+QtmErTDg24A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIk56rAJr9IMPxcPnfspRsVoorSI+MPgdaWXBtVKQaAvYHbKilPtxBtq7HIU98Af2
	 Ch8NHjhiC/ov16p7Elm9xxrUF4DxjKN0TvqJPhi1IXUImh+lizpdcRXSJKLFzpGKGF
	 1z49l1fFp3XwmFqSYZ4n6I9TqgeYVvHhYiZCvEGZLs2aeULYk1b2WdTfialVG+Hk6S
	 drKA1h4/bY21JL/GlwbbihAk1bDzWmZnptjcPdZPty7IoPEgWsrbW5GmAA8DcLWULO
	 WS8+ZogLcVIET98ETRxt2WipNSx1ktLu6Dv0aCBkJVeE6UtrwiYQBJq5MA9d6uH+zc
	 FLlRnE6UbIbYg==
Date: Mon, 24 Nov 2025 10:50:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <aSQqZcW39Ze1IE74@ryzen>
References: <20251111105100.869997-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>

On Tue, Nov 11, 2025 at 11:51:00AM +0100, Niklas Cassel wrote:
> Revert all patches related to pcie-designware Root Complex Link Up IRQ
> support.
> 
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> During the initial scan, PCI core doesn't see the switch and since the Root
> Port is not hot plug capable, the secondary bus number gets assigned as the
> subordinate bus number. This means, the PCI core assumes that only one bus
> will appear behind the Root Port since the Root Port is not hot plug
> capable.
> 
> This works perfectly fine for PCIe endpoints connected to the Root Port,
> since they don't extend the bus. However, if a PCIe switch is connected,
> then there is a problem when the downstream busses starts showing up and
> the PCI core doesn't extend the subordinate bus number after initial scan
> during boot.
> 
> The long term plan is to migrate this driver to the pwrctrl framework,
> once it adds proper support for powering up and enumerating PCIe switches.


Hello PCI maintainers,

Merge window is opening soon,
what is the status of this series?


Kind regards,
Niklas

