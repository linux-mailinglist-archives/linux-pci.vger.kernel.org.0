Return-Path: <linux-pci+bounces-13378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521EB97ECA6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64921F221DE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1419CC2C;
	Mon, 23 Sep 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyMGdrU4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419881AC1
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100032; cv=none; b=RyreoxjShV26+wUh6EBdPt582Mg2faHe0wEm7J3sbk3dxxuzckL00kBpPv9UYNqZpwLUEqINw9gXJrEXVQxiX0A5ZkRQ/f9XDco3KEPOJxi6KRLrGVkJNGwqH9K5lthFPSLI4h4dAZ2hkYMC7bzRr8t+caYmA4uco2k6jPOb+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100032; c=relaxed/simple;
	bh=k5b1vUgAi9EhHehY2cDcSsh3AAo7r60XqvMs3ip0KPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFxqsvB8Gp07ux+YSQ8ObWoIP/scdiCuTSbk7NKQ/tDdN/tbhyjSIXuf8VBWmavQ8959OmXRtrDhCHHPqZJGvcJox718QjsXxV1LCxsdXjUVL5gAPvCIAMAb0ovgrjnurBI5Muc8yHmme2Pi5gB7qyAK1FkiDsh1DAZuSKD2xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zyMGdrU4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so40022335e9.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727100027; x=1727704827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8SazwJrWtDCMj4dPgSxXhKdNI4ps1CxW8kM2uCcbug=;
        b=zyMGdrU4zPbJus2HxGE2EwYHMsYHOBUopH1suD5uCJDm4+HqajSv/l/Hn7c5IhgAVw
         G3CJnq7bdmJEepCQ4vh2R8M38f2ub7I21z2OgQKHI4m0ZQsDBdcNqat20UWspzXaNVHx
         fIgE+A2Pw3V4iWzg0GaPm/zV5iRWfEoXem83seAprcQm+Qx6JzU4FFUACHpIfCiEZHXE
         jDwVOmgEVWlnAndvKaVlDevqpmn8FLhgmO2h7DgE4xgU+uh+sAbvCy1hDV16d2KYQsY8
         Kfri7f3KbXIYVHnBBRwIh+krpG9nJlBJyhbYYcILMlGN0hIw0FjFURL2XVbwnQ9DbZ0Q
         F+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727100027; x=1727704827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8SazwJrWtDCMj4dPgSxXhKdNI4ps1CxW8kM2uCcbug=;
        b=s1P2D/PtJx2HwmrfFikNkzauk1umMMDzcFshEwiYt+1jZoOyUWnG1nl0qw73LNC478
         tLx68tBT75Q8N8DQANrJNC8RHEA77v6mpcI1huFgSTts1CmDlrLr0ESRnbrQvBeS/n13
         eQU8euYpf2WeiqJ8WJ8imHMwlrR+LNfbi9dyjGOL4upJ/jhUzSoWLnlioSC4WawBQaE+
         z3/0z4yt6GW392dH7PylPFEpPWvoueXf9ZtRhjCTmpD+cve2ug9FDRkW/TUUQYnG6ZnK
         SbJPBTXcmLmGkLdZ1PJ13ZugndCSbWa40einGmmTpKtQTp1XiDlntOWU/ScbiEIT89Uv
         3qHw==
X-Forwarded-Encrypted: i=1; AJvYcCXILRC0gBg6C3l0RWFdLVTRLKEUU0I6c4XSQJh89BjuCXEZrTg0v2RbZjiVw4768vpR6q0WuyXgnqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mR5yFzJHd/ykPWul4NWPiYdPMjIZgJCgLjwoNQjqUqPss/gT
	2D5SJ44TS5zmRQoZiUPvl4dYaiDn17Umi5MaH0I6PrgpqbsCu+mV79Y7wX2JDw==
X-Google-Smtp-Source: AGHT+IGd4Jgcl/E/mParjkXqLeUflk39tqcsXEMYyEzYrJhf0HeCTnOsmZo3zvuU483VWuoxuNNxvw==
X-Received: by 2002:a05:600c:4706:b0:42c:c073:412b with SMTP id 5b1f17b1804b1-42e7adb1f0amr80190915e9.30.1727100027393;
        Mon, 23 Sep 2024 07:00:27 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7affcc6esm103072955e9.47.2024.09.23.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:00:26 -0700 (PDT)
Date: Mon, 23 Sep 2024 16:00:25 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: qcom: Add new cfg and ops without config_sid
 callback for X1E80100
Message-ID: <20240923140025.4qhguusbhiajf3xa@thinkpad>
References: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
 <20240923125713.3411487-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923125713.3411487-6-quic_qianyu@quicinc.com>

On Mon, Sep 23, 2024 at 05:57:12AM -0700, Qiang Yu wrote:

No need to mention the ops/cfg in subject. It is a detail for patch description.
So use:

"PCI: qcom: Add support for X1E80100 SoC"

Also add some information about the IP capability. Like what speed/gen version
it supports, lane width etc...

> Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
> callback to config BDF to SID table. However, this callback is not
> required for X1E80100 because it has smmuv3 support and BDF to SID table
> will be not present.
> 
> Hence introduce cfg_1_38_0 and ops_1_38_0 with config_sid callback being
> NULL since X1E80100 has IP version 1.38.0.
> 

I'd rewrite the last sentence as below:

"Hence add support for X1E80100 by introducing a new ops and cfg structures that
don't require the config_sid callback. This could be reused by the future
platforms based on SMMUv3."

- Mani

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 88a98be930e3..56ba8bc72f78 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.38.0 */
> +static const struct qcom_pcie_ops ops_1_38_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1409,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_38_0 = {
> +	.ops = &ops_1_38_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1837,7 +1851,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_38_0 },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

