Return-Path: <linux-pci+bounces-26062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466DCA914BF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E1E3A3CC6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034192153CD;
	Thu, 17 Apr 2025 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bru4i23k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D81DE2DB;
	Thu, 17 Apr 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873762; cv=none; b=aUl9zOWPKn7l95o3FTPloT1oQe+Urv2iLK0Y9XshSpW2gkurfQqeQTKmJX2I1eVE0G4Ww11iLB+SLsJS7VnVUIOaTH7etphcA7lqSOWy1hglXyLZXtuscrLpCBrYrsLcnu0gO9B5VK4ubkdIYuHDGoZbrlCcsgmfv9zk8EJV9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873762; c=relaxed/simple;
	bh=/wchmnTtakq0AAgyIzoT2V5RCudJ4GFGi6XXxMMU6GM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XTzjTzgz5e5Oy3yWOe+K2QFLUdmnE9nFMY8tSQ5ymwPDw6NwWV0L2CX1M6Ld1jejW3C4JMig4F28Nki+zd5RyC9/a9nAjLyhrHtPPCx8Sl6B5U31vPCVfuwCL0kTwKwwiV/+WuxYld8v8oNNxpTS9YBUCE3KQCK4Qg/1ydi7RiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Bru4i23k; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1232f7211;
	Thu, 17 Apr 2025 15:09:09 +0800 (GMT+08:00)
Message-ID: <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
Date: Thu, 17 Apr 2025 15:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aACoEpueUHBLjgbb@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1PS1YdTh9MTR0YHxlPHR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9642947cc309cckunm1232f7211
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6Dgw6LTJWGhBPTThCVige
	SEhPCxdVSlVKTE9PQ0xITE5KSE5CVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDSE03Bg++
DKIM-Signature:a=rsa-sha256;
	b=Bru4i23kQYP97Nux3LeWYaNmKGGkZOkOZHQ0UKzubnL1kmVrx40dZe9StL44MeqBGjDHQsj/p2arOdsfDLIMDj7XsnYJaSq8EMu/yUacpIEFeqa5MGha3wpPB1oztmJIUtu4dZy5cnd8M4RGAKe/Stpn69AXKrNpf617Id0ZB04=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NhjvZ2JRR5EyoY0B1vtxKVPb3zuD+k++ITAMYs8q1PE=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/17 星期四 15:04, Niklas Cassel 写道:
> Hello Hans,
> 
> On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
>> The RK3588's PCIe controller defaults to a 128-byte max payload size,
>> but its hardware capability actually supports 256 bytes. This results
>> in suboptimal performance with devices that support larger payloads.
> 
> Patch looks good to me, but please always reference the TRM when you can.
> 
> Before this patch:
> 		DevCap: MaxPayload 256 bytes
> 		DevCtl: MaxPayload 128 bytes
> 
> 
> As per rk3588 TRM, section "11.4.3.8 DSP_PCIE_CAP Detail Registers Description"
> 
> DevCap is per the register description of DSP_PCIE_CAP_DEVICE_CAPABILITIES_REG,
> field PCIE_CAP_MAX_PAYLOAD_SIZE.
> Which claims that the value after reset is 0x1 (256B).
> 
> DevCtl is per the register description of
> DSP_PCIE_CAP_DEVICE_CONTROL_DEVICE_STATUS, field PCIE_CAP_MAX_PAYLOAD_SIZE_CS.
> Which claims that the reset value is 0x0 (128B).
> 
> Both of these match the values above.
> 
> As per the description of PCIE_CAP_MAX_PAYLOAD_SIZE_CS:
> "Permissible values that
> can be programmed are indicated by the Max_Payload_Size
> Supported field (PCIE_CAP_MAX_PAYLOAD_SIZE) in the Device
> Capabilities (DEVICE_CAPABILITIES_REG) register (for more
> details, see section 7.5.3.3 of PCI Express Base Specification)."
> 
> So your patch looks good.
> 
> I guess I'm mostly surprised that the e.g. pci_configure_mps() does not
> already set DevCtl to the max(DevCap.MPS of the host, DevCap.MPS of the
> endpoint).
> 
> Apparently pci_configure_mps() only decreases MPS from the reset values?
> It never increases it?
> 

Actually it does:

https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L4757

> 
> Kind regards,
> Niklas
> 
> 

