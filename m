Return-Path: <linux-pci+bounces-21822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B311A3C6D3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF462189C349
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CD192580;
	Wed, 19 Feb 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1SRxA3G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70E1F61C
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987856; cv=none; b=fnMnlXiq07d31wGx8GFwMGGIgyxZPJ14L6U4Q4oHC90O617UN4uWXywP6TlFjNB5562GECPGqas8n1F3g6a1djxId2bENqlqPkuQAV8UkNsluC6735ejFLZJWoEfUi+lOubjV2gZyV+xpjJvNQL36mUkbiUbJaszOK4WdTWx1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987856; c=relaxed/simple;
	bh=6sc5vtDBVt0WGcXf2/2k+XKp2TfrekaRkNGeNs+uqtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWSuKTv7cEg8nDszyNk4sNh100Pd3xY7JyUutVFF9w+s+TaO9j6PmLSAzV8oULL8Kj5mBv0SqVxnriSJ6z0qHKBRio7dBAHlSn51GD3xeYe5QSG3ru6qoD4qqmdYKno78btDhQO1/gMdxOyPImSzkbaQ4Ddha7/1Gm8l7Vm/IYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1SRxA3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHKFsn016821
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78pq2Tqo6aDU3KcPcf25D+KEq6BDiVBvwf3/VKY2io8=; b=N1SRxA3GvUcj7Xqp
	Zct5UGrRdxIZr9OJ9HrX5AKk53IOsaWHvFVVw5Tg9VrG1vtsKTaxAOZUv5earOHM
	d6NdHHFhu/Jbziz6+Y9V4N/57y9LmqzAO4FzrKuhQgK2MoywQnTIFwShoNXHsezO
	VRuxp7NSfJuwoMra45Y8uLkdEujGC4sDn9QUaifPGpZ11bCDw7xAzCY0Q69gSGyQ
	e3dt8DMBdeJT86l85rFDHJCMqls/PyyLL1TWvunPOFDEdGJJ0CzPpgBDE2nhNNZR
	RS2NM1HSULo1/BuDb5WIoHEAIb+7MWH4yUOgqiiLL0aPltuuuSH6tHXZIiUMlX8l
	OBTm0Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0bg12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:57:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22119b07d52so59729575ad.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 09:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987852; x=1740592652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78pq2Tqo6aDU3KcPcf25D+KEq6BDiVBvwf3/VKY2io8=;
        b=pAaC0m0B7QXsKULbuf+skMM3PcQ9wC28IDQhpe23AX/NzoPCPJ6m8cYq2iWs8ZwT+y
         nJZ7eZIi7MAy0xO4RoScaj7wzCeV9FRRsqje+pfC1Zd+jfMEowLSjeZuGXQr/YIj1p/+
         I3suxyQO0FVN92qujsH5lj0luQRSJVzrRS6puc5EqJneiugr50DzgqTBob1dsz35A+Tj
         o0OzFiaUHaOm35meBv8wzzy5KeyPE5SdW9NQrHOJ3kVSLFBq1QZfxvi347YGAiC9okSP
         4CLbJ0Cf8FfGfzQT5NahXAL4bDeMr6/Sg/whfAFX1gS0wY41+c1V312UPerm8T/5IIh6
         9IRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbmkjYPDbv5DBryMXTx+XWkBOnwhjyWrbpMIUFi5XqsUQuO7zm1fSbQ1VEEEneioZusu15bpBFk58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIeuOXtgq9jm3pXmGfEVJR0K1cSTtdva14W9/BvBVIfxer+q9
	4mYWd66yR6BqWh99pp34sf93MetHBO+kIXZDz4TyZ4kUIuyz35EBCdEnMjCreNPSRNPiGLXxoBz
	To3CwSB0sc+RHnXCDJVsHWPgKCXOpMnDAqr0NsPOwEZTj5ude5JVjsB5G75I=
X-Gm-Gg: ASbGnctKP7dGfzXV3+Sz5tdyjpgDgUDEHtYQbkSfHHn9UrsO+a7NeKX99XKEgIAwYff
	QAWSHKWOaOh9JBz839ZcJkg4+fq5mg/aKZap/8LG7eSilFDIYhEDW8yok0MZeRb2+KQh7C8MVlF
	dgeTRQA27PxIQ2k4RFzD1zW2cicQxDcdWsRtzBKtTetl7teHa+bwFxcKbn/Qvl66CqeXZ5FImoj
	WRp5BXe7/Z/jeTieIo/OQZH+OsUfkncpEDR+eTyb7k0cy0FnByHz+RtI50bMncWt7Skczk4JE1A
	Jrcnr5R2itrHxplHZiLIvQPSuJegrV6R9fY=
X-Received: by 2002:a05:6a20:6a24:b0:1ee:dcd3:80eb with SMTP id adf61e73a8af0-1eedcd382c1mr3404937637.22.1739987852598;
        Wed, 19 Feb 2025 09:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR5P32nd4JPmJkWHQBBmcstlZrG31rBUniS5q+4t2AdRvM+sL+oJVFS4OznQBsMO+V9ZWjlQ==
X-Received: by 2002:a05:6a20:6a24:b0:1ee:dcd3:80eb with SMTP id adf61e73a8af0-1eedcd382c1mr3404894637.22.1739987852215;
        Wed, 19 Feb 2025 09:57:32 -0800 (PST)
Received: from [192.168.29.92] ([49.43.231.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425467b9sm12233766b3a.30.2025.02.19.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:57:31 -0800 (PST)
Message-ID: <915795ea-3e75-fc55-4c37-a05a6570fbbf@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 23:27:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] PCI/bwctrl: Add support to scale bandwidth before &
 after link re-training
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_jjohnson@quicinc.com,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
 <20250217-mhi_bw_up-v1-2-9bad1e42bdb1@oss.qualcomm.com>
 <f58ff91f-95a1-1a0d-91e9-972f0eeddd4c@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <f58ff91f-95a1-1a0d-91e9-972f0eeddd4c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X1asA38o--yJuJhbU49b-ToNQTyLVtI1
X-Proofpoint-ORIG-GUID: X1asA38o--yJuJhbU49b-ToNQTyLVtI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190139



On 2/17/2025 2:58 PM, Ilpo Järvinen wrote:
> On Mon, 17 Feb 2025, Krishna Chaitanya Chundru wrote:
> 
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
>> the link re-train.
>>
>> In case of PCIe switch, if there is a request to change target speed for a
>> downstream port then no need to call these function ops as these are
>> outside the scope of the controller drivers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
>>   include/linux/pci.h       |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index 0a5e7efbce2c..e3faa4d1f935 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -161,6 +161,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>>   int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   			  bool use_lt)
>>   {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
>> +	bool is_root = pci_is_root_bus(port->bus);
> 
> is_rootport ?
> 
ack.
>>   	struct pci_bus *bus = port->subordinate;
>>   	u16 target_speed;
>>   	int ret;
>> @@ -173,6 +175,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   
>>   	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>>   
>> +	/*
>> +	 * The controller driver may need to be scaled for targeted speed
>> +	 * otherwise link might not come up at requested speed.
>> +	 */
>> +	if (is_root && host->ops->pre_scale_bus_bw) {
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
>> +	if (is_root && host->ops->post_scale_bus_bw)
>> +		host->ops->post_scale_bus_bw(host->bus, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
> 
> Is the naming of these callbacks too specific for your use case? Does PCIe
> spec actually call changing the Target Speed "scaling bus bandwidth" or
> something along those line?
> 
it is not the PCIe spec, I named based on current driver only. If there
is better name I can modify it.
>>   	return ret;
>>   }
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 47b31ad724fa..58f1de626c37 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -804,6 +804,8 @@ struct pci_ops {
>>   	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>>   	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>>   	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
>> +	int (*pre_scale_bus_bw)(struct pci_bus *bus, int target_speed);
>> +	void (*post_scale_bus_bw)(struct pci_bus *bus, int current_speed);
> 
> Please document these, including the locking requirements.
ack.

- Krishna Chaitanya.
> 

