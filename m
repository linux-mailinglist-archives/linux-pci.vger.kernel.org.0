Return-Path: <linux-pci+bounces-44-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B57F31B2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ECE282FA3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362551C4C;
	Tue, 21 Nov 2023 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohE6HsT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA52772A;
	Tue, 21 Nov 2023 14:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE614C433C7;
	Tue, 21 Nov 2023 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700578502;
	bh=q975IMvHTp904h9O7b2W+x9yRvoCm+xt1tUto3RHfXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohE6HsT9sw+OZaAGQxe04Vqxub4vBcXHT/A0cMRrMvn03KPK1kbWQmE8jUXPb7gHV
	 3TAKuiNmtTdqWNX+6FVBSOzIPAM+O+7UVApq3aXx96TFQkV/YjTRxHTuJA25HYtfHD
	 /7VpleuYHdh+x8VYrdfAKBNbaQyEP8yB9VFayYdoNKlNMh+vsBs8tvdH2VoSPGuSjA
	 A7hGhp+4SPYAhMvbdB4yL80v3shwE9gFqwL2KqWOO3NKqtEO1DINXEx1tMPciNhgYx
	 CtNcLPCTpUVZbqLhhOaH37XV4al0dAjoR89oySpAF8mnlfdtZt7cDaaz1bu+lCaaXE
	 iWkQfhtbU6B8Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1r5S9h-0007vM-0T;
	Tue, 21 Nov 2023 15:55:13 +0100
Date: Tue, 21 Nov 2023 15:55:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP
 controller as cache coherent
Message-ID: <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>

On Tue, Nov 21, 2023 at 08:08:13PM +0530, Mrinmay Sarkar wrote:
> The PCIe EP controller on SA8775P supports cache coherency, hence add
> the "dma-coherent" property to mark it as such.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 7eab458..ab01efe 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3620,6 +3620,7 @@
>  				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>  		interconnect-names = "pcie-mem", "cpu-pcie";
>  
> +		dma-coherent;
>  		iommus = <&pcie_smmu 0x0000 0x7f>;
>  		resets = <&gcc GCC_PCIE_0_BCR>;
>  		reset-names = "core";

What tree is this against? 

Both controllers are already marked as dma-coherent in mainline so this
patch makes no sense (and the context also looks wrong).

It was even you added them apparently:

	489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")

Johan

