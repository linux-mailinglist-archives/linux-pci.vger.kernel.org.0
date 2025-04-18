Return-Path: <linux-pci+bounces-26244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AEA93BE2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E97AEF2C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2A481A3;
	Fri, 18 Apr 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NhI7IWfE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1526184F;
	Fri, 18 Apr 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996963; cv=none; b=LBX1byK6VECTCMH3EpqZPlG1IXsN0eODtlLXwPufDlocsBl4b9slYylKqCwZS4eyraVo9pJRaY5dG2jdF+BZRY1W4bmyWcHwrfaMPVRPDGChfImAuWL1WAL7GtiSZOJQTJPyIS38wLxMu0Fk+/emThWSSg+5YacK7vaXbSWu0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996963; c=relaxed/simple;
	bh=Tfu/fjEp11lnlyK3a9IV0VgCG9rncGnZLY0wPxc3V44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu741svfXnPPewIIU+jsqtfDkuL19WHxhwV+nr8HDEPjA88dGTto//nN36UfteVn5F5fDzw7JEweRBa+NWjdrJwR1yu8HNZ+JLmNdipYtVgs402b2rSa9xnsaYONXDpkAa8Zqau/2u10bkkdjdGd8Kt85tHQmpll0vx9VDJaUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NhI7IWfE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=JoiCvAoObANggbvCxlH2pC3tiGIdLdTH2E7i+CtOu60=;
	b=NhI7IWfEufQdqZ9Fi8LAbN5Tm277ipnd/At1S8RBJWu98rFgfvXXYFegTA2jHp
	3kS8NQq6jvS9nchsAhBGP9Derv4ViJBIF0I+DhJ1ms625shs/L5Q+E7ysqz9ymvV
	M/eHYoIO9iFutl8OxXN5/poWMaDCMrF6K5wC0FynLMd6A=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnr+8yigJoVSsGBA--.55761S2;
	Sat, 19 Apr 2025 01:21:55 +0800 (CST)
Message-ID: <8af8a418-b808-4a14-9969-1c6d549e1633@163.com>
Date: Sat, 19 Apr 2025 01:21:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org,
 kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250417165219.GA115235@bhelgaas>
 <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
 <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnr+8yigJoVSsGBA--.55761S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr45tr4fGF1xGr4xJFW7CFg_yoW5Xr48pa
	y7Kay8Ar18JFW3JF4kAF109F9Yy3ZayFWj9w47GrZ8Z3W5tryfCrZxtr45t3s7GrsF9Fy3
	Z3s5JFyUJFnIvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuyIUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwozo2gChB3CFgAAsy



On 2025/4/18 22:55, Niklas Cassel wrote:
> 
> 
> On 18 April 2025 14:33:08 CEST, Hans Zhang <18255117159@163.com> wrote:
>>
>> Dear Bjorn,
>>
>> Thanks your for reply. Niklas and I attempted to modify the relevant logic in drivers/pci/probe.c and found that there was a lot of code judging the global variable pcie_bus_config. At present, there is no good method. I will keep trying.
>>
>> I wonder if you have any good suggestions? It seems that the code logic regarding pcie_bus_config is a little complicated and cannot be modified for the time being?
> 
> 
> Hans,
> 
> If:
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..2e1c92fdd577 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2983,6 +2983,13 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>           if (!pci_is_pcie(bus->self))
>                   return;
>    +       /*
> +        * Start off with DevCtl.MPS == DevCap.MPS, unless PCIE_BUS_TUNE_OFF.
> +        * This might get overriden by a MPS strategy below.
> +        */
> +       if (pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +               smpss = pcie_get_mps(bus->self);
> +

Dear Niklas,

Thank you very much for your reply and thoughts.

pcie_get_mps: Returns maximum payload size in bytes

I guess you want to obtain the DevCap MPS. But the purpose of the smpss 
variable is to save the DevCtl MPS.

>           /*
>            * FIXME - Peer to peer DMA is possible, though the endpoint would need
>            * to be aware of the MPS of the destination.  To work around this,
> 
> 
> 
> does not work, can't you modify the code slightly so that it works?
> 
> I haven't tried myself, but considering that it works when walking the bus, it seems that it should be possible to get something working.
> 


After making the following modifications, my test shows that it is 
normal. If the consideration is not comprehensive. Could Bjorn and 
Niklas please review my revisions?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..5b54f1b0a91d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2951,8 +2951,7 @@ static int pcie_bus_configure_set(struct pci_dev 
*dev, void *data)
         if (!pci_is_pcie(dev))
                 return 0;

-       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
-           pcie_bus_config == PCIE_BUS_DEFAULT)
+       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
                 return 0;

         mps = 128 << *(u8 *)data;
@@ -2991,7 +2990,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
         if (pcie_bus_config == PCIE_BUS_PEER2PEER)
                 smpss = 0;

-       if (pcie_bus_config == PCIE_BUS_SAFE) {
+       if ((pcie_bus_config == PCIE_BUS_SAFE) ||
+           (pcie_bus_config != PCIE_BUS_TUNE_OFF)) {
                 smpss = bus->self->pcie_mpss;

                 pcie_find_smpss(bus->self, &smpss);


Best regards,
Hans


