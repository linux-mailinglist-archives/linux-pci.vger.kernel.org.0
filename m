Return-Path: <linux-pci+bounces-26154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B705CA92ECC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 02:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAE14A0B21
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEC250EC;
	Fri, 18 Apr 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="A37u9bG/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4A442C
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936094; cv=none; b=Wq6YtNr2X63hieI+lHUB2Vxw4Mv/4rXT8RL/6iDL7lCqcaGm2c0SsCJVAXmbR3aQJQt0VPNdZXcHkRY5sT10gQBnD+V2Q6+ew/nZsKbDKREMLJpYpGwPdlJ3ruwddpjrTAjA8vdWvmXxFOait+R+58nKEZMy4JaomhlFHZ/Wd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936094; c=relaxed/simple;
	bh=SR08pTySedTwHd4a68w4MghDWMIDE6AHd/eHkhysxKI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h3v5moUINyS7errVVZ60aPm/qCh7kUG7VZsSLM/uuGDfnB2rexHFbYGZDgqMXo+IGkclIlViAgqQeY4r9hF0qr46Yu7uy3AEyetU13JL2PGK80UWKtDjGwYeRK/JcTH7isOwkSmVwabd3WiPc+7sqYgBQIcSQ2CfU1bFcbSC6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=A37u9bG/; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12470582a;
	Fri, 18 Apr 2025 08:28:01 +0800 (GMT+08:00)
Message-ID: <6490464f-c47a-9a63-e0a1-251d52781c9d@rock-chips.com>
Date: Fri, 18 Apr 2025 08:27:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
To: Niklas Cassel <cassel@kernel.org>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_5aib0WGKfIANj_@ryzen> <aADdI7ByEImYy3Pq@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aADdI7ByEImYy3Pq@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0ZHlZMTh4ZT05JS0lPQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96464b971d09cckunm12470582a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6CDo5DTJWQxUBMwECSDxO
	PikaCwpVSlVKTE9PQkhNS0NJSk9OVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpCSE43Bg++
DKIM-Signature:a=rsa-sha256;
	b=A37u9bG/VQcfB92CcXbjvVDg9qcerAsemNk2u76dK1k/Cc/rhyPel3uz/UP/x69T25x14uR1XQAPzbxxg/sTq2g2b6jpaDk4l2DMxBZu/wZQYH3Be+CVAuJS3NlAtNBi6+BeyIcBC6asK9YHKnC3hNSCRNgZqHboZ/6th+MA5pU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Jt8fEUVQruj1fDLANC6RjIVA6yS/VPpH2zThqfqOuxA=;
	h=date:mime-version:subject:message-id:from;

Hi Niklas

在 2025/04/17 星期四 18:51, Niklas Cassel 写道:
> On Tue, Apr 15, 2025 at 03:09:29PM +0200, Niklas Cassel wrote:
>> On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:
> 
> (snip)
> 
>>> +
>>> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
>>
>> Here you are setting PCIE_CLIENT_RC_MODE unconditionally.
>>
>> I really don't think that you have tested these callbacks with EP mode.
>>
>> If we look at pcie-qcom.c and pcie-qcom-ep.c, dev_pm_ops is defined in
>> pcie-qcom.c, but not in pcie-qcom-ep.c.
>>
>> Perhaps it is starting to be time to have two separate drivers also for
>> rockchip?
> 
> Hmm.. looking at pcie-tegra194.c, they do still have both RC and EP in the
> same file, but they simply return -ENOTSUPP in the EP case:
> https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/controller/dwc/pcie-tegra194.c#L2381-L2384
> 
> Perhaps you could do something similar?

I'll look into it. Thanks for providing this useful hint.

> 
> 
> Kind regards,
> Niklas
> 
> 

