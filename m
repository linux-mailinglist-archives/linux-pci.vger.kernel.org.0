Return-Path: <linux-pci+bounces-25549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A683A8212B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4305B7AC097
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC526ACD;
	Wed,  9 Apr 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Tx60nnQz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com [220.197.32.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A125D205
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191733; cv=none; b=GY30JAhzJeT+D3Kel6A81mIfsM/J9Dz7qUX6ZGp+adR+vln5LX3ktygaYrJe2ffR9inc+6q0AYimWUZ3BFIohb+7AWaz1KedZQ+hQqIoVU2taRMDSMnwQo3Xjjj42C2P4XXUHcbQlRuxUhmO1bg2WmLM0JYC96ZnKqL1SkQrPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191733; c=relaxed/simple;
	bh=YCdhEm03gQlB/w92JRWNNtoOkeaIhPH5JKi95suvFFM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ChlTLr071TOoDGjgcY4RgwWELSLkD8lZHAx7GOzFjAIBVkJ92qOiGUvq5HjrVG07WWTDTZASCBjgsSbaI2HWjkK22BSlqvnExEZVPS4lO7eFjkp5sn+N4MOvgJDHGJkbWd+yq5HWYBcXFFaGZdw3aGaOsMFtjqKxx5MRPXhgmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Tx60nnQz; arc=none smtp.client-ip=220.197.32.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 113968543;
	Wed, 9 Apr 2025 17:41:59 +0800 (GMT+08:00)
Message-ID: <79e65678-d6e3-0336-8052-a8d593a4efb9@rock-chips.com>
Date: Wed, 9 Apr 2025 17:41:42 +0800
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
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
To: Niklas Cassel <cassel@kernel.org>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
 <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
 <Z_Y7h1vzVCCEiXK6@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <Z_Y7h1vzVCCEiXK6@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4aGlZDS0NJHUoaTB4eTB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9619ed896009cckunm113968543
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6GQw4STJRGjwUPRUoTgMB
	CD4KCiJVSlVKTE9PSkJKTElLTENMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhDSEg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Tx60nnQz0SaucqyI97KnjZcXQful9pI9IorFsSozH0sVFJF+eXla9q12Nwi4KuIRdinWLezvoDNec1dLmzKc6bVUKK8N7RfyKDvQqd/0wKRUEZAwN+lMktTvcqd3w4brlNrgGzXyv+LWrrcJDhRev+1HuiTs4BcMDrg/OVH2O2A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=L+som5XFBFne47xQFx0pWlnLjpeop6UnENj8Zo2lS6c=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/09 星期三 17:19, Niklas Cassel 写道:
> Hello Shawn,
> 
> On Wed, Apr 09, 2025 at 05:09:38PM +0800, Shawn Lin wrote:
>> 在 2025/04/09 星期三 16:30, Niklas Cassel 写道:
>>> On Wed, Apr 09, 2025 at 02:40:33PM +0800, Shawn Lin wrote:
>>>
>>> Is there any advantage of using a rockchip specific way to read link up,
>>> rather than just reading link up via the DWC PCIE_PORT_DEBUG1 register?
>>
>> This is a very good question which we tried but made real products
>> suffer from it for a long time, and finally we found the reason and
>> discarded it.
>>
>> Quoted from DWC databook, section 8.2.3 AXI Bridge Initialization,
>> Clocking and Reset:
>>
>> "In RC Mode, your AXI application must not generate any MEM or I/O
>> requests, until the host software has enabled the Memory Space Enable
>> (MSE), and IO Space Enable (ISE) bits respectively. Your RC application
>> should not generate CFG requests until it has confirmed that the link is
>> up by sampling the smlh_link_up and rdlh_link_up outputs."
>>
>> Quoted from DWC databook, section 5.50 SII: Debug Signals
>> "[36]: smlh_link_up: LTSSM reports PHY link up or LTSSM is in
>> Loopback.Active for Loopback Master" which refers to
>> PCIE_PORT_DEBUG1_LINK_UP per code.
>>
>> The timing in dwc core is drving smlh_link_up->L0->rdlh_link_up->FC
>> init(a fixed delay) from IC simulation when linking up.
>>
>> The dw_pcie_link_up() wasn't reliably work as expected by massive test.
>> The problem is clear from our ASIC view, that cxpl_debug_info from DWC
>> core is missing rdlh_link_up. cxpl_debug_info[32:63] is indentical to
>> PCIE_PORT_DEBUG1, So reading PCIE_PORT_DEBUG1 and check
>> smlh_link_up isn't enough.
>>
>> The problem was introduced by commit 1 and fixed by commit 2 but not to
>> the end. And finally commit 3 rename the register but not fix anything.
>>
>> It was broken from the first time. Any dwc controllers should not be use
>> the buggy default method to check link up state from our view.
>> So this's the whole story for it, which may help you understand the
>> indeed problem and why we reinvent rockchip_pcie_link_up() here.
>>
>> [1]. commit dac29e6c5460 ("PCI: designware: Add default link up check if
>>      sub-driver doesn't override")
>>
>> [2]. commit 01c076732e82 ("PCI: designware: Check LTSSM training bit
>>      before deciding link is up")
>>
>> [3]. commit 60ef4b072ba0 ("PCI: dwc: imx6: Share PHY debug register
>>      definitions")
> 
> Thank you for the detailed answer.
> 
> It seems like we should really add a warning and a comment in
> dw_pcie_link_up(), so that others don't get hit by this hard to debug issue!
> 
> (Especially since dw_pcie_link_up() was added by someone with a @synopsys.com
> email).
> 

Yep, will do it with another patch.

> 
> Kind regards,
> Niklas
> 

