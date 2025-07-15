Return-Path: <linux-pci+bounces-32165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A95B06243
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3853A58438A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465E1E9B35;
	Tue, 15 Jul 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nehBQBhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575161DF26B;
	Tue, 15 Jul 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591335; cv=none; b=KsGY/onODa4v7rNmK5Q/IcF3gEwvOV0ztEiN1/fcpvbijM5PRHhpi79O0sVXeAgHK8SZbvcbhLpcySPRA+2igByxtv22diEYtMtpLrP++Voccgo7Wnx+0t03+Lbsw2/hB9MdzE/kRds7+LvurfVs3hGsO3F5zyOPN3x3EHTn61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591335; c=relaxed/simple;
	bh=txUfSwjyOVKeDzlPKIBEVTgZb3j/w8eAWl4cWJAms9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI4p0iJixg0K5HIc9P/EeBuu5GdBGWmm6PAcvh66hx6zBBvjXTPxKXOq7BHwyM302YYX8inJi51+MHAOZ50RqEipwmoQ+NtU32q+RITWqYuABOcZ8CGESdsOC4n0mJ/5xtHI44HPZZVY5yCwM654A+dgdgTqxIufmWAWvJOn35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nehBQBhg; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=SP7dE1bKFm+Zk1R9d8gy12/jTWzAHbDIeWSSV5I0Ffw=;
	b=nehBQBhggmGzsVClzFYyo3YKVar9NmcrCXQKH8/hXqk5TfLczz5c1ul8b+/3Md
	Gi6wgadAcqQOQ3nTTgkOj1J6DmC5lmBoBBWwQ4MzVcGoj70yWjogVitdw/yXdeiT
	W/lcliVaXiL2IhxP/n8ycjonrgMtKRzJdTYd4i0BLSrKk=
Received: from [IPV6:240e:b8f:919b:3100:7981:39b4:a847:709a] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHnzWFa3ZoCeijFA--.44532S2;
	Tue, 15 Jul 2025 22:53:58 +0800 (CST)
Message-ID: <64e0809b-b931-4820-8f61-377db0dbfc49@163.com>
Date: Tue, 15 Jul 2025 22:53:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
 quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com>
 <20250711230013.GA2309106@bhelgaas>
 <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
 <470742a6-861e-498e-9da4-1fa213969c7e@163.com>
 <drj7qm65bfu7irnfyy2cfhzkqlrkvd2tuvlxrlpxyohhpjbs3x@ecgooujjynmx>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <drj7qm65bfu7irnfyy2cfhzkqlrkvd2tuvlxrlpxyohhpjbs3x@ecgooujjynmx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHnzWFa3ZoCeijFA--.44532S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWrZw1kuF45Gr4rZFykGrg_yoW5Gr43pF
	WFyFySka1kArn7Cw12qw1UJFyYyw4Syry5W34Fqw1UAFs093s7Jr47trWruF9xWr4xZw1j
	vrWYgF9rXFyq9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UizVbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwOLo2h2Y3mlqwAAsi



On 2025/7/13 01:02, Manivannan Sadhasivam wrote:
> On Sun, Jul 13, 2025 at 12:05:18AM GMT, Hans Zhang wrote:
>>
>>
>> On 2025/7/12 17:35, Manivannan Sadhasivam wrote:
>>>> We only have two callers of this (pcie-qcom.c and vmd.c, both in
>>>> drivers/pci/), so it's not clear to me that it needs to be in
>>>> include/linux/pci.h.
>>>>
>>>> I'm a little dubious about it in the first place since I don't think
>>>> drivers should be enabling ASPM states on their own, but pcie-qcom.c
>>>> and vmd.c are PCIe controller drivers, not PCI device drivers, so I
>>>> guess we can live with them for now.
>>>>
>>>> IMO the "someday" goal should be that we get rid of aspm_policy and
>>>> enable all the available power saving states by default.  We have
>>>> sysfs knobs that administrators can use if necessary, and drivers or
>>>> quirks can disable states if they need to work around hardware
>>>> defects.
>>>>
>>>
>>> Yeah, I think the default should be powersave and let the users disable it for
>>> performance if they want.
>>>
>>
>> Dear Bjorn and Mani,
>>
>> Perhaps I don't think so. At present, our company's testing team has tested
>> quite a few NVMe SSDS. As far as I can remember, the SSDS from two companies
>> have encountered problems and will hang directly when turned on. We have set
>> CONFIG_PCIEASPM_POWERSAVE=y by default. When encountering SSDS from these
>> two companies, we had to add "pcie_aspm.policy=default" in the cmdline, and
>> then the boot worked normally. Currently, we do not have a PCIe protocol
>> analyzer to analyze such issues. The current approach is to modify the
>> cmdline. So I can't prove whether it's a problem with the Root Port of our
>> SOC or the SSD device.
>>
>> Here I agree with Bjorn's statement that sometimes the EP is not necessarily
>> very standard and there are no hardware issues. Personally, I think the
>> default is default or performance. When users need to save power, they
>> should then decide whether to configure it as powersave or powersupersave.
>> Sometimes, if the EP device connected by the customer is perfect, they can
>> turn it on to save power. But if the EP is not perfect, at least they will
>> immediately know what caused the problem.
>>
> 
> We all agree that not all endpoints are standards compliant. So if they have any
> issues with ASPM, then ASPM for those devices should be disabled in the quirks
> or in the device driver.
> 
> That said, the change that Bjorn proposed is not going to happen in the
> immediate future.

Dear Mani,

Ok, I will keep an eye on the changes of ASPM.

Best regards,
Hans


