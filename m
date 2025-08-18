Return-Path: <linux-pci+bounces-34165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B6B2990A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 07:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD717AA4C6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0458220F2C;
	Mon, 18 Aug 2025 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WpZ5N/9l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA513B797
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496081; cv=none; b=rxPIgSxBrCwb1YEhta49++fFnA9DNeuWlTIoTIKk2XzmkP8itZ9gcQqynqSnO2FyWp7udAs9McQWQwEyIazHpUIUE3GeqeKJyRMYYDlH0llCKNYBRoN5CbjhRZ491hoLVYBfmEOiaEDEdRoNbzsLiQki9I9THVPunsCjw6eS7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496081; c=relaxed/simple;
	bh=6RL9+Xn5aegTJY0wjfAGUb6Cr92tP/PpJ2hnpOZOiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coAAnSqua3hktuXZB9ClN37LMtUvzameQU/ekCS3Y13+qy5LRh3zpAhxXs05PNnk1hX/gBRjQGdQBL/Q4v+v0lhUdL5aANTg4VTXjx6BWQvgjVgdQ2AIyRqos6dxGXXGarQnEdr9TqgvX9a/h5ocjXorRgpdx3eGyh7FT+MzaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WpZ5N/9l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HLdBMJ008371
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 05:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UeidIzr/dKJkWw7XetUW6GunyrwIPKaUXOvs0jevNFA=; b=WpZ5N/9lLxtvIiLL
	tvCtZGO6DxuJNKFjeGBEAEw53dQ6VjgKlknokGx5ZCc71GJ9wmZpYK1RnmMpbP/i
	EcUpg1j9CxTzngUGbVkEDfQJF9ZTWTbKa9KG5ZWPSk9S0LObhKUnnZj3OCFiI0SP
	fMwh8HxIDR70+9MuKs6TAdz6ouni790VfwOO5zeVKWSu4EwI21u23JV49aZwgUCZ
	9a1ZWtIf7oCeO0OCgSwxh4sjaUOs+BMT3fwbQtmZDn1JA47odMnL1yhcMtPZgovo
	ON7pLqDlAajFnRvPgta8UhmjASThtb5c/rs5YPpaomcdwcM8xxK7NrbGSAOBE5Gm
	ccyr0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj743dcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 05:47:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f440f0so39224995ad.0
        for <linux-pci@vger.kernel.org>; Sun, 17 Aug 2025 22:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496077; x=1756100877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeidIzr/dKJkWw7XetUW6GunyrwIPKaUXOvs0jevNFA=;
        b=JHGv2/BD68x+X85QVgtf/IVfNO4RomYsmxWj52fKA9vqa0vo0oN01t8HlOUWfQD0oP
         vGv+YYb3/4bvUEeopLFdU1czKVLru8oxZiUoPmf/XbDvg9qq8MI1hgK8fIqpd0Swh4AV
         nYs27z5W5e1BCZmCoK6JusXyBgwYTkS1x/ymBBt0mL4mrvo1tdcP914R51uqP5svw5Uj
         e3QmMVNQRemjvS5HTVWXtBpPwhYuBZq47D2eiI+3RLADzqLvV0FN658ztAQqpOBfyUsI
         dF60ONzF4XJJ9SjMiel82zO1cnKTyGBAuEcsfEYLZcnTdq15XvNwrDS5nbwgROIIY2Ng
         X4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3VA0lt758OMXCifRnFKW254oCw+ugyqT8y1aZDUVJu33dNyBLgHgXJS2hDSaGKW8iZWqslkzbDKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxzl9p2aX0zEKdb7qotfMJXFcUXLlBcfPZOOx+Lo5N0pXQyuXP
	optDjSCp7hrYeeqkr/DBQaB3TcdgBO6cf97OBDrlqI4r5WYs979EX0xOMFwtCoOaljZvX2Ex+u4
	MZgSz+2bJ+aoOVtXL1VE3JucnoebNdnBK9OI2W7fcnPYEBMDsNRR83Q4jCkRLmxUefVFVRJs=
X-Gm-Gg: ASbGncstnRVkyA9CZ+Gua63jEzIvVznEaINMBqjvmV/ipe8IIK7zBEPm4nrg+Tzq49t
	s267Nin3OA5fyuRTEzL0+xE+Qpm7uklanfWN/ZyUtUPol87qDbo5ZZeZATOlK9/WVBTuhv+g6ih
	PZEsC/Thktv9SzMcRGU9dexKbcHgek3wrzAi//6Tw2d8xx9aGyaRkYq/1o6zQ7WyrePUMKJEGgA
	mqZyRuAyrJLQfdoIIzcECzlAu3QNXWUEubLftQUxwc0do2i4LZ3tUSbyOe11U/lKFSZz35QoosM
	MHJQDE1mF3MwkvVGzheAWo73GdZzH2WJSqTr3vbTWdxtvhSgDPMH8mseKbSwXRRsPVgPWS2JAg=
	=
X-Received: by 2002:a17:902:ef02:b0:244:6b77:5b10 with SMTP id d9443c01a7336-2446d89d221mr126079075ad.36.1755496077051;
        Sun, 17 Aug 2025 22:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4IOalNWar66B22rHJVMIAjJY1v2hPIOrJvCuOPmIDSJbaYtKfcaHS83aej4K/R2Bxeoqgw==
X-Received: by 2002:a17:902:ef02:b0:244:6b77:5b10 with SMTP id d9443c01a7336-2446d89d221mr126078695ad.36.1755496076565;
        Sun, 17 Aug 2025 22:47:56 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5a9b9esm69293305ad.167.2025.08.17.22.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:47:56 -0700 (PDT)
Message-ID: <bb1b095f-4198-495d-a82d-1d1d7b7367d1@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 11:17:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com>
 <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2>
 <5625ffa1-f952-4646-a17a-fbbfffcdba2a@oss.qualcomm.com>
 <4c68074e-5809-bc4c-185a-88ddcb81f31b@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <4c68074e-5809-bc4c-185a-88ddcb81f31b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1mGgX6hpQnnA9YgMwR7esIUX9cGWKSAy
X-Proofpoint-ORIG-GUID: 1mGgX6hpQnnA9YgMwR7esIUX9cGWKSAy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX5OkNRCAMTqg6
 iMsEcXrcje6Jaw65wDWV7fBDL00uj1DI5wslfwhrLzqHFpyAjhUebhaVQNZ9YEMKLaHJaaiPJJ1
 kY6RAK2h/Cr2BJkeALhoarnJ+N2q+XvxTKBp+mTT2PaOM2Yffuk6jJfP/FLNkALEdNNHEJt3OMw
 vBGjOu95kz+1oeyQ4/SOk14hOS5SiJUyQrdvj35Bm1SZRnTGUME1Wt6gqlV6E6iHqIJhRZJZSsm
 h2OWqZMjwxAicg3lskbq8wpKQ1sVeiisbpW0FaNQ7PbC7RHECxlr/04uFBX1Gsa3fXuhTghvMPU
 diiy/ZMhNOHszQGpSL44Bzg0cmloFblnAEyrvuGDM6rYh1rU5TBuR4yGpbh8g/iiJMOEkFiV1/F
 ZFZSP+s8
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a2be8e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=BTqdaEJVcAPEW8WuxcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033



On 7/9/2025 5:50 PM, Ilpo Järvinen wrote:
> On Wed, 9 Jul 2025, Krishna Chaitanya Chundru wrote:
>> On 7/8/2025 10:06 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Jun 09, 2025 at 04:21:24PM GMT, Krishna Chaitanya Chundru wrote:
>>>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>>
>>>> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
>>>> located after the ERDB array. The location of this group of registers is
>>>> indicated by the MISCOFF register. Each capability has a capability ID to
>>>> determine which functionality is supported and each capability will point
>>>> to the next capability supported.
>>>>
>>>> Add a basic function to read those capabilities offsets.
>>>>
>>>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>> Signed-off-by: Krishna Chaitanya Chundru
>>>> <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bus/mhi/common.h    | 13 +++++++++++++
>>>>    drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 47 insertions(+)
>>>>
>>>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>>>> index
>>>> dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd
>>>> 100644
>>>> --- a/drivers/bus/mhi/common.h
>>>> +++ b/drivers/bus/mhi/common.h
>>>> @@ -16,6 +16,7 @@
>>>>    #define MHICFG				0x10
>>>>    #define CHDBOFF				0x18
>>>>    #define ERDBOFF				0x20
>>>> +#define MISCOFF				0x24
>>>>    #define BHIOFF				0x28
>>>>    #define BHIEOFF				0x2c
>>>>    #define DEBUGOFF			0x30
>>>> @@ -113,6 +114,9 @@
>>>>    #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
>>>>    #define MHISTATUS_SYSERR_MASK		BIT(2)
>>>>    #define MHISTATUS_READY_MASK		BIT(0)
>>>> +#define MISC_CAP_MASK			GENMASK(31, 0)
>>>> +#define CAP_CAPID_MASK			GENMASK(31, 24)
>>>> +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
>>>>      /* Command Ring Element macros */
>>>>    /* No operation command */
>>>> @@ -204,6 +208,15 @@
>>>>    #define MHI_RSCTRE_DATA_DWORD1
>>>> cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>>>    							       MHI_PKT_TYPE_COALESCING))
>>>>    +enum mhi_capability_type {
>>>> +	MHI_CAP_ID_INTX = 0x1,
>>>> +	MHI_CAP_ID_TIME_SYNC = 0x2,
>>>> +	MHI_CAP_ID_BW_SCALE = 0x3,
>>>> +	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
>>>> +	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
>>>> +	MHI_CAP_ID_MAX,
>>>> +};
>>>> +
>>>>    enum mhi_pkt_type {
>>>>    	MHI_PKT_TYPE_INVALID = 0x0,
>>>>    	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>> index
>>>> 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be
>>>> 100644
>>>> --- a/drivers/bus/mhi/host/init.c
>>>> +++ b/drivers/bus/mhi/host/init.c
>>>> @@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller
>>>> *mhi_cntrl)
>>>>    	return ret;
>>>>    }
>>>>    +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32
>>>> capability, u32 *offset)
>>>> +{
>>>> +	u32 val, cur_cap, next_offset;
>>>> +	int ret;
>>>> +
>>>> +	/* Get the first supported capability offset */
>>>> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
>>>> MISC_CAP_MASK, offset);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*offset = (__force u32)le32_to_cpu(*offset);
>>>
>>> Why do you need __force attribute? What does it suppress? Is it because the
>>> pointer is not le32?
>>>
>> yes to suppress warnings.
> 
> I'm pretty sure sparce with endianness checking won't be happy with that
> construct as you pass u32 where le32_to_cpu() expects __le32. Have you
> checked this with sparse? (It might not check endianness with default args.)
> 
>>>> +	do {
>>>> +		if (*offset >= mhi_cntrl->reg_len)
>>>> +			return -ENXIO;
>>>> +
>>>> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		val = (__force u32)le32_to_cpu(val);
>>>> +		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
>>>> +		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
>>>> +		if (cur_cap >= MHI_CAP_ID_MAX)
>>>> +			return -ENXIO;
>>>> +
>>>> +		if (cur_cap == capability)
>>>> +			return 0;
>>>> +
>>>> +		*offset = next_offset;
>>>> +	} while (next_offset);
>>>> +
>>>> +	return -ENXIO;
>>>> +}
> 
> There's a generalization of capability search in Hans Zhang's series,
> can it be used here too?
I Checked this option, the mhi capabilities will not fit in to the
series mentioned for not matching the mask for cap ID, size etc. mhi
capability are similar to PCI, but they vary between mask of cap ID, 
size of the space etc. so going with current approach only.

- Krishna Chaitanya.
> 
> 

