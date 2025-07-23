Return-Path: <linux-pci+bounces-32788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E95B0F0A6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9AD1C83FC3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145B16F06B;
	Wed, 23 Jul 2025 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I6MV5ZZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16F277CB8;
	Wed, 23 Jul 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268448; cv=none; b=u3Gey8itXxzYw0SELucJ7TA9Sjh8HZtI3exKMJFt/2kGgTbe6WJZ6L5sEMjQdZJKtgCjvRVLBWfy582CNSlR03TiAV/Oovm6g3TuL/TERypYcewNBVvzeV88V3HLZck+isWP9ra8/aw76ilUQ8xNM4x9Q3nSFd+84LkpU7vaB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268448; c=relaxed/simple;
	bh=XFKlGoRDNIP9xHezYy6FedqnnzH7yQlAfi74H36rk5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnn18QloQtb+9ReJ8MHr3PeT86vZx1kVh2NX/NcbwJCs8cqOkoclawEsWHi3CWK7/PCzJ9aoaoKz5EVkt1ZardvLdfusq865Si7bvi/HFnVtZQxEkO0P1j8efeWcx4Brl4uv78UFQwI2acEp8pq6W7pfF8URjR0Gn9JY0qXZGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I6MV5ZZv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9e34g028685;
	Wed, 23 Jul 2025 11:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rXyY98
	gBFsKNIUwm61q4RC5iDzASeVtBCRo/LxrSEvc=; b=I6MV5ZZv9n9cYCf8R+K924
	A7bq/OnQu7Th26ym7jCug8MQcHa771Ps3g3FoDqyvhZGZhGDglSp8/l0sTgzRJmk
	s/KAR3Bah2eyB03U9fS2RhWwM3R7Oa5sMN+r6lJuZ4d6mhah+US5j2Ac5wWZp1qt
	YjATeZ3Y1T34ktuGv/f7qMO6JGTI4HRT5hYbvH5zi671fe2g0k/84Bq9W9WisVAM
	rw0DSGMgb9oXoM1DtyBXJ+ZE/PzC1z0TRefMbghV69ORHTbd9JvZV2GJXDaeqFUa
	VeyP24ow73n/mfYkwcv2BakCfIYAPEUkbUQlmEwxvOhwk5ONFzCMNxcCbl3N6aVw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyk0r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:00:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56NB0LTb005675;
	Wed, 23 Jul 2025 11:00:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyk0qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:00:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N86YaI004133;
	Wed, 23 Jul 2025 11:00:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fxn7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:00:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NB0NSC21365436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 11:00:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BAC58060;
	Wed, 23 Jul 2025 11:00:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FFA658063;
	Wed, 23 Jul 2025 11:00:19 +0000 (GMT)
Received: from [9.204.206.224] (unknown [9.204.206.224])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 11:00:19 +0000 (GMT)
Message-ID: <97289b39-ca4b-47ac-af81-c5223932ff63@linux.ibm.com>
Date: Wed, 23 Jul 2025 16:30:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] PowerNV PCIe Hotplug Driver Fixes
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        christophe leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20250722204704.GA2815491@bhelgaas>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250722204704.GA2815491@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Nm6biQkwCC6kDwcAJfurgg3QHzgi2LN
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6880c0c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=1pD9pYlTiUhiYWAN9AsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wh94iUv_xNberR8-A23dJ-8HaY003zBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MCBTYWx0ZWRfX+FSqIcfZ5YmY
 K8vjJImsB2oiS+he4B+1JzHzyhSpRQ6FxkySAjN3uS9PnVyVDPvA5m8ZK6qJrZmfifPINNQyqTd
 3xnKwrGcCTEPjCgpatpm7w86UniY+QbuWFYNixHIARf61rCz+DPEYIXYgD5Rg5VfbOOu1GKOLuB
 zxexJMpOORGwkxBUndvan/F9S3BqvPcckbCs1Elc7beI5Fro4xVTAE0xTL/mWz38qvMU4rzjgc9
 2WHwwy1XmY6CEyrsEyruazDROq0/g8MCrAqTpcVOEXaxps6QNGwdlDSQ+oZxDvbqa2S60owJy/X
 bPFUv5iSWs0pywB3ceZ0EPbokt687c1htlDU7o3rODz1H4AOeGygpEb2W1RH20xShCQ80EuadjF
 GgT1Z69X1zsSexugWL/Rnpf0V9BYl4CdfHpqD/3IGZgFmCAw2bCnAO90OJHco4d9GgZasYuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230090



On 7/23/25 2:17 AM, Bjorn Helgaas wrote:
> [-> to: Madhavan, Michael, Mahesh; seeking acks]
> 
> On Thu, Jul 17, 2025 at 06:27:52PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jul 15, 2025 at 04:31:49PM -0500, Timothy Pearson wrote:
>>> Hello all,
>>>
>>> This series includes several fixes for bugs in the PowerNV PCIe hotplug
>>> driver that were discovered in testing with a Microsemi Switchtec PM8533
>>> PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
>>> PCIe switches that don't correctly implement slot presence detection
>>> such as the aforementioned one. Without the workaround, the switch works
>>> and downstream devices can be hot-unplugged, but the devices never come
>>> back online after being plugged in again until the system is rebooted.
>>> Other hotplug drivers (like pciehp_hpc) use a similar workaround.
>>>
>>> Also included are fixes for the EEH driver to make it hotplug safe,
>>> and a small patch to enable all three attention indicator states per
>>> the PCIe specification.
>>>
>>> Thanks,
>>>
>>> Shawn Anastasio (2):
>>>   PCI: pnv_php: Properly clean up allocated IRQs on unplug
>>>   PCI: pnv_php: Work around switches with broken presence detection
>>>
>>> Timothy Pearson (4):
>>>   powerpc/eeh: Export eeh_unfreeze_pe()
>>>   powerpc/eeh: Make EEH driver device hotplug safe
>>>   PCI: pnv_php: Fix surprise plug detection and recovery
>>>   PCI: pnv_php: Enable third attention indicator state
>>>
>>>  arch/powerpc/kernel/eeh.c         |   1 +
>>>  arch/powerpc/kernel/eeh_driver.c  |  48 ++++--
>>>  arch/powerpc/kernel/eeh_pe.c      |  10 +-
>>>  arch/powerpc/kernel/pci-hotplug.c |   3 +
>>>  drivers/pci/hotplug/pnv_php.c     | 244 +++++++++++++++++++++++++++---
>>>  5 files changed, 263 insertions(+), 43 deletions(-)
>>
>> I'm OK with this from a PCI perspective, and I optimistically put it
>> on pci/hotplug.
>>
>> I'm happy to merge via the PCI tree, but would need acks from the
>> powerpc folks for the arch/powerpc parts.
>>
>> Alternatively it could be merged via powerpc with my ack on the
>> drivers/pci patches:
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> If you do merge via powerpc, I made some comment formatting and commit
>> log tweaks that I would like reflected in the drivers/pci part.  These
>> are on
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=hotplug
> 
> Powerpc folks: let me know how you want to handle this.  I haven't
> included it in pci/next yet because I don't have acks for the
> arch/powerpc parts.
> 

Patchset looks fine to be. 

I am fine to take it via my tree since I already have your Acked-by.

Maddy


> Bjorn
> 


