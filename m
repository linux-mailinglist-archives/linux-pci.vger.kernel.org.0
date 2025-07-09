Return-Path: <linux-pci+bounces-31764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9AAFE89E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527083A4CFC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598252D8372;
	Wed,  9 Jul 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XK0LFGIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4052D543F
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062983; cv=none; b=qJuNzknym0viSxK60W4ReXIGbOIw6MJ+UspCdHW91/UHe5RELGT4HmmtCOhlwH0W6wTn3ylDhwGgzad8oXREu0F8CssgUYCXePXm5hrqiG4nq8T4IsinSIsNqyUD7nUHNcn7L89ZXwkrFEpB0ONEwpJIGcP0uMuOj2G+LKs3q8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062983; c=relaxed/simple;
	bh=vWjnsHaFdY57vSv5iKmGhETY4L2tSuUWtXsAYrevCaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJ5AMXskEhlCVck5H4qTZGih+HmmJAOA7b76rG/A/fkuhKZoaBepicUek6E7i0HgICN6ycKhKvBLRx9y4hQBQTyl22EE6w1xKkqJlpKMbKMDWbkZ4W2V1xML+IvLEBSr09V1p5ZRaJ0c8qnnBBkl2XvhWhsGd0jd8TBgEjKfszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XK0LFGIg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569C4DTx017268
	for <linux-pci@vger.kernel.org>; Wed, 9 Jul 2025 12:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GzAznaWmjvDBxr0Q3tW6ieQZBTpTt1BwUiW915blvK8=; b=XK0LFGIgeCIC6qbe
	HEYJm5Cjmmu9I7sT6QLpk91tlYapcdArHKQ5hGXt21y5fsG8s0uqIeBkRZKKIJwg
	2qNTZMSCW0pNZv8+z2E1zcU0gl9fMn+pHZvB4Cthp3atR2sI3sYXOYmUI9/8AW73
	Afc3q6P5wb+NX3coayjBm5p1V951ZuDB5+87AVAlmSHfWtY1WXxd2HjE28msz1pI
	hCwUwE0pfhFsoEh6gk7uIsoQNLF6rxGAeiRdbMhQT67PxCUI2bDe5FHeStI4mdTT
	Jik6wYfBH9trLGPTJPc2Q27ljmZPTR6vPleZFqxhdjKZpkhdHGIO5sbG0yf0+zHq
	Lv1NRA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefmbk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 12:09:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b34fa832869so740170a12.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 05:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062979; x=1752667779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzAznaWmjvDBxr0Q3tW6ieQZBTpTt1BwUiW915blvK8=;
        b=SPhsc4OLvUKyellC3YOcKXpMLYcP/ftrFo7wQx26Tbnc0KPhTpcE7ftZa20b13rPE8
         VKHapuihSZDKTMGt6suD5niB3glbftldR6emLkaR+zWOJgDVoi38ZWO9FXWTCboAcuV4
         hg+cgsCV2B/WmtEo0vCLxKBXAs+jQiSuqcjtI/eAcLxpTySJEOXxlBBhurpRDHClIJUm
         C+ebmq6vH9KuPiH1uAL7praD/hEf/f3uK8a/9USscpwb/e/429+d9+QAHiVY/8H2kWv3
         AOvh4hZZE5uuKNHss+dCs5wjJcaJY6tQKB1vnpk9SfTw34y9/5ZA28oSUUrAMpBDfXUD
         8VqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Qy/2Sv4hpGJjd9TBVO029f6BkM6jGjwXu8amDWW9+BQsGzW8y6VW2Knw40pvZhDWfTUzk6TENwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83aC3QNYHs77gBKJ9xqYTTgwUsKsZvJjqXTn+tjnh+Cyz/+aP
	vZGLLIlYrF5gvDjF9gJUOggJ50p0Sha53N/6iaeKziE21JMfMBUBRwg1+60ASOUpMkO2wYBSaSu
	sdfaeXP2lz8X15sDAMf9A5W7JvpTkZCCBP7E8mxUtwODaJUXzsGz2Vaei9EgaSpU=
X-Gm-Gg: ASbGnctLWRbLmg8dTmAjuZPvMuzTL3KC0WDDJYuKiB1hh1Sl8dwODwb3jAzd6CESF5n
	qwYLCC3sZfuCE8PrUEC5yGAnAaWZfuVmGpVItFgJRqRqN+crqoZHMbQ9PaJuCVdbFxn8GVtqzfl
	59FgybYfLmqD/ItoohHEujmEvqCxYc/LcNJH2EtdGg+Y+4sMgyeRJ545hRbqAKWIqga+RaSNWKh
	Ep3i6YV7AtWc/OGqpekXnidazY0mV8Bg47rKqnLkr5hIXEgrywz8BEJ1fl8fnM4W3reb2UaPHky
	bC5t7UiGp9KyMBsVX0hiPFNY3I3fbqdKh2WYthaEvtIaFe6akcNN
X-Received: by 2002:a17:902:ef47:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23ddb586dbdmr30688765ad.9.1752062979181;
        Wed, 09 Jul 2025 05:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5CmuLtJ9EVCj5EH3hN0FC/CSxne9G31njh1b728ZlbRWZpXih/MgtxmqEpMqJxZ6THKsVA==
X-Received: by 2002:a17:902:ef47:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23ddb586dbdmr30688305ad.9.1752062978696;
        Wed, 09 Jul 2025 05:09:38 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e9d6sm144191025ad.151.2025.07.09.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:09:38 -0700 (PDT)
Message-ID: <5625ffa1-f952-4646-a17a-fbbfffcdba2a@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 17:39:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com>
 <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwOCBTYWx0ZWRfX6g7DIAhKXOOG
 u8uEJtuNDDgCQWVe26JiRFCtgtbvb9tPMzRUg6ew71XziXIytaJYzO1Ri3UVfyqaMLBysHxYA0t
 D04KjpWAOyuAI3xRbWcnyGdLMHbfPMdIuL88CpDQ8bUeoTWWTVcbYwJaob6LBVJFxq9c4RxBaou
 xC+It07rO5b44hI/cJ+qF3y1IwDDY/A0Ca76tf/OQttcw4i416RFhtSm8q9QiHpjlyT9BEma5bL
 CGFljlBMfwznCdy7Lm5LgTP+k/gRgOrDGH3jsTe2AKrbpSAu50P36tuShrZW8hGn8Rh2vEMR9sz
 vglqYGrF5OomEZCF77IMbEmCU9YTT1yYyjXar5LKV8W6VIbjtH7fl/+ynSP9/YQFboTgkWU2xL0
 lE1/ua+ecJ9xJ2Ht8MFzwJpCuK4OtkLo8vCNDhMMBZY1ovqY3+1OjC8Y2JRP6aE5hfOBNFkJ
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686e5c04 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=wBt9fhMRhOodALO6grUA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4wv42xWrdhZp4lZyXSer1HL-ITSJukLn
X-Proofpoint-ORIG-GUID: 4wv42xWrdhZp4lZyXSer1HL-ITSJukLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090108



On 7/8/2025 10:06 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 04:21:24PM GMT, Krishna Chaitanya Chundru wrote:
>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>
>> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
>> located after the ERDB array. The location of this group of registers is
>> indicated by the MISCOFF register. Each capability has a capability ID to
>> determine which functionality is supported and each capability will point
>> to the next capability supported.
>>
>> Add a basic function to read those capabilities offsets.
>>
>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/common.h    | 13 +++++++++++++
>>   drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -16,6 +16,7 @@
>>   #define MHICFG				0x10
>>   #define CHDBOFF				0x18
>>   #define ERDBOFF				0x20
>> +#define MISCOFF				0x24
>>   #define BHIOFF				0x28
>>   #define BHIEOFF				0x2c
>>   #define DEBUGOFF			0x30
>> @@ -113,6 +114,9 @@
>>   #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
>>   #define MHISTATUS_SYSERR_MASK		BIT(2)
>>   #define MHISTATUS_READY_MASK		BIT(0)
>> +#define MISC_CAP_MASK			GENMASK(31, 0)
>> +#define CAP_CAPID_MASK			GENMASK(31, 24)
>> +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
>>   
>>   /* Command Ring Element macros */
>>   /* No operation command */
>> @@ -204,6 +208,15 @@
>>   #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>   							       MHI_PKT_TYPE_COALESCING))
>>   
>> +enum mhi_capability_type {
>> +	MHI_CAP_ID_INTX = 0x1,
>> +	MHI_CAP_ID_TIME_SYNC = 0x2,
>> +	MHI_CAP_ID_BW_SCALE = 0x3,
>> +	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
>> +	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
>> +	MHI_CAP_ID_MAX,
>> +};
>> +
>>   enum mhi_pkt_type {
>>   	MHI_PKT_TYPE_INVALID = 0x0,
>>   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>>   	return ret;
>>   }
>>   
>> +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
>> +{
>> +	u32 val, cur_cap, next_offset;
>> +	int ret;
>> +
>> +	/* Get the first supported capability offset */
>> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*offset = (__force u32)le32_to_cpu(*offset);
> 
> Why do you need __force attribute? What does it suppress? Is it because the
> pointer is not le32?
> 
yes to suppress warnings.

- Krishna Chaitanya.
> - Mani
> 
>> +	do {
>> +		if (*offset >= mhi_cntrl->reg_len)
>> +			return -ENXIO;
>> +
>> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		val = (__force u32)le32_to_cpu(val);
>> +		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
>> +		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
>> +		if (cur_cap >= MHI_CAP_ID_MAX)
>> +			return -ENXIO;
>> +
>> +		if (cur_cap == capability)
>> +			return 0;
>> +
>> +		*offset = next_offset;
>> +	} while (next_offset);
>> +
>> +	return -ENXIO;
>> +}
>> +
>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   {
>>   	u32 val;
>>
>> -- 
>> 2.34.1
>>
> 

