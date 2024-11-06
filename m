Return-Path: <linux-pci+bounces-16093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D39719BDB47
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 02:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B785B22576
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0BE188A18;
	Wed,  6 Nov 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ae5x6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A8185B6E;
	Wed,  6 Nov 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857227; cv=none; b=dh6V0HVz711zfvKjFfXtxqc/dV6Mg0ysZlecT8xnczwUK+LtKwWXqLc7pqSeu5sndU5vngvAqqGV99PES9xzoUVdeUUWyhfe93GBMEydR5qKOY2HbtCVDp+ChNXIbbAoQ1VHW/NxLbVC2s5Yrgp+z+RNt443Gop3CIvPyjnW1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857227; c=relaxed/simple;
	bh=2qZF0UH8un2sU3i+H0aULvDk3LSIb2B4gJQw/wg2RWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FUYTKpqShGy9pH+pdSHFDwUKGTZVCIPS3epXnoVKm4ELZGVlPPBcJ6TfxmzvBhX5O4oEseatFEtfL5aYUu+QJVC4I+qhpFSKHT5gZN4d1JDMbAolEm6XT48CR4a4LkdTodGhE/0WxWCxnJ5DxWfWja1/zbT9egIME/0L++8smvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ae5x6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BFAC4CECF;
	Wed,  6 Nov 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857226;
	bh=2qZF0UH8un2sU3i+H0aULvDk3LSIb2B4gJQw/wg2RWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D/ae5x6XQivZmlQd7HUdaCNYSMauQxnhSTaij4PDtzFJDvcnKuDMp93nQHW5BPr4Q
	 yj1kDMRhtuY4pZeaMtgqr4r1g7v+oxW14PEMpKO7ZvuYvK0Fv/JEzkv5ZsZYJ4D2rg
	 QwM0CgC+nFKubQnOt/IwVn29z6TNx+I2Ms3ApCYwMAKIlOSXbsUA5FgoVPW9jDRdwA
	 11pYEpBupBzvm3lC/7dBvv4bXA7FWZqqOP1PBRrA0B1PpOC6K4uCY6sNT7JKqZb/81
	 oQvM+wgTn15tXXfAK6pnLf2GH9wF2yrFgvDkqjC7cy/rBbxK1JrZ7fGO9TW4Z9SUgE
	 tILw97FdTNqcQ==
Date: Tue, 5 Nov 2024 19:40:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/4] PCI: qcom: Add support for IPQ9574
Message-ID: <20241106014024.GA1499855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801054803.3015572-5-quic_srichara@quicinc.com>

On Thu, Aug 01, 2024 at 11:18:03AM +0530, Sricharan R wrote:
> From: devi priya <quic_devipriy@quicinc.com>
> 
> The IPQ9574 platform has four Gen3 PCIe controllers:
> two single-lane and two dual-lane based on SNPS core 5.70a.
> 
> QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
> Reuse all the members of 'ops_2_9_0'.

Wow, this is confusing.

"Based on SNPS core 5.70a", but "Synopsys IP rev is 5.80a."
Are those supposed to match?  Or is it 5.70a of one thing but 5.80a of
a different thing?

And where does ops_2_9_0 come in?  The code comment says:

  /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
  static const struct qcom_pcie_ops ops_2_9_0 = {

which doesn't match 1.27.0 or 5.70a or 5.80a.  In fact there's nothing
in the file that matches 1.*27.*0

Honestly, I don't really care if you have all the versions here in the
commit log.  But if the versions *are* here, can we make them make
sense?

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [V7] Rebased on top of [1] to avoid DBI/ATU mirroring. With that dropped
>       the need for separate ops.
>  [1] https://lore.kernel.org/linux-arm-msm/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6976efb8e2f0..e9371f945900 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1752,6 +1752,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> -- 
> 2.34.1
> 

