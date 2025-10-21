Return-Path: <linux-pci+bounces-38944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD649BF8B99
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F76D3AF278
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BC20468E;
	Tue, 21 Oct 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Me/IKRPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1F350A3C;
	Tue, 21 Oct 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078872; cv=none; b=E2UPRGC677bUJjhm1lyZ4kYChrFtbhRODykyqbkzr1MfVeq657qQ45ZJAbqiKiHhhOKk+6ZPXXeiEhrgrxv2XefU50HWN3/87/AlsRHdJ0lqlt+Pr1DGMWi7IIRKT9zo4uXys8dMQjB67gDM5kHCBdq94d8wYHlmNqfTeUtEBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078872; c=relaxed/simple;
	bh=MmyGVz514tYF4CV16vMrOST0EOpGoH8FznP6p3BreJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3y5rKKeWxy+dtacI4vy1Fo1B2m1sgb8DRpDq0RCM5pYH2vICGKiaq0kapZa+blLrvUtZwy97UXEj+spyGT75K1CtykdUrSX+WMkKhjwsoSYh0ngxf7MmU/ytooA85ipMKlPEFl2OvnZKGD1y7BN54Q52p67XC4D6byNqhMzR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Me/IKRPF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LJcdJd016484;
	Tue, 21 Oct 2025 20:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YBqJ9h
	NCe/TNzh8IBcphbZ08wR6W/jXosPlBKB2QCtU=; b=Me/IKRPFImZE2XW65m8a3A
	Rx8NlcR+7R7Tlo41GfLKJw/g4LW0Y4AQwkMYMOMJzxYhcge8RgDgrPhjEHIyyVe2
	A0cDx4vK5/96RNkw7SrSbDx7rJVI7qW8CRYBn81UOai4KL85GcpD+XphSPlmPBwT
	TnUIaMvut8fdnHq/NH/PSq2ewqkHdxBj/lEtKxJgnMuoo2XsJeKJQ19bhWNg3NdH
	UUAhTGuFtBMb1rT8mhsp1WTwX13+7ofXDzWauqZEJ+zbwUzed8Y67VKiwOtV7YkK
	hCTX6lUalptw2f5F7H7dQ60nIZu+GfJ/ow1dZMhNv+Zqxw48E7e7M0+b1+xMH/xA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s17n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:34:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LIr1d6032099;
	Tue, 21 Oct 2025 20:34:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mvqjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 20:34:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LKYQtD32047760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 20:34:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2F4758043;
	Tue, 21 Oct 2025 20:34:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C575805D;
	Tue, 21 Oct 2025 20:34:25 +0000 (GMT)
Received: from [9.61.241.19] (unknown [9.61.241.19])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 20:34:25 +0000 (GMT)
Message-ID: <bd54ee4b-8349-4447-9cbb-484439df2473@linux.ibm.com>
Date: Tue, 21 Oct 2025 13:34:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] s390/pci: Restore IRQ unconditionally for the zPCI
 device
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, schnelle@linux.ibm.com
References: <20251020190200.1365-1-alifm@linux.ibm.com>
 <20251020190200.1365-4-alifm@linux.ibm.com>
 <0170a16a-aadd-450f-be9a-9b60dfd5c8e7@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <0170a16a-aadd-450f-be9a-9b60dfd5c8e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9C5iDtqoMPTxK4BkehnyndoAc1uGLBzL
X-Proofpoint-GUID: 9C5iDtqoMPTxK4BkehnyndoAc1uGLBzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+izsYzK45nLf
 EqxKialKvFX3L92UzYcFwkARRtLPBVtkauwbfHO1PUbzVYJ5o6uYxqtR42pn46AAn6xhjxyR81Q
 zmBbske0eKSVvefmmivLfZr0mYBpLmxE5oTm+z0kPQLTDsc6lSKfxljQSD2RGHVLuBqXAHdx7qx
 PGnM/UGa053g7IPGQaVzPw+fuAbub7+WfU9SgWiDGBQaLwsfUAH0DhVm4bwohJ5eEH9BqcvOWsb
 t1WIzy7izKr1N3ZBHOyqPkyN1SkkmEY5OwxVQ/MajVWlpMKeCHXPzhzLJaantpn19ljBfEGr60E
 cIDCkSptKuiMiOQ12VFMO3ZGBSN0Mc0Tct8jjeJhTU1E1dQ7Z5CDKijZK2e3lhaiyd6ZVvDub9v
 FGNn98YzZs0SudneCFPY40YGGG2SQg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7ee54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=OYQa30pwPum5nJitelwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 10/21/2025 7:07 AM, Matthew Rosato wrote:
> On 10/20/25 3:02 PM, Farhan Ali wrote:
>> Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
>> introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
>> resetting a zPCI device.
>>
>> Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug slot"),
>> mentions zpci_clear_irq() being called in the path for zpci_hot_reset_device().
>> But that is not the case anymore and these functions are not called
>> outside of this file. Instead zpci_hot_reset_device() relies on
>> zpci_disable_device() also clearing the IRQs, but misses to reset the
>> zdev->irqs_registered flag.
>>
>> However after a CLP disable/enable reset, the device's IRQ are
>> unregistered, but the flag zdev->irq_registered does not get cleared. It
>> creates an inconsistent state and so arch_restore_msi_irqs() doesn't
>> correctly restore the device's IRQ. This becomes a problem when a PCI
>> driver tries to restore the state of the device through
>> pci_restore_state(). Restore IRQ unconditionally for the device and remove
>> the irq_registered flag as its redundant.
>>
>> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
> But one question: Unlike the other 2 patches in this series, this only touches s390 code.  It doesn't depend on the other 2 patches in this series, right?
>
> If not then shouldn't this one go thru s390 rather than PCI subsystem?  Note: none of the s390 arch maintainers are on CC.

Yes I think this could go through s390 tree as it just changes s390/pci 
code. Will submit this as a separate patch from this series.

Thanks

Farhan

>
>> ---
>>   arch/s390/include/asm/pci.h | 1 -
>>   arch/s390/pci/pci_irq.c     | 9 +--------
>>   2 files changed, 1 insertion(+), 9 deletions(-)
>>

