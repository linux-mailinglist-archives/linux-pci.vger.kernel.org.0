Return-Path: <linux-pci+bounces-35501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87CB44D1B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D235802D9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B522A4FE;
	Fri,  5 Sep 2025 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lbc0m0r8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BD10942
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049475; cv=none; b=a7O5f05/pjMdzbIKy5x73PRD4HnjtkNLxlAxZofG6mpmVkSx+mKUSpbsQ9BJopxFDA75PNzTsJ6sdsIllbuxpUoELkFMJ3WZrxft+lBKSkLYk7tV/wUQuLbOpY9xB2uF+2gaaQCgzPUUsUDZ6xt3cLIMJ8xp9cCggv+cH7ebGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049475; c=relaxed/simple;
	bh=MyDwk+JF8dckFakhkcfiJSqeBkt8fotzN0n+PuTJSZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mb4lIyNRmCzOtNTrCedVr3hGj5lrR1HqXrRVaP0ppMiHGxu3HLHl9+f0SpV1awo76Uc0Drn+qsHwtSyNxEMTtke0u04ePJ5ymnFCQ2h0lGVZp3bjOZFh9qA1255D515byvjZAJWvPzkwuP7vbJxI7ehEzsSekh2QsYdD9ZhuCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lbc0m0r8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IB6GM008152
	for <linux-pci@vger.kernel.org>; Fri, 5 Sep 2025 05:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/kkMetT+6syjiH0zDEnX+yyeCPRKqyQXOS64Sr9lqW0=; b=Lbc0m0r8GXRBSr9X
	UDq9lsgb3tJeVwEGkrN3/bw00o7K1G+TFL1eYZdf5pNlqehF4BCTOm8maXuJ+qJi
	lw1XoAeCI3o9+EtsTONLFS/mYDJaVSanuycIyglzEF5l1RfURTuTXkvzKAKU9d46
	SPPreKTlQxvsLfypfJGugLKR1yphUSNHUCqnOP5dlPL5GJeULUUd1FAwvjrDXJEd
	PEyRwyF5KBoB1jyaMK8cR591O3J1aRlZmMIifZclk3vn2zgIZTutdTvXtgPCOYLY
	mDIKtdddM4EG7Ydm+e/ScBF6S5IrrBwd+cHpuRsO+LQXHvACSokvzH9D8VmFekQQ
	NhjtgA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjsuv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2025 05:17:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c72281674so1343646a12.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 22:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757049470; x=1757654270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kkMetT+6syjiH0zDEnX+yyeCPRKqyQXOS64Sr9lqW0=;
        b=C1MyIcILVrCChNBMX8MKjq394vZ7I06Wg0josonVgVjM+J+/A+IufokHafhtvfaq2J
         M7giVcfq+QSyPJK7aZg+Zoaj7SgCqDV9T6m9hzdQ6/Jc6ZIpNXsSGqztgz/LsyrVC+FK
         nMLtMuC6qbx+75jnj9EtJbosOkvF2xojuW1/+aA3R1YQFmbqW0UrPAHkfx0C1ZwYavXe
         R7WqYc6Ak7LuHOHrUmr+MGOoYy3Iws7CaR9Zik1YtVyVxyWs/xo0HyeL++zNrCgbN/88
         98/SSeq/s2qpe26Tg3FZpT1Ed3TUQ0/VhnvYxXnCMj3SliRVf3Ccw3TRRyFRK+amGmzu
         oNSw==
X-Forwarded-Encrypted: i=1; AJvYcCUr/TFLKRBHhiSEvi79AcCSD6Xls9lWNFZ5CO/2vi2Yzcnt9AdshdnTSR/0u8fl0M/7Y5pq+uyf93M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+MKI4SNS91FZUdXp8fNAlb4LIOzDx3FAHfsESlBftHNJQYvB
	plxvpBiSB2gpfIPQN6HHHVLBYfFWJ3+3o6iurbtvpd+RMwKZflm2jxTfSXcTQJQ6DV1q0WcHfB7
	nuFnvHhAV0/7TDecjJ/PksldzegbJRWgIdPF7dK5XJ4DJBbRa0/eP6/MCbo+IA5U=
X-Gm-Gg: ASbGncsTWe5SJBe8iDGJ+SXkc+lkfvvg1zxo8SIeWlbJxTxOYAf2XQzWiuQnReyQe/t
	efLMpFc5ejegdNQcbWwVySuyb7YM2rbLRCnHbSTQOj7DIAQ9GA25zp1JcElmPqFSDEwVye5hEQc
	EQ7kR+uTv3QLodJbPYgI1nm+2Jbpuc2Pg6qN18oMhzKUzXhblutDI1nT0CAdDYY5lXp1JpqIyuL
	fYrCF47wj5QmzAovJ0I3qfNyHmi1emWXF/AtYwEZuc2v2waZ0wKlOEP5B052zLLDojV6iAp+aVS
	jGXdxpMzsKuINK4nD/73jl/wyDzBfPnGI1cG3CIMBr88dcByjMgO4N+jP4GOqrCz3Vr+XC1bkQ=
	=
X-Received: by 2002:a17:903:1a67:b0:24c:b83f:c6bc with SMTP id d9443c01a7336-24cb83fcae1mr93316635ad.56.1757049470490;
        Thu, 04 Sep 2025 22:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/HudJkVHY47aTTdSdxbVjhGZ0iA7XAdq3M3NzhR8STMn+juzLVlL0XwOIV5uAOZ5kdH1N5A==
X-Received: by 2002:a17:903:1a67:b0:24c:b83f:c6bc with SMTP id d9443c01a7336-24cb83fcae1mr93316105ad.56.1757049469919;
        Thu, 04 Sep 2025 22:17:49 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f3205cdsm85944905ad.90.2025.09.04.22.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:17:49 -0700 (PDT)
Message-ID: <79d44c24-d853-4128-b966-8a25aaefad73@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 10:47:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250903201233.GA1216782@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250903201233.GA1216782@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68ba7280 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qonHfBBtBxQ77LOI7bEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: bw4w83Q_n-3wN25D3Z8TBO4x7YJBi2hy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX3kiCcG2oRUAo
 /w23ek8koEN3fYaeEvao36v9PkLieuAzvijgN7q7CXFEig7bd4kglKQ8dWueN6yVb97JkX1ST6q
 sk97zJDcb9ZKbAZSO+6AfBXTgcrAH6QhYhN408EXAemKeRH9NmMcgCFvyRSvE6X6uqQgVKT9U0Y
 gOVFkNt0zUPyivff0Qn9biwXcDjZQ+/4+sFn4aCp+ckag1ediKHWYhSt9OsSZz1ntz8CqY5Bl4A
 Ep4VwUBt8sId59G+7Z4HRiJB/BQVqt36CQ5McMSXHUxwUgDLyMKOYOSyoipPcdO4brjWY5vNzVr
 qMBBMSf/lFWLWiyKPnKycMR9bYbP/FUme5cNeT9VQ20AvBw3Am2dRgCdo5eyKM3hM681tzFEDN6
 i+c696nb
X-Proofpoint-ORIG-GUID: bw4w83Q_n-3wN25D3Z8TBO4x7YJBi2hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/4/2025 1:42 AM, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
>> The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
>> gives us the offset from which ELBI starts. So override ELBI with the
>> offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
>>
>> On root bus, we have only the root port. Any access other than that
>> should not go out of the link and should return all F's. Since the iATU
>> is configured for the buses which starts after root bus, block the
>> transactions starting from function 1 of the root bus to the end of
>> the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
>> outside the link through ECAM blocker through PARF registers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 5092752de23866ef95036bb3f8fae9bb06e8ea1e..8f3c86c77e2604fd7826083f63b66b4cb62a341d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -55,6 +55,7 @@
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>   #define PARF_Q2A_FLUSH				0x1ac
>>   #define PARF_LTSSM				0x1b0
>> +#define PARF_SLV_DBI_ELBI			0x1b4
>>   #define PARF_INT_ALL_STATUS			0x224
>>   #define PARF_INT_ALL_CLEAR			0x228
>>   #define PARF_INT_ALL_MASK			0x22c
>> @@ -64,6 +65,16 @@
>>   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>>   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
>> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
>> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
>> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
>> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
>> +#define PARF_ECAM_BASE				0x380
>> +#define PARF_ECAM_BASE_HI			0x384
>>   #define PARF_NO_SNOOP_OVERRIDE			0x3d4
>>   #define PARF_ATU_BASE_ADDR			0x634
>>   #define PARF_ATU_BASE_ADDR_HI			0x638
>> @@ -87,6 +98,7 @@
>>   
>>   /* PARF_SYS_CTRL register fields */
>>   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
>> +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
>>   #define MST_WAKEUP_EN				BIT(13)
>>   #define SLV_WAKEUP_EN				BIT(12)
>>   #define MSTR_ACLK_CGC_DIS			BIT(10)
>> @@ -134,6 +146,9 @@
>>   /* PARF_LTSSM register fields */
>>   #define LTSSM_EN				BIT(8)
>>   
>> +/* PARF_SLV_DBI_ELBI */
>> +#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
>> +
>>   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>>   #define PARF_INT_ALL_LINK_UP			BIT(13)
>>   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>> @@ -317,6 +332,48 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>>   	qcom_perst_assert(pcie, false);
>>   }
>>   
>> +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u64 addr, addr_end;
>> +	u32 val;
>> +
>> +	/* Set the ECAM base */
>> +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
>> +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
>> +
>> +	/*
>> +	 * The only device on root bus is the Root Port. Any access to the PCIe
>> +	 * region will go outside the PCIe link. As part of enumeration the PCI
>> +	 * sw can try to read to vendor ID & device ID with different device
>> +	 * number and function number under root bus. As any access other than
>> +	 * root bus, device 0, function 0, should not go out of the link and
>> +	 * should return all F's. Since the iATU is configured for the buses
>> +	 * which starts after root bus, block the transactions starting from
>> +	 * function 1 of the root bus to the end of the root bus (i.e from
>> +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
>> +	 */
>> +	addr = pci->dbi_phys_addr + SZ_4K;
>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
>> +
>> +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
>> +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
>> +
>> +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
>> +
>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
>> +
>> +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
>> +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
>> +
>> +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
>> +	val |= PCIE_ECAM_BLOCKER_EN;
>> +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
>> +}
>> +
>>   static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>>   	}
>>   
>> +	if (pci->pp.ecam_enabled)
>> +		qcom_pci_config_ecam(&pci->pp);
>> +
>>   	/* Enable Link Training state machine */
>>   	if (pcie->cfg->ops->ltssm_enable)
>>   		pcie->cfg->ops->ltssm_enable(pcie);
>> @@ -1314,6 +1374,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +	u16 offset;
>>   	int ret;
>>   
>>   	qcom_ep_reset_assert(pcie);
>> @@ -1322,6 +1383,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (pp->ecam_enabled) {
>> +		/*
>> +		 * Override ELBI when ECAM is enabled, as when ECAM
>> +		 * is enabled ELBI moves along with the dbi config space.
>> +		 */
>> +		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
>> +		pci->elbi_base = pci->dbi_base + offset;
> 
> This looks like there might be a bisection hole between this patch and
> the previous patch that enables ECAM in the DWC core?  Obviously I
> would want to avoid a bisection hole.
> 
> What happens to qcom ELBI accesses between these two patches?  It
> looks like they would go to the wrong address until this elbi_base
> update.
> > Is this connection between DBI and ELBI specific to qcom, or might
> other users of ELBI (only exynos, I guess) need a similar update to
> elbi_base?
>
This is specific to QCOM only, with the commit 10ba0854c5e61 ("PCI:
qcom: Disable mirroring of DBI and iATU register space in BAR region")
The DBI address can moved to upper region of the PCIe region. When DBI
is moved ELBI also moves along with it. So if this patch is not present
elbi will not point to correct ELBI address.

- Krishna Chaitanya.
>> +	}
>> +
>>   	ret = qcom_pcie_phy_power_on(pcie);
>>   	if (ret)
>>   		goto err_deinit;
>>
>> -- 
>> 2.34.1
>>

