Return-Path: <linux-pci+bounces-38843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C774BF4630
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD81C35152B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061371D5CC9;
	Tue, 21 Oct 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHcnkSfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12621BFE00;
	Tue, 21 Oct 2025 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013933; cv=none; b=VDw4Dn24zZqIuXuFKCN+3soBqR//AW5Y5JC564WCCSMLFb3uOMsLJIvsOwL3P6oMQjM/b4kFAv6fZ7jZO2c3O/w4p1pgomTSAzGqIqLjj7CaOPfhryJGyjudZnmwaIxuK3iA0FLIrDsF1yWDVlKIJfypj09+rdejMSn+4pu8F6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013933; c=relaxed/simple;
	bh=8UAGN1YhXZIbc93snwY/CRtubSt6sDkHXFrJ7cAY2Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqUFWr+vsqMfXGYehhaT4bdWOJE8gmUNoLK9wIhzfmGInHXK6ezAgyD3IUoCu31pMtXBp3tN5TaQuvdzt2eHBETlpRExN8rMPLjOIcqSgiqr2/BW2O9k7QwJUoyF+aFQ8wlNlB1GFPLKWCkiR0a5plBMvX/Sd0qhiV2vnrqseVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHcnkSfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68ABC116C6;
	Tue, 21 Oct 2025 02:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761013933;
	bh=8UAGN1YhXZIbc93snwY/CRtubSt6sDkHXFrJ7cAY2Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHcnkSfVYUiNs1+laZL/oTzN3Hwxulz3SDXzmd39w+CmT5bYFjNvL3B2LlK9tR2EZ
	 MsV+kFf0G0g34cY2gCGrybn3d+8LVj5mPlzQx65l6HFVpSX90tezuAsndIbl8dwdM/
	 IIKkMsR6N2dMg011uJPL28VumrpkuIW5fMBZPytwtZrLDtraufFed0Xf55NANa26OJ
	 OLhoySAkQjU6VOn+Ojr32RTbf4nUiTFyJ+SUYaQechFw9ycmSg9Iyn1bkx8nlbpYjx
	 7l0l0rKtIRP7EIY2QMIhZwgN9s49EkHms8o4WL/BnTnrMl27ydTB3EENp18Fo/09Ro
	 tIPFNNyq18iiw==
Date: Tue, 21 Oct 2025 08:02:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
	stable@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <aaug44bngs5amid7un4plotcjpbc6ym44cztnhet7z44ybywgc@apzhg6enhxgy>
References: <20251017164558.GA1034609@bhelgaas>
 <54FD6159-AE45-432B-8F0E-4654721D16A6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54FD6159-AE45-432B-8F0E-4654721D16A6@kernel.org>

On Sat, Oct 18, 2025 at 07:07:35AM +0200, Niklas Cassel wrote:
> On 17 October 2025 18:45:58 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> (snip)
> 
> >> 
> >> Thus, prevent advertising L1 Substates support until proper driver support
> >> is added.
> >
> >I think Mani is planning a change so we don't try to enable L1
> >Substates by default, which should avoid the regression even without a
> >patch like this.
> 
> Sounds good, I suggested the same:
> https://lore.kernel.org/linux-pci/aO9tWjgHnkATroNa@ryzen/
> 
> 
> >
> >That will still leave the existing CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> >and sysfs l1_1_aspm problems.
> 
> Indeed, which is why I think that this patch is v6.18 material.
> 

Not strictly a 6.18 material as the Kconfig/sysfs/cmdline issues existed even
before we enabled the ASPM states by default in v6.18-rc1.

The default ASPM issue will be fixed by a separate patch which will be generic
for all platforms. I'll apply this patch for v6.19.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

