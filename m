Return-Path: <linux-pci+bounces-34341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF0B2D3F4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F072E5861B5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A823A9AD;
	Wed, 20 Aug 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPBJM4Ik"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105E1494A8
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670676; cv=none; b=SJ23QBO+Xa6fk41a6h+mIx2/i8NLQQZ84+H4vVbwSa+eQIWCG8ZR/H9vqxDcfE+O7tgtH2p8tDB20f0YgPesBgeNMwThVj9pru3cxU7e8vltN3IDOhd45lxA90oBzpMzSj9GpBMsjWFdmn6hvdU+xmVWyba4JGZl/ATst8X6rgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670676; c=relaxed/simple;
	bh=acxMMGd2x/HKWGU/E/B1l2IvWsTnQwauMXyl3r65/5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0wJDn2PFzntloKF4yqhnDA3O62se+0b6s6SGszMWnWysQU0TrYrZXq9/WiAje15gKKsa3W1FpwVGK78cQ93w/2ccXur187KdSrL+OYm8m7tUHj9dq8s1baTgtIp+IOThKjc9eudHLHqYzE7m5ixHS2cVup6vKd9fYyZOAe6WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPBJM4Ik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oqBG025884
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 06:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bkq+cHdJt1KbvcxQfB2RcSUjegt/SMBaHSxlr5BbPY=; b=pPBJM4IkUCc7AjW7
	5WE+DTBsliH63oe2SkgY7IWE7ea6YBExexcpAEv4g2cxsh5z440YLP5GHikjCcRH
	sP78jWNxVbTnLOJNOYQJhHFwuLhbrNmWlEN3o4P76SDKg60VgeEDWN+6hfzRN9+R
	UDRivJivIbkejr8DpPcpRM4SK9Pg8fE+qJK7K5VCfy4wXVcBiKqZtni0wlqiGL2H
	Vt8SFuYzPGFv/ikxQrF2ToxtUpmv+bwgfSmXUs7hP5efZA9JD/pJTu7BINgSdaTw
	utACXgdJXiUw6cxSSPQZZ7pnZejbW65wLVwVY8c9qt2Di5ZzuokdOyuGxdn+lOQg
	KyXKCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a8m32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 06:17:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f440f0so68364085ad.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 23:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670673; x=1756275473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bkq+cHdJt1KbvcxQfB2RcSUjegt/SMBaHSxlr5BbPY=;
        b=i94NNdb5mcRc92O2gS8fYHD7biPGIbv0EEUMs2uKTRRqtGVfKtQ6Q87UMIJrH3X5Lb
         vX+b9VcaJiAUNFdbGik/YSmQHb0xGhycGjRCAeH4mkfiLmpWKRAvehsf3q+dH0gz7/UY
         w5RYzPAxcKW6VadDmQ7ajs39eWUyr1QnZoXEEnW2mGyMVkjjRTfNIZIsMaJiPhdUNPrI
         XvIIMvwK380d3p+sW6f51k7ccFqCyG4V5Od+BpVLzc3/7Z2/8DARpIfpWTpl/POMJi3Y
         +6NkVgSQVIg9d2xvfwSM7jAvwV+A389WQmuzJJslnIBjiXKrWHtKhI1qATz37ozMTEmV
         WPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5WAudZVnFZSB5pDpD8+Z3tTJ854QJSZkMCwXHFPOZSIVMAg4OI3tyoKw3HpyDMKm4wo6Wa5hKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfFfTVlG90Q+1CZP+33SF8MTuqVg6JFP3X4T/DlAHZeUi/P+x
	g6ovvTlLSZSAh7gqRC2eFxBqc3LTBcW98EXq/inUG3150GT2fDzsbau6GUglq4DVQPm/WAquJt6
	rLYGuyQfk6Alpjq1XyLRU6eWa8jEbDqvHE5YhJMppHr+4d1SIxbGtO0yJz57sP8k=
X-Gm-Gg: ASbGnctzxgoVOgJYRJ3opCf39UhwynzzhywCFq5O2qyHwPoNXmVa3R2o+pYj/jgn7Te
	n2ioOd7zfw0h9MBWC8pDL+otmNw0YR6hcNYPk6VEa6/Fo7G+qAP+DBsC6JMSZIw/WCLQ4JPXalR
	D/32ru75QXObQUEU3yTR617vWv4hHyWi1MnEQAOPYLkyB7Ipko3NR4F3k8ilY+K/QmjzoMBEUyB
	psPRW5VAKfnGZOCv2AXMmJm7prk3L2r2Y35qK1D/9eYVdEaD6AM2DOSRg1TjwYPFNfg9uPRLEar
	KJtyxMXYZ6fA2iR3xFQXkk+/MlzuqTxlAACWOFamXFQiEIHRrLBGI4FNa+d/zr0V/s58pAY2JhC
	8S0duMCC5chKtvjPmpwh/lWx0JSAMnA==
X-Received: by 2002:a17:902:db11:b0:244:99aa:5484 with SMTP id d9443c01a7336-245ef22750bmr21232915ad.33.1755670672776;
        Tue, 19 Aug 2025 23:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsKwESvuXAmKPzOJGduohtMXI7XkJlUbHq5xijCZfUS3+Y+d26WTnyjnHki+tQuTQXR8vTwA==
X-Received: by 2002:a17:902:db11:b0:244:99aa:5484 with SMTP id d9443c01a7336-245ef22750bmr21232595ad.33.1755670672285;
        Tue, 19 Aug 2025 23:17:52 -0700 (PDT)
Received: from [10.249.96.170] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8ab7b2dfsm2046761b3a.38.2025.08.19.23.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:17:51 -0700 (PDT)
Message-ID: <33468410-69e5-4144-88e0-cc34a736c0e4@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:17:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-4-2ea09f83cbb0@oss.qualcomm.com>
 <6zlydkdgmowqg7cv5eeoaf7mrpnhzokyvhh5xasvznqaxnhdji@xol3jiz2lzld>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <6zlydkdgmowqg7cv5eeoaf7mrpnhzokyvhh5xasvznqaxnhdji@xol3jiz2lzld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j9RgO5d7xwguK0QnJpBmhEpuARP5bMix
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a56891 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=sH0VmbEyIx9rPeTW6gYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j9RgO5d7xwguK0QnJpBmhEpuARP5bMix
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxpMPFCKdSSJw
 htf7rIciDlt0qvoBMfRZMEokF2TCLi8D88bCBvlIeqyRGaTZcCwSy9JG5AaYKQgSZgQOhl6PSzV
 iE6uJ2Q1ZZqE47ZTxwA9c0S57qcKo5eWccIayxHcgp/yXErn24yVo3sAcO/N22MlVMYMSOJ3p5n
 tnA8gg53kWVNUObryLiz2uxh0w9v0YRz6puskR8AU3n3tdV2GtF1OGWGiCrY5C4PZewpehsEBH0
 ySTnvAtgMv4vEJ4Q8LWvy7JO3rEsi2z0hAGKYEeBr3jrVIITDzsGgjfKj4CohES1Q41OaRZ6z4X
 35+8ssThrheg0Q493bAE7VD+W87ZuTHcQB9YkXs/1UMpju7q7mMX8AG2qQgGQr0d/HVjDnzfq6q
 HCjplcDRSavK+JrsbwNJzjVuzLFXjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/20/2025 2:43 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 19, 2025 at 02:52:08AM -0700, Wenbin Yao wrote:
>> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>
>> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..e422cf6932d261074ed3419ed8806e9ed212c26c 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -93,6 +93,12 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
>>   	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
>>   };
>>   
>> +static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
>> +	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
>> +	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
>> +	[QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
>> +};
>> +
>>   static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>> @@ -3229,6 +3235,10 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>>   	.ln_shrd	= 0x8000,
>>   };
>>   
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
>> +	.pcs        = 0x9000,
> Even if the driver uses only PCS regs for 8.50 currently, I'd suggest
> describing the whole picture here. Otherwise it might backfire later, if
> we add offsets for other blocks later and they won't match the ones used
> for Glymur.

OK，will add them.

>
>> +};
>> +
>>   static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>>   	.lanes			= 1,
>>   
>> @@ -4258,6 +4268,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
>>   	.phy_status             = PHYSTATUS_4_20,
>>   };
>>   
>> +static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
>> +	.lanes = 4,
>> +
>> +	.offsets        = &qmp_pcie_offsets_v8_50,
>> +
>> +	.reset_list     = sdm845_pciephy_reset_l,
>> +	.num_resets     = ARRAY_SIZE(sdm845_pciephy_reset_l),
>> +	.vreg_list      = sm8550_qmp_phy_vreg_l,
>> +	.num_vregs      = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
>> +
>> +	.regs           = pciephy_v8_50_regs_layout,
>> +
>> +	.pwrdn_ctrl     = SW_PWRDN | REFCLK_DRV_DSBL,
>> +	.phy_status     = PHYSTATUS_4_20,
>> +};
>> +
>>   static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -5114,6 +5140,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>>   		.data = &qmp_v6_gen4x4_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
>> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
>>   	},
>>   	{ },
>>   };
>>
>> -- 
>> 2.34.1
>>
-- 
With best wishes
Wenbin


