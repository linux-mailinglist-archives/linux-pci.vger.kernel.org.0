Return-Path: <linux-pci+bounces-40650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133CC43D7A
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C193A86E0
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E32EC088;
	Sun,  9 Nov 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hurIJbO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC31D432D;
	Sun,  9 Nov 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691308; cv=none; b=t8dNCLotK7Q1/NCQ9tt+hhXS4E1SdDjU3lHtalOMBnCx8xNLMQO23k2gfuMheORwBcfXAsGpZk3D49ikHO/XS6ORy/oA8VWk2Uq3A7s1psmk8ZvdccD4qg+4xmRRnmvrSZ4fUHYvqCRvkPeVJ4FoZDY2aJXaNYWsP2eer5Ny4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691308; c=relaxed/simple;
	bh=9+deIiz/07lRUWttLH1XL6KToavdGNMSxgLPjvkZhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I00AvXOenYpXypKMlNARr6i2L18a7PtX49dxEYF4HjeX8OkYDUPJNSnBfs5W96PEztmHOjqhhCooCIgZlVzgagv/mp7J876uffYEGM4PTpHzu/PDYRJ3Cy2HWu0cfolx9pvk/7kKaZyMqnD/rdkdVSutlx5uMGAOA+a0qbpsXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hurIJbO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41ABC4CEF8;
	Sun,  9 Nov 2025 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762691307;
	bh=9+deIiz/07lRUWttLH1XL6KToavdGNMSxgLPjvkZhJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hurIJbO4oHCGlhmRNAgt+fgtD84571YdTIU65SqQLikCy0YK6bGSG7HxhBNlSk9aS
	 PALZVZ02wZOtd9kZLJqpdvYHJZ/HSYktjSKv08/JU4tlGx8jIssFmNBzs4yu2IGtJU
	 0YxNi2u0zPftBTq/zVxWk45vug4/C5PHWgNZJRuErdgmGm9yisSh6mwc0bA40SRXas
	 FbTqSGCiqroy0yC+wm+BmvTih4g6V/tnUB0rYJShev3QE87VQusnlGoMuV7RlUvqbg
	 CkslesMC7ljHB7f7iAID75aBnIQP3T9N/4s6Ty0pftu6RB/9GGpUUvhN9L9fBqEL/h
	 wvgFouCpUPSUg==
Date: Sun, 9 Nov 2025 13:28:22 +0100
From: Niklas Cassel <cassel@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
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
Message-ID: <aRCI5kG16_1erMME@ryzen>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen>
 <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>

On Sun, Nov 09, 2025 at 01:42:23PM +0900, FUKAUMI Naoki wrote:
> Hi Niklas,
> 
> On 11/8/25 22:27, Niklas Cassel wrote:
> (snip)> (And btw. please test with the latest 6.18-rc, as, from experience,
> the
> > ASPM problems in earlier RCs can result in some weird problems that are
> > not immediately deduced to be caused by the ASPM enablement.)
> 
> Here is dmesg from v6.18-rc4:
>  https://gist.github.com/RadxaNaoki/40e1d049bff4f1d2d4773a5ba0ed9dff

Same problem as before:
[    1.732538] pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.732645] pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
[    1.732651] pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.732661] pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
[    1.732840] pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.732947] pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
[    1.732952] pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.732962] pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
[    1.733134] pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.733246] pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
[    1.733255] pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.733266] pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
[    1.733438] pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.733544] pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
[    1.733550] pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
[    1.733560] pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
[    1.733571] pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
[    1.733575] pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
[    1.733585] pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
[    1.733596] pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46


Seems like the ASM2806 switch, for some reason, is not ready.

One change that Diederik pointed out is that in the "good" case,
the link is always in Gen1 speed.

Perhaps you could build with CONFIG_PCI_QUIRKS=y and try this patch:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..ac134d95a97f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -96,6 +96,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	static const struct pci_device_id ids[] = {
 		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
+		{ PCI_VDEVICE(ASMEDIA, 0x2806) }, /* ASMedia ASM2806 */
 		{}
 	};
 	u16 lnksta, lnkctl2;





If that does not work, perhaps you could try this patch
(assuming that all Rock 5C:s have a ASM2806 on pcie2x1l2):

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
index dd7317bab613..26f8539d934a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
@@ -452,6 +452,7 @@ &pcie2x1l2 {
 	pinctrl-0 = <&pcie20x1_2_perstn_m0>;
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&pcie2x1l2_3v3>;
+	max-link-speed = <1>;
 	status = "okay";
 };



Kind regards,
Niklas

