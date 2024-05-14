Return-Path: <linux-pci+bounces-7455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9C8C55CA
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 14:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8399B1F22D75
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D92D60A;
	Tue, 14 May 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ej2hmhZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DA320F;
	Tue, 14 May 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688533; cv=none; b=bZQ6imw6P+dfldto3Ug7/lP6zUMelTNcfG7lwqU7ClaI7FCIAZ/8UlyQtqqanWUO6h8oGN4oHPQTFBNTlTAn1rckcJO8dDf4y0xRDUOnwCXzG2zz2uYMojy6D3wvBFkCtmeakAulqCYOjNKvto5MS1+S+sp8t1mQHRsepvZiR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688533; c=relaxed/simple;
	bh=VCEpHm3X2mGQsiTObD3pA+it8oca7WjVJw8ZFR5TALc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6t+uMQvdvDhVfVMt3rvhZNW27cYE3nd/ExrUuCM3DdxeWf8U3TSzKMt4JDIF8jFJsAm/To3vFGs2tx5y6/Oqof8xMSDNbujfdl1vGY/huMGEObkjV+pumj2+BLrJ9qf14XbtYeIkGonQQrW3K6TuXCZewY5PmPmwX+P3DE0BEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ej2hmhZv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EBpNwO007140;
	Tue, 14 May 2024 12:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S/jaGGRNl5KjdI3CpWmC0+vE/WR4/B/OKm0Gwa115tA=;
 b=Ej2hmhZvMRUUvXGiFR81o8ASHtZHlMHCpwPSEKvTFbi6KxxSH4PFtf0miDH9sF5Gv4kM
 404TFeB7GuHb3WAjF+iC/zpBHZDuHFUpM0gLQjIDp+6ezH/TYMWdbNBHkHwPbM+RouLe
 5/oxH+qGVS2DW9bKGXSKoEll/nORGf4ena0IzpO2Y/cKvEifez2B2voKb1bpBdM1lNYQ
 gZCu5peJStGrAMmbKsQjIZduc+rf/RTHYH9gfhFmxo+n1uTaXHf2a/2J8TxwiA7BAZh1
 9ZPxLvixLpXu1mtAkwc3q5CdIVBqL+IR/yrpMEU6YI0H6XnzT9lNhS3idTEdG2WeWpu5 mA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y44hrrg32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 12:08:39 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EC762V031147;
	Tue, 14 May 2024 12:08:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y44hrrg2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 12:08:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EBMt26020367;
	Tue, 14 May 2024 12:08:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcywd3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 12:08:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EC8Z2K6226484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 12:08:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B28058055;
	Tue, 14 May 2024 12:08:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C868058066;
	Tue, 14 May 2024 12:08:29 +0000 (GMT)
Received: from [9.171.90.14] (unknown [9.171.90.14])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 12:08:29 +0000 (GMT)
Message-ID: <1873d93c-4325-4fba-b11c-9ba740b22202@linux.ibm.com>
Date: Tue, 14 May 2024 17:38:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arch/powerpc: hotplug driver bridge support
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com
Cc: nathanl@linux.ibm.com, gbatra@linux.ibm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@kernel.org,
        brking@linux.vnet.ibm.com, tpearson@raptorengineering.com,
        oohall@gmail.com, bhelgaas@google.com, mahesh.salgaonkar@in.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20240509120644.653577-1-krishnak@linux.ibm.com>
 <20240509120644.653577-3-krishnak@linux.ibm.com>
 <581d163f-837d-401a-a50d-2305de6c8804@linux.ibm.com>
Content-Language: en-US
From: krishna kumar <krishnak@linux.ibm.com>
In-Reply-To: <581d163f-837d-401a-a50d-2305de6c8804@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vhmHzLAmOVfFAIzR32zkM5YUJRdSDrZi
X-Proofpoint-ORIG-GUID: tUVmFlBjathVarV2Rt8KfX6vNg2KFMfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140085

Thanks Sourabh for review. I have incorporated your comments and will be 
sending my patch soon.

Best Regards,

Krishna

On 5/13/24 15:15, Sourabh Jain wrote:
> Hello Krishna,
>
> Is "arch" in commit title really required?
>
> On 09/05/24 17:35, Krishna Kumar wrote:
>> There is an issue with the hotplug operation when it's done on the
>> bridge/switch slot. The bridge-port and devices behind the bridge, which
>> become offline by hot-unplug operation, don't get hot-plugged/enabled by
>> doing hot-plug operation on that slot. Only the first port of the bridge
>> gets enabled and the remaining port/devices remain unplugged. The hot
>> plug/unplug operation is done by the hotplug driver
>> (drivers/pci/hotplug/pnv_php.c).
>>
>> Root Cause Analysis: This behavior is due to missing code for the DPC
>> switch/bridge. The existing driver depends on pci_hp_add_devices()
>> function for device enablement. This function calls pci_scan_slot() on
>> only one device-node/port of the bridge, not on all the siblings'
>> device-node/port.
>>
>> The missing code needs to be added which will find all the sibling
>> device-nodes/bridge-ports and will run explicit pci_scan_slot() on
>> those.  A new function has been added for this purpose which gets
>> invoked from pci_hp_add_devices(). This new function
>> pci_traverse_sibling_nodes_and_scan_slot() gets all the sibling
>> bridge-ports by traversal and explicitly invokes pci_scan_slot on them.
>>
>>
>> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
>> ---
>>
>> Command for reproducing the issue :
>>
>> For hot unplug/disable - echo 0 > /sys/bus/pci/slots/C5/power
>> For hot plug/enable -    echo 1 > /sys/bus/pci/slots/C5/power
>>
>> where C5 is slot associated with bridge.
>>
>> Scenario/Tests:
>> Output of lspci -nn before test is given below. This snippet contains
>> devices used for testing on Powernv machine.
>>
>> 0004:02:00.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
>> 0004:02:01.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
>> 0004:02:02.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
>> 0004:02:03.0 PCI bridge [0604]: PMC-Sierra Inc. Device [11f8:4052]
>> 0004:08:00.0 Serial Attached SCSI controller [0107]:
>> Broadcom / LSI SAS3216 PCI-Express Fusion-MPT SAS-3 [1000:00c9] (rev 01)
>> 0004:09:00.0 Serial Attached SCSI controller [0107]:
>> Broadcom / LSI SAS3216 PCI-Express Fusion-MPT SAS-3 [1000:00c9] (rev 01)
>>
>> Output of lspci -tv before test is as follows:
>>
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>>   |                           | +-01.0-[08]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           | +-02.0-[09]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           |               \-03.0-[0a-0e]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>> C5(bridge) and C6(End Point) slot address are as below:
>> # cat /sys/bus/pci/slots/C5/address
>> 0004:02:00
>> # cat /sys/bus/pci/slots/C6/address
>> 0004:09:00
>>
>> Hot-unplug operation on slot associated with bridge:
>> # echo 0 > /sys/bus/pci/slots/C5/power
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>>  From the above lspci -tv output, it can be observed that hot unplug
>> operation has removed all the PMC-Sierra bridge ports like:
>> 00.0-[03-07], 01.0-[08], 02.0-[09], 03.0-[0a-0e] and the SAS devices
>> behind the bridge-port. Without the fix, when the hot plug operation is
>> done on the same slot, it adds only the first bridge port and doesn't
>> restore all the bridge-ports and devices that it unplugged earlier.
>> Below snippet shows this.
>>
>> Hot-plug operation on the bridge slot without the fix:
>> # echo 1 > /sys/bus/pci/slots/C5/power
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>> After the fix, it restores all the devices in the same manner how it
>> unplugged them earlier during the hot unplug operation. The below 
>> snippet
>> shows the same.
>> Hot-plug operation on bridge slot with the fix:
>> # echo 1 > /sys/bus/pci/slots/C5/power
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>>   |                           | +-01.0-[08]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           | +-02.0-[09]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           |               \-03.0-[0a-0e]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>> Removal of End point device behind bridge are also intact and behaving
>> correctly.
>> Hot-unplug operation on Endpoint device C6:
>> # echo 0 > /sys/bus/pci/slots/C6/power
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>>   |                           | +-01.0-[08]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           |               +-02.0-[09]--
>>   |                           |               \-03.0-[0a-0e]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>> Hot-plug operation on Endpoint device C6:
>> # echo 1 > /sys/bus/pci/slots/C6/power
>> # lspci -tv
>>   +-[0004:00]---00.0-[01-0e]--+-00.0-[02-0e]--+-00.0-[03-07]--
>>   |                           | +-01.0-[08]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           | +-02.0-[09]----00.0  Broadcom / LSI 
>> SAS3216 PCI-Express Fusion-MPT SAS-3
>>   |                           |               \-03.0-[0a-0e]--
>>   |                           \-00.1  PMC-Sierra Inc. Device 4052
>>
>>
>>
>>   arch/powerpc/include/asm/ppc-pci.h |  4 +++
>>   arch/powerpc/kernel/pci-hotplug.c  |  5 ++--
>>   arch/powerpc/kernel/pci_dn.c       | 42 ++++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ppc-pci.h 
>> b/arch/powerpc/include/asm/ppc-pci.h
>> index a8b7e8682f5b..a5d5ee4ff7c0 100644
>> --- a/arch/powerpc/include/asm/ppc-pci.h
>> +++ b/arch/powerpc/include/asm/ppc-pci.h
>> @@ -28,6 +28,10 @@ struct pci_dn;
>>   void *pci_traverse_device_nodes(struct device_node *start,
>>                   void *(*fn)(struct device_node *, void *),
>>                   void *data);
>> +
>> +void *pci_traverse_sibling_nodes_and_scan_slot(struct device_node 
>> *start,
>> +                           struct pci_bus *bus);
>> +
>>   extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
>>     #if defined(CONFIG_IOMMU_API) && (defined(CONFIG_PPC_PSERIES) || \
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c 
>> b/arch/powerpc/kernel/pci-hotplug.c
>> index 0fe251c6ac2c..639a3d592fe2 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -106,7 +106,7 @@ EXPORT_SYMBOL_GPL(pci_hp_remove_devices);
>>    */
>>   void pci_hp_add_devices(struct pci_bus *bus)
>>   {
>> -    int slotno, mode, max;
>> +    int mode, max;
>>       struct pci_dev *dev;
>>       struct pci_controller *phb;
>>       struct device_node *dn = pci_bus_to_OF_node(bus);
>> @@ -129,8 +129,7 @@ void pci_hp_add_devices(struct pci_bus *bus)
>>            * order for fully rescan all the way down to pick them up.
>>            * They can have been removed during partial hotplug.
>>            */
>> -        slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
>> -        pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
>> +        pci_traverse_sibling_nodes_and_scan_slot(dn, bus);
>>           max = bus->busn_res.start;
>>           /*
>>            * Scan bridges that are already configured. We don't touch
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>> index 38561d6a2079..2e202f9cec21 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -493,4 +493,46 @@ static void pci_dev_pdn_setup(struct pci_dev *pdev)
>>       pdn = pci_get_pdn(pdev);
>>       pdev->dev.archdata.pci_data = pdn;
>>   }
>> +
>> +void *pci_traverse_sibling_nodes_and_scan_slot(struct device_node 
>> *start, struct pci_bus *bus)
>
> Two things regarding the return type of the above function.
>
> 1. Function only returns NULL
> 2. Caller of this function doesn't take any action based on the return 
> value of this function.
>
> How about changing the return type from void * to just void?
>
>> +{
>> +    struct device_node *dn;
>> +    struct device_node *parent;
>
> parent variable is not really required.
>
>> +    int slotno;
>> +
>> +    const __be32 *classp1;
>> +    u32 class1 = 0;
>> +
>> +    classp1 = of_get_property(start->child, "class-code", NULL);
>> +    if (classp1)
>> +        class1 = of_read_number(classp1, 1);
>> +
>> +    /* Call of pci_scan_slot for non-bridge/EP case */
>> +    if (!((class1 >> 8) == PCI_CLASS_BRIDGE_PCI)) {
>> +        slotno = PCI_SLOT(PCI_DN(start->child)->devfn);
>> +        pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
>> +        return NULL;
>> +    }
>> +
>> +    /* Iterate all siblings */
>> +    parent = start;
>> +    for_each_child_of_node(parent, dn) {
>> +        const __be32 *classp;
>> +        u32 class = 0;
>> +
>> +        classp = of_get_property(dn, "class-code", NULL);
>> +        if (classp)
>> +            class = of_read_number(classp, 1);
>> +
>> +        /* Call of pci_scan_slot on each sibling-nodes/bridge-ports */
>> +        if ((class >> 8) == PCI_CLASS_BRIDGE_PCI) {
>> +            slotno = PCI_SLOT(PCI_DN(dn)->devfn);
>> +            pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
>> +        }
>> +    }
>> +
>> +    return NULL;
>
> Some level of code duplication can be avoided if we push both cases
> 1. Call of pci_scan_slot for non-bridge/EP case
> 2. Call of pci_scan_slot for bridge port
>
> inside `for_each_child_of_node` macro.
>
> Something like this.
>
>     u32 class;
>     int slotno;
>     const __be32 *classp;
>     struct device_node *dn;
>
>     for_each_child_of_node(start, dn) {
>         class = 0;
>         classp = of_get_property(dn, "class-code", NULL);
>         if (classp)
>             class = of_read_number(classp, 1);
>
>         /* Call of pci_scan_slot for non-bridge/EP case */
>         if (!((class >> 8) == PCI_CLASS_BRIDGE_PCI) && start->child == 
> dn) {
>             slotno = PCI_SLOT(PCI_DN(dn)->devfn);
>             pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
>             of_node_put(dn);
>             return;
>         }
>
>         /* Call of pci_scan_slot for bridge port */
>         if ((class >> 8) == PCI_CLASS_BRIDGE_PCI) {
>             slotno = PCI_SLOT(PCI_DN(dn)->devfn);
>             pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
>         }
>     }
>
>
>> +}
>> +EXPORT_SYMBOL_GPL(pci_traverse_sibling_nodes_and_scan_slot);
>
> What is the need for exporting the above function?
>
>> +
>>   DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
>
> - Sourabh Jain

