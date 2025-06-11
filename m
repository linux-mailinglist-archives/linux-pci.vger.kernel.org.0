Return-Path: <linux-pci+bounces-29460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09704AD5A98
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B8D3A6DE1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7451D130E;
	Wed, 11 Jun 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTLXh2x2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03D1A8404
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656079; cv=none; b=n9Xm+ms5Rs2uq/NSfYPPUQnwtvPmsM+rJv+fuD4RzggJJgng2rxAR7D52UiTFqbxsA/lWwY7a9jtujBYKg/GdqNzjivTymcrZtianvVZzObGGdcRFuHOftzlZRKjhe8Qpcvr3fLehzedwCBxNeNtFyMaxN60KZrf9SsztHBORUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656079; c=relaxed/simple;
	bh=o3QCcI9l3rgw2lYmIHWf/86KQEbZnbRgtKG06BPEfR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km2+8nRKHyLD+VBOgcnr3vTkm2OwlqzNhBg1aAG/kVyb9hL1YAC7SVYbm0+vh3+c+1JISON3e8n/Af7znXsODZCSZyg2PVQXWrd2+crPxGI/6NmY13A4N9iYJh8yiPLOdh5bBy1dFB7uojtZVbW87jk0jtaIX4GeNInQBLXH/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MTLXh2x2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DEt9009023
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNaG/m5ckjCaNCaR3betd1kEB9RBVitnuO8XEu1xsPw=; b=MTLXh2x2vBoA5M42
	K0m6KQf57LfkC9rvRxdn+ZUlhTcxaFcUYKVg5B3t7ceiNo3MLdKh/FLEWbllcP8o
	i3MiyXxNjWiwAE0XT6UXymkDo7uRpu16raU63odzU3QDst3vDo0XMOknXH7x2VGe
	pXCPcR0Rpn62kvKzjofYhKtjUiXn2fpjOt4PkupXryTjtk5INDG1XGAAUaS1Ve8g
	rnk3Eb+9NShsOXH2+5u//NZVr1/GvAhcLXQxNmHL6HJm9LF3ftuXpEZKzt9ORWiF
	ugcWOXHFk1T0P+InwjVn1Qy41Y4I8Cfz0JuVne7w66zu000ThPJfpLAESTkJoapX
	zpIwDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753bsf3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:34:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5af539464so15759885a.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 08:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656076; x=1750260876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNaG/m5ckjCaNCaR3betd1kEB9RBVitnuO8XEu1xsPw=;
        b=pisIuyEF7kRVEfef3ufC70uwF3RmO9tysDe3dHi87F6VmDPWDWShpRikGyMwjZxRzP
         OIyZ2doTkPPgACHDxJ4GkBp0a8B1/4IIbcJ36voY+Pf3cxVXQmn3rUhHqLrNsRn16H1B
         DY89csH+ifcz4pMDme+hshxp358hBHxxHCVm9sGdjtPSSsfuEDPIWsJAUffiTyqHYwTQ
         bADBCY8hchwAZr9I479b2PJ+PSvQ8NThAZ/JAi8YpTDltK9Gp815JXOWn0avFsappC0z
         Hq30TDFtNg0GPz5vcNY3EmVFwi60gY76FvnD5GnRt/h8aHY18IUnbnjxp76nm+FMOQ+f
         mLgA==
X-Forwarded-Encrypted: i=1; AJvYcCURRs1++wbeb5Q8U1D/opMDjBVDfB0cjds4Sp8RNviirC4TJ0fubjjYIreQObbsVKAjkyhPK7TVxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7fXy4iVYkB2aZy3e6pia6gsqUlJnWFMWTw5kObNpa30pI6Er
	qvyOtxMphm9M87uHwgzjBfhy3g4QBJWQywsRh8Pp0ALJ0BNZSHc/1kJ+mRrNljSDCF50hdbArH7
	e5PB60nVyrxpoC85hk/gFX6zdNgcrbRrBs9J2r8T8rObiolgTkmSGZISu2V9E/Fw=
X-Gm-Gg: ASbGncvDCaRdHpY6zJPBeF+CLt1Sp/Xy+enyvKHpVwg6Zfn9ym97J7mfNMJ7JhIsWCe
	CV5kXWmBWppMm2D6gKedBMSQVxA6Q/Qe+8DLD5EPF0oZ1+qgO6MjJ6RAJ7w5Ktxlvr+zUtHEAvH
	OGg0f+AloKNc6oohNIF+pGyhngvk+qAY+87DV8DRNqAUvUH6klWlHXQX8dEOkF4paxFiTzF6oQ9
	/tq7J/z5ZeW6dIm18YfyV796sdCyQXot+k8maHehYnj4zMOHRo3ZhYU4mSxUsJl6baWI+jiHL3C
	G1AW9QKoxIY1O1VZWHzg/ARyT84Z9Z6lQ+FVep/2Gb9sh5iAgEMhJycMKaQqNNPaX19SN5BPBAb
	iY6M=
X-Received: by 2002:a05:620a:2456:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d3a8732298mr205841985a.0.1749656075503;
        Wed, 11 Jun 2025 08:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ouoE52qGE7NcwixeAf1E/9WuVIcED+AzFLeYamXtXx05GWCerQ9yNA/jVMaQIkg69Bj3+Q==
X-Received: by 2002:a05:620a:2456:b0:7cd:4a08:ea12 with SMTP id af79cd13be357-7d3a8732298mr205839285a.0.1749656075131;
        Wed, 11 Jun 2025 08:34:35 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d75467fsm920990266b.14.2025.06.11.08.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:34:34 -0700 (PDT)
Message-ID: <fcfa77dd-d7a7-4d3e-8e67-6d3f3eb439b4@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 17:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8775p: Add PCIe lane
 equalization preset properties
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        dmitry.baryshkov@linaro.org, manivannan.sadhasivam@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
 <20250611100319.464803-3-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250611100319.464803-3-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzMSBTYWx0ZWRfX9BM+bpozsSPk
 pecoS+LHEBCrwGMoANDjA7IAqCPiILMSnuuH1ay57/V/YZIixQ0a9jyCY6QAZoBudbpgSR4MT2z
 Vm+1hANYeMCc1uGpdcFFhWQTRHEGEqiNf9zgZHdZuvElvMKycABt+LuqDazjSYIZZRKXnqigKHG
 iAMLYxWvVYwyDfRXiqim4CJq2KQvFolZWQ6ollyZCKMrs4/n0gKUVgCTvZgvSes2vTLKS3xFFrP
 /PlbmrWXBwisqV164VAuGUxmIzpL4iICD3x7J/KEXFaj9qH80+O1fNY4gW6NZMp39j4UdEqRPCJ
 4pjwKbUrfAcZJFELcdHQOMHFOuyybZs93xfo/otkDdlq32Ts6jDkt1EdvSH8Dhni2VxPJ4M4CFb
 e0+QsMgWSy7zSuqiHC7KtgN2uaqnbzvfk0XuLdg5M0XeqHcIA3WauK0TccXj1lZZK0wguZgb
X-Proofpoint-GUID: ETMMddkJC9WX2U1BFA7hezF3P_5csoPL
X-Proofpoint-ORIG-GUID: ETMMddkJC9WX2U1BFA7hezF3P_5csoPL
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=6849a20c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=E4L0-HUXtsqUrGG0iVcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=808 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110131

On 6/11/25 12:03 PM, Ziyue Zhang wrote:
> Add PCIe lane equalization preset properties with all values set to 5 for
> 8.0 GT/s and 16.0 GT/s data rates to enhance link stability.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

