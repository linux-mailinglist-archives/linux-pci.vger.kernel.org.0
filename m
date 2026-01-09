Return-Path: <linux-pci+bounces-44364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12892D0A5F1
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CA3E3014771
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7135BDBC;
	Fri,  9 Jan 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LIwHT/IZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSWc9aJx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039592E8B78
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964174; cv=none; b=manZTQv7sSqzVOWnLHeliCc1w958lvm8BbR/lCBK1XjHecVB24qZNilTfmdCLtT6jTmN/F9g8sayqVQk9YNvTRMcL4nXsw8X+9lvFfcVnYj4chEFbHtOn1GmefEv4LvP4AfK7fk1AuDjE4DS6S1TIswrlWm4Vhi13SDgfmbIc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964174; c=relaxed/simple;
	bh=ps/OHQAiC6se3cEW2zplxvs7ZvKj6l3oo/RzaBwZy8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OndBTFtKalKez1uSMBtlakJC5XZwW8XREUzIG6T4gn7UGJwCbjGqH5jeCdET+RvWvMnF/E+T/j9zn3H70bsOQBS3l2zWwh0b4ph9hh56EqzXyw+NQ3NHlYi3h60iuK0ssVJn3bRoOpUPJ9m9l00BZwwfyXSV2fCRjNA8PRhZ7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIwHT/IZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSWc9aJx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609673iV3141619
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 13:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=R3a7pfMrwbdfP6OiQTe+1tjO
	UlbBTRlV6TY59r847XY=; b=LIwHT/IZ8UoQUUNUe0HlpwrU5Dmrch0OONEB2Qis
	V5fSau88OleOvSYAsy9FtXjjGntVc0wTEjniH1gVnP6DKycrdgD/Wh9fT2a3kvZQ
	sxsyl0EmJR043IR/xx8LCVPH+XYF9BnOKHuKm5si+kbKfbNVREXCsRvOuAOzBITq
	pl5v6sJTpsdH5raa/WEhWwejCwitXCMuu8DK49Haypa3j6rmMQRaTXDWb2y98WFE
	kBDkmJMwpUZKBtDu8t0Ba5QcS+nSibGIiDlVnoGix5MKPl0LgbVnikF2g+42r1Wr
	fZ1NEdgescWit4E9a2yhBcDkB3EQ0cI82wpGwjra3BbVPA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j2qk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 13:09:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a47331c39so105722186d6.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964169; x=1768568969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3a7pfMrwbdfP6OiQTe+1tjOUlbBTRlV6TY59r847XY=;
        b=kSWc9aJxpVTNJIdRtQzf+sIorQq6U4TIfIrJ5tABKHRdYGZfJtAG+LpQnrZLN0851C
         Y5XKY0G44TAkVPPBHj5CXiDLH8cYCHGG0p2u4Hcb5PHMM5UBA9VRILtPXDwlnsdBZA91
         IR4nrW7BZFJACLPz0vsvJR8yBfyH/U/g9Em5Rkuw3FnjwxT1lk9F+Mqu3ldncH6KejQ5
         P+7+AQST+qxNwmzL3ZxJ7rbRhcumXfUyOOrWug14Qepg9ywqoQgh9kgTuIdgRmosQCGZ
         VOHxT8o18ZqCYAa0Rqru61NvUo68K8x2yO6Q+kM7WCMNn59UbZSlvGpAHly307JkFnWx
         wfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964169; x=1768568969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3a7pfMrwbdfP6OiQTe+1tjOUlbBTRlV6TY59r847XY=;
        b=rkO1EMcLKw7yfBc10BIGXplBMvdfBasqIIgY/r7+9zbNpc4KsLiiSIziuEomUgRc+J
         OPSnJ5ftqZECp/Os9SbGgM+kO2i2E2y6lX0YYG9pgQzbHMHh9BG5GJ6OHZ3bD3gjEQ1+
         G4a2cyujUAa6zVFDyb8aZsaGHNSSnKa+1+EDLaKAlNVFiCJpGyRlKeQ7/7IiYjNL3GWC
         9xClgFOCkt4Jr3F4+1pFl5o6xGV7wkfEN1SzBwejI2d27p8i+4u2WE0ecGJkkDgqCpZe
         hcyPCCG0mT0VIZ8fRB8ssK2e5R06yS02YsQv6s9HMTlPsbVntrm59bSKrpIjSfHPUZdl
         v2oA==
X-Forwarded-Encrypted: i=1; AJvYcCWshbCnn/ON2jMrolKsgPggxn6dIrXJmFAWUrtgh5PzZe+HEUDxHKR+sb30yX/Gz4mW4RMVHXEgwco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrfemceV1oWeVu3AcMc25iCgTJBdp6d2njVBxBybsVU+onAU4
	0rcjE7TAgM2nKuEneuTe7l/ScPE3uFQTW4HWFMxQsIxXjc6JnU3qmpaPgjxkS44KPLRDxV4C0HJ
	pDyxTnXaEXeFMAikDWo3BzV/y7kPPehmDUycFWyP8+Ge0q0wmRLAhftl5uML7vz0=
X-Gm-Gg: AY/fxX4VgwkpPwEK0DQ9nhXzjNdvvl35Q+K/rYVEtmCSyBaJvihYxnPoWYkSJIc6l1l
	3dVd6TcU9fW28abaBdaxutZ/CRb5Qywkwc2WBZLTayceQgTklYD7KRaaV2jTdJQMdOsQ8kOb3E9
	PezUG1+stGJOpdXGtOYMyqeg1FbhCX3ZUB3P7j96y/9eOiXm6hq3HEIK6aQ1CqyogqKj9btcaw7
	3oSQNMJflDTGoziY5PIWVSZZQqjmdUIBsLOSRv0cgDAKfR7GFzYOWFyFzOk7GgQvv70z8FlNVHh
	J6kbbocLLJD854v7ENxuRPl25gG4Je3RmgANDLHGZSVzoErzfZtaw3OBkjsMsIPlIjgISWO7Hbh
	HVkt/Fd9Go+pmjEUSl211SzSg/eI69GEIArJtXRO2y3Xew12HqGVmTftivz/VtcYCCy8XLTSqrT
	L4Vom2EQf3lfUoflewRHyfFT0=
X-Received: by 2002:ad4:5fcf:0:b0:888:4939:c29 with SMTP id 6a1803df08f44-89084337fa3mr121939876d6.71.1767964168987;
        Fri, 09 Jan 2026 05:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExPjHfm5UM4LvqSExffBGQJ/2HOmM9rKV3EjtLbJMMh8Ei6M6ooIa7N4YvIEzPCYTBdksAxA==
X-Received: by 2002:ad4:5fcf:0:b0:888:4939:c29 with SMTP id 6a1803df08f44-89084337fa3mr121939296d6.71.1767964168441;
        Fri, 09 Jan 2026 05:09:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b71b7eb22sm1841461e87.41.2026.01.09.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:09:27 -0800 (PST)
Date: Fri, 9 Jan 2026 15:09:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: qcom: enable Link retain logic for Hamoa
Message-ID: <woztsrvxwkgi34z3yop7nja6ojbxdboyzz5xpz4xlym75dtyja@iopi7hvw42v7>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-5-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-link_retain-v1-5-7e6782230f4b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5NyBTYWx0ZWRfX5OKeZ83uXZjm
 elhSzdA/7vh/uLylwAWsJPitpKMOIpW6b9K+ZnJQ+8tSwJccjLdVyuI2AA/PFHjsZroPhQFmDwZ
 PL78u7yXZRl4ieF1qrX8n/2uPR2wf1uhTRBs7ZgsHLf2TqH8T0IYZmyznO8Rdw6YZXIxqFzkFyv
 /R+lKv3k8i3fpRsDxB2k0YccRaYJstHe1zRjhRkWXk0gFqjkOCNOCWLTT3AXJC4a2lkj3f0wdfw
 AXGeWocHD8CX3jmQS7ZfNz9mR7CnVG98azxuKwdPQ8TdKhJxh42eaqYZoVfcid8p5DbIOSCqwAf
 ennXIXEISq2Yhrp4OY9WzfPFNK7EpHSWFVnDeVe8FRb3IG0ECv5kTnRoDVtvbqQNgrTOmTHAf6T
 2c+lkZLvMFvTWSWWMC1sobbsBkOJ6awXCvPSPg8j4sIzHQDkUrARD6Eje2CeUVBW9qNYxVa7+/2
 qsPmigkj9CBvRNIHGPQ==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=6960fe0b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: kAK3CiwL_-W2VS44te74yt4stz0_OYnN
X-Proofpoint-ORIG-GUID: kAK3CiwL_-W2VS44te74yt4stz0_OYnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090097

On Fri, Jan 09, 2026 at 12:51:10PM +0530, Krishna Chaitanya Chundru wrote:
> The Hamoa platform supports keeping the PCIe link active across
> bootloader and kernel handoff. To take advantage of this, introduce a
> specific configuration (cfg_x1e80100) with link_retain = true and
> update the device match table to use it.

Why are we enabling it only for this platform?

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index bdd5bdb462c5f6814c8311be96411173456b6b14..975671a0dd4757074600d5a0966e94220bb18d8c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1531,6 +1531,12 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_x1e80100 = {
> +	.ops = &ops_1_21_0,
> +	.no_l0s = true,
> +	.link_retain = true,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_fw_managed = {
>  	.firmware_managed = true,
>  };
> @@ -2168,7 +2174,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_x1e80100 },
>  	{ }
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

