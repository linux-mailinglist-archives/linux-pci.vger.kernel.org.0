Return-Path: <linux-pci+bounces-37828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D8BCE418
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F7B3A1F2B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2E0301031;
	Fri, 10 Oct 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D++fSYIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96522301015
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121179; cv=none; b=C145P9OPRJdTRGPZf4p9FqxHWHZDamZvw9/Ac0RExHtLxee4xOD75OIjOallAT9AEuqyfZ1Q5Mx2zVlrInBljRhW+CYDLDnF9NvgKOaA3XXI83wo8RnZA9gEkzsqzaKjzfIg1yTDF0IgGkCnL9qLV/WeGM1uReuiKgh9v/s/Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121179; c=relaxed/simple;
	bh=DeSZCmy8qKaf/hrkCJzbO4T+6mmq6tERS/lKYAuCof4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVOgVqWYBwt/pMMwnJ2WonVeYrheMa+Z+ns589uaKGa+xLZ6RmR2PfW1iS2fqUc4UJoDdiqQY8Trep6FNJSNRxufPBHYvu8YhR64JSRK5cHdOjHvpLVNiDkUooAuALOcmk4cTHenqnEOvXttEB0B6SOMlEzpSSUKwVtctQ2YVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D++fSYIq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ABRbIO024175
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYWMxOVH5PMb6N4KYuAsgb0talNOaEWcWrXu6nfbXTQ=; b=D++fSYIqPfAG9o7p
	XNaX3X0R0NDeawmwiQ7621wPBgF+Jw9yb0owM6epKEj6xxqUnqPa3VOmiZLTmTUO
	XAVLul6LM5PGyLR7Yy3eXWGzjvWp9FkOpXb17FqLOE9ODopBEB2oRNYZaX+WPnUy
	74Y81ijrx8Jw2SkloO0iNxFZvwDl4Yy0t/iQEjvk6ryVCXYZEIlSkLDZG/XtUv8f
	+xHm9DJEGGGDL93Nis33yeNcQvyKVCr0j1NNXPXYYmlu5VfbGXL4x6Vfw7ZWD17h
	+eG0hu3tx0MI3XU6M3fxi3kctBRqSpzZeQa8q1njIZpj2FieB8mMGzDmsjiEmy3H
	qmvH1w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49q18y966v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:32:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-873eac0465eso12744196d6.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 11:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760121175; x=1760725975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYWMxOVH5PMb6N4KYuAsgb0talNOaEWcWrXu6nfbXTQ=;
        b=ktpTATJ0idaqIfy+8dm4JeA8ELUZHv2DiMRuTrJ+Ad8niIASYJQWWXJTfGE1u78kN8
         CT3Gij3oVDKdwI0FFZS/I9ZkEaojcp301GGYO6D0S+056yo47Qd5AU12iI1Z1aC5g39x
         J+bvB7BsNJoH6ZbQmuKyRE0WzqhRVUXvKI1E4URY4o6vdJCp8zygajnosjAjKrhIqBt6
         Pa8McHSFRZb63qsAweNs5H5vOzCWue4ArnnlNzL4FTia2K1KN0OYoL8B3TWIOZN6evVL
         HE6vrGvBobZvVtmZZmqp1PD+OiaPtTeeIhzX8vOKcNa0NUqsAgCNUGVoJfrwle0hE7Xw
         I0yQ==
X-Gm-Message-State: AOJu0Yw4zc29ZPhtuAVKi9mUiQIwbPXhIeT/+tf3Z9Ws11xzx/Cy/WlC
	UkuywXncIN3HkBND37r2HBq5dsttFNO5EIa9GDOV9TBAEYFTwT8e07oCNgFi9woMrzp1iWTSoAd
	zmsZDkz7it4vRzsHVAtiBjozXnjfU2LF+gdPHU5en9g5vU6JhRvoYStolFnE626mN6VwoYdM=
X-Gm-Gg: ASbGncss9YNYBRDbaU4b5Nlh9dU5mHjcHg7iTth+ehK6MUrCkag8sRFq3V+WJX+lPMr
	R5N1UO267FhbwvMeKFBRT8r+14YMCf/dZ7gdD3P6TjFB378F8oftSnrRyw/4dTJQHq2qcOZ7CTg
	wrG7WJ9Vw4fHv3KmTqMiHGzKEEaFJji+Js62W+1UnS73U/N0AzOOaVoh+mmF2TJ9O5Y7TECQhB6
	QKigmdfu8nO4zspsodwdsELge1MFKWFkLmwZwmpaAw5NgKOLMnhi9F4K0/7XJCuTswGP/vIqwfr
	4LPGyQ9zHHthZ+ru67I61HHBS8Mt9WPnUgHJZXq3bU4CEkIdB25YWBPg4AzoA6A1OrAzC6IF+Ye
	5LjRgF+dNiowEXLl2Wln0Sg==
X-Received: by 2002:a05:6214:f25:b0:7c8:8c3b:99fc with SMTP id 6a1803df08f44-87b2ef4ed5dmr112076176d6.4.1760121175635;
        Fri, 10 Oct 2025 11:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhQfGBPvvej/Bb5PYt709FHH1mmSHi9GsC/188HhZgdbWAkPACwLdz6IVQIlQc1SwCKcIL/w==
X-Received: by 2002:a05:6214:f25:b0:7c8:8c3b:99fc with SMTP id 6a1803df08f44-87b2ef4ed5dmr112075716d6.4.1760121175001;
        Fri, 10 Oct 2025 11:32:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm2817329a12.15.2025.10.10.11.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:32:54 -0700 (PDT)
Message-ID: <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _yffhCv9p_ZPbaKYWYSzmcpwI94Lnl47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2NSBTYWx0ZWRfX/NJRpBVBFdS3
 L2zVYcrjK9UqdEtxeevWdhtA5664izOtCpCfkqS2XYLtEj9pAdUmqar5ZQbRkL6pNVCJUStfQ6W
 r2/mTB807FJX4Wa1hir4w5iESXUi5ZLRQKSHeuakK730bnGM54LcaB13p5U3S/VX2BrvnH85aZ8
 Z4fvnnbCl2PTeqYghoMz7XRM/G4/v6KcCraTDiuLrwSj7HIk1S0JJOo4hI0xeqrAN0grWPg6l7f
 +CnUQg/yWNpZTQ4j/V0WF2/QsAOxN/T+/Zasuv9usp6hXeFLRHce4rxvXJa5Hhwo0OXXfiB4s94
 Y7me7T5U3I8WVGeZyczhGPPdFIc+TDYWG3B9xYSHkFEOi6DqnHWB13i12DEhTWFp6X1jXJ9TUnl
 df6b9yA3zhDaQFFkKcy4dmdsJFFdWQ==
X-Proofpoint-ORIG-GUID: _yffhCv9p_ZPbaKYWYSzmcpwI94Lnl47
X-Authority-Analysis: v=2.4 cv=LJZrgZW9 c=1 sm=1 tr=0 ts=68e95158 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=f56zXKZffaiFsfKDMp4A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510100065

On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> Even for the new DT binding where the PHY and PERST# properties are
> specified in the Root Port, both are optional. Hence, treat them as
> optional in the driver too.

I suppose this makes sense if the PHY is transparent to the OS
or otherwise pre-programmed and PERST# is hardwired or otherwise
unnecessary.. both of which I suppose aren't totally impossible..

> 
> If both properties are not specified, then fall back to parsing the legacy
> binding for backwards compatibility.
> 
> Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3dc06bd2f626f8f53920 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>  
>  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
>  				      "reset", GPIOD_OUT_HIGH, "PERST#");
> -	if (IS_ERR(reset))
> +	if (IS_ERR(reset) && PTR_ERR(reset) != -ENOENT)
>  		return PTR_ERR(reset);

Please introduce an _optional variant instead

Konrad

