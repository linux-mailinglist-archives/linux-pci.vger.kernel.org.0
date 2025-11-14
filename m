Return-Path: <linux-pci+bounces-41217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16485C5BD93
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C743B4E23A1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5642F6561;
	Fri, 14 Nov 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lhxx9i5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com [45.254.49.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A92561AB
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106757; cv=none; b=tMOnbXR/9jlrPcPtdByFaHHWByBZxyKR1/llIPZ9aj7knOWNnvY4SAhacFdjWRDA3VPmL/RPStALdEn6xeKsVAksBBDPF2LfcH5MyrSqjdhLhTyb+4ds5ATctc0teKSqypSkFB7wdeYI+v5YHb0EceR+MZ/FT0Es99nHJjTlbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106757; c=relaxed/simple;
	bh=bmp4ci6hwqB9miii6SRVNE0HXbmkjXAQCmpn+TZWyC4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDZFUl90I9q6RhnGbX/YT6glraDufJTZCE2lOgDegfb68TOlJxJs7Zpin+PAeFzrwT4vo6TXZvYZ1f+qZe8FTKBCsUKTptMWCl5wq9Oa8HpVh9rlttVmxi+JGlVAKiRSgZa1+3wJR123pw+w5PUmZmEjgsKh7/R+UFy0CQ8wvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Lhxx9i5M; arc=none smtp.client-ip=45.254.49.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29955cdc9;
	Fri, 14 Nov 2025 15:47:16 +0800 (GMT+08:00)
Message-ID: <cdb79e0e-60ee-4206-8e2a-922ad36e27ea@rock-chips.com>
Date: Fri, 14 Nov 2025 15:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK
 definition
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1763102197-130089-1-git-send-email-shawn.lin@rock-chips.com>
 <cmwjx6qbv57lhpedwpb7o2y2sn3mccf7pbdwtj6kdajoorawhs@fxdgr27cgg7q>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <cmwjx6qbv57lhpedwpb7o2y2sn3mccf7pbdwtj6kdajoorawhs@fxdgr27cgg7q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a815534a809cckunmd380d28c429435
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gZSFYaHx5IQkkfGk5JSUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Lhxx9i5MaaBEjCzzJB9UvoVf5GSuVNIib+9efkxuWzAMxkjZQNfPcRNDdOhwxNzJGj38LtSRrn441TI2GpewPNhH4xa3lfoxzSVXh46r+E2Es/faWrpCTwtiRCBCUr+OcZtLnsAbAAowKO0VHnjeL0cvaFpaZJxkobqfac0Pvws=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Bpsdpbw4VK4bEFX3NRcVRezLl3Pr7glS6gzicjKMrM8=;
	h=date:mime-version:subject:message-id:from;

Hi Mani

在 2025/11/14 星期五 15:35, Manivannan Sadhasivam 写道:
> On Fri, Nov 14, 2025 at 02:36:37PM +0800, Shawn Lin wrote:
>> Per DesignWare Cores PCI Express Controller Register Descriptions,
>> section 1.34.11, PL_DEBUG0_OFF is the value on cxpl_debug_info[31:0].
>>
>> Per DesignWare Cores PCI Express Controller Databook, section 5.50,
>> SII: Debug Signals, cxpl_debug_info[63:0] says:
>> "[5:0] smlh_ltssm_state: LTSSM current state. Encoding is same as the dedicated
>> smlh_ltssm_state output."
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> No fixes tag?

I was thinking it actually didn't casue any problem since the ltssm from
dwc core didn't need the sixth bit. So I didn't know if it worths a
backport if I add a fixes tag. But if it does, then :)

Fixes: 23fe5bd4be90 ("PCI: keystone: Cleanup ks_pcie_link_up()")

> 
> - Mani
> 
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index e995f692a1ec..24bfa5231923 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -97,7 +97,7 @@
>>   #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
>>   
>>   #define PCIE_PORT_DEBUG0		0x728
>> -#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
>> +#define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
>>   #define PORT_LOGIC_LTSSM_STATE_L0	0x11
>>   #define PCIE_PORT_DEBUG1		0x72C
>>   #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
>> -- 
>> 2.43.0
>>
>>
> 


