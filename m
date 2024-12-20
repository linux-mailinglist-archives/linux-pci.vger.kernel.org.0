Return-Path: <linux-pci+bounces-18897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84739F9016
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD1C188F8EE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107C1C1F34;
	Fri, 20 Dec 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAxU+lgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABE1C1F09
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689850; cv=none; b=lFpozo1JVvVAqmQ8zr7+nm+srRVgEMlUnQliZW0yvAKngYveri9ZYEkilHsmylJQgR7gLBRRb8y+ws7jOYrU/v3jnK6m+Xojj7CixAe1YrJ73TzXDtzBm70BJ6ThOkqq5mUSueSYI/ArO4vWzg2FK7NGkEqbThicgkaiBtKXePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689850; c=relaxed/simple;
	bh=SFDPgxVu6wtDC2GsMxKEW9jpJd3//ZBI6GCKoD59BXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYm7uFwiY+zelBf/4nzAgMgMFWPess9bgZUq3H+UrH6HtFxR2/4hSe4iwEp1jm9aKD4ZfIiv8O0Y96ZzC2uavEDuHLnSxbgSqZNaq3O9WkysxoIB/eXSvv7VgsnjWmqGKMPaLBe9REfT9y8JeoRoO7jdZh2K9AtWEgnx5jjS76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAxU+lgF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK7M0E1028939
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wrpm/RvJv4pqacQSl95wP5M/EJZnFTnri3TZQLQlVCA=; b=hAxU+lgFGE2X/6wu
	NdYIb+VZLP0ogvuttHDlq34Q1iUgb07Fn+CSka9QhOucMSGFyfoqogBKHhL4iMcn
	qpu+ifJCdiFiRQq41YqstBOF4ThFX+LNjitowUzzSJTndh4u53F1DAVsRZsRhuFO
	nse171owuVycrLxtG5JIagm50Mf3w3jkZxAr3+7WTmAGl+RlZgsePv7IrUU6xnm6
	xoPbMxsDscCTiVwPUp2Z7g6mh+d7Qomrdj9PM0qoG8A/A30Mz70IrMrOsP3uRSVK
	EBzE9VElQU5N2by+dMl/VpMuYrDEH28sknxojrHeDYID0053jzZIZX1bKxaaY2MN
	9vnImg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n44hrgdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:17:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467922cf961so4391411cf.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 02:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689846; x=1735294646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrpm/RvJv4pqacQSl95wP5M/EJZnFTnri3TZQLQlVCA=;
        b=wwpU3EuokT23UAT8+/ogHuphH2fWEIk7ZpPGKac0qY6C1yMaW+KMgJjsDq5D+X3oSU
         pbDFYa+e6QnZke7l54YaDX61YBzVJnwBXxFqERzQfm6bXSLTMLNaSDuafe1qUQAaRV89
         O4xxfRZCFVQO2OhL63Q9apArRCNtfsS8m+rvSGyygoKSE6/V1gNmNgY82lodj505C9lh
         NfxIUO701EjOfQMEiQEZIDVfZWbapvV6Iub/Wnf8tL2taI4nZeSe2Mg2MsOFa51qJjPA
         pcGCuSNZWQwLz4uLCS9xNMEyvZzgF+VLER9tdqBXbUZW7zlF7B//iNo0kRxRMU7C75f8
         B1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXOZBnNd0Jp8gGa7tKkanoY13oG5nlhX+qrhDV+ydPh3ifZUOrfJVzAxnas/NPW70J09ondMSHZ9IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tlXk5roPDc6clNTO6mPbxDSDohFB4TAxm4nsqai52DlVTwkr
	0Z2AJw5E1k8nvmZCbWaz0K00wfcP8/70uBUDTelha6jYGSUiuGroRy7EqgLi5iIHdA/fC2KIpJc
	RYDjNAUKAxLa97uA3Ty9a04A8w8z3Ct4nCdAiXTHEbVxRwILKO4e9uBE+kEA=
X-Gm-Gg: ASbGncs98Drlh/eClmakcVp18w1pbh9uyTkGJdGrWpHYXLskO5DxzQ09w4jp4Cs6SAn
	1QWu77QO3yUKGrXnfDcwuHCILwRozTUA6NCrQVTCnll8x4L7yG23Y1Iy1IHkwWgvdTJxrj+0C41
	S5WoXiT9K1LsR1Oi9yfrwcxd+BPrlYHx1732xlA9Hk/+OR0yY2pE5gKf6TgVwjilO5/m3i8WrsB
	K45SbjIFo6HO0a+6hqA5aHghzKyxbk99tt44Z8uuV6mMsItV43iGyonZAgRVpFVHlB2kkQe66uv
	h++lNjTeYTaZxaPmQRiBe1Q0tqJm/wCYrL4=
X-Received: by 2002:a05:620a:4455:b0:7a9:bc9b:b27 with SMTP id af79cd13be357-7b9ba733805mr115535985a.6.1734689846244;
        Fri, 20 Dec 2024 02:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWt/HpECNmTA7E5A2IgoO13Yn8mzdDwcbQ+XpPB87YicCL8ukox//oEwyNPqrgS2GNb+JyvQ==
X-Received: by 2002:a05:620a:4455:b0:7a9:bc9b:b27 with SMTP id af79cd13be357-7b9ba733805mr115534485a.6.1734689845814;
        Fri, 20 Dec 2024 02:17:25 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f5f4sm159878766b.6.2024.12.20.02.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 02:17:25 -0800 (PST)
Message-ID: <ab23e0ca-3c2f-44ab-b6d1-cfcf63f29f74@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 11:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: qcs8300: enable pcie1 for
 qcs8300 platform
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
 <20241220055239.2744024-9-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220055239.2744024-9-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0uqlbwT25E3HZNV5KZY1WzPqwJ0TOScQ
X-Proofpoint-ORIG-GUID: 0uqlbwT25E3HZNV5KZY1WzPqwJ0TOScQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=696 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200085

On 20.12.2024 6:52 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, board related gpios,
> PMIC regulators, etc.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

