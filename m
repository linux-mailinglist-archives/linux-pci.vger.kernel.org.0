Return-Path: <linux-pci+bounces-13466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540A9850E4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4293F1F21034
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65659149013;
	Wed, 25 Sep 2024 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KQe6rc+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC5946F;
	Wed, 25 Sep 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230752; cv=none; b=utw8qyesGijij8R6kAYL7ondqM3i734c0hlJGv/bvBfmafgdt/5AiTj/udsIo3L7AaH241zo3v1pRSYdc4PuS8TT/AO6UkbsaMqjI+wnzhZMUtEPqmKf8F/OqV9c3K1pzvxrrhN4YdweW+iuZrQDELjWvZiiPwiGr4W0LxtVtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230752; c=relaxed/simple;
	bh=oqMXqPenpnnACiruyiOns6DjEWIO3FXYx2lK3V9hScw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sWjiq0sanYbfGmUPcaDd0sQ6lrFFL2YAnFszagPYqNcJLByoIr4moQIHtXCE+avZ5sY+7NQRFZsOd6ebPHrpvHEdBKQiNnoOJkhA2PTvHNJAUycbTLjjLVc27v/O/jHqdD8c4V5rvll77AbO3gc/Hhu0VdpPZkvcQ4MtPw4oz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KQe6rc+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHeUO0025397;
	Wed, 25 Sep 2024 02:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6whLWtPSgr0+Y2zMO6IskNPkPfq9lg9PtKIpHEQYVbk=; b=KQe6rc+HIsOSpHji
	1H3nwUqA2/1WgW8DsyErMEL1t/0UAZgMa/Z1Hfwdsvg9+6YS2qE0UL9nWaU3pxq3
	NdrrdnHOH9PbX3CCx2njxp9q1yOuNHbKFS+yF5cJZizDcDHNb9N2dd1k9JlPYNU+
	lcUXlvUUjmtHwckp5Trd/gkSO562aL44sfniiDl77mCgSrLgRYumhnKIDGBV9jFZ
	ZdF+dylA9z+MguIoh6GnPSjHbzqyKPWmxlUMFP4D4nXNyjV6T0B/+cB6UhzbA0Eb
	moIHx8Gx4OF7iJyRwY4m0BaTO4p1pJPky2rUH4ujOlCcDnjeNjs2BsKhw12kJyox
	hEePHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6tq1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 02:18:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P2Iq3q030045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 02:18:52 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 19:18:48 -0700
Message-ID: <115efc10-60fd-436f-99b6-0b141f9585e7@quicinc.com>
Date: Wed, 25 Sep 2024 10:18:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Mario Limonciello <mario.limonciello@amd.com>, <rafael@kernel.org>,
        <mika.westerberg@linux.intel.com>, <ulf.hansson@linaro.org>,
        <bhelgaas@google.com>, <Basavaraj.Natikar@amd.com>,
        <Shyam-sundar.S-k@amd.com>, <mpearson@lenovo.com>,
        <markpearson@lenovo.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
 <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
 <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
 <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F0YU-THIKDcK4yDkH0twd7aD3rYNUhXX
X-Proofpoint-ORIG-GUID: F0YU-THIKDcK4yDkH0twd7aD3rYNUhXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250016



On 9/25/2024 1:55 AM, Mario Limonciello wrote:
> On 9/24/2024 00:52, Baochen Qiang wrote:
>>
>>
>> On 9/23/2024 9:37 PM, Mario Limonciello wrote:
>>> On 9/23/2024 05:07, Baochen Qiang wrote:
>>>> Hi,
>>>>
>>>> recently it is reported that on some Lenovo machines (P16v, Z13 etc.) unexpected ACPI event wakeup is seen with kernel 6.10 [1][2]. To summary, the unexpected wakeup is triggered by simply unplug AC power or close lid of the laptop. Regression test shows this is caused by below commit, and with that reverted the issue is gone:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k?id=166a490f59ac10340ee5330e51c15188ce2a7f8f
>>>>
>>>> Well what confuses me is that this commit basically resets WLAN hardware before going to suspend. that said, WLAN target maintains limited functionality (PCIe link handling etc...) during system suspend and is thus not expected to wakeup system.
>>>>
>>>> kernel log shows this is an ACPI GPE event wakeup:
>>>>
>>>> Sep 22 22:34:32 fedora kernel: PM: Triggering wakeup from IRQ 9
>>>> Sep 22 22:34:32 fedora kernel: ACPI: PM: ACPI non-EC GPE wakeup
>>>> ...
>>>> Sep 22 22:34:32 fedora kernel: PM: noirq resume of devices complete after 693.757 msecs
>>>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x07
>>>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x0e
>>>>
>>>> Consulting ACPI tables show GPE 0x07 is used by the EC and GPE 0x0e is used by GPP6 device:
>>>>
>>>> Scope (\_SB.PCI0.GPP6)
>>>> {
>>>>       ...
>>>>       Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>>>>       {
>>>>           M460 ("PLA-ASL-\\_SB.PCI0.GPP6._PRW Return GPRW (0xE, 0x4)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
>>>>           Return (Package (0x02)
>>>>           {
>>>>               0x0E,
>>>>               0x04
>>>>           })
>>>>       }
>>>>       ...
>>>> }
>>>>
>>>> while GPP6 is the PCI bridge (the PCIe root port in this case) to which WLAN target is attached to:
>>>>
>>>> Device (GPP6)
>>>> {
>>>>       Name (_ADR, 0x00020002)  // _ADR: Address
>>>>       ...
>>>> }
>>>>
>>>> Scope (_SB.PCI0.GPP6)
>>>> {
>>>>       Device (WLAN)
>>>>       {
>>>>           ...
>>>>       }
>>>>       ...
>>>> }
>>>>
>>>> and lspci also shows such relationship:
>>>>
>>>> $ lspci -vt
>>>> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
>>>>              ...
>>>>              +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter
>>>>              ....
>>>>
>>>> Based on above info:
>>>> #1 is that valid to get the conclusion that this unexpected wakeup is triggered directly by PCIe bridge?
>>>> #2 if this is related to WLAN (seems so based on the regression test), is it the WLAN wake pin (a GPIO pin?) that originally triggers this? and how does it affect the bridge?
>>>> #3 quick tests show that with GPP6 wakeup disabled this issue is gone. so a workaround is to disable GPP6 wakeup before going to suspend and enable it back after resume. But is it safe to do so?
>>>>
>>>>
>>>>
>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921
>>>>
>>>
>>> With pinctrl-amd there is an extra debugging message present [1] that is activated when you enable '/sys/power/pm_debug_messages' which will tell you if a GPIO is active during the suspend cycle.  That can help you to rule out whether this is the WoWLAN GPIO pin causing the behavior.
>>>
>>> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/pinctrl/pinctrl-amd.c#L626
>> Thanks for the reminder, Mario.
>>
>> I do notice that some reporters mentioned about this [1]. and I can also see this on my P16v machine:
>>
>> [  881.799289] PM: suspend entry (s2idle)
>> ...
>> [  897.491440] PM: Triggering wakeup from IRQ 9
>> [  897.491714] ACPI: PM: ACPI non-EC GPE wakeup
>> [  897.491720] PM: resume from suspend-to-idle
>> ...
>> [  898.153259] PM: noirq resume of devices complete after 556.675 msecs
>> [  898.153443] ACPI: GPE event 0x07
>> [  898.153502] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 1st time
>> ...
>> [  898.314804] mhi mhi0: Requested to power ON //WLAN begin to reinitialize
>> [  898.314841] mhi mhi0: Power on setup success
>> [  898.694562] mhi mhi0: Wait for device to enter SBL or Mission mode
>> [  899.305898] GPIO 18 is active: 0x10157a00 //I guess this is the WoWLAN GPIO pin
> 
> Yeah that's what it looks like to me too.  The easiest way to confirm this (without a schematic that is) is to look at the _AEI / _EVT in the SSDT and see what is notified when this is active.
seems GPP6 is notified, does this mean GPIO18 is NOT bound to WLAN wakeup pin? but instead it is bound to the PCIe root port?

Scope (\_SB.GPIO)
{
    Method (_AEI, 0, NotSerialized)  // _AEI: ACPI Event Interrupts
    {
        Name (BUF0, ResourceTemplate ()
        {
		...
            	GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
                	"\\_SB.GPIO", 0x00, ResourceConsumer, ,)
                {   	// Pin list
                    	0x0012
                }
		...
	})
        Name (BUF1, ResourceTemplate ()
	{
		...
		GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
			"\\_SB.GPIO", 0x00, ResourceConsumer, ,)
		{   	// Pin list
			0x0012
		}
		...
			
	})
	If ((\_SB.PCI0.LPC0.EC0.WWDT != 0x0F))
	{
		Return (BUF0) /* \_SB_.GPIO._AEI.BUF0 */
	}
	Else
	{
		Return (BUF1) /* \_SB_.GPIO._AEI.BUF1 */
	}
    }
	
    Method (_EVT, 1, Serialized)  // _EVT: Event
    {
        M460 ("  OEM-ASL-\\_SB.GPIO._EVT-Start Case %d\n", ToInteger (Arg0), 0x00, 0x00, 0x00, 0x00, 0x00)
        Switch (ToInteger (Arg0))
	{
		...
            	Case (0x12)
            	{
                	M000 (0x3912)
                	M460 ("    Notify (\\_SB.PCI0.GPP6, 0x02)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
                	Notify (\_SB.PCI0.GPP6, 0x02) // Device Wake
            	}
		...
        }

        M460 ("  OEM-ASL-\\_SB.GPIO._EVT-End Case %d\n", ToInteger (Arg0), 0x00, 0x00, 0x00, 0x00, 0x00)
    }
}

> 
>> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
>> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>> ...
>> [  899.826378] PM: suspend exit
>>
>>
>> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:
> 
> I don't believe that just removing the kernel module is enough.  Can you physically remove the hardware?
not possible, it is soldered, not a M.2 module
> 
>>
>> [ 2640.849342] PM: suspend entry (s2idle)
>> ...
>> [ 2650.806234] PM: Triggering wakeup from IRQ 9
>> ...
>> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
>> [ 2651.467880] ACPI: GPE event 0x07
>> [ 2651.467961] ACPI: GPE event 0x0e
>> ...
>> [ 2651.848848] PM: suspend exit
>>
>>
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
>>
> 
> Is it possible for you to put a scope on the GPIO and/or PCIe analzyer on the bus?
it is hard to me -- for the GPIO I need the schematic which is not available, and for the PCIe analyzer we need hardware rework for that, but I will try.

> 
> It sounds to me that most likely what's going on is PME being asserted from WLAN controller.
But I don;t see a PME interrupt fired on the root port:

$ cat /proc/interrupts
  36:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI-0000:00:02.2    0-edge      PCIe PME

$ lspci -tv
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
	   ...
           +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter


> 


