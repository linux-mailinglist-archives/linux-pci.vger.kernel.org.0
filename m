Return-Path: <linux-pci+bounces-31995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156FB02BCF
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0403A9BBB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AD273D7F;
	Sat, 12 Jul 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S+j6qs76"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC31F1906;
	Sat, 12 Jul 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752336401; cv=none; b=FDJHd2cJAy6WfvXwt+azAy6qyFlStFjajXIMTPblbD6NzfD2aPMB8SJpHxDwwJqLvZEPKfJ6xUAlHpGsd6EYJMakJ7J0EmQymgaAR4fDjhUT4a8IS/yNjrcPrqyJQOHgapmNC5jCRCEqw4ykRSex0SCPdWo4UougPPxqI44Wn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752336401; c=relaxed/simple;
	bh=8QMnezUr6RcxdJ1mE8flllbSLTsIaWjyZOkrmVf3mMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNndaR2cidav9kuNPuCa2zsynIqtDEzI7xYzBVrUuldiF/ry9HuV7OXkbLdFd6iYzP72shTsaa2vZRdlgZtOYD7P3G4bqE4YXLPw97QWQcKP76uBElenxFvZD5FGXtNChhO+NAcTYADz1DsxPmloXSeg3iiBLKYGXRmueF4+Qns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S+j6qs76; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yFk0YyJvli1XN+U/jjkn0xB8ubUiOgd+hURsOqBNf9A=;
	b=S+j6qs763V46bHzoyxwgydQT5N0u4ktlfIpn1OKSgRh5nwt7hFgfhQQleZ64pn
	mdWlwlSBdXqDssSuyxqXbTVW/VBnwirbYVaOu1b+bgbFd0K7ZnRCeQZx0xesnmns
	Fg1C8l2sQsnxjonA9XQ2BThELeyWA4v9Mpuq3YDgtN8ME=
Received: from [IPV6:240e:b8f:919b:3100:7981:39b4:a847:709a] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHkby7h3JoR4ilAA--.23899S2;
	Sun, 13 Jul 2025 00:05:17 +0800 (CST)
Message-ID: <470742a6-861e-498e-9da4-1fa213969c7e@163.com>
Date: Sun, 13 Jul 2025 00:05:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgCHkby7h3JoR4ilAA--.23899S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1ftFy5uw13Zr43KF1kuFg_yoW8uFW8pF
	Wrtr9aka1kAF97Cw12yw1UJFyFyw4SyryYk348Xw1UAF45uasrGr4UtrWruF9xXrWxWw4Y
	vr4jgF1Dua4q9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiZ2-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwuIo2hyg6ZSywAAsd



On 2025/7/12 17:35, Manivannan Sadhasivam wrote:
>> We only have two callers of this (pcie-qcom.c and vmd.c, both in
>> drivers/pci/), so it's not clear to me that it needs to be in
>> include/linux/pci.h.
>>
>> I'm a little dubious about it in the first place since I don't think
>> drivers should be enabling ASPM states on their own, but pcie-qcom.c
>> and vmd.c are PCIe controller drivers, not PCI device drivers, so I
>> guess we can live with them for now.
>>
>> IMO the "someday" goal should be that we get rid of aspm_policy and
>> enable all the available power saving states by default.  We have
>> sysfs knobs that administrators can use if necessary, and drivers or
>> quirks can disable states if they need to work around hardware
>> defects.
>>
> 
> Yeah, I think the default should be powersave and let the users disable it for
> performance if they want.
> 

Dear Bjorn and Mani,

Perhaps I don't think so. At present, our company's testing team has 
tested quite a few NVMe SSDS. As far as I can remember, the SSDS from 
two companies have encountered problems and will hang directly when 
turned on. We have set CONFIG_PCIEASPM_POWERSAVE=y by default. When 
encountering SSDS from these two companies, we had to add 
"pcie_aspm.policy=default" in the cmdline, and then the boot worked 
normally. Currently, we do not have a PCIe protocol analyzer to analyze 
such issues. The current approach is to modify the cmdline. So I can't 
prove whether it's a problem with the Root Port of our SOC or the SSD 
device.

Here I agree with Bjorn's statement that sometimes the EP is not 
necessarily very standard and there are no hardware issues. Personally, 
I think the default is default or performance. When users need to save 
power, they should then decide whether to configure it as powersave or 
powersupersave. Sometimes, if the EP device connected by the customer is 
perfect, they can turn it on to save power. But if the EP is not 
perfect, at least they will immediately know what caused the problem.

I wonder if there are others who have encountered similar problems as 
well. If I say anything wrong, please point it out. Thank you.

Best regards,
Hans


