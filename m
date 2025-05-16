Return-Path: <linux-pci+bounces-27859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E77AB9C8E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FD31B665DA
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AE239E89;
	Fri, 16 May 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLzkf2sA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3441DFDE
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399787; cv=none; b=K+QGThFnA2tvl+kw2WDsvpAPCqiwGrXLgYusF9Cgfep/DOTwsaWX3xt1u9VQ74CXJ+OUffLHvHC5EZ31hw6vaGf4GnRXPtrVhVJJAkB3CQ8WzLF6N7jHHeRxK570DV1sF/Z+n+BIrBfl9d/NxNQux0SyMXpLGF8+tGBA3xib80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399787; c=relaxed/simple;
	bh=3XXz7vRINk0tGaKj+MeS3kJIyL4bpCw4p+dTKdtdfM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3uhC38eYU0BdZmZjfjXK9n2y6hha0eMfNLw3vRtsF0JgRSP5v83C7x3BgDgwPegAl5KJBwqKc6WXAsfQAKubqdDCRca4qgCRSJQ+ZEg0998GrTR0bWkI0bmpKlj3tZFLKQ0GUzRySu2+wKSud30LRldtv+i2gbbe3m2xsPIZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MLzkf2sA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBakUK025636
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 12:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SWaS/wBVLAvfdc/nM2uoXAFHKvztBdqdG5TtveZ7LUM=; b=MLzkf2sA58xbgcHq
	tFDhCFKlWCFy3uY47/9KRVLZrTrm/R6FwDCLzpnxswkzblxP/KxkP/cflyGiUSvx
	HhTATA5BPhBo9hzSnLp4VftKFmHMVjlaMdTvcsL14CAw63Kew0tiQrHp9wwB243T
	3d5WmST8nD02hrPN6iNHBWFFwI5e2/bQNlfqTLm6PTK9SLJx1aur6o2wVgILD3jf
	WHCGWQy3L9Z26S0xO22mDRdjc7KtvMDGh/VkEc35TCGJySbnKolBP25g3A5PAj1t
	29vEzInrsSu8AxM4+5LBr7nWZnGiCv86qHUxRJlkOGEzKRkgkKXW1vBB/5WDu2sL
	0uAuxw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcp1yw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 12:49:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73c09e99069so2461486b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 05:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399784; x=1748004584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWaS/wBVLAvfdc/nM2uoXAFHKvztBdqdG5TtveZ7LUM=;
        b=DzIX0pxf/4lQ1iBsXdwY3uQHXwONcvv3hiscOUeawcNK4VJlf1slxFemiuAsxb0S3K
         QTN71ufyrf1VwRNqxOjKV2iQOlhIF+YpUWKfCCDzd+Cvnyzf/oDL5nyGCIWry4MwUoRb
         IDjrQyW/TbaT2/ayaTuiE+vIUTYnC50Ogdi1v3NpvmRQDQi2qN1AKdu/XfgY01SAxhZV
         D0v8h9U3EHalFoTdMsovevR9RUvTrza5inzsCFfpC4v6/+uX0ZS0efazsxuv7UI5HJt+
         2sPdSIvzZ54Fkz+nEixujBstkqGw9S5U3DU2DvmqdZQb0zFwZFxVHUOESMF70Qg50DDM
         yWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/DrfaiO1DLhtF14MU40yvOb/kc+ICY8W9D8aZR5Ykuo2UpzEMNzl5ehlm+CcuC0LiXSYVAeXt2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnjQ+D4HzPdtyAhN1rfqKrnaMMUUr2t/sjb3hHGJGcXgemn6T
	5jBzuM2WUZFVvxhmJpuUCCfmHfOar2MK4yGuJa9a6ueDBDaon/eH4K6F5j1AjdxSqfpQNy+G7g3
	Uxa8anHxUQyp8TxwJZx78I0RmsAciVoFodgrhecvMuAzFd2tKP6x4mLRzUnEwrG8=
X-Gm-Gg: ASbGncsEEAY1gsyC+mLr4adyYn9UX5BhaWpo+iG06YRGB0nCONbpM8VpoLCfzZBKrJo
	0Zi8SfssoMTw7Dr1+8/bN0r8AEYiLZQuYkdKWv6uP5RrTEg0lqS5TjMfkhw7SYBX7nqS8DiLTb4
	tdWzqggALDDm2DoqQd0h9mZojEyAStZo/hz/g0sd9aXOF6QxE/2qXlaLQcerCzYdr835/aejNx2
	EGqtqdPID1Iz+QRv5P/NXGXWAi/Lq0nXvMjnCyuJfadCdpzxB2QeBIhfVrVpa2I7BnGNlZc+s4S
	/wYfbgt9526R9FG2rm/o6sw9RJsm5hMbIDzqc/+vgw==
X-Received: by 2002:a05:6a00:4606:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-742a98004abmr3848553b3a.10.1747399783816;
        Fri, 16 May 2025 05:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQNLTbI1B+VJP2oSagYa9oYzNOY1Dzfl1XASdr4bvFkyNdifiPDpdHQrMJseRvKhV111pTPQ==
X-Received: by 2002:a05:6a00:4606:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-742a98004abmr3848526b3a.10.1747399783377;
        Fri, 16 May 2025 05:49:43 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d9c3sm1407485b3a.121.2025.05.16.05.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:49:42 -0700 (PDT)
Message-ID: <7673cb4e-b359-be7c-27db-639f208e3835@oss.qualcomm.com>
Date: Fri, 16 May 2025 18:19:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 02/10] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-2-869ca32170bf@oss.qualcomm.com>
 <7njsbucxngxc2eninh57oexywiqsyysrbesyige5zwr4pmxf7t@rw6657lheg4j>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <7njsbucxngxc2eninh57oexywiqsyysrbesyige5zwr4pmxf7t@rw6657lheg4j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d9cc-zFg5-BPv5XCXtiEDZItxvo1vlcf
X-Authority-Analysis: v=2.4 cv=D8dHKuRj c=1 sm=1 tr=0 ts=68273468 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=PjKuzrdxt0Go-pjIBLUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEyMyBTYWx0ZWRfX4nPj5gW0kEF+
 vCb2BHfF76WYbKHg3/vNy9sOJFXvZ9VdZWhpUnbkqodAxE+sjp3sd4i8mgoZneSav+Joi6s1iwy
 Ak27ARLhRAqrxdY9V2O695x6pWgOojW8J/jsP3IV0OnxBZw5Htsgbk32vTHKzpMO+ykhuNe1CZN
 pmFXpklqBwL6xJdI8Xpkl2rGgzVV5rOtFl8HI6cplKtiSyJZ0ONnbMg/e2VYl1pcezv7pxGlhmw
 gcP4IOndM6pqovF37zKp+2RmMh3ez0hsLyNp4yqf5yIj18/xf1yIYirToSAGbYQbyI/oBnoK4Kv
 W4QY/0c/8rfxsPYgliOgE5RQC/sUVaaS/OvuVcl/6zM5WOLj0M3BEXg3ah+xOexllpdmpKH7gU9
 7g/nTsSi+vnjNT77IMq9v9/wPAlW8G0LT9t1KIEGZqIreX6sCpn/vBtMF9B6nTtRc4L/dYr8
X-Proofpoint-GUID: d9cc-zFg5-BPv5XCXtiEDZItxvo1vlcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160123



On 4/25/2025 9:27 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 13, 2025 at 05:10:09PM +0530, Krishna Chaitanya Chundru wrote:
>> If the driver wants to move to higher data rate/speed than the current data
>> rate then the controller driver may need to change certain votes so that
>> link may come up at requested data rate/speed like QCOM PCIe controllers
>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>> link retraining is done controller drivers needs to adjust their votes
>> based on the final data rate.
>>
>> Some controllers also may need to update their bandwidth voting like
>> ICC bw votings etc.
>>
>> So, add pre_scale_bus_bw() & post_scale_bus_bw() op to call before & after
>> the link re-train. There is no explicit locking mechanisms as these are
>> called by a single client endpoint driver.
>>
>> In case of PCIe switch, if there is a request to change target speed for a
>> downstream port then no need to call these function ops as these are
>> outside the scope of the controller drivers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
>>   include/linux/pci.h       | 13 +++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index 0a5e7efbce2c..b1d660359553 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -161,6 +161,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>>   int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   			  bool use_lt)
>>   {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
>> +	bool is_rootport = pci_is_root_bus(port->bus);
> 
> s/rootport/rootbus
> 
>>   	struct pci_bus *bus = port->subordinate;
>>   	u16 target_speed;
>>   	int ret;
>> @@ -173,6 +175,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   
>>   	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>>   
>> +	/*
>> +	 * The controller driver may need to be scaled for targeted speed
> 
> s/controller/host bridge
> 
>> +	 * otherwise link might not come up at requested speed.
>> +	 */
>> +	if (is_rootport && host->ops->pre_scale_bus_bw) {
>> +		ret = host->ops->pre_scale_bus_bw(host->bus, target_speed);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
>>   		struct pcie_bwctrl_data *data = port->link_bwctrl;
>>   
>> @@ -197,6 +209,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   	    !list_empty(&bus->devices))
>>   		ret = -EAGAIN;
>>   
>> +	if (is_rootport && host->ops->post_scale_bus_bw)
>> +		host->ops->post_scale_bus_bw(host->bus, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
>> +
>>   	return ret;
>>   }
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 47b31ad724fa..9ae199c1e698 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -804,6 +804,19 @@ struct pci_ops {
>>   	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>>   	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>>   	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
>> +	/*
>> +	 * Callback to the drivers to update ICC bw votes, clock frequencies etc for
> 
> s/drivers/host bridge drivers/
> 
>> +	 * the link re-train to come up in targeted speed. These are called by a single
>> +	 * client endpoint driver, so there is no need for explicit locking mechanisms.
> 
> You need to mention that these ops are meant to be called by devices attached
> to the root port.
> 
Ack.

As these are bridge driver specific ops, it feels to me we need to add
these in the host bridge driver similar to recently added one
reset_slot, I will move it in the next series.

- Krishna Chaitanya.
> - Mani
> 

