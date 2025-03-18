Return-Path: <linux-pci+bounces-24003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D5A66939
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 06:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4792E1898E17
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80E1C3BF7;
	Tue, 18 Mar 2025 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKorFj3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAA1A5BB4
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275417; cv=none; b=LWixBM/8xn12yU0IYzuu7BalUVBHHHDgCDLr25Wyk9UlEd3Ia5yR5RCXx3J1YrkMrJi5hbEnbg5H/oPLfLs7TgUyW+3RiDv7+e8zn/1k2i2tqn/ChQFreh8YA7aQwWKNq7gJtcp3pdEL2JcwcUGBLC6OONl5UStpF4mKGavnumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275417; c=relaxed/simple;
	bh=fS8f1uf7BKU/HUlUWVNLVuoNMefbids35kp6IPXf0ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNBRTKh7xiczHIjWoMHAgs8JP+YNfISfYRvawddCTQz0vXnUOTqIzfXfXbb65b09uebuUyNp0RPga1UgVEKPjl3mYMKZjotMv4NB7r+zBoCswexRkYrWHPmvQ6Hg+5kHexJYkpmenKee9UxbBK3hJK7/mooXrjFA7LrEAG0I0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKorFj3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I19Gvr022103
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Pl3Kah0DsqoBQNkGt5y+JtyywDOv40qZgjfSIjoPws=; b=GKorFj3lPIqc4vbt
	oJB1nnqmwVIcNFlatNgjSGd/BWPwTLSPsPewYwS7CGsgL21yPdSmqcm5Sw28FrMJ
	6rPV6PjlRDJcsaCq8cxh+zG3zXfZKef52p8JQhJsLCFU2lHyVrZPPKyKvXHYeizl
	mmzsPgrDcgcMEO8b0fzGg8oALvSsNttuSK9IuJ5sDwMNzwtQs5QfXfmMAuhQuarz
	+E/bmSkUre5nfB0B+yzkC8+OG5Qj6tpMTKqiNI7fW0jSGqXAUd3evOTtJu+dWanC
	TuW64AK1EVcj2BzU0FTJqCmoBOHmBXmtTRWsfOaYxxr2vxZpOrUJbd7zjVqAje+7
	kZ6Biw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx0hqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:23:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so67560955ad.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 22:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275413; x=1742880213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Pl3Kah0DsqoBQNkGt5y+JtyywDOv40qZgjfSIjoPws=;
        b=ca6TpYahv8jqPGzvziiX9yldOfawgaca2l1O8Ahws798+de0xgq14OJe59tONOjNiW
         fE/r2/TCPBvG1J6xlqnakkDaARn65YrLvcxhQdimG5efaPFWP9kLdCVbJhpxku5sbSqA
         gQDZGPfbj2kbP8R/ZydbS01Eu4wxBWyS3lIqayHFqbz1+tWooc8CyMO1Kqo3Y7t7SM1o
         KeQT5SVb0AlSODXJw93fxlcqunZDGgXAApcXq5oY0lAnn+jzG1ekwN1lEiBaSdeq4NH6
         a+qQdBoEFc5khyY6pjXyZSWjN3Xs7KJmROIQG+iMJ4bvMvPA6dw1MyYCNjaxBOOFAIHR
         9BQg==
X-Forwarded-Encrypted: i=1; AJvYcCWxaT1xVeF11uB9jQjsrHw7k4BcDzbECLFdb4kQtg/HKIuGmApG5gpKe/69T+7H32c9s1F2g9shwdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziR2Seita3i1Wp4cnVCTkomE9F4z1lt+ImbgiDBKdWugE7Xmrb
	WNqxYZOhgw7D8ZOcjZxMcZdilxTxaEkNZgug6c5WM8wuYr42LHjYQs8IfnJ3vYNKWp7mAas0okT
	hmf9PxtJG07j1qCqhjtrX6/72On3T4bqNhPRRAuNr5OWNPWCDc+UBHM4tjUM=
X-Gm-Gg: ASbGnctqYNbwMDEZGvaK0AKHvlD6JGD3G3pssXJgZ+Av7d0yv5Nj8uw3435y33Hu4E1
	y6zOkX1S4g3H25/9hgBESstHiHHF7+Xi41Gqpb+e8/pMhvsAY4I4orrO6ujSMu7nDgYqkC+AXTe
	RH0vMYyz/G8xO0jDnCtatzcv1z5fslCRYlwXkXBDhVwDF3LS/NKM08WrOA8bcoY10i6twofiCCF
	9u5+jpxzTGszwXQLt+Ac2o3Zc2R596ckVl1FOC1Q05UZvlVHr/iJ4DbzpOoZlsQQKPoZVBd5PtX
	xZARFW5gcUv2ZpxlZHCQsYALJgvwDi1wF/g00ecguIbGnw==
X-Received: by 2002:a17:902:d50e:b0:223:2630:6b82 with SMTP id d9443c01a7336-225e0a36298mr195663085ad.10.1742275413084;
        Mon, 17 Mar 2025 22:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBRYCNl/XCdXfHrA8o7EzcA4Q4teMrA8bJQWpzYSr7LqJZwMY0PAPuiPLPIeZMcDFz1f6ICw==
X-Received: by 2002:a17:902:d50e:b0:223:2630:6b82 with SMTP id d9443c01a7336-225e0a36298mr195662565ad.10.1742275412575;
        Mon, 17 Mar 2025 22:23:32 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e2dsm85348125ad.58.2025.03.17.22.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 22:23:32 -0700 (PDT)
Message-ID: <ab9a0399-95e6-09a1-0eed-84cc73efcf51@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 10:53:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 10/10] wifi: ath11k: add support for MHI bandwidth
 scaling
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
References: <20250313172828.GA740705@bhelgaas>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250313172828.GA740705@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dDRE7eRGo0vQVknaWJrU3qnQ86kfWWmA
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67d90356 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=CBOw_B3jzJvQ_MzsqMMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dDRE7eRGo0vQVknaWJrU3qnQ86kfWWmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180037



On 3/13/2025 10:58 PM, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 05:10:17PM +0530, Krishna Chaitanya Chundru wrote:
>> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
>>
>> Add support for MHI bandwidth scaling, which will reduce power consumption
>> if WLAN operates with lower bandwidth. This feature is only enabled for
>> QCA6390.
> 
> What is the event that initiates bandwidth scaling or reduces power
> consumption?  Is there any kind of user interface like a sysfs knob
> an administrator can use?
> 
it is initiated by the endpoint firmware based upon the bandwidth
requirements, if there is high bandwidth data endpoint requests for
higher data rates or if there is less bandwidth they request for lower
data rates to reduce power. Endpoint initiates this through MHI
protocol.

We will update the commit with this information.
> Does this happen based on ath11k usage?  Battery or thermal status?
> 
> I guess reducing power consumption or reducing heat is probably the
> driving factor since we would always use max performance if power and
> heat were not issues?
> 
> Some hints here would be useful.
> 
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
>> index 6e45f464a429..74769c0993ae 100644
>> --- a/drivers/net/wireless/ath/ath11k/mhi.c
>> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
>> @@ -20,6 +20,7 @@
>>   #define MHI_TIMEOUT_DEFAULT_MS	20000
>>   #define RDDM_DUMP_SIZE	0x420000
>>   #define MHI_CB_INVALID	0xff
>> +#define MHI_BW_SCALE_CHAN_DB 126
>>   
>>   static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
>>   	{
>> @@ -73,6 +74,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
>>   		.client_managed = false,
>>   		.offload_channel = false,
>>   	},
>> +	{
>> +		.num_elements = 8,
>> +		.irq_moderation_ms = 0,
>> +		.irq = 1,
>> +		.mode = MHI_DB_BRST_DISABLE,
>> +		.data_type = MHI_ER_BW_SCALE,
>> +		.priority = 2,
>> +		.hardware_event = false,
>> +		.client_managed = false,
>> +		.offload_channel = false,
>> +	},
>>   };
>>   
>>   static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
>> @@ -313,6 +325,33 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
>>   	writel(val, addr);
>>   }
>>   
>> +static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
>> +					   enum mhi_er_data_type type)
>> +{
>> +	if (type == MHI_ER_BW_SCALE)
>> +		return MHI_BW_SCALE_CHAN_DB;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
>> +				  struct mhi_link_info *link_info)
>> +{
>> +	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
>> +	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
>> +	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
>> +	struct pci_dev *pdev;
>> +
>> +	if (!pci_dev)
>> +		return -EINVAL;
>> +
>> +	pdev = pci_upstream_bridge(pci_dev);
>> +	if (!pdev)
>> +		return -ENODEV;
>> +
>> +	return pcie_set_target_speed(pdev, speed, true);
> 
> Seems kind of unfortunate that:
> 
>    1) The endpoint driver needs to be involved here, even though it
>    does nothing that is endpoint-specific, and
> 
As mentioned above the trigger to switch data rates is from the firmware
running in the endpoint. so we need to do from endpoint driver only.
>    2) The endpoint driver twiddles something in *another* device (the
>    upstream bridge).  There's a potential locking issue here and
>    potential conflict with any other devices that may be below that
>    bridge.
>
pcie_set_target_speed API is already having locks to protect/synchronize
various endpoint requests.

- Krishna Chaitanya.

>> +}
>> +
>>   static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
>>   {
>>   	struct device_node *np;
>> @@ -389,6 +428,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
>>   	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
>>   	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
>>   	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
>> +	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
>> +	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
>>   
>>   	switch (ab->hw_rev) {
>>   	case ATH11K_HW_QCN9074_HW10:
>>
>> -- 
>> 2.34.1
>>

