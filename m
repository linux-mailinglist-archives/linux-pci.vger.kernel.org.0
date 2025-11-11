Return-Path: <linux-pci+bounces-40911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860BC4E3CD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E383A82E5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742193246F6;
	Tue, 11 Nov 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JE3rvUeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973195.qiye.163.com (mail-m1973195.qiye.163.com [220.197.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA317B50A;
	Tue, 11 Nov 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868964; cv=none; b=biNSIxBGfHoSxj9136x4WvpZyh7IbZ/SHkchJDrhMZLwRHBMjqtuehOy4gEp0wzGQk2pJgmqa5PartYEVv3/s8FRo+u1R3oWR153hyHAjCZ9RQr3WlbJ93SdMVLzT0QnYQZm/sPBm+Rhpey45UAKijG9iBCrhbvTXW8BTgF2UVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868964; c=relaxed/simple;
	bh=rs8ZMHsGqoZAi449uqrDys8kFWlhMODL2mwmbIrThnc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0fsgJFIwvpCjSOxSrRcmPH7TiKAXZcAnJ8BdBoJ/adGbVD/d5PskbGWsk6fvBmYsMENT54E/3nVPs3UQu3s6CdnAKXnflQvcPVd2pRsDj0k/XpgLR+hawqOXB3USx/LwplBhOQBEnXJ1riIp3mQDrV/wa4fdJm950I8VRYcrx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JE3rvUeS; arc=none smtp.client-ip=220.197.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 293418357;
	Tue, 11 Nov 2025 21:33:59 +0800 (GMT+08:00)
Message-ID: <6b847014-ea46-4e16-8eab-c1a57e7a236e@rock-chips.com>
Date: Tue, 11 Nov 2025 21:33:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, FUKAUMI Naoki <naoki@radxa.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20251111105100.869997-8-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a731f8d6709cckunm858b49041d64c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkwYVkNJHUwfHRkeSBlKHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=JE3rvUeSo9xsGVjhoyWvCxwk+7LA/vw96b1LQfbIdMM20F2HkHfOVj6TQVzvEHpOQSauiG8jBjOI02owbOAiP2MOgjToiR2HyQLpOBi/C9OuGL/3jd/LmckwiEazBOkIc0XWl/GxisXYiQNP1D7Q4jZz1j+PSlsQtUFH1nZSJNE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=T1dUf5Nc6vc4f4P7/aobXuszncjlaJXSyBYXfdKwIsE=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/11 星期二 18:51, Niklas Cassel 写道:
> Revert all patches related to pcie-designware Root Complex Link Up IRQ
> support.
> 
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> During the initial scan, PCI core doesn't see the switch and since the Root
> Port is not hot plug capable, the secondary bus number gets assigned as the
> subordinate bus number. This means, the PCI core assumes that only one bus
> will appear behind the Root Port since the Root Port is not hot plug
> capable.
> 
> This works perfectly fine for PCIe endpoints connected to the Root Port,
> since they don't extend the bus. However, if a PCIe switch is connected,
> then there is a problem when the downstream busses starts showing up and
> the PCI core doesn't extend the subordinate bus number after initial scan
> during boot.
> 
> The long term plan is to migrate this driver to the pwrctrl framework,
> once it adds proper support for powering up and enumerating PCIe switches.

For pcie-dw-rockchip

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Niklas Cassel (6):
>    Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link
>      Up"
>    Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up
>      IRQ"
>    Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
>    Revert "PCI: qcom: Enable MSI interrupts together with Link up if
>      'Global IRQ' is supported"
>    Revert "PCI: qcom: Enumerate endpoints based on Link up event in
>      'global_irq' interrupt"
>    Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up
>      event"
> 
>   .../pci/controller/dwc/pcie-designware-host.c | 10 +--
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 60 +-----------------
>   drivers/pci/controller/dwc/pcie-qcom.c        | 63 +------------------
>   4 files changed, 6 insertions(+), 128 deletions(-)
> 


