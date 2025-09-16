Return-Path: <linux-pci+bounces-36259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D11B597DE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 15:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DE7A4B3A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045853019BE;
	Tue, 16 Sep 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sH1xuCuM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751F28315A;
	Tue, 16 Sep 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029979; cv=none; b=jc0O5uwr1R7r9m5LEWZ/ldx2DhvzfFFVBxSkBhzbzvGiPgrHyfuMpxZLwIR0uGvGc2G+ue0c7CQ0POM/wqXQiMucgOYUbKNY8Atzsjs06x/1KblAG2qBn+YGzqlXndUkv6Fq2+bKqfvBwuMZOKYEj3Q9DoWnDJg7LeHJCcQAoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029979; c=relaxed/simple;
	bh=oXfCogu51Y1JMNG2+OaF7xr6XeoOW7V7I6ypr3fSbQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVUg1oU4tqI0cFVk9MoFkFVKAQ4Dnfn/NkTxRdmtqJiLMlLrAfw7sSQl/7XQHvX4j0O1wPuRCbOvXDhVm3mIzeerPd/1n9O9t0sJ+TgUcPzaIY5D4ot6ZaZeT7Cxn7JN3Bqsy7GRrcL+Wt8c48BhAdlyuYbjF10qSarCfVaTETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sH1xuCuM; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cR30h3BTpz9skk;
	Tue, 16 Sep 2025 15:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758029972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8GhPVxxHZ+Y3EpvPo7HYyNQhRtudJBKn7C5LHbgH50=;
	b=sH1xuCuM3gwfGZQIONkrBz7X5tBdHkdCoIv2OPaL/wefxJq38KRnLdtQ8hsK7wbaEu7sm6
	LfGcbfYaMWQJzXpeXqMZO1018t7jgae3JpBWOVu2Ti60NXlO87oUYW3ZrWMTMnsqAf4Ycg
	+fg2ZsPKSNcq7DsZoZ1hyndCRsX90BRMnX0MUrdP5HS0KeoHhg0icNUWLfEEpcc0pOkpme
	7KFnXkBHSTYGjbfA7Zwoss57Cr8K685HNtRjk20G/oK4eJ+HhREgrR+FxjUYEMaBmzZ39T
	eC1C9uSxRTmqc5Ci7id7YnGQ1mdp5ASLE8mNSP1hr5qmrdnd/fwNgdEJkn8rXg==
Message-ID: <6fdc7d1e-8eaa-4244-a6b4-4a07e719dd73@mailbox.org>
Date: Tue, 16 Sep 2025 15:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250915235910.47768-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdXAK6EhxPoNoqwqWSjGtwM24gL4qjSf6_n+NMCcpDf1HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ddt3k6hk83bg1jd35oym9p6444sir7a3
X-MBO-RS-ID: 0586fb1d42d24f34612

On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hello Geert,

> On Tue, 16 Sept 2025 at 01:59, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
>> Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
>> indicates that register 0xf8 should be polled until bit 18 becomes set to 1.
>>
>> Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
>> to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
>> condition is inverted and returns when register 0xf8 bit 18 is set to 0,
>> which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
>> the timing changes just enough for the first readl_poll_timeout() poll to
>> already read register 0xf8 bit 18 as 1 and afterward never read register
>> 0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
>> controller.
>>
>> Fix this by inverting the poll condition to match the reference manual
>> initialization sequence.
>>
>> Fixes: faf5a975ee3b ("PCI: rcar-gen4: Add support for R-Car V4H")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> @@ -711,7 +711,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>>          val &= ~APP_HOLD_PHY_RST;
>>          writel(val, rcar->base + PCIERSTCTRL1);
>>
>> -       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
>> +       ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
>>          if (ret < 0)
>>                  return ret;
>>
> 
> This change looks correct, and fixes the timeout seen on White Hawk
> with CONFIG_DEBUG_LOCK_ALLOC=y.
> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> 
>      SError Interrupt on CPU0, code 0x00000000be000011 -- SError

...

>       el1h_64_error_handler+0x2c/0x40
>       el1h_64_error+0x70/0x74
>       dw_pcie_read+0x20/0x74 (P)
>       rcar_gen4_pcie_additional_common_init+0x1c/0x6c

SError in rcar_gen4_pcie_additional_common_init , this is unrelated to 
this fix.

Does the following patch make this SError go away ?

"
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d787f2a364d5..5932f83996f0 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct 
rcar_gen4_pcie *rcar)
         if (ret)
                 goto err_unprepare;

+mdelay(1);
+
         if (rcar->drvdata->additional_common_init)
                 rcar->drvdata->additional_common_init(rcar);

"

