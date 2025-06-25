Return-Path: <linux-pci+bounces-30570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCFAE75B5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE837A2F83
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 04:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821101DDC1E;
	Wed, 25 Jun 2025 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cw7YY4IY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABECA6B;
	Wed, 25 Jun 2025 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824532; cv=none; b=pHHz0jlf7ZIvItQxoiqLe0IX22uYmeRih9svNPzK100IKpUZ6A2pWvH2PO7hropG135G0Rd+P0UI5uVh8Ntm3SVta2Bp/MsnN15GVsCwnM9a+AygX2NSl5R60hl6fcFKNyLzk1epFXukp4dBK2nUVmUvk3IqjdB9000bSOqCuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824532; c=relaxed/simple;
	bh=0quii99h3f+9e5zkIYBdYDpxwMgwkdCMaxiVUd9Jbes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5pP20LGfEcm8jSUSrihm33WY4HEPvW81qJKPsmmj4QzSMMnJx+W4h2IbfQb1E/xRVU+PqtReLLAZurkdsTjKGdSS7erhOgC71n0GI/lBlGKjmLSATzPcfJ17lIgU1TPD3yNhnWGtgr+hRpbby2vwThYG7xjqY4SjT3QaUjsTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cw7YY4IY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2mSEV005257;
	Wed, 25 Jun 2025 04:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CTC5bb
	5TRggTUyWAwklA6qEcbcOVDN+cMCMh2nDGpgY=; b=Cw7YY4IYEy3sHVvHkAzitL
	bbA+P7N26cdosX0tSrF78Ftjlw7MOqTEa+f9SVM0ChAHLR3SDdqG5BWeply9ex1z
	AzGNvo2a9lBoN0QacAfXcxCglBQ4HkZHg8GvB+M9LbdmXU4vN7yYMXo3UWDMxgGN
	bBHVAHD0rknZt8p/y3QWD33cxteSHUDSUdwYBo8LhDQZ/YFwwh5aA62D6Ot/5fiB
	js01pj4nBs4KLi1I5zsOnWiuHfhdh06uqpTunCsoqw7vjA4TZWqWF5weo0mMaEbz
	TdIbBVaKdzoQbPFaiSVaHb8qvXGANjr/JVBtU670urRdaEjU644+DcHhqALvJhYw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63vm4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:08:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55P48QiD025346;
	Wed, 25 Jun 2025 04:08:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63vm4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:08:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P11bE5030546;
	Wed, 25 Jun 2025 04:08:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyyhdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:08:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55P48NxJ44761594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:08:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EC62004E;
	Wed, 25 Jun 2025 04:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2363620040;
	Wed, 25 Jun 2025 04:08:21 +0000 (GMT)
Received: from [9.124.208.33] (unknown [9.124.208.33])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 04:08:20 +0000 (GMT)
Message-ID: <f13a2d2b-af52-4934-b4fa-66bc1e5ece32@linux.ibm.com>
Date: Wed, 25 Jun 2025 09:38:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
To: Lukas Wunner <lukas@wunner.de>
Cc: linuxppc-dev@lists.ozlabs.org,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "\"linux-pci\"," <linux-pci@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        "\"Bjorn Helgaas\"," <bhelgaas@google.com>
References: <20250618190146.GA1213349@bhelgaas>
 <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>
 <19689b53-ac23-4b48-97c7-b26f360a7b75@linux.ibm.com>
 <aFaCfYre9N52ARWH@wunner.de>
Content-Language: en-US
From: Krishna Kumar <krishnak@linux.ibm.com>
In-Reply-To: <aFaCfYre9N52ARWH@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAyNyBTYWx0ZWRfX4BuxgLEhfKSC mtymIFPSF+Jk7lUj56DlzBR5da9PZuRu8IzWCKKWKBBq7FZbCvKN+MutADFuZ3nEY8WGUbsiQFz rLybvTIM+nKf12Vc54KGizMO/gRPwTiw9GG2pUBzTrajrtFHpUl47+mnripckEy4VQaRJcx+47Y
 rBlrgJtYfgRzxne5qrv1VPxAipFZmK9+7cP5xV+fM+wMe2yVwyJkkZrN1NqK+dhQLjGsDxa4Gh3 fsuiZP5IZP+zUND4NzLUH5P8Tq41umwxlsNjow/4tmE4M41ErVsx7SUdyEkj92b2UFHRVzzXNLJ YoBKh02fbdGRtibMfpA0MRazmVz+xptaJkeXousTyHMmdgm/Xf0rEwbPdAvIa/SWzRxcmY7ybsl
 f8durvnkh14OMC1X2Fv6XzyexwllqJBxFckUJygukYOMDCjF6PEU2WeJSn+nxKSS9SQwfi+z
X-Proofpoint-ORIG-GUID: yiqUkf_PB65z0wXU9OmhBeOz5zRw8NBU
X-Proofpoint-GUID: kbw0Ib_9qGZWx1SP8ant6y5GWk5SXmjw
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685b763b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7sqxYtyxsES66T7-EJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250027


On 6/21/25 3:29 PM, Lukas Wunner wrote:
> On Fri, Jun 20, 2025 at 02:56:51PM +0530, Krishna Kumar wrote:
>> 5. If point 3 and 4 does not solve the problem, then only we should
>> move to pciehp.c. But AFAIK, PPC/Powernv is DT based while pciehp.c
>> may be only supporting acpi (I have to check it on this). We need to
>> provide PHB related information via DTB and maintain the related
>> topology information via dtb and then it can be doable.
> pciehp is not ACPI-specific.  The PCIe port service driver in
> drivers/pci/pcie/portdrv.c binds to any PCIe port, examines the
> port's capabilities (e.g. hotplug, AER, DPC, ...) and instantiates
> sub-devices to which pciehp and the other drivers such as aer bind.

Good to know and thanks for the info. As I already told I did not go through pciehp.c,

and its internal working (since I did not needed it) I can only comment in concrete manner 

once I am done with its code review and internal logic.

What my concern was, you can comment on below point if I am wrong (I will learn something) -

1. If we get PHB info from mmcfg via acpi table in x86 and create a root port from there with 

some address/entity and if this Acpi and associated entity is not present for PPC, then it can be a problem.

2. PPC is normally based on DTB entity and it identifies PHB and pcie devices from there. If this all the information 

is correctly map via portdrv.c then there is no problem and whatever you are telling is correct and it will work.

3. But if point 2 is not handled correctly we need to just aligned with port related data structure to make it work. 

Not a big deal but need to put thorough logic and testing effort. If its already in place, we are good.


>
> How do you prevent pciehp from driving hotplug on PowerNV anyway?
> Do you disable CONFIG_HOTPLUG_PCI_PCIE?

I am not sure if at present pciehp is used for Powenv, and PPC uses this config or it has disabled it (since we rely on pnvphp.c for our hotplug operation, I did not checked it). 

If its going to work on PPC by enabling config and its giving correct output, I dont see any reason to not using it as an 

alternate driver where pnvphp.c fails. But yeah, as I told I can commnet on this once I do some experiment (going through 

the code and some testing). But yeah, its always good to hear from you. Thanks a bunch !!

>
> Thanks,
>
> Lukas

Best regards,

Krishna


>

