Return-Path: <linux-pci+bounces-12333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9689623E1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84E9285F41
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F1166F3A;
	Wed, 28 Aug 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iy002u14"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B621166F37;
	Wed, 28 Aug 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838446; cv=none; b=t4jZ7Av+K+NsITPdGxPSYFbiwDnno6Xc8OOuqrv24ASTv9aYQ6r0LAWFoKQj4bx1/iuKcifj6s8U78mumNnbPEnC/zRqMST8tVt3Z7iL+SwqGrdRlH4xEEnQ2Mun+BeSGopysAyjeNE4BjRYU9eBKJbvqQVxNVdE0MS34GCORNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838446; c=relaxed/simple;
	bh=yfMj4pW5P/0JNbbT2dV5VwJXg//vOMNzR88TEbLrb4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cUMSt+BbzzGpN7tjSH2KCnN2QHg4c76wm9Y0jRzV6YWbW7hWQE5QliL//cRfpCrBPLQ/5UMp7xK2uvCGZRniXsFpGMeLOqjPIwrY5bIoyCxA4RzCoxf7WDRtjBv4K33YfxRauL9cRpkv7Q74J+39GggZCBTciDBlGqjDgaRWX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iy002u14; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLa8Vd003338;
	Wed, 28 Aug 2024 09:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wFrCP06yThMc9EUNQaHvP6RM6Ru44h3Cwde2qdVIPg8=; b=Iy002u14I9Dn0CL9
	4FMVMqIMRSdotoyDQbbcZdg3RLZmW3vZttY551Q8tcn+BZ+bgfB1mKqz4aCxsDPd
	EV2J3sDPHjT8AuupszFnoRpBEtwGwvKieP4660H6fDIL1K9jSct0J92tFw7UxArC
	5n5mTce+6mFhqCwVdRXXamG5PDx84dL4rrNnH9nzWWf9cm1hwSDLlR7RiQbqKLG1
	/PHIJSvzvyFDXLHB6ZD/foZmR0pRTvgBJwLq4xR1EIcL34xmXgUJADH616hZok92
	h4N1FjT8Biw4lPjpEJMzIi74qhH3Pn645l8b5/1q5xgoQEBrlL2YiGasS4Wo3wPI
	CKdudA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puuhc4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 09:47:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47S9lE2Z022003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 09:47:14 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 02:47:08 -0700
Message-ID: <2c23f7e8-c407-4c5c-a8e2-65be98f9c92b@quicinc.com>
Date: Wed, 28 Aug 2024 17:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] phy: qcom: qmp: Add phy register and clk setting for
 x1e80100 PCIe3
To: Konrad Dybcio <konradybcio@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>
CC: <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-4-quic_qianyu@quicinc.com>
 <2d3f3da1-713e-4378-b87d-11f10f0f9590@kernel.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <2d3f3da1-713e-4378-b87d-11f10f0f9590@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bPaR0HwOi_PMeNhFKaeI2BPb0mytkZPr
X-Proofpoint-GUID: bPaR0HwOi_PMeNhFKaeI2BPb0mytkZPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=799
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280070


On 8/27/2024 6:33 PM, Konrad Dybcio wrote:
> On 27.08.2024 8:36 AM, Qiang Yu wrote:
>> Currently driver supports only x4 lane based functionality using tx/rx and
>> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
>> PCIe3 related QMP PHY provides additional programming which are available
>> as txz and rxz based register set. Hence adds txz and rxz based registers
>> usage and programming sequences. Phy register setting for txz and rxz will
>> be applied to all 8 lanes. Some lanes may have different settings on
>> several registers than txz/rxz, these registers should be programmed after
>> txz/rxz programming sequences completing.
>>
>> Besides, PCIe3 related QMP PHY also requires addtional clk, which is named
>> as clkref_en. Hence, add this clk into qmp_pciephy_clk_l so that it can be
>> easily parsed from devicetree during init.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
> [...]
>
>> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_rx_tbl[] = {
>> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x3a, 1),
> 1 -> BIT(0)
>
> [...]
>
>> +	/* Set to true for programming all 8 lanes using txz/rxz registers */
>> +	bool lane_broadcasting;
> This is unnecessary because you call qmp_configure_lane conditionally,
> but that function has a nullcheck built in
Yes, there is null pointer check in qmp_configure_lane, will remove
lane_broadcating check.
>> +
>>   	/* resets to be requested */
>>   	const char * const *reset_list;
>>   	int num_resets;
>> @@ -2655,6 +2815,8 @@ struct qmp_pcie {
>>   	void __iomem *rx;
>>   	void __iomem *tx2;
>>   	void __iomem *rx2;
>> +	void __iomem *txz;
>> +	void __iomem *rxz;
>>   	void __iomem *ln_shrd;
>>   
>>   	void __iomem *port_b;
>> @@ -2700,7 +2862,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>>   
>>   /* list of clocks required by phy */
>>   static const char * const qmp_pciephy_clk_l[] = {
>> -	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>> +	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "clkref_en",
> Why not just put in TCSR_PCIE_8L_CLKREF_EN as "ref"? It's downstream
> of the XO anyway.
Yes, TCSR_PCIE_8L_CLKREF_EN is source from XO, will update patch as
your comments.

Thanks,
Qiang
>
> [...]
>
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -3700,6 +3907,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>>   
>>   	qmp_configure(qmp->dev, serdes, tbls->serdes, tbls->serdes_num);
>>   
>> +	if (cfg->lane_broadcasting) {
> All these ifs can be unconditional
>
> Konrad

