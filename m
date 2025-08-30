Return-Path: <linux-pci+bounces-35183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4FB3CB46
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409B51BA40B5
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134B1EA7D2;
	Sat, 30 Aug 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW9qDrs2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCB42050;
	Sat, 30 Aug 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560695; cv=none; b=dQthiGxOQvp8CRkDfosKV1Q2n9KYQj4p99YrLA3UlxkY3k6x53LsKVyl6Kt6TGzLTstMeQ47XQEN3OBHTjnFQ/3CD8ETNajIf7gY+dW2BQbqpmM9N/HIKNrOJifnAb44PLpKF6dzSD6wvASA4MYBeb8S4wZPVYpVL+sZdkd/68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560695; c=relaxed/simple;
	bh=w3wYydljHQg2HpG8JrWb7tcoSoUd51RkuNZCVaIMrNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEHiN+vx1feoRm48WhccVMWG1QPOV4QInaeSRBDx0lTuAknzf94Me46OgwN7O8xb5jickPdQfvSXgJzSv01Mla0J7Al0cedkyBBhqHLGhU274Bcy+Y+EGH2XPmGSfVPs7PvVj9mXD1RVyQWDpyWfhdGwTXQt59H5ifufY4PMzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW9qDrs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABC9C4CEEB;
	Sat, 30 Aug 2025 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756560694;
	bh=w3wYydljHQg2HpG8JrWb7tcoSoUd51RkuNZCVaIMrNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW9qDrs2bJRKGg8XAOsaEP1hLjKbCPHeE/cIF5MfgRVU3+Gn18GZG5MDIVXKx2390
	 hHjHPiL8VPQqtHipkLrWoJFg/OCCg6Ine0d6tXQ7N6NHsG1w06rfE7jkZm3dkafJon
	 Et6BZQXVuDpY0SBmJbHX2yvJBW/Wx57N6z11XB5fL98NGv/DLI+8H155xG2eCUZEkT
	 5jdkflTf30bJ522qexMAoKMdVkK6psJZ3/1RTu/0HkQUqetKz4VO328B4cliwzuyJg
	 sL5LjSZMJG5MkqX+4zvC2BvUFEveTbdsYKFa8wPtjiuR1ovLMk9ybXiXMD1MGcDQaU
	 5LT47nEMxhr8w==
Date: Sat, 30 Aug 2025 19:01:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/15] arm64: dts: cix: Add PCIe Root Complex on sky1
Message-ID: <4mxs6oyaipouujkfw2lomf4fp3z64f2tos7b35qkzlx7c6vi63@lzm4syg4vayh>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-15-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-15-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:38PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
> Cadence PCIe core.
> 
> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
> using the ARM GICv3.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
> Changes for v8:
> - The rcsu register is split into two parts: rcsu_strap and rcsu_status.
> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 7dfe7677e649..26c325d8d934 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -288,6 +288,132 @@ mbox_ap2sfh: mailbox@80a0000 {
>  			cix,mbox-dir = "tx";
>  		};
>  
> +		pcie_x8_rc: pcie@a010000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a010000 0x00 0x10000>,
> +			      <0x00 0x2c000000 0x00 0x4000000>,
> +			      <0x00 0x0a000300 0x00 0x100>,
> +			      <0x00 0x0a000400 0x00 0x100>,
> +			      <0x00 0x60000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
> +				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0xc0 0xff>;

Isn't each controller in separate domain? Or as per the hw design, all
controllers are under a single domain sharing the busses?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

