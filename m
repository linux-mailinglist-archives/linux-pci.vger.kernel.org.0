Return-Path: <linux-pci+bounces-35499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9BDB44D01
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223B0A43E53
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2B260586;
	Fri,  5 Sep 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eE+AAGia"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE82229B02
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048919; cv=none; b=mgRV/UGF/iEBxANw10fJlefz30PABa1ROh78AB4XKFONGhCpTShH8aSUAa/+/AWKEIGsvi4LtVKjHLqApFGOdoNZaVnOtBqJ7fktPK+9ePbAmZdNA0LYwAAz75cwPvTOCA8UKkjeSXNDo1zKZseX3JoHx5vD/YqKaFBxE/Jsc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048919; c=relaxed/simple;
	bh=GrlHgzC2CZ+jmdFYYWA4oPGmFL26PhRfAOttrHjSV9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiNSXzaAI0izdlAaL2qjdNsWVRohxiUpLdssauOR2Bn5FL90JijfBEfzSviLOXGh+EVqgVGgKu3F1OSmHlZe3ia3hu2WA8uwKfv4BzjKSa5mF6DK1pcIH87v4jOgeZy9HBOj0zjec3zDL6mfbMFsC4yiUKLDIKSwSuDs3bOdeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eE+AAGia; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IesL1008316
	for <linux-pci@vger.kernel.org>; Fri, 5 Sep 2025 05:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSV9LgvcNte42quuPILmy53FTfP05rNvZ3H6trDOXVA=; b=eE+AAGiaO+bRxnq7
	6QCLrNnCi4HVlWcL52am0ymom5JkC2A6sPXa/0TPeb9gEb0+LxgQRM8OLhLs8oL/
	xdLXnry0dsr2g6ntdkJOTv59oVV3hQ4uGAwQUUB92V3ChvFHbI90kyaSf7PUdS5R
	W/exYD/mq82BKtyFWi7SoMutwU4Dg4DNLg5VOayLHHcJXd4iKOGrl87qeg1VX2qh
	ME+kZT6nEmYrleMV8dgRr2u8sxEL3sATP5CpESf4irxv8iyLuTGcLXnq5n9nhc2l
	8BYkMlPiQye5Lw0p28LqcacTTh8FidpILrFQoDuS3hEXJ0Rx7IX7K58EBrDABO5A
	Bl7S6w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjsu76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2025 05:08:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso1429074a12.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 22:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048915; x=1757653715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSV9LgvcNte42quuPILmy53FTfP05rNvZ3H6trDOXVA=;
        b=D/hCACyzIBLtmjyu2xbshbLBHr5De1Mb0NYx6SCm0qT71HGihUvceuoX3dE/m82rvQ
         kIDriBZlwSA0Da/jAlCTjSThxzK5IoYBdAEbyYNcvRKtSd993kpgWKD7synkmejCo/pQ
         iWjdg6Ydt6mblzlCbEaUnlXEkoR7hFBWRR3zEV4CnEN7317hsOzJOa1vIFBrkzg5P/q5
         TWpJ1aAxKCEDWHDi9hcRUi6QTjpqPmkHXlmOl2V0NZd3nnxXcoHljhr+YtN3VlNrcWgj
         z1kyamKRKx8QP19Tp5gK2xBlOA1Q0nPifx1AF4HSdmKBLs82HCwwVsA9RyTlLAP2edxy
         vSAw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Xw/eWFBhtxnZj6eP75DH2ecU53/Q1CkNgdc4wZFnxJzB/kZ+PsoWYaZIyBD+NXzkC6bLtA3gzW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVm0SAVmDvWn3/Zgjne9corxzztGH0V8SlgGkt9kOlzTFxsvP
	zw1uKMqtkrGgG7bynQr7AfzQWmDl/vva3QT296R+c06xbsWaGd48RqQc/g6MqvfgnVM4mGUa2qm
	wjGuBuFvGIfftwhbpiAmODWlaU2ic3E1ihbu1nTpYcOZHBG9xi7Ra3yUWENHrIDs=
X-Gm-Gg: ASbGncve04EA3Fb8j0AQQIYD2qUVKuSGgg0ikXsNulfQ1qAml7UvrVwV/uAPkLpmWhC
	y1u7LyrSug70dC8KAlyiqina4blIYeo+VFWBGScHS2gbykGwUwWpU+ODv74tQDk2YjLYKu9UYbY
	tx1o6u5ypb5fu8U8otJYptOFnuFe5erd0ZCMufe0W4q62XJWxy00BwfZoBS08NW03kgyf/tEHH1
	A0oBPRhERBDhFxXSGBjXCKlnoTfQ8tGDl9rM8klyWMQyRSlOsgoTAkvNlPFNGTUyiw/H3QeZEL+
	rMurlXw75In+V1xmwsK2qcJyzGB18VdSKVVyFA5n1XNTbvh5NYsKyDjmMpsOZku0bESw/Bfi9w=
	=
X-Received: by 2002:a17:903:37c5:b0:24a:a2c5:a0a1 with SMTP id d9443c01a7336-24aa2c5a420mr239775695ad.21.1757048915002;
        Thu, 04 Sep 2025 22:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY/HqqWmtHl5e1NSr2FpgkUWCKmbzdwLY6Mz0jjApAO3v/DyNq9FxUsI0fmcFaLxI90E2kLw==
X-Received: by 2002:a17:903:37c5:b0:24a:a2c5:a0a1 with SMTP id d9443c01a7336-24aa2c5a420mr239775175ad.21.1757048914300;
        Thu, 04 Sep 2025 22:08:34 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da183asm198371925ad.74.2025.09.04.22.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:08:33 -0700 (PDT)
Message-ID: <6502ef34-34c8-4aa5-a0f4-6860ac5a2802@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 10:38:31 +0530
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
References: <20250903195721.GA1216663@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250903195721.GA1216663@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68ba7054 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9HwtANXkhL7ZsJXsY_EA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: uSTdXNnUCDtwjf9bG0f296_89VfTfslj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX8SH8BH2vV9g1
 2fWpKO32uXx+PjOMFwydok9JF2P6ce2Bzi3kJ3T0GXld1fHx2fqIRPu2/S8ER0bSZGoy3TIrofa
 CCk6MaXCIn81wUDhPDKXVszq/aJrOPyRwdqOHNdsUSqmrcKqA3V/7bRM6o8SD7qEO7rUG0+9n8Y
 E20j4tXXw26ijrULL7W2msQt+oX4B3q/kIwGwrOCO+3q1e2O0hk5bJ89peu3/z5YMgufRTtQWo3
 bjW6HpfUeQOiEPtM2Vd+HbKgtlxAZmZUwoSbPKk+At9T4AwmiYNh7bEPUhaxp9OfcggCjoRCBfe
 F5blBpC98JkoKsvu4Tot2go1H3/QHz2LOwOoQ9bgx7KSrwfAcuqnl/7Uya9SnLwmV1m6pSrV2Qe
 mfKdzkWQ
X-Proofpoint-ORIG-GUID: uSTdXNnUCDtwjf9bG0f296_89VfTfslj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/4/2025 1:27 AM, Bjorn Helgaas wrote:
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
> 
> I guess this is an implicit restriction to a single Root Port on the
> root bus at bb:00.0, right?  So when the qcom IP eventually supports
> multiple Root Ports or even a single Root Port at a different
> device/function number, this would have to be updated somehow?
> 
> No need to change anything here; just making sure I understand what's
> going on.
> 
You are correct Bjorn, this is for single root port on the root bus.
when there is multi root port we need to change this logic in future if
QCOM decides to have multi root port devices.

- Krishna Chaitanya.
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
>> +	}
>> +
>>   	ret = qcom_pcie_phy_power_on(pcie);
>>   	if (ret)
>>   		goto err_deinit;
>>
>> -- 
>> 2.34.1
>>
> 

