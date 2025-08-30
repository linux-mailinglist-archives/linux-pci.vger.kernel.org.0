Return-Path: <linux-pci+bounces-35170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE141B3C7B6
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 05:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9888D5A111B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 03:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA41F3B8A;
	Sat, 30 Aug 2025 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knb/vVYf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA747262B;
	Sat, 30 Aug 2025 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526334; cv=none; b=NfK++b+PyF7k/uDfJYtA33ksZw14St+vHudgO+LMdPw4BaizRun+agXXE+FFcu0BGr/9wEfdmiu2AXlVm7do4+Wlt9KNnlvbqSF1/M9B5+CIRDhBTnSNPFEP0g6aUmNX0o/ZIg2E7whvq2Vpo1PvBx6P/rjZ3ngS/UoYp5rpLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526334; c=relaxed/simple;
	bh=VABUD4jO9Kymnm8cj7uMAQ8AvocLC42Iebzpv/8ohiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1GUAnIeda/fIDvQOKdkwosczgyjYsN0v3l7LTsw7fnQ54ZrZe5oHy8OaOyWsjwzPpjOeWHforfb5M3g0lSQvPWmE8h04cWODJL1e73m/bqk4Nom1sQ/boIDDsQdqd+/nu6SUv0XUSSTE4W2kbfDgSnFdfW0mSfEmXAcX3O6kUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knb/vVYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6EC4CEEB;
	Sat, 30 Aug 2025 03:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756526334;
	bh=VABUD4jO9Kymnm8cj7uMAQ8AvocLC42Iebzpv/8ohiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knb/vVYf4lzqy+199q3lrWFfPdLUs3K4k2ZKF73nP9OEKi7V13ySggZQiv2/QnjKn
	 YATGK0Lmv/VQ9OpWMJLweUDUxXJrNz7qFfJMXHaKkNSVCB8SA5cbykG9MhYfHd4KBA
	 MjjMQ0SfPFwcJoz4Kpx7ZcO5ma6EzP76t1UHW37Fq+w/aeq9ValcipbntIFij7dNE5
	 K76xpi0EB9sVHWIiNteFgj6o55LbRmLuON7mGnck+00x2/Qp9qvuDEIY8mwPEk7jJR
	 ww4rvZWGxCeyCpaiJvC17/LAn0NToem0XETjxU3QuukDR03GcyUTjOTgZJOD6CjU02
	 wGM3SiHbl2QLw==
Date: Sat, 30 Aug 2025 09:28:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de, 
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 12/12] arm64: dts: fsd: Add PCIe support for Tesla FSD
 SoC
Message-ID: <dsa7u5pz7qmjaunzrqgpjkyv4xh427bbnpkdzvkpz3w6v6xf6v@5kxhihh4hw2j>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525@epcas5p2.samsung.com>
 <20250811154638.95732-13-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811154638.95732-13-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:38PM GMT, Shradha Todi wrote:
> Add the support for PCIe controller driver and phy driver for Tesla FSD.
> It includes support for both RC and EP.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  34 +++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi |  65 +++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 147 +++++++++++++++++++++
>  3 files changed, 246 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index 9ff22e1c8723..1b63c5d72d19 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -130,3 +130,37 @@ &serial_0 {
>  &ufs {
>  	status = "okay";
>  };
> +
> +&pcierc2 {

It'd be good to use underscore to differentiate RC and EP modes:

	pcie_rc1
	pcie_ep1

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
> +			<&pcie0_slot1>;

Could you please explain what these 'preset' and 'slot' pins are?

> +};
> +
> +&pcieep2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
> +			<&pcie0_slot1>;
> +};
> +
> +&pcierc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> +			 <&pcie0_slot0>;
> +};
> +
> +&pcieep0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> +			 <&pcie0_slot0>;
> +};
> +
> +&pcierc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> +};
> +
> +&pcieep1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> +};

[...]

> +		pcieep2: pcie-ep@15400000 {
> +			compatible = "tesla,fsd-pcie-ep";
> +			reg = <0x0 0x15090000 0x0 0x1000>,
> +			      <0x0 0x15400000 0x0 0x2000>,
> +			      <0x0 0x15402000 0x0 0x80>,
> +			      <0x0 0x15800000 0x0 0xff0000>;
> +			reg-names = "elbi", "dbi", "dbi2", "addr_space";
> +			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
> +				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
> +			clock-names = "aux", "dbi", "mstr", "slv";
> +			num-lanes = <4>;
> +			phys = <&pciephy0>;
> +			samsung,syscon-pcie = <&sysreg_fsys0 0x434>;
> +			status = "disabled";

So only host mode DMA is cache coherent and not endpoint? Weird.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

