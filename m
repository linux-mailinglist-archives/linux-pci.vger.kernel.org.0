Return-Path: <linux-pci+bounces-3369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24207851F61
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91C4B211AA
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806374D108;
	Mon, 12 Feb 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN459PGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C14CE17;
	Mon, 12 Feb 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772625; cv=none; b=GSasimkF3W4jlNi7iemDZcummP9C0S7iua2k3rCahxdZ1DaYpMfOkEkVcj8XTojqyqU8JfdNABn2ElroI3aFklKcrHXMJwGsZU0Vlt7gmLucEYsyDgd86rrd8NH22x5//SkWXQXwHtjgKcTkd7Z0Vl+EMau2TyA9F9m2BXgLpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772625; c=relaxed/simple;
	bh=WJTZLg7P31UOHkGMFRbZcg8HMo6a14geuMHlP7wmsvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OjKUlqpJB2a5iuePw5nqENwVdJESV9ElbmtXsIsEnt8SVgofgMDyHNZp6eO5VarLoqBso8CLv28BcTZuRiOWv+JplOvUaWxipHq8IntLi53xqwduwpVH93BBxmTk58wIeOeZsGmt9fav+rFk5TC1ABRXbg/MpTxgtPSUa/HH/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN459PGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF61C433C7;
	Mon, 12 Feb 2024 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772624;
	bh=WJTZLg7P31UOHkGMFRbZcg8HMo6a14geuMHlP7wmsvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tN459PGdNiP+K+FQS2ePZMWvSN1MacojwojTa2FtvHGf+BF0ypfy8deCji0pmyel5
	 T6Rx/NHP+OLpMrzrqj5vcRYlgOA8WXh4Otweqor/ljRzbS2gaz8K1ye8sTq5fWkn0D
	 009W4+da/usr1mTSBKNa8/kowX4/rvZd3P8+SljbI5pkkaEUO+sqy7LmDaK9aTkLpK
	 e4OaYB7rjkQGbZZK/c674VcapdxCaj4xIQn35XqdtMlj+6uG4vgd7zkxf7UUdLQCjo
	 IrF8X6PmgDB+NsV4Id64mN2dJwH/S/oGg5BCVWJLBRuXBfj5bBVbGd2oVaAifqLvGi
	 vTuplK4Qe7RvA==
Date: Mon, 12 Feb 2024 15:17:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <20240212211703.GA1145714@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-topic-8280_pcie-v2-2-1cef4b606883@linaro.org>

Maybe include the reason in the subject?  "Read back" is literally
what the diff says.

On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
> To ensure write completion, read the PARF_LTSSM register after setting
> the LTSSM enable bit before polling for "link up".

The write will obviously complete *some* time; I assume the point is
that it's important for it to complete before some other event, and it
would be nice to know why that's important.

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index cbde9effa352..6a469ed213ce 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -539,6 +539,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  	val = readl(pcie->parf + PARF_LTSSM);
>  	val |= LTSSM_EN;
>  	writel(val, pcie->parf + PARF_LTSSM);
> +	readl(pcie->parf + PARF_LTSSM);
>  }
>  
>  static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
> 
> -- 
> 2.40.1
> 

