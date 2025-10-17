Return-Path: <linux-pci+bounces-38482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09931BE92D5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEA65E85E4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E23396FA;
	Fri, 17 Oct 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rGPiBtUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF43396F1
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710881; cv=none; b=BIww7ckfZu/lysik/z6t/0FJPgUM9ZAoq8YJI6B3JE7DovID/XvK8KQf+FlhVXK+pK1oag2M2I0ldbFwQOVBMyGN63uGvYZyymgei3MXc/Emmc5whGaODoKJNI/iqlyOLkXyf6DQrnGCnZYba4LyrIvnQZpzMGBatzD/hsyMb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710881; c=relaxed/simple;
	bh=T5DbWNLZPZ8w2UDbLucYBupyis7t2YeILN5raue7V58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JruFrntP8bxnlJrgZhAsoY5SqA5oGknP242vledyS6u6qKcOlN4hG7QamrBGKVTe+dWBUs3FqB4ZQLtpHvNN7IZIhIbY2r/adkZM7BhKqbiwOAMcdN27k99iN1oE23PoikpdrMxXHvw9fW5iff4gASoZpNbVx7T8fjSGmBWwpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rGPiBtUm; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id 9ji0vHCBNaPqL9lKRvNxqS; Fri, 17 Oct 2025 14:21:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 9lKOvlj3kwoI29lKOvJsA9; Fri, 17 Oct 2025 14:21:09 +0000
X-Authority-Analysis: v=2.4 cv=PZX/hjhd c=1 sm=1 tr=0 ts=68f250d6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=HaFmDPmJAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c3N2V53nFsz6MthyhhEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CjaQGKVGTxZ1bRrGBuHqQUNCs7DDwt+H3CUoVjyRlBc=; b=rGPiBtUm6P9UpV1D6RLs8LEXBz
	XfdDUsn5cxFw/wYeaTOk28Om3ET45Q4wYDiAnWStomzzkdyGS9M9VrNCbI6WFAeky0V04Vh44WWaa
	LtyLNDmgdPQJ8G/3Rqh4bO8rCpd47ipbg9fuBUsb4/mFQWkl7acLknZJ53/+maoyazwHcconvliaI
	cph3K9F5/jXxotvIvqxQRXwjvhgDrl7sMu6t5G1gsqO2tR+PiMeN9Kxwe+zPZHbYo7TChebv1fYxu
	dYQxCAnQkd+WqcJHb64czAqR6ibd7ZLRikEOSOT45T6+EEpfBExai14YLSt9Qum4D/jNX970IuWHv
	XUUhnclA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:50342 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v9lKO-00000002hUO-16hY;
	Fri, 17 Oct 2025 08:21:08 -0600
Message-ID: <6bf478b8-2194-4ffb-aaac-8e3e314ad71c@w6rz.net>
Date: Fri, 17 Oct 2025 07:21:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
 Paul Walmsley <pjw@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, regressions@lists.linux.dev
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
 <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
 <759e429c-b160-46ff-923e-000415c749ee@oss.qualcomm.com>
 <b203ba27-7033-41d9-9b43-aa4a7eb75f23@w6rz.net>
 <yxdwo4hppd7c7lrv5pybjtu22aqh3lbk34qxdxmkubgwukvgwq@i4i45fdgm6sw>
 <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>
 <xfpqp3oign7c3336wxo5yexgitxotttrxgkyzbfknjmfk6pmdc@drsk3ardfl5t>
 <432e4026-208f-459e-82dc-e74ef5da6a87@oss.qualcomm.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <432e4026-208f-459e-82dc-e74ef5da6a87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v9lKO-00000002hUO-16hY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:50342
X-Source-Auth: re@w6rz.net
X-Email-Count: 7
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCSX/dzMQzMMEqZUX1G/8bZHB32X+17nSHEUxV0noLVzoYMTTlOauPan+9eZ69zLpHLJYU/gN+Tj21T5uKSTVkPTQ/jR/02wtk6dVgTRN3J7mafcvhLF
 iFN4zbJymuI3BmP/TQwQZF9iHMx/YDJMYcF7ok40I8TWHkFjhpnXxl4WLJuowtgklf8ZhduOxszBXV0YrQ3/V1QIsqU/yVldsiQ=

On 10/17/25 04:43, Krishna Chaitanya Chundru wrote:
>
>
> On 10/15/2025 7:33 PM, Manivannan Sadhasivam wrote:
>> On Tue, Oct 14, 2025 at 03:41:39PM -0700, Ron Economos wrote:
>>> On 10/14/25 09:25, Manivannan Sadhasivam wrote:
>>>> On Mon, Oct 13, 2025 at 10:52:48PM -0700, Ron Economos wrote:
>>>>> On 10/13/25 22:36, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>> On 10/14/2025 10:56 AM, Ron Economos wrote:
>>>>>>> On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
>>>>>>>>
>>>>>>>> On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
>>>>>>>>> [+cc FU740 driver folks, Conor, regressions]
>>>>>>>>>
>>>>>>>>> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>>>>>>>>>> The SiFive FU740 PCI driver fails on the HiFive
>>>>>>>>>> Unmatched board with Linux
>>>>>>>>>> 6.18-rc1. The error message is:
>>>>>>>>>>
>>>>>>>>>> [    3.166624] fu740-pcie e00000000.pcie: host bridge
>>>>>>>>>> /soc/pcie@e00000000
>>>>>>>>>> ranges:
>>>>>>>>>> [    3.166706] fu740-pcie e00000000.pcie: IO
>>>>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>>>>> [    3.166767] fu740-pcie e00000000.pcie: MEM
>>>>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>>>>> [    3.166805] fu740-pcie e00000000.pcie: MEM
>>>>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>>>>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>>>>>>>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>>>>>>>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>>>>>>>>>> [    3.579552] fu740-pcie e00000000.pcie: Failed to
>>>>>>>>>> configure iATU in ECAM
>>>>>>>>>> mode
>>>>>>>>>> [    3.579655] fu740-pcie e00000000.pcie: probe with
>>>>>>>>>> driver fu740-pcie
>>>>>>>>>> failed with error -22
>>>>>>>>>>
>>>>>>>>>> The normal message (on Linux 6.17.2) is:
>>>>>>>>>>
>>>>>>>>>> [    3.381487] fu740-pcie e00000000.pcie: host bridge
>>>>>>>>>> /soc/pcie@e00000000
>>>>>>>>>> ranges:
>>>>>>>>>> [    3.381584] fu740-pcie e00000000.pcie: IO
>>>>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>>>>> [    3.381682] fu740-pcie e00000000.pcie: MEM
>>>>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>>>>> [    3.381724] fu740-pcie e00000000.pcie: MEM
>>>>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>>>>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll
>>>>>>>>>> T, 8 ob, 8 ib, align
>>>>>>>>>> 4K, limit 4096G
>>>>>>>>>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>>>>>>>>>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>>>>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>>>>> [    3.988164] fu740-pcie e00000000.pcie: PCI host
>>>>>>>>>> bridge to bus 0000:00
>>>>>>>>>>
>>>>>>>>>> Reverting the following commits solves the issue.
>>>>>>>>>>
>>>>>>>>>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc:
>>>>>>>>>> Support ECAM mechanism by
>>>>>>>>>> enabling iATU 'CFG Shift Feature'
>>>>>>>>>>
>>>>>>>>>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom:
>>>>>>>>>> Prepare for the DWC ECAM
>>>>>>>>>> enablement
>>>>>>>>>>
>>>>>>>>>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc:
>>>>>>>>>> Prepare the driver for
>>>>>>>>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
>>>>>>>>> As Conor pointed out, we can't fix a code regression with a DT 
>>>>>>>>> change.
>>>>>>>>>
>>>>>>>>> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the
>>>>>>>>> driver for enabling ECAM mechanism using iATU 'CFG Shift
>>>>>>>>> Feature'")
>>>>>>>> Hi Conor,
>>>>>>>>
>>>>>>>> Can you try with this patch and see if it is fixing the issue.
>>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>>> b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>>> index 66367252032b..b5e0f016a580 100644
>>>>>>>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>>> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct
>>>>>>>> platform_device *pdev)
>>>>>>>>
>>>>>>>>           platform_set_drvdata(pdev, afp);
>>>>>>>>
>>>>>>>> +       pci->pp.native_ecam = true;
>>>>>>>> +
>>>>>>>>           return dw_pcie_host_init(&pci->pp);
>>>>>>>>    }
>>>>>>>>
>>>>>>>> - Krishna Chaitanya.
>>>>>>>>
>>>>>>> I've already tried it. It doesn't work. Same error message as 
>>>>>>> before.
>>>>>> Can you share us dmesg logs for this change.
>>>>>>
>>>>>> - Krishna Chaitanya.
>>>>> [    3.159763] fu740-pcie e00000000.pcie: host bridge 
>>>>> /soc/pcie@e00000000
>>>>> ranges:
>>>>> [    3.159853] fu740-pcie e00000000.pcie:       IO
>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>> [    3.159916] fu740-pcie e00000000.pcie:      MEM
>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>> [    3.159953] fu740-pcie e00000000.pcie:      MEM
>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>> [    3.160039] fu740-pcie e00000000.pcie: ECAM at [mem
>>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>>> [    3.571421] fu740-pcie e00000000.pcie: No iATU regions found
>>>>> [    3.571472] fu740-pcie e00000000.pcie: Failed to configure iATU 
>>>>> in ECAM
>>>>> mode
>>>>> [    3.571529] fu740-pcie e00000000.pcie: probe with driver 
>>>>> fu740-pcie
>>>>> failed with error -22
>>>>>
>>>>> Same as before the change. The entire log is here:
>>>>>
>>>>> https://www.w6rz.net/dmesg.txt
>>>>>
>>>> Weird that the driver still creates ECAM even after skipping it 
>>>> using the flag.
>>>> The flag is not meant for that purpose, but it should've worked 
>>>> anyway.
>>>>
>>>> Can you try this diff and share the dmesg log?
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 20c9333bcb1c..58080928df9f 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -523,8 +523,12 @@ static int dw_pcie_host_get_resources(struct 
>>>> dw_pcie_rp *pp)
>>>>           pp->cfg0_size = resource_size(res);
>>>>           pp->cfg0_base = res->start;
>>>>
>>>> +       dev_info(dev, "%s: %d native_ecam: %d", __func__, __LINE__,
>>>> +pp->native_ecam);
>>>> +
>>>>           pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
>>>>           if (pp->ecam_enabled) {
>>>> +               dev_info(dev, "%s: %d ECAM ENABLED", __func__, 
>>>> __LINE__);
>>>>                   ret = dw_pcie_create_ecam_window(pp, res);
>>>>                   if (ret)
>>>>                           return ret;
>>>> @@ -533,6 +537,7 @@ static int dw_pcie_host_get_resources(struct 
>>>> dw_pcie_rp *pp)
>>>>                   pp->bridge->sysdata = pp->cfg;
>>>>                   pp->cfg->priv = pp;
>>>>           } else {
>>>> +               dev_info(dev, "%s: %d ECAM DISABLED", __func__, 
>>>> __LINE__);
>>>>                   pp->va_cfg0_base = 
>>>> devm_pci_remap_cfg_resource(dev, res);
>>>>                   if (IS_ERR(pp->va_cfg0_base))
>>>>                           return PTR_ERR(pp->va_cfg0_base);
>>>>
>>>> - Mani
>>>>
>>> After testing with this patch, I must have transferred the wrong 
>>> image to
>>> the target when testing before. The "pci->pp.native_ecam = true;" 
>>> patch to
>>> pcie-fu740.c does work.
>>
>> Thanks! However, it was not a proper fix. The issue seems to be due the
>> assumption that the whole DBI space (Root Port + misc registers) lies 
>> at the
>> start of the ECAM region. This is true for Qcom, but not for all DWC 
>> glue
>> platforms.
>>
>> Krishna is working on a patch that decouples the DBI region from ECAM 
>> so that
>> the driver will continue using DBI for accessing Root Port config 
>> space and ECAM
>> for bus > 0.
>>
>> This is one step backwards for ECAM since the driver is supposed to 
>> use ECAM for
>> accessing all devices starting from the Root Port. But since DWC has 
>> clubbed
>> non-Root Port specific registers in the DBI space, we have to live 
>> with this
>> limitation as ECAM is supposed to access only Root Port specific 
>> registers.
>>
>> The patch will be posted after internal validation asap.
>>
> Hi Ron,
>
> Can you try with this series and let us know if it is helping you or
> not.
>
> https://lore.kernel.org/all/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com/ 
>
>
> - Krishna Chaitanya.

The patch works good. Here's the log of PCI messages.

[    3.221506] fu740-pcie e00000000.pcie: host bridge 
/soc/pcie@e00000000 ranges:
[    3.221594] fu740-pcie e00000000.pcie:       IO 
0x0060080000..0x006008ffff -> 0x0060080000
[    3.221658] fu740-pcie e00000000.pcie:      MEM 
0x0060090000..0x007fffffff -> 0x0060090000
[    3.221696] fu740-pcie e00000000.pcie:      MEM 
0x2000000000..0x3fffffffff -> 0x2000000000
[    3.221783] fu740-pcie e00000000.pcie: ECAM at [mem 
0xdf0000000-0xdffffffff] for [bus 00-ff]
[    3.323453] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, 
align 4K, limit 4096G
[    3.523137] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
[    3.723138] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.827134] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.827445] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00
[    3.827479] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.827503] pci_bus 0000:00: root bus resource [io 0x0000-0xffff] 
(bus address [0x60080000-0x6008ffff])
[    3.827529] pci_bus 0000:00: root bus resource [mem 
0x60090000-0x7fffffff]
[    3.827551] pci_bus 0000:00: root bus resource [mem 
0x2000000000-0x3fffffffff pref]
[    3.827750] pci 0000:00:00.0: [f15e:0000] type 01 class 0x060400 PCIe 
Root Port
[    3.827797] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    3.827821] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    3.827844] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    3.827866] pci 0000:00:00.0:   bridge window [io 0x0000-0x0fff]
[    3.827888] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.827912] pci 0000:00:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.827998] pci 0000:00:00.0: supports D1
[    3.828018] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    3.829345] pci 0000:01:00.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Upstream Port
[    3.829398] pci 0000:01:00.0: PCI bridge to [bus 00]
[    3.829424] pci 0000:01:00.0:   bridge window [io 0x0000-0x0fff]
[    3.829446] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.829475] pci 0000:01:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.829509] pci 0000:01:00.0: enabling Extended Tags
[    3.829597] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    3.835150] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up 
L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[    3.835188] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
[    3.835274] pci 0000:01:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.835433] pci 0000:02:00.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    3.835483] pci 0000:02:00.0: PCI bridge to [bus 00]
[    3.835508] pci 0000:02:00.0:   bridge window [io 0x0000-0x0fff]
[    3.835530] pci 0000:02:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.835557] pci 0000:02:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.835592] pci 0000:02:00.0: enabling Extended Tags
[    3.835680] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    3.836142] pci 0000:02:02.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    3.836193] pci 0000:02:02.0: PCI bridge to [bus 00]
[    3.836217] pci 0000:02:02.0:   bridge window [io 0x0000-0x0fff]
[    3.836240] pci 0000:02:02.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.836267] pci 0000:02:02.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.836302] pci 0000:02:02.0: enabling Extended Tags
[    3.836391] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    3.836840] pci 0000:02:03.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    3.836890] pci 0000:02:03.0: PCI bridge to [bus 00]
[    3.836915] pci 0000:02:03.0:   bridge window [io 0x0000-0x0fff]
[    3.836936] pci 0000:02:03.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.836965] pci 0000:02:03.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.836999] pci 0000:02:03.0: enabling Extended Tags
[    3.837088] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    3.837513] pci 0000:02:04.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    3.837563] pci 0000:02:04.0: PCI bridge to [bus 00]
[    3.837588] pci 0000:02:04.0:   bridge window [io 0x0000-0x0fff]
[    3.837610] pci 0000:02:04.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.837638] pci 0000:02:04.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.837672] pci 0000:02:04.0: enabling Extended Tags
[    3.837760] pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
[    3.838260] pci 0000:02:08.0: [1b21:2824] type 01 class 0x060400 PCIe 
Switch Downstream Port
[    3.838311] pci 0000:02:08.0: PCI bridge to [bus 00]
[    3.838336] pci 0000:02:08.0:   bridge window [io 0x0000-0x0fff]
[    3.838358] pci 0000:02:08.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.838386] pci 0000:02:08.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    3.838421] pci 0000:02:08.0: enabling Extended Tags
[    3.838509] pci 0000:02:08.0: PME# supported from D0 D3hot D3cold
[    3.839437] pci 0000:02:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.839472] pci 0000:02:02.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.839501] pci 0000:02:03.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.839530] pci 0000:02:04.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.839557] pci 0000:02:08.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.839788] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    3.839964] pci 0000:04:00.0: [1b21:1142] type 00 class 0x0c0330 PCIe 
Legacy Endpoint
[    3.840056] pci 0000:04:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
[    3.840181] pci 0000:04:00.0: PME# supported from D3cold
[    3.847149] pci 0000:04:00.0: ASPM: DT platform, enabling L0s-up 
L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[    3.847190] pci 0000:04:00.0: ASPM: DT platform, enabling ClockPM
[    3.847225] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    3.847421] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    3.847743] pci 0000:06:00.0: [15b7:5002] type 00 class 0x010802 PCIe 
Endpoint
[    3.847823] pci 0000:06:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    3.847852] pci 0000:06:00.0: BAR 4 [mem 0x00000000-0x000000ff 64bit]
[    3.860322] pci 0000:06:00.0: ASPM: DT platform, enabling L0s-up 
L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[    3.860362] pci 0000:06:00.0: ASPM: DT platform, enabling ClockPM
[    3.860414] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    3.860613] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    3.860645] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 07
[    3.860671] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 07
[    3.860751] pci 0000:00:00.0: BAR 0 [mem 0x60100000-0x601fffff]: assigned
[    3.860781] pci 0000:00:00.0: bridge window [mem 
0x60200000-0x606fffff]: assigned
[    3.860808] pci 0000:00:00.0: bridge window [mem 
0x2000000000-0x20004fffff 64bit pref]: assigned
[    3.860834] pci 0000:00:00.0: ROM [mem 0x60090000-0x6009ffff pref]: 
assigned
[    3.860857] pci 0000:00:00.0: bridge window [io 0x1000-0x5fff]: assigned
[    3.860886] pci 0000:01:00.0: bridge window [mem 
0x60200000-0x606fffff]: assigned
[    3.860912] pci 0000:01:00.0: bridge window [mem 
0x2000000000-0x20004fffff 64bit pref]: assigned
[    3.860937] pci 0000:01:00.0: bridge window [io 0x1000-0x5fff]: assigned
[    3.860975] pci 0000:02:00.0: bridge window [mem 
0x60200000-0x602fffff]: assigned
[    3.861001] pci 0000:02:00.0: bridge window [mem 
0x2000000000-0x20000fffff 64bit pref]: assigned
[    3.861026] pci 0000:02:02.0: bridge window [mem 
0x60300000-0x603fffff]: assigned
[    3.861050] pci 0000:02:02.0: bridge window [mem 
0x2000100000-0x20001fffff 64bit pref]: assigned
[    3.861075] pci 0000:02:03.0: bridge window [mem 
0x60400000-0x604fffff]: assigned
[    3.861099] pci 0000:02:03.0: bridge window [mem 
0x2000200000-0x20002fffff 64bit pref]: assigned
[    3.861124] pci 0000:02:04.0: bridge window [mem 
0x60500000-0x605fffff]: assigned
[    3.861148] pci 0000:02:04.0: bridge window [mem 
0x2000300000-0x20003fffff 64bit pref]: assigned
[    3.861173] pci 0000:02:08.0: bridge window [mem 
0x60600000-0x606fffff]: assigned
[    3.861197] pci 0000:02:08.0: bridge window [mem 
0x2000400000-0x20004fffff 64bit pref]: assigned
[    3.861221] pci 0000:02:00.0: bridge window [io 0x1000-0x1fff]: assigned
[    3.861242] pci 0000:02:02.0: bridge window [io 0x2000-0x2fff]: assigned
[    3.861264] pci 0000:02:03.0: bridge window [io 0x3000-0x3fff]: assigned
[    3.861285] pci 0000:02:04.0: bridge window [io 0x4000-0x4fff]: assigned
[    3.861306] pci 0000:02:08.0: bridge window [io 0x5000-0x5fff]: assigned
[    3.861332] pci 0000:02:00.0: PCI bridge to [bus 03]
[    3.861353] pci 0000:02:00.0:   bridge window [io 0x1000-0x1fff]
[    3.861378] pci 0000:02:00.0:   bridge window [mem 0x60200000-0x602fffff]
[    3.861401] pci 0000:02:00.0:   bridge window [mem 
0x2000000000-0x20000fffff 64bit pref]
[    3.861431] pci 0000:04:00.0: BAR 0 [mem 0x60300000-0x60307fff 
64bit]: assigned
[    3.861469] pci 0000:02:02.0: PCI bridge to [bus 04]
[    3.861489] pci 0000:02:02.0:   bridge window [io 0x2000-0x2fff]
[    3.861512] pci 0000:02:02.0:   bridge window [mem 0x60300000-0x603fffff]
[    3.861534] pci 0000:02:02.0:   bridge window [mem 
0x2000100000-0x20001fffff 64bit pref]
[    3.861561] pci 0000:02:03.0: PCI bridge to [bus 05]
[    3.861581] pci 0000:02:03.0:   bridge window [io 0x3000-0x3fff]
[    3.861603] pci 0000:02:03.0:   bridge window [mem 0x60400000-0x604fffff]
[    3.861625] pci 0000:02:03.0:   bridge window [mem 
0x2000200000-0x20002fffff 64bit pref]
[    3.861657] pci 0000:06:00.0: BAR 0 [mem 0x60500000-0x60503fff 
64bit]: assigned
[    3.861692] pci 0000:06:00.0: BAR 4 [mem 0x60504000-0x605040ff 
64bit]: assigned
[    3.861727] pci 0000:02:04.0: PCI bridge to [bus 06]
[    3.861747] pci 0000:02:04.0:   bridge window [io 0x4000-0x4fff]
[    3.861769] pci 0000:02:04.0:   bridge window [mem 0x60500000-0x605fffff]
[    3.861791] pci 0000:02:04.0:   bridge window [mem 
0x2000300000-0x20003fffff 64bit pref]
[    3.861819] pci 0000:02:08.0: PCI bridge to [bus 07]
[    3.861838] pci 0000:02:08.0:   bridge window [io 0x5000-0x5fff]
[    3.861861] pci 0000:02:08.0:   bridge window [mem 0x60600000-0x606fffff]
[    3.861883] pci 0000:02:08.0:   bridge window [mem 
0x2000400000-0x20004fffff 64bit pref]
[    3.861910] pci 0000:01:00.0: PCI bridge to [bus 02-07]
[    3.861929] pci 0000:01:00.0:   bridge window [io 0x1000-0x5fff]
[    3.861951] pci 0000:01:00.0:   bridge window [mem 0x60200000-0x606fffff]
[    3.861973] pci 0000:01:00.0:   bridge window [mem 
0x2000000000-0x20004fffff 64bit pref]
[    3.862000] pci 0000:00:00.0: PCI bridge to [bus 01-07]
[    3.862019] pci 0000:00:00.0:   bridge window [io 0x1000-0x5fff]
[    3.862040] pci 0000:00:00.0:   bridge window [mem 0x60200000-0x606fffff]
[    3.862061] pci 0000:00:00.0:   bridge window [mem 
0x2000000000-0x20004fffff 64bit pref]
[    3.862087] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    3.862107] pci_bus 0000:00: resource 5 [mem 0x60090000-0x7fffffff]
[    3.862126] pci_bus 0000:00: resource 6 [mem 
0x2000000000-0x3fffffffff pref]
[    3.862147] pci_bus 0000:01: resource 0 [io  0x1000-0x5fff]
[    3.862166] pci_bus 0000:01: resource 1 [mem 0x60200000-0x606fffff]
[    3.862185] pci_bus 0000:01: resource 2 [mem 
0x2000000000-0x20004fffff 64bit pref]
[    3.862208] pci_bus 0000:02: resource 0 [io  0x1000-0x5fff]
[    3.862227] pci_bus 0000:02: resource 1 [mem 0x60200000-0x606fffff]
[    3.862246] pci_bus 0000:02: resource 2 [mem 
0x2000000000-0x20004fffff 64bit pref]
[    3.862269] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
[    3.862288] pci_bus 0000:03: resource 1 [mem 0x60200000-0x602fffff]
[    3.862307] pci_bus 0000:03: resource 2 [mem 
0x2000000000-0x20000fffff 64bit pref]
[    3.862330] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    3.862349] pci_bus 0000:04: resource 1 [mem 0x60300000-0x603fffff]
[    3.862368] pci_bus 0000:04: resource 2 [mem 
0x2000100000-0x20001fffff 64bit pref]
[    3.862391] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    3.862410] pci_bus 0000:05: resource 1 [mem 0x60400000-0x604fffff]
[    3.862430] pci_bus 0000:05: resource 2 [mem 
0x2000200000-0x20002fffff 64bit pref]
[    3.862453] pci_bus 0000:06: resource 0 [io  0x4000-0x4fff]
[    3.862472] pci_bus 0000:06: resource 1 [mem 0x60500000-0x605fffff]
[    3.862492] pci_bus 0000:06: resource 2 [mem 
0x2000300000-0x20003fffff 64bit pref]
[    3.862514] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    3.862533] pci_bus 0000:07: resource 1 [mem 0x60600000-0x606fffff]
[    3.862553] pci_bus 0000:07: resource 2 [mem 
0x2000400000-0x20004fffff 64bit pref]
[    3.863320] pcieport 0000:00:00.0: PME: Signaling with IRQ 36
[    3.864092] pcieport 0000:00:00.0: AER: enabled with IRQ 36
[    3.864563] pcieport 0000:01:00.0: enabling device (0000 -> 0003)
[    3.864769] pcieport 0000:02:00.0: enabling device (0000 -> 0003)
[    3.865381] pcieport 0000:02:02.0: enabling device (0000 -> 0003)
[    3.866107] pcieport 0000:02:03.0: enabling device (0000 -> 0003)
[    3.866669] pcieport 0000:02:04.0: enabling device (0000 -> 0003)
[    3.867371] pcieport 0000:02:08.0: enabling device (0000 -> 0003)
[    3.867885] pci 0000:04:00.0: enabling device (0000 -> 0002)


