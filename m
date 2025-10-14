Return-Path: <linux-pci+bounces-38097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73799BDBAB1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0343E32B4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67E2405FD;
	Tue, 14 Oct 2025 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="i6D/lyue"
X-Original-To: linux-pci@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4782EB87B
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481711; cv=none; b=E0r0Hrmjnf4TvM1wctY6gT1fRX7lDAreYOBflxseE28H58Ael5nPlCC6tNv8WnqXSBDAuYtaqbPfUjtvnRfYKkUCQ711Ci+wuDkYgIzWvjWkJTaY21SorhBn7Pnw8Ft6YY5/xaqgCX+7GxojEwd0sRYqqo2XJYevrLk+fUD6EXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481711; c=relaxed/simple;
	bh=MbRQFribj+5STwgaWMFF3WBwk/TcGInw+Ndx6s4fwT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSUSno+9LH3CIhMkNW1UBE4UdiRq+sD/zX6iNk5kalF9TroGzXpXQiJciJLpLGkXlb2SzX1Xvrva7FIoul+2tgOLkB+AmUrvRnC618jMkH+ucpeah5qnewWwvQ6OXFwDhqBbzBzeEWToo/yqL+t4CBPZR0fDAt/10/2DA8Jhrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=i6D/lyue; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 8kFgvDdIVjzfw8niBvNQEm; Tue, 14 Oct 2025 22:41:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8ni9vdilHHyqZ8niAvezW5; Tue, 14 Oct 2025 22:41:42 +0000
X-Authority-Analysis: v=2.4 cv=G4EcE8k5 c=1 sm=1 tr=0 ts=68eed1a6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=HaFmDPmJAAAA:8
 a=vM3gs7XVnYeaolmWJR8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1h7AsFu1o7hpH/VvaWjvJ1mc5DROWm0EZY2CZM9c6zk=; b=i6D/lyueiejs9mWI6IaG7hUb+J
	2faXEfA4RxC6kvu0ivMYfsr+3oxGVfXG6GQ5bGQF0CgA7ui0oiT1DI+Ufd5vshTByeRDqiliatBq5
	/YcaiOoilHu0W9qKrpui1ePxqTNdKFkxF3tG6Ker2Nwo2EwbSRrBKAmrKNCWdx5eiafV7y4ebuSgW
	hAULpIqQIa65mKFINvYwVR8HpIiDZHPO+cv/ehYAp0JbUaDRTe9Hei3zu8FqSPWEO/gS42GYANZQO
	NA4srgXt2rmNCNKdq/rei3UnBCf9KtLzrF+LY5OXZLXugyP1SKoPTx52MfM6ESp0ZGp8ruY9lRtPd
	IeWNzTag==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:53688 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8ni9-00000000nz7-3GFL;
	Tue, 14 Oct 2025 16:41:41 -0600
Message-ID: <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>
Date: Tue, 14 Oct 2025 15:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>,
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
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <yxdwo4hppd7c7lrv5pybjtu22aqh3lbk34qxdxmkubgwukvgwq@i4i45fdgm6sw>
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
X-Exim-ID: 1v8ni9-00000000nz7-3GFL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:53688
X-Source-Auth: re@w6rz.net
X-Email-Count: 7
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCe9X6CG7sjBdHStbASL99EAtk4I54u620BGgYBe9xos5HLqR3A0Ju/dP6Yrop3cAqLqbkqRuCQqDdjq9ZbwfQjH73DgeOSbG1y1tPvz6fnggUTQWKOl
 tWd0zu3sCjCnKhcrDbZt8SBO+qS8oMfrhkgvGkUh+yC2kIA3J1mVJgnEFfY5DWlkXHEicf0E5h8zd1PBuH0tKAOF44Cmk0C7ycw=

On 10/14/25 09:25, Manivannan Sadhasivam wrote:
> On Mon, Oct 13, 2025 at 10:52:48PM -0700, Ron Economos wrote:
>> On 10/13/25 22:36, Krishna Chaitanya Chundru wrote:
>>>
>>> On 10/14/2025 10:56 AM, Ron Economos wrote:
>>>> On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
>>>>>
>>>>> On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
>>>>>> [+cc FU740 driver folks, Conor, regressions]
>>>>>>
>>>>>> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>>>>>>> The SiFive FU740 PCI driver fails on the HiFive
>>>>>>> Unmatched board with Linux
>>>>>>> 6.18-rc1. The error message is:
>>>>>>>
>>>>>>> [    3.166624] fu740-pcie e00000000.pcie: host bridge
>>>>>>> /soc/pcie@e00000000
>>>>>>> ranges:
>>>>>>> [    3.166706] fu740-pcie e00000000.pcie:       IO
>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>> [    3.166767] fu740-pcie e00000000.pcie:      MEM
>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>> [    3.166805] fu740-pcie e00000000.pcie:      MEM
>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>>>>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>>>>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>>>>>>> [    3.579552] fu740-pcie e00000000.pcie: Failed to
>>>>>>> configure iATU in ECAM
>>>>>>> mode
>>>>>>> [    3.579655] fu740-pcie e00000000.pcie: probe with
>>>>>>> driver fu740-pcie
>>>>>>> failed with error -22
>>>>>>>
>>>>>>> The normal message (on Linux 6.17.2) is:
>>>>>>>
>>>>>>> [    3.381487] fu740-pcie e00000000.pcie: host bridge
>>>>>>> /soc/pcie@e00000000
>>>>>>> ranges:
>>>>>>> [    3.381584] fu740-pcie e00000000.pcie:       IO
>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>> [    3.381682] fu740-pcie e00000000.pcie:      MEM
>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>> [    3.381724] fu740-pcie e00000000.pcie:      MEM
>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll
>>>>>>> T, 8 ob, 8 ib, align
>>>>>>> 4K, limit 4096G
>>>>>>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>>>>>>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>> [    3.988164] fu740-pcie e00000000.pcie: PCI host
>>>>>>> bridge to bus 0000:00
>>>>>>>
>>>>>>> Reverting the following commits solves the issue.
>>>>>>>
>>>>>>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc:
>>>>>>> Support ECAM mechanism by
>>>>>>> enabling iATU 'CFG Shift Feature'
>>>>>>>
>>>>>>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom:
>>>>>>> Prepare for the DWC ECAM
>>>>>>> enablement
>>>>>>>
>>>>>>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc:
>>>>>>> Prepare the driver for
>>>>>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
>>>>>> As Conor pointed out, we can't fix a code regression with a DT change.
>>>>>>
>>>>>> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the
>>>>>> driver for enabling ECAM mechanism using iATU 'CFG Shift
>>>>>> Feature'")
>>>>> Hi Conor,
>>>>>
>>>>> Can you try with this patch and see if it is fixing the issue.
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>> b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>> index 66367252032b..b5e0f016a580 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct
>>>>> platform_device *pdev)
>>>>>
>>>>>          platform_set_drvdata(pdev, afp);
>>>>>
>>>>> +       pci->pp.native_ecam = true;
>>>>> +
>>>>>          return dw_pcie_host_init(&pci->pp);
>>>>>   }
>>>>>
>>>>> - Krishna Chaitanya.
>>>>>
>>>> I've already tried it. It doesn't work. Same error message as before.
>>> Can you share us dmesg logs for this change.
>>>
>>> - Krishna Chaitanya.
>> [    3.159763] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
>> ranges:
>> [    3.159853] fu740-pcie e00000000.pcie:       IO
>> 0x0060080000..0x006008ffff -> 0x0060080000
>> [    3.159916] fu740-pcie e00000000.pcie:      MEM
>> 0x0060090000..0x007fffffff -> 0x0060090000
>> [    3.159953] fu740-pcie e00000000.pcie:      MEM
>> 0x2000000000..0x3fffffffff -> 0x2000000000
>> [    3.160039] fu740-pcie e00000000.pcie: ECAM at [mem
>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>> [    3.571421] fu740-pcie e00000000.pcie: No iATU regions found
>> [    3.571472] fu740-pcie e00000000.pcie: Failed to configure iATU in ECAM
>> mode
>> [    3.571529] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
>> failed with error -22
>>
>> Same as before the change. The entire log is here:
>>
>> https://www.w6rz.net/dmesg.txt
>>
> Weird that the driver still creates ECAM even after skipping it using the flag.
> The flag is not meant for that purpose, but it should've worked anyway.
>
> Can you try this diff and share the dmesg log?
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..58080928df9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -523,8 +523,12 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>          pp->cfg0_size = resource_size(res);
>          pp->cfg0_base = res->start;
>
> +       dev_info(dev, "%s: %d native_ecam: %d", __func__, __LINE__,
> +pp->native_ecam);
> +
>          pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
>          if (pp->ecam_enabled) {
> +               dev_info(dev, "%s: %d ECAM ENABLED", __func__, __LINE__);
>                  ret = dw_pcie_create_ecam_window(pp, res);
>                  if (ret)
>                          return ret;
> @@ -533,6 +537,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>                  pp->bridge->sysdata = pp->cfg;
>                  pp->cfg->priv = pp;
>          } else {
> +               dev_info(dev, "%s: %d ECAM DISABLED", __func__, __LINE__);
>                  pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>                  if (IS_ERR(pp->va_cfg0_base))
>                          return PTR_ERR(pp->va_cfg0_base);
>
> - Mani
>
After testing with this patch, I must have transferred the wrong image 
to the target when testing before. The "pci->pp.native_ecam = true;" 
patch to pcie-fu740.c does work. Here's the message with the debug prints:

[    3.227746] fu740-pcie e00000000.pcie: host bridge 
/soc/pcie@e00000000 ranges:
[    3.227833] fu740-pcie e00000000.pcie:       IO 
0x0060080000..0x006008ffff -> 0x0060080000
[    3.227896] fu740-pcie e00000000.pcie:      MEM 
0x0060090000..0x007fffffff -> 0x0060090000
[    3.227934] fu740-pcie e00000000.pcie:      MEM 
0x2000000000..0x3fffffffff -> 0x2000000000
[    3.227993] fu740-pcie e00000000.pcie: dw_pcie_host_get_resources: 
526 native_ecam: 1
[    3.228019] fu740-pcie e00000000.pcie: dw_pcie_host_get_resources: 
539 ECAM DISABLED
[    3.331449] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, 
align 4K, limit 4096G
[    3.531131] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
[    3.731132] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.835131] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
[    3.835465] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00


