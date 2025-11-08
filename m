Return-Path: <linux-pci+bounces-40622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB6C42D42
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9378D3AFC7B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8E1A3166;
	Sat,  8 Nov 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilNH3q9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B127470;
	Sat,  8 Nov 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608478; cv=none; b=h4G5z9Jgb8QIhtCtev77rQ6IF/TsqK0Jd8j5MHTg0yQ4A2obPZMiOeRtJQwP+h0MpA3i9my6O9zjWWCmbqSjr4sUD0kOStXYHQ07mZf/U2PV5dZjNyq4TK89L+y8fTLktNsc8ZjruOlxln7KdumbLBvCVQfDuceZeu0x7Zh/kHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608478; c=relaxed/simple;
	bh=QeGuROr+Dr2oL5DcoUeRVOAIwOeC5RcqPRm5KXFpnsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o496L/2b5wPtf6mCMz44AoFNX1Tdkj4FhAKghXovcN1F6AMGA5lMfBfN8jCrhjT3IW6iZpsC1QU58OCQ3BwWxKKEXTx9jCzwynSPb6KEsHDPyCIVeRU1C/+/G1gdMASnIGgse/UgBXgxzYA9vl/kewVAuTyAPFk231m9qPOaeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilNH3q9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A6C116C6;
	Sat,  8 Nov 2025 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762608478;
	bh=QeGuROr+Dr2oL5DcoUeRVOAIwOeC5RcqPRm5KXFpnsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilNH3q9NrhOHNla2+3dARxg/3Xfn1ZfQl4N1Bwdi/w3zRG3uAPUb0dj5OlNLq5szQ
	 j4u2uMCLxotZPpjEkOHexu4uKUXfbGsRA3kRtVg8OKzxSxFVebmvnuOOo8VB9yO7iM
	 Ob3otYACIYoorbZaU3eYWA9BHOuTblqgHt+u8YzeUwTBI3QNfwOt+opdia8WQWVGai
	 +A13AQMVw4fQQCAnAyVi4Xz8eDT7/2Bo4iVZ6sy4cP1cTUUxc9bvO67WunBT7DvA0E
	 EGE4cLJFasLg33S/kgZv7naDA9CrS8FNNlenKd8Aow39KEhiSvEHHYL2tZmjkoj/5k
	 zaRF0XqP+48Wg==
Date: Sat, 8 Nov 2025 14:27:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <aQ9FWEuW47L8YOxC@ryzen>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ840q5BxNS1eIai@ryzen>

On Sat, Nov 08, 2025 at 01:34:32PM +0100, Niklas Cassel wrote:
> 
> The pcie-dw-rockchip.c driver is modelled after the qcom driver.
> So if this is a problem when a ASM2806 switch is connected, I would
> expect qcom platforms to have the same problem.

Looking more closely at this, comparing the "good" kernel:

[    1.868857] pci 0004:40:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
[    1.869509] pci 0004:40:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    1.870050] pci 0004:40:00.0: PCI bridge to [bus 01-ff]
[    1.870510] pci 0004:40:00.0:   bridge window [io  0x0000-0x0fff]
[    1.871044] pci 0004:40:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.871640] pci 0004:40:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.872353] pci 0004:40:00.0: supports D1 D2
[    1.872738] pci 0004:40:00.0: PME# supported from D0 D1 D3hot
[    1.875190] pci 0004:40:00.0: Primary bus is hard wired to 0
[    1.875690] pci 0004:40:00.0: bridge configuration invalid ([bus 01-ff]), reconfiguring
[    1.876543] pci 0004:41:00.0: [1b21:2806] type 01 class 0x060400 PCIe Switch Upstream Port
[    1.877384] pci 0004:41:00.0: PCI bridge to [bus 00]
[    1.877846] pci 0004:41:00.0:   bridge window [io  0x0000-0x0fff]
[    1.878389] pci 0004:41:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.879030] pci 0004:41:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.879764] pci 0004:41:00.0: enabling Extended Tags
[    1.880614] pci 0004:41:00.0: PME# supported from D0 D3hot D3cold
[    1.881409] pci 0004:41:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0004:40:00.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    1.888729] pci 0004:41:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.889766] pci 0004:42:00.0: [1b21:2806] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.890621] pci 0004:42:00.0: PCI bridge to [bus 00]
[    1.891084] pci 0004:42:00.0:   bridge window [io  0x0000-0x0fff]
[    1.891628] pci 0004:42:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.892269] pci 0004:42:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.893028] pci 0004:42:00.0: enabling Extended Tags
...
[    1.928510] pci_bus 0004:43: busn_res: [bus 43-4f] end is updated to 44
[    1.929432] pci_bus 0004:45: busn_res: [bus 45-4f] end is updated to 45
[    1.944674] pci_bus 0004:46: busn_res: [bus 46-4f] end is updated to 46
[    1.956691] pci_bus 0004:47: busn_res: [bus 47-4f] end is updated to 47
[    1.957298] pci_bus 0004:42: busn_res: [bus 42-4f] end is updated to 47
[    1.957893] pci_bus 0004:41: busn_res: [bus 41-4f] end is updated to 47


With the "bad" kernel:
[    1.383075] pci 0004:40:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
[    1.383738] pci 0004:40:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    1.384280] pci 0004:40:00.0: PCI bridge to [bus 01-ff]
[    1.384740] pci 0004:40:00.0:   bridge window [io  0x0000-0x0fff]
[    1.385274] pci 0004:40:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.385871] pci 0004:40:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.386582] pci 0004:40:00.0: supports D1 D2
[    1.386957] pci 0004:40:00.0: PME# supported from D0 D1 D3hot
[    1.389549] pci 0004:40:00.0: Primary bus is hard wired to 0
[    1.390062] pci 0004:40:00.0: bridge configuration invalid ([bus 01-ff]), reconfiguring
[    1.390897] pci_bus 0004:41: busn_res: [bus 41-4f] end is updated to 41
[    1.391505] pci 0004:40:00.0: ROM [mem 0xf4200000-0xf420ffff pref]: assigned
[    1.392130] pci 0004:40:00.0: PCI bridge to [bus 41]
[    1.392607] pci_bus 0004:40: resource 4 [io  0x0000-0xfffff]
[    1.393103] pci_bus 0004:40: resource 5 [mem 0xf4200000-0xf4ffffff]
[    1.393657] pci_bus 0004:40: resource 6 [mem 0xa00000000-0xa3fffffff]
[    1.412296] pci 0004:41:00.0: [1b21:2806] type 01 class 0x060400 PCIe Switch Upstream Port
[    1.413155] pci 0004:41:00.0: PCI bridge to [bus 00]
[    1.413641] pci 0004:41:00.0:   bridge window [io  0x0000-0x0fff]
[    1.414204] pci 0004:41:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.414934] pci 0004:41:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.415746] pci 0004:41:00.0: enabling Extended Tags
[    1.416465] pci 0004:41:00.0: PME# supported from D0 D3hot D3cold
[    1.417181] pci 0004:41:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0004:40:00.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    1.423384] pci 0004:41:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.424348] pci_bus 0004:42: busn_res: can not insert [bus 42-41] under [bus 41] (conflicts with (null) [bus 41])
[    1.425351] pci 0004:42:00.0: [1b21:2806] type 01 class 0x060400 PCIe Switch Downstream Port
[    1.426698] pci 0004:42:00.0: PCI bridge to [bus 00]
[    1.427184] pci 0004:42:00.0:   bridge window [io  0x0000-0x0fff]
[    1.427766] pci 0004:42:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.428415] pci 0004:42:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.429171] pci 0004:42:00.0: enabling Extended Tags
...
[    1.462051] pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.463116] pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
[    1.463718] pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.464651] pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
[    1.465688] pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.466747] pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
[    1.467351] pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.468283] pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
[    1.469322] pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.470370] pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
[    1.470960] pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.471902] pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
[    1.472930] pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.473985] pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
[    1.474578] pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.475530] pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
[    1.476414] pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
[    1.477001] pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
[    1.477911] pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
[    1.478814] pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46


We can see that the pcie-dw-rockchip.c driver detects the ASM2806 switch
in both cases. So the problem is not really with enumerating the root port.

The problem seems to be that with the "bad" kernel, you get a lot of:
[    1.464651] pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them

Because the bus ends are different, and conflicts with each other.
I don't know why this happens.

Perhaps we could add a quirk for ASM2806 that does some extra sleep if that
switch is detected, if for some reason, the switch is not actually ready
after the delays defined by the PCIe specification.

(And btw. please test with the latest 6.18-rc, as, from experience, the
ASPM problems in earlier RCs can result in some weird problems that are
not immediately deduced to be caused by the ASPM enablement.)


Kind regards,
Niklas

