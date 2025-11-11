Return-Path: <linux-pci+bounces-40808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E7C4B1DD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 03:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378324FD9F9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA001DF258;
	Tue, 11 Nov 2025 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cd08qT9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB01D6DB5;
	Tue, 11 Nov 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825762; cv=none; b=WYY+K2cWbm/Ase9ViEwrrabD8/ZD4EPvlzWf8h6EiLG4d819f53YQXhqiZjZEDeESbTQ3t5ZJcAgmtQqOMNRQlnLvhZvWu/jv95TZQktD726+Hh0PkUVrnwUvKZ2f4KwrudwDi0i/3bO94AOpB/RlyP7VOcf+wo7Dh1qTOCIR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825762; c=relaxed/simple;
	bh=8Aa0nYtS35ONkaQQoY2uBUXHTP1ScGiI5IZMaAxyNrk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tMwAqp+/51QNmqIIHcyK5Fr0c54LG/sWyszYuamyxEEWGhuM4Wxt4L8Y4O1/oJuLQwxF52Ih7hJEk/3xLCN/A91Qa/+ERnQ4q/7XsiKAUNHuD5GraZnfIMkntFsveZQVkZO/QIfZHVIiiw+QSLQ1axIhehpljQFWd0ewYpnt+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cd08qT9+; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 291ba890e;
	Tue, 11 Nov 2025 09:33:53 +0800 (GMT+08:00)
Message-ID: <4a2a4203-3eb0-4eab-a06e-ce5c6bf18ff4@rock-chips.com>
Date: Tue, 11 Nov 2025 09:33:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Christian Zigotzky <chzigotzky@xenosoft.de>,
 Manivannan Sadhasivam <mani@kernel.org>, mad skateman
 <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>,
 Al <al@datazap.net>, Roland <rol7and@gmx.com>,
 Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au,
 linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20251110222929.2140564-1-helgaas@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a708c486b09cckunm21ab4954142baac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5LSVZCGE4fHUkfHh8ZHktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cd08qT9+ofTOHLviYsPJU6/zj7uWHpgRHy2ESEJxDV1L/c8gW4npffGalzbbjreYmLcwN/86vIr1ikZC6wZsG4I+t/7HOnoH9eQLrFRhvbWfKt5+u+3Bis9Ii6eiLvJdGdTvAAOi91zO6iWc1PVmtroFmRO8/KE2EaOaRBNA7J0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wldv8Qsh/4sLIhJ4SctOETeeCU5PBThyRygSnxhx63A=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/11 星期二 6:22, Bjorn Helgaas 写道:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> L0s, L1, and (if advertised) L1 PM Substates.
> 
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> (v6.18-rc3) backed off and omitted Clock PM and L1 Substates because we
> don't have good infrastructure to discover CLKREQ# support, and L1
> Substates may require device-specific configuration.
> 
> L0s and L1 are generically discoverable and should not require
> device-specific support, but some devices advertise them even though they
> don't work correctly.  This series is a way to add quirks avoid L0s and L1
> in this case.
> 

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Bjorn Helgaas (4):
>    PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be
>      overridden
>    PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link
>      states
>    PCI/ASPM: Convert quirks to override advertised link states
>    PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
> 
>   drivers/pci/pci.h       |  2 ++
>   drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
>   drivers/pci/probe.c     |  7 +++++++
>   drivers/pci/quirks.c    | 38 +++++++++++++++++++-------------------
>   include/linux/pci.h     |  2 ++
>   5 files changed, 47 insertions(+), 27 deletions(-)
> 


