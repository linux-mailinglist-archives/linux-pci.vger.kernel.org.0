Return-Path: <linux-pci+bounces-25038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE7A77515
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B1E1690B1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989311E98FA;
	Tue,  1 Apr 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6zsxb8a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E61E47A6
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491845; cv=none; b=aD/2J51L5fJYFOHEtynyKjVP5O67igP6TjqH1Ku5z0FOzk6qHIoJyknQ5Q7147Whil8WFUkqo46obgMcbK3HvMDX52RQuQcAasLu6yYwus4EjXklr8InfWZnQsplN+PKiywHgVvbAs/SJzz3L8uHcFG8+/CBn10fgZTh5Q6hzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491845; c=relaxed/simple;
	bh=K94tqSCdI38kDfHqpKSLdrbnPJqSiDjqX6KGxtHaBus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHPkwD24oNpaHdWQ/4qyJ3peSPYfbcsmzpVxuQRDTyswtExPyAeLLFjtxY7arDFh4oJvB961tGOj6rMd4mx90CFeiuN34zzY8fwM1/STg+cAKT2aHzJVtu5pQLWiTOCBzFddi5ZLnb9xTDSUvHf0sHVu3N6DmCKRsp5l8R1+Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6zsxb8a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VKGZFa008473
	for <linux-pci@vger.kernel.org>; Tue, 1 Apr 2025 07:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FtMGRVk1ZbNEw+POJb8t9Wm2iW3twKtu3+p8pqREbTY=; b=S6zsxb8ac9snJQ4a
	pTSJ9wyVBp8SZhPsTxzorNsUhzlFYMn469v5G22Mk820Coizt/sgGtlsRE90TJPA
	TiKcJldUyDfAqZ65mWrqsRetWJ0ndGKR9F5RHz9RxP2M3GeuqaDKGOVvau+xjydb
	81Vuv1k9Le+O3hWNx4OaeEN/gb6aAX6TAP/2vMKxb8W24KWlfteo+vj/JIprg4lk
	gtXGX9fZTwdu9K0OUHOrYdK8zDqBw5S98yioEQ9Khz9fUMFDG+wnm/BrhNRgvG9V
	aPt/kQq1xw960uFCenOVOfxafW+c8CdTKRiSRm5Ic9fYa3sdOuGnVcPcySUiQlky
	ycSSxw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnhbqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 07:17:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so8782941a91.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 00:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743491841; x=1744096641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtMGRVk1ZbNEw+POJb8t9Wm2iW3twKtu3+p8pqREbTY=;
        b=LcASXWmrQcdULW70q6qYzXhPAuYYXHNRX1MMD2WXO07XZ/Vusbrh76THV28bjUS3hN
         5y5XCM4/NMq+pZX1vVM/mPnqqyjHo1MJlhAODhSYGqVNyQakDVBDh92ItYMgFwD8HSKV
         9jx5yM0xUnBWAWkxFHdjQAADYdxDawSQxnobt18c4WNgj6IMzq4bZsycMJdopJAuZ8xa
         gW/zDIojaq4HuGZPuY3U/eXw+9CYb5493tS+jSzmjFLqNjy8RO4m0uSS+5SEoyB4Vt6O
         FdknIcP7BER4P0wSh0DnUgyudWyJoj2E5y6eP5XLEYZ3gu7oHbPE7dKbHd9CoX331vNO
         +Biw==
X-Forwarded-Encrypted: i=1; AJvYcCV+7Ghh18A1ZvpvbLT8M4c7U6ptMZGgXaMVk3mZx7YliibwhKpbSqXmeXNhoxmVDstny2JCU6NxiJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOVEyN3pXFx9eOncvyP3MiBDCd6JwDsFsPXfUdeYapIjIssNA
	N3QlSNhtn7aK4E+JVrSzxediwLqCBL8460lX63LXtTtrkjUVaPUHpW1xJqfkjoVSpqH0K8UN9xB
	IrrC12lMvLKuZEKggb7vtCxRxzSkhuvEy24sfJwyjpiQbt3D1orGUcIpv/rE=
X-Gm-Gg: ASbGncvRA8ohtTBZq22KBTVG/ucMB9nOKjoZZna9GTPuhXwi4SGJzF/IiGUe3lGu8eU
	hjHNC3RrPQEwzD2kiFM640OMZ7wKDYOyYdm5FR3GxNBveUccydDM225IKw3vuneNa9tZtFbqn5o
	sKWFd5ZbzX0lqIHIzkkd/0zzGxCMuy0hmv0j71Ih4XufZeB7n4lYWVag9DGl89XZ95Gt1yalSlQ
	7/FKefLPPGloaktKqeVjorzz4kyHPxv8HMqUAaVnE6vZVcBB18RTFR7hOQlLVK0oPZ8ncVw9Fim
	tArQPsy0lRnkSZJFQmCNGVumaQYXHAIgtR5z45AEq70Ijw==
X-Received: by 2002:a17:90b:134d:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-305320ae2eamr18234706a91.15.1743491841325;
        Tue, 01 Apr 2025 00:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr4gOlMNdHJzyZphobs28BNbuI4vi69zmTSjUxMF19Ghg9xXQwTQ1pg7rC685uTI4i0vHJiA==
X-Received: by 2002:a17:90b:134d:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-305320ae2eamr18234674a91.15.1743491840854;
        Tue, 01 Apr 2025 00:17:20 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecb62sm81122505ad.230.2025.04.01.00.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 00:17:20 -0700 (PDT)
Message-ID: <95db82e9-8527-0520-07db-672e64b6e25b@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 12:47:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] PCI: Add support for PCIe wake interrupt
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com>
 <20250401-wake_irq_support-v1-2-d2e22f4a0efd@oss.qualcomm.com>
 <Z-uPOLNPIgm63PWY@wunner.de>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <Z-uPOLNPIgm63PWY@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2WJE-cHznx6uFqF2NdLzvhi1Mb1fOeNY
X-Proofpoint-ORIG-GUID: 2WJE-cHznx6uFqF2NdLzvhi1Mb1fOeNY
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eb9302 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=i3ooZJLN8YTFS9vXi5sA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=742 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010048



On 4/1/2025 12:31 PM, Lukas Wunner wrote:
> On Tue, Apr 01, 2025 at 10:12:44AM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe wake interrupt is needed for bringing back PCIe device state
>> from D3cold to D0.
>>
>> Implement new functions, of_pci_setup_wake_irq() and
>> of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
>> using the Device Tree.
>>
>>  From the port bus driver call these functions to enable wake support
>> for bridges.
> [...]
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -695,6 +695,10 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>>   	if (type == PCI_EXP_TYPE_RC_EC)
>>   		pcie_link_rcec(dev);
>>   
>> +	status = of_pci_setup_wake_irq(dev);
>> +	if (status)
>> +		return status;
>> +
>>   	status = pcie_port_device_register(dev);
>>   	if (status)
>>   		return status;
>> @@ -728,6 +732,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>   		pm_runtime_dont_use_autosuspend(&dev->dev);
>>   	}
>>   
>> +	of_pci_teardown_wake_irq(dev);
>> +
>>   	pcie_port_device_remove(dev);
>>   
>>   	pci_disable_device(dev);
> 
> Why doesn't the teardown order mirror the probe order, i.e. why is
> of_pci_teardown_wake_irq() called *before* pcie_port_device_remove()
> instead of after?
> 
ack, in the next patch I will move teardown after
pcie_port_device_remove()
> (pcie_port_device_remove() is the opposite of pcie_port_device_register().)
> 
> Also, why is it safe to bail out of probe on failure of
> of_pci_setup_wake_irq() without unwinding whatever pcie_link_rcec()
> has done?  I think this needs either an explanation or reordering.
> 
if there is a failure in port_device_register also we are not unwinding
so I taught it is already taken care. Looks like it is not.

In the next patch I will move of_pci_setup_wake_irq() above 
pcie_link_rcec() to avoid all this.

- Krishna Chaitanya.

> Thanks,
> 
> Lukas

