Return-Path: <linux-pci+bounces-36921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BF9B9D342
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C3C4A2CCE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CC2E8882;
	Thu, 25 Sep 2025 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geaGq1vO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DB2E6105
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767500; cv=none; b=bUGqFcfPm2rpCvS6oYJ2jQTMVT6qthoPd9RvtulzdO5ak0vvfkgxHXQZOL8sjSwSB+itif0QzaN/0GDrjaj3Pw1burcVmrFOc6+6umFxqncSOeJJlPhY/gl+1YdeCzMonc+AY4eE2nI98be73kvAmnhxoKUBo4e+awEx+8Qhlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767500; c=relaxed/simple;
	bh=pcrcivp6jRezc7W+w/l9SYu4yeO+SeLB/7dvhRX5kiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp2WXPVhJfSiPdjrDCnpkBX3JDiPaI7/KRvtSVREnSNBBQaQyKOMrHvXpuc1F5aC8cs68Q7go8stZUo/SXLEdve9eHnJBrhrCuJ7COlGyD2GU/Cuh5oRDUm00dcBTS70aY8jcEDF0e8GDCzehtAzL6YzbmEe8ApBRj9h0WOlnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geaGq1vO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONiVaD029044
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D3nYnV6I3tQHUFYA7g+3qAT/
	UOlfwsLFTqadtUtQzK4=; b=geaGq1vODBz5/agzHiMLsyIDN1ZxM5VUKarGnTn+
	QYI6tCoiqFePkJSaYP+k5LERIL9k8IXUAVCKhyB1KRg1ToHZDuIGOrOn87YECWVy
	MQgjrs47ryVBq72k2k42Ufb5lzuNMwk9DejzWCydJ5k/VZt+koF3zqn6mdDpeJtA
	XjV14NRbsa9CgbakbfuosL6DtdET/Sb7ydx5nLfF6/NqEvqG/92skMDgUsf1Qhrh
	rFjAOH0U0EQ1girD5hYc4WedoDSxJFela6zb4QiJLDFgts2k/MrBtku5q0M5Yvqq
	uB2gB3Ssn0dsNdGxO39Iv1TNkLqBOKnWX3yVbJ1cob55uQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxt1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 02:31:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b302991816so10050351cf.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 19:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767497; x=1759372297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3nYnV6I3tQHUFYA7g+3qAT/UOlfwsLFTqadtUtQzK4=;
        b=tJOD1aJE5opuYzhFHmBr/UHAvxfotvVvhFqqBUTEBLhsZeYy5A2EFAxoaKXWjLZzQ2
         4ux51mloyP15BUoTLNdLb6ZagO4CUeP8yhAwnqtwmkHgre1fFizQRDeN1UMe/TOuyrCq
         xjBaV+TiCnVmaOvQr2rgwTBXktNO//Eo4SOwYSMxyk2pGbvUhCNT1YyRtmNB3u8G068v
         8HA3W2DLe1Sr1paff7idbct567zq9shr/IMBxCUGKyPBxzYnDlscfRHiEYi953miwcil
         5GD52JQFeugZrYAOjnbj1SwBWKzRdxRt8QvXikNyVtk2103G0PxLs7nLB5KHKtM3HCHE
         uHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrp+/Turh2gznKyWDnrDvsJKwnAFg02H7eziniFdeY2V7v0JpIeoU3ct3RqurclaDwjdqscwe0NCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNhlD4H0R68Lzxe/fT5aT6JucdYHTCajfwaM6nEpvVf2RzLyX
	uEtn5gZiX/w6HhEZfBxz/FlNYqbruSlp9xUz5OI7EsmEi0HxlE8Hyi0OLp3InexWV7uV7amghDt
	j3M9EiWf1eKPE2N8JJhNfSceRMX58QREssmmcEWh03yb1e7RhZHU+ofKGsMNENPs=
X-Gm-Gg: ASbGncuXaQqUxhxFM11pgvJr6MAsxwWABkxPRI4nKte1PhhA2DHTeaTDD4EBtSbNcmP
	6h2cLtnBnAUK6Q5Xn3zUBqdth134iPBVhU6QYGYNFp59VmexkFIr5srnlYCMwggly+CURga8jpK
	Wdp7V6sEpXijj/+4Fp2pDp25w+N6gpXPJpqkYIA+R/y2L/9q3R8nZ3Li//8ziY96jVS4Z93EAcQ
	K15bKx8rNrnFLzp2FgxZbx68SrWnV1r7LLd2JSD9VkdDts4uxJaTdEbhaeTnbRz4JrBH/2ItyxS
	RSzQID08JR2k0VE4sGfbPNujhu+0kh6Rwad6VQvDdJTo21pvi0IxDTk0CqVXaxTBzmJuTHH9Vig
	kjYK6SdKZ866KO6+BMSVA4u2i4rAieAVJRmLQwZtCqO2ugGQz8Kp/
X-Received: by 2002:a05:622a:28b:b0:4cf:1f63:e0d7 with SMTP id d75a77b69052e-4da4d8e137cmr27710541cf.81.1758767497303;
        Wed, 24 Sep 2025 19:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEvoHvlnh9KHRZr3AgHqArgHyeDWrmzl2oYp0o4JenqL8v9CmviTgtlWMTnrGZUhqt1jjqQA==
X-Received: by 2002:a05:622a:28b:b0:4cf:1f63:e0d7 with SMTP id d75a77b69052e-4da4d8e137cmr27710291cf.81.1758767496803;
        Wed, 24 Sep 2025 19:31:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a32638sm240397e87.118.2025.09.24.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:31:35 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:31:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 6/6] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 Kaanapali
Message-ID: <zl6tq3prervuiapz5ekd5sxfzo7injnanpyfvxz2vn35fkb4kh@25zejng3n7k3>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-6-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pcie-v1-6-5fb59e398b83@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4a98a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lYzJZiZmsC8Xh2LukrIA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Vr6ByTsmRGzJs24AxQZpA_lyF0elNaBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX58vC4dFv3yh8
 KsTOpmOCVXDVnnHNB295eqFDM+4Uypj40su2wqo4YGsI4OPhlapY20B2HkQSTNVVi5cmeTYf+xD
 kj+9sVeILcvpNsdGzyoBJI8F/rI9PPcl3UBDCyhHsbDNJW2TSlfFJVRUVrNZiZzYMJ5iicN0Kjh
 3mAaxWv66zDGAdPjKkaoPacFbrY90YinBt19JAMy4509JN130w8nH/8oedGwVj8W3NEKrtSBnM6
 9DWY76EswQHz8JQ6XFkdE9puvlHRmmPgi554hRj0EoYPjcnLW5eXWmJs0jxkXFgJyeNuxrNiSnP
 woIBMyeFyqXMagsvcO0V7dDfM+YohrAiS58EzgwImigpGeQt3cpSfw/mwRPAvhGTxwoOSFJTexk
 n7VCd139
X-Proofpoint-GUID: Vr6ByTsmRGzJs24AxQZpA_lyF0elNaBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Wed, Sep 24, 2025 at 04:33:22PM -0700, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Add QMP PCIe PHY support for the Kaanapali platform.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 194 +++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 
> @@ -5276,6 +5467,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>  		.data = &qmp_v6_gen4x4_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,kaanapali-qmp-gen3x2-pcie-phy",
> +		.data = &qmp_v8_gen3x2_pciephy_cfg,

This list is expected to be sorted.

>  	},
>  	{ },
>  };
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

