Return-Path: <linux-pci+bounces-41843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401AC77392
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 05:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2F5B354E45
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 04:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D42E5406;
	Fri, 21 Nov 2025 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NLRP+FfG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com [220.197.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7192E22A3;
	Fri, 21 Nov 2025 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697864; cv=none; b=V+F8KZBKR9D3Agu1bHboDYllhBnbjdMtKYtBwbmk4TXL03ArWWtsNlgXmD8jtCrty9N6zGcB6VxjmqksrLYcyTmuR+Z7taWZb6luwRmXcJLc77wFb8Z/eJwi2C4x70PSW16iPdaL6Mke4kB5goBIq9+wY6BWgLc5DiiQGva7HIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697864; c=relaxed/simple;
	bh=tmUIUwjh6ag5V89Vb8YKaOYNZPTJjeo/iR8DA6yyJwg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C5LhUcuF1UCRVHMaVlH7d10vLAXEgOv166iiaxg9WsYSi2ZeQ9onJxhtmQy3fYKDHLVGc+M0iXa6n1YspDgry0ZUMzCNc0enTxNOUva/JjaAAR35e0BgSDjIkffEJLa7VsTUbsB5L5Tw3X5X5EWnHCSELJ/u8yt6sB9uLG6X9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NLRP+FfG; arc=none smtp.client-ip=220.197.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a5fd61a0;
	Fri, 21 Nov 2025 12:04:10 +0800 (GMT+08:00)
Message-ID: <3ac0d6c5-0c49-45fd-b855-d9b040249096@rock-chips.com>
Date: Fri, 21 Nov 2025 12:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
To: Manivannan Sadhasivam <mani@kernel.org>,
 Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
 <dc8fb64e-fcb1-4070-9565-9b4c014a548f@rock-chips.com>
 <7d4xj3tguhf6yodhhwnsqp5s4gvxxtmrovzwhzhrvozhkidod7@j4w2nexd5je2>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <7d4xj3tguhf6yodhhwnsqp5s4gvxxtmrovzwhzhrvozhkidod7@j4w2nexd5je2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa495795209cckunm2f5a53171e2124
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhoZSlZNTBhCTEJMThofSx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NLRP+FfGPFDcV/Y95SK5E1FUM13AbVYyiKgoPswjmtubPkpZfutOq0POaLWppVmVg+tZqziRndFXti0bsKW5L7q3iUj+53wvSRbvgnVa7KPfLJIgbI26THgaoQ3XbZqmqCz15TLFGtkH7BhQ7mpdCMbbR09RZ7fqQhOO+f1WyTk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=eHPus6e6hJ+s0s7cPd4uBhaHj4ISkRUaslMlAd6Xo10=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/21 星期五 1:00, Manivannan Sadhasivam 写道:
> On Thu, Nov 20, 2025 at 10:06:03PM +0800, Shawn Lin wrote:
>> 在 2025/11/10 星期一 14:59, Qiang Yu 写道:
>>> Some platforms may not support ITS (Interrupt Translation Service) and
>>> MBI (Message Based Interrupt), or there are not enough available empty SPI
>>> lines for MBI, in which case the msi-map and msi-parent property will not
>>> be provided in device tree node. For those cases, the DWC PCIe driver
>>> defaults to using the iMSI-RX module as MSI controller. However, due to
>>> DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
>>> when MSI is properly configured and supported as iMSI-RX will only monitor
>>> and intercept incoming MSI TLPs from PCIe link, but the memory write
>>> generated by Root Port are internal system bus transactions instead of
>>> PCIe TLPs, so they are ignored.
>>>
>>> This leads to interrupts such as PME, AER from the Root Port not received
>>
>> This's true which also stops Rockchip's dwc IP from working with AER
>> service. But my platform can't work with AER service even with ITS support.
>>
>>> on the host and the users have to resort to workarounds such as passing
>>> "pcie_pme=nomsi" cmdline parameter.
>>
>> ack.
>>
>>>
>>> To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
>>> from Root Ports when using iMSI-RX as MSI controller, which is indicated
>>> by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
>>> eliminating the need for manual kernel command line workarounds.
>>>
>>> With this behavior:
>>> - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
>>>     components.
>>> - Platforms without ITS/MBI support fall back to INTx for Root Ports and
>>>     use iMSI-RX for other PCI devices.
>>>
>>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>>    	dw_pcie_dbi_ro_wr_dis(pci);
>>> +	/*
>>> +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
>>> +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
>>> +	 * interrupt handling.
>>> +	 */
>>> +	if (pp->has_msi_ctrl) {
>>
>> Isn't has_msi_ctrl means you have something like GIC-ITS
>> support instead of iMSI module? Am I missing anything?
>>
> 
> It is the other way around. Presence of this flag means, iMSI-RX is used. But I
> think the driver should clear the CAPs irrespective of this flag.

Thanks for correcting me. Yeap, how can I make such a mistake. :(

Anyway, this patch works for me:

root@debian:/userdata# ./aer-inject aer.txt
[   17.764272] pcieport 0000:00:00.0: aer_inject: Injecting errors 
00000040/00000000 into device 0000:01:00.0
[   17.765178] aer_isr ! #log I added in aer_isr
[   17.765394] pcieport 0000:00:00.0: AER: Correctable error message 
received from 0000:01:00.0
[   17.766211] nvme 0000:01:00.0: PCIe Bus Error: severity=Correctable, 
type=Data Link Layer, (Receiver ID)
root@debian:/userdata# [   17.767045] nvme 0000:01:00.0:   device 
[144d:a80a] error status/mask=00000040/0000e000
[   17.767980] nvme 0000:01:00.0:    [ 6] BadTLP

root@debian:/userdata# cat /proc/interrupts | grep aerdrv
  60:      0      0      0      0      0      0     0     0     INTx   0 
Edge      PCIe PME, aerdrv, PCIe bwctrl
  63:      0      0      0      1      0      0     0     0     INTx   0 
Edge      PCIe PME, aerdrv
110:      0      0      0      0      0      0     0     0     INTx   0 
Edge      PCIe PME, aerdrv

> 
>>> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
>>> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
>>
>> Will it make all devices connected to use INTx only?
>>
> 
> Nah, it is just for the Root Port. The MSI/MSI-X from endpoint devices will
> continue to work as usual.

Qiang Yu,

Could you please help your IP version with below patch?
It's in hex format, you could convert each pair of hex
characters to ASCII, i.g, 0x3437302a is 4.70a. The reason
is we asked Synopsys to help check this issue before, then
we were informed that they have supported it at least since
IP version 6.0x. So we may have to limit the version first.

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1057,6 +1057,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)

         dw_pcie_msi_init(pp);

+#define PORT_LOGIC_PCIE_VERSION_NUMBER_OFF 0x8f8
+       val = dw_pcie_readl_dbi(pci, PORT_LOGIC_PCIE_VERSION_NUMBER_OFF);
+       printk("version = 0x%x\n", val);
+




