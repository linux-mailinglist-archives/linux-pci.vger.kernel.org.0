Return-Path: <linux-pci+bounces-38986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90FBFB597
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17CE65023E9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CEC280332;
	Wed, 22 Oct 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WK6lqT/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045B313E37
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128052; cv=none; b=esWT5Z4g3V5Ns4WwtfekZ5KrseSqdcx93Y5Sj2mwpDtv+ANzl/JrVl6QDfJHb1odo1O59L0Py0DLgkNV0A+JsHdDSTgegbtSVUmJqIUcBrgJ5e5pgxjLPl0V6B67vkOSCy1L/RawFqBhGi7lPM5DH2Bszb9OSKnnzBzZlcQJk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128052; c=relaxed/simple;
	bh=/RPC8MRZ+06OZ870SGOFUxfv1txw7sdwuxUVZRVmSdQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OLxtGgqwBTqcSLYo9VRSJHz+vzU/2znvPucyg3mcOvAeJE3WDxQ7lQgtyOOK1TOPd5I8YF9KF8oelz953vn33UFOj61BgzA/A46zYZjjwn2CvTtZCO2zzytv1oiMBnG+Ouaa9fasevHfKEtFDzDeAcRWKo1L/Zvto/kpiRwuJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WK6lqT/g; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26cc20127;
	Wed, 22 Oct 2025 18:14:00 +0800 (GMT+08:00)
Message-ID: <be96bc56-c84f-4dac-a4a0-5b3d1b43f505@rock-chips.com>
Date: Wed, 22 Oct 2025 18:13:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
 <eorncfyktfdc33md7ogqccy5z2lsye7ew32wdy4sbegvjo2rdl@qp2zy7u75jqg>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <eorncfyktfdc33md7ogqccy5z2lsye7ew32wdy4sbegvjo2rdl@qp2zy7u75jqg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0b69477609cckunmb34b901f7eb0b1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxCGVYeSxpLSR5PQ0kaSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WK6lqT/gf5Ep4/xz/eLn35/ap0koV2X8sG+UwiWb/fBQH6SNGDpC7RWujOSSLtv6Su4/Sg53kAKl0Fr4QmRH1+H9s2xJaIDjlVFrAP04OjkTZGuKB2kaiE7848BoaQGbf188jMoZuyG/E5vRso7x8vtpLFPDKMlFwunbTMtbjEw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GmeWE1M63NeoHlFURMlwTAHebQLrzaGk/W6PAN9HlMc=;
	h=date:mime-version:subject:message-id:from;

Hi Mani

在 2025/10/22 星期三 18:02, Manivannan Sadhasivam 写道:
> On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
>> of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
>> is properly connected and could enable L1.1/L1.2 support.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>   drivers/pci/of.c  | 18 ++++++++++++++++++
>>   drivers/pci/pci.h |  6 ++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..52c6d365083b 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>> +
>> +/**
>> + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> 
> I don't see a benefit of this API, tbh. The API name creates an impression that
> the API will check for the presence of CLKREQ# signal in DT, but it checks
> for the presence of the 'supports-clkreq' property. Even though the presence of
> the property implies that the CLKREQ# routing is available, I'd prefer to check
> for the property explicitly instead of hiding it inside this API.

It makes sense.

Will the name of_pci_supports_clkreq_present() look good? Or we just
drop it and let host drivers to explicitly check supports-clkreq inside
their code?


> 
> - Mani
> 


