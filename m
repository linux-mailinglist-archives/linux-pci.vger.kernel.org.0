Return-Path: <linux-pci+bounces-2112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14A82C332
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215151C22491
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF07319C;
	Fri, 12 Jan 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY8m34m0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988173166;
	Fri, 12 Jan 2024 15:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCB3C433F1;
	Fri, 12 Jan 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705075141;
	bh=jBImdO0S4zjiJ9OH3nJj+sPPUzC+dYAUvnkM8s2S6c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HY8m34m0nNaiz0xrwm+QSOdMVhR7C3tyYKhqnIbQEvg+eg0DXS3yCDnsTeJr3RL6C
	 xbsAE78nNhaE5Dfxl2M6P5V1QkhHDFR3TkOkQVdAY9N2M3DzhSuKkySriNRLaa/MTm
	 KzTN09TOUOkrO8IO3eSbpMriKu6jcPPLhUIZtiy/dfylNIev+tpjPzIHY9TLXM41EI
	 VBlZuNCO0O3Gkmp9nWlDP9D+n4Kdvy0gwv77bRCgUd3oSCdCaZVteOspPIiraQY2Xp
	 XGQK3syqvEAVJcuT8DJ8lQbfn7x45PqZdlAT0/Asr1LDT8Bebmx3yEZmhb16Q2aOHN
	 1ZwNc1BZApd2A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rOJw4-0001kR-1H;
	Fri, 12 Jan 2024 16:59:09 +0100
Date: Fri, 12 Jan 2024 16:59:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Message-ID: <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
> CPU-PCIe path consits for registers PCIe BAR space, config space.

consits?

> As there is less access on this path compared to pcie to mem path
> add minimum vote i.e GEN1x1 bandwidth always.

gen1 bandwidth can't be right.

> In suspend remove the cpu vote after register space access is done.
> 
> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> cc: stable@vger.kernel.org

This does not look like a fix so drop the above.

The commit you refer to explicitly left this path unconfigured for now
and only added support for the configuring the mem path as needed on
sc8280xp which otherwise would crash.

> @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 */
>  	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>  	if (ret) {
> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  		pcie->suspended = true;
>  	}
>  
> +	/* Remove cpu path vote after all the register access is done */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, 0);

I believe you should use icc_disable() here.

> +	if (ret) {
> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> +		return ret;

And you need to unwind before returning on errors.

> +	}
>  	return 0;
>  }
>  
> @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));

icc_enable()

> +	if (ret) {
> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> +		return ret;
> +	}

Johan

