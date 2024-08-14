Return-Path: <linux-pci+bounces-11679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D195220F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BF12861BA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA791BD038;
	Wed, 14 Aug 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bfFmdQ2J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1017.netease.com (mail-m1017.netease.com [154.81.10.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F21B0111;
	Wed, 14 Aug 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660185; cv=none; b=i4v/KXGERPBYFgpcKC5rOZxW8WUErujdG8hxiWBUopIIn5iww0Ad0sTsimU0OQJ825xR8vBAYebsz4RXdPIrbAadaqWftO3nG1rHyt6OJCyy8QkfuXaad4mzEON0Z5zkXd2ee3HzGyjn+/ZS/3I5RvW9r01zLQhwfc0IgyhN4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660185; c=relaxed/simple;
	bh=Y9c/XLRJlf8KnnkMcsULdAtCn226wo9wTDZfFWWtVBs=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=t2vI1oPb/7HdOC/bZ0yu+jVPUfEdRUZnAJ2EdzBOx0VzOxvQuulmEf1KpMqK1i+swwvJETOxgIdhkgSIgHOAgc+LXCssz4Md49/0WjZgywNt+w/+3PfS88Zml/JtjNFiY94LzKFhOHS5f+1acd91TmrRob+DkOZEJJsZ6Z4sbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bfFmdQ2J; arc=none smtp.client-ip=154.81.10.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=bfFmdQ2JOyRtEM8Haweg5FGlJmlqS4Jm/rCbQjBX08K827IQQQFjQw9nMddgOGtkZNosiOSkCXQFIwIJLREmr/gJZIAYlykkK4xF0cT2nKiAOlMmkmRHPD6Qf7UX+7n6g04xqJLN9HwMIiLStj2HhueMbA6CT0Tt1PQJXVAmL2k=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=o8T7XJcjR9eOeMW62BDQdgaQ5z2uFScakm2eov4tfpQ=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B090C460862;
	Wed, 14 Aug 2024 18:12:38 +0800 (CST)
Message-ID: <3dd691bc-d13d-483b-96d1-7aae79ea6671@rock-chips.com>
Date: Wed, 14 Aug 2024 18:12:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Language: en-GB
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jisheng Zhang <jszhang@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [v4,05/11] PCI: dwc: imx6: Share PHY debug register definitions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMYGFZPTkxMGU9CSxhPHh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a915060139903aekunmb090c460862
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6KRw*NzIzH01WKAoMNRYW
	GFEwFAxVSlVKTElITUhLSE5CQkpMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhKQ0o3Bg++

Hi folks,

       DWC PCIe driver introduced a default method to check link up for
DWC controller. However, this is broken by test and can't work 100%
reliably. It was first added by commit 1 and fixed by commit 2. Finally
commit 3 moved PHY debug regs to PCIE_PORT_DEBUG1 which checks
cxpl_debug_info[63:32].

Quoted from DWC databook, section 8.2.3 AXI Bridge Initialization, 
Clocking and Reset:

"In RC Mode, your AXI application must not generate any MEM or I/O
requests, until the host software has enabled the Memory Space Enable
(MSE), and IO Space Enable (ISE) bits respectively. Your RC application
should not generate CFG requests until it has confirmed that the link is
up by sampling the smlh_link_up and rdlh_link_up outputs."


So the problem is very clear that cxpl_debug_info from DWC core is
missing rdlh_link_up. So reading PCIE_PORT_DEBUG1 and check smlh_link_up
isn't enough. But I don't know what PCIE_PHY_DEBUG_R1 means. Does it
means both of smlh_link_up and rdlh_link_up? If yes, than commit 3 
should be removed. Otherwise it was broken already from the beginning
commit 1.

[1]: commit dac29e6c5460 ("PCI: designware: Add default link up check if
sub-driver doesn't override")

[2]: commit 01c076732e82 ("PCI: designware: Check LTSSM training bit
before deciding link is up")

[3]: commit 60ef4b072ba0 ("PCI: dwc: imx6: Share PHY debug register
definitions")

