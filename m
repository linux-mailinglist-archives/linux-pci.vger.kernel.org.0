Return-Path: <linux-pci+bounces-13410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA610983C7E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 07:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF77280D04
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C29433B0;
	Tue, 24 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rzzr9Ap+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77F1FB4;
	Tue, 24 Sep 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157157; cv=none; b=XkERiYVEJckQw8abQ4Bfyf2+AWPPc+15Lz5ieC6I+y0xmWD+X25bs0vzQg3/GoHxrfgKFF4re3an7KoqTaiL0aqURud7QD5WgrgslNzRYXOzPlEBWxoUkep6ZGSY8E61NMHkqJ2W10EMhegJ4Jtvfc6PUPcg9qVPwxYhDVCMF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157157; c=relaxed/simple;
	bh=bdDtutD2AX+b8M/zUVUc8osppsP9U2nJtxRBvla7F38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SoVLwpIXDzLP5cL9oBsCN0tWtEzJ/C5oKre6GvRTymWojNa21bd3Nfg+ITAE08kUGNhlIVBvPlSzQ48xP0r9jheggh038DBmMmwQM0IEbaoeyOYhhVY0VzdX6bijKTDDQPOXCH8FNJIwozfUblx70TjTi9gVnHR3N23b9TNdlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rzzr9Ap+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NLea8W018674;
	Tue, 24 Sep 2024 05:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	juHGuZAvU1EMEN/6xg5NxWUpAOPzcKBMkLjcPFHV5Fw=; b=Rzzr9Ap+9g9z3tnb
	rIuEEB4LXEU+JBp2WlSjwo7MeXplu32PpG3SrWm2R+k50K15gTbxZwadwHEBSx7T
	rPUZVaxi+Tpw8tgrXIqQDqdkVgl8zCxT1emULBH03bq/IlD2Oxy0j8xuHu7cuJu4
	7jIGjG40xNiBBfGxXTup7tX2LWtFFrmriLMNheI0j+3H9zs33z7TFM7/bFK9kqb2
	BalHTBHKcFCnHB8Q4ZS0+Sf8wffeZxjnaROtrxT4lZSkHrKMDUmtKwDpz3Bc7CmL
	scPWPNx6CNHpxP7Iyvikfst1y/NL2yNn1naUOS19dvG/Uh3zLNpahgX9Tk4e1vzh
	cJVxlw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3s74mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 05:52:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48O5qMxA009443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 05:52:22 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 22:52:18 -0700
Message-ID: <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
Date: Tue, 24 Sep 2024 13:52:17 +0800
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D305zhPoFIQ_AWylgJW0zGAa734KzMXY
X-Proofpoint-ORIG-GUID: D305zhPoFIQ_AWylgJW0zGAa734KzMXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240038



On 9/23/2024 9:37 PM, Mario Limonciello wrote:
> On 9/23/2024 05:07, Baochen Qiang wrote:
>> Hi,
>>
>> recently it is reported that on some Lenovo machines (P16v, Z13 etc.) unexpected ACPI event wakeup is seen with kernel 6.10 [1][2]. To summary, the unexpected wakeup is triggered by simply unplug AC power or close lid of the laptop. Regression test shows this is caused by below commit, and with that reverted the issue is gone:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k?id=166a490f59ac10340ee5330e51c15188ce2a7f8f
>>
>> Well what confuses me is that this commit basically resets WLAN hardware before going to suspend. that said, WLAN target maintains limited functionality (PCIe link handling etc...) during system suspend and is thus not expected to wakeup system.
>>
>> kernel log shows this is an ACPI GPE event wakeup:
>>
>> Sep 22 22:34:32 fedora kernel: PM: Triggering wakeup from IRQ 9
>> Sep 22 22:34:32 fedora kernel: ACPI: PM: ACPI non-EC GPE wakeup
>> ...
>> Sep 22 22:34:32 fedora kernel: PM: noirq resume of devices complete after 693.757 msecs
>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x07
>> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x0e
>>
>> Consulting ACPI tables show GPE 0x07 is used by the EC and GPE 0x0e is used by GPP6 device:
>>
>> Scope (\_SB.PCI0.GPP6)
>> {
>>      ...
>>      Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>>      {
>>          M460 ("PLA-ASL-\\_SB.PCI0.GPP6._PRW Return GPRW (0xE, 0x4)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
>>          Return (Package (0x02)
>>          {
>>              0x0E,
>>              0x04
>>          })
>>      }
>>      ...
>> }
>>
>> while GPP6 is the PCI bridge (the PCIe root port in this case) to which WLAN target is attached to:
>>
>> Device (GPP6)
>> {
>>      Name (_ADR, 0x00020002)  // _ADR: Address
>>      ...
>> }
>>
>> Scope (_SB.PCI0.GPP6)
>> {
>>      Device (WLAN)
>>      {
>>          ...
>>      }
>>      ...
>> }
>>
>> and lspci also shows such relationship:
>>
>> $ lspci -vt
>> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
>>             ...
>>             +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter
>>             ....
>>
>> Based on above info:
>> #1 is that valid to get the conclusion that this unexpected wakeup is triggered directly by PCIe bridge?
>> #2 if this is related to WLAN (seems so based on the regression test), is it the WLAN wake pin (a GPIO pin?) that originally triggers this? and how does it affect the bridge?
>> #3 quick tests show that with GPP6 wakeup disabled this issue is gone. so a workaround is to disable GPP6 wakeup before going to suspend and enable it back after resume. But is it safe to do so?
>>
>>
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921
>>
> 
> With pinctrl-amd there is an extra debugging message present [1] that is activated when you enable '/sys/power/pm_debug_messages' which will tell you if a GPIO is active during the suspend cycle.  That can help you to rule out whether this is the WoWLAN GPIO pin causing the behavior.
> 
> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/pinctrl/pinctrl-amd.c#L626
Thanks for the reminder, Mario.

I do notice that some reporters mentioned about this [1]. and I can also see this on my P16v machine:

[  881.799289] PM: suspend entry (s2idle)
...
[  897.491440] PM: Triggering wakeup from IRQ 9
[  897.491714] ACPI: PM: ACPI non-EC GPE wakeup
[  897.491720] PM: resume from suspend-to-idle
...
[  898.153259] PM: noirq resume of devices complete after 556.675 msecs
[  898.153443] ACPI: GPE event 0x07
[  898.153502] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 1st time
...
[  898.314804] mhi mhi0: Requested to power ON //WLAN begin to reinitialize
[  898.314841] mhi mhi0: Power on setup success
[  898.694562] mhi mhi0: Wait for device to enter SBL or Mission mode
[  899.305898] GPIO 18 is active: 0x10157a00 //I guess this is the WoWLAN GPIO pin
[  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
[  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
[  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
...
[  899.826378] PM: suspend exit


But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:

[ 2640.849342] PM: suspend entry (s2idle)
...
[ 2650.806234] PM: Triggering wakeup from IRQ 9
...
[ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
[ 2651.467880] ACPI: GPE event 0x07
[ 2651.467961] ACPI: GPE event 0x0e
...
[ 2651.848848] PM: suspend exit



[1] https://bugzilla.kernel.org/show_bug.cgi?id=219286


