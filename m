Return-Path: <linux-pci+bounces-4463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9287091A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81B41C239D5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF936214B;
	Mon,  4 Mar 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="e5cWzcyq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1656169F
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575695; cv=none; b=C+IDJ1gNy9D44ya2x/jnkJZgkcPFNG7qV7esAjRT/N4jsupKm2AYwI9W51kbKmz5QTbPiWn1tJ15vhAa84W1AoLU7agLU8i6HyImhFDmDWxQMqT6G6lamBOxKKe3J0CYPDOxppV0SkI9t7mM6R0VrWgUXjZ3HZb3zv3elpd4wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575695; c=relaxed/simple;
	bh=SCCU9dbfZqUMw7g1ftHwe7lhiBrDP1IoW13xbyD472Q=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=B1eHHamxtuuGlZmhXhDXwKSjvrj3UTUUhesuXTZVoq7Tcd0LgJmLDzsS0IcdhF0aYljN+ioaEk0rRnztygpCheQQv0a+KaBl2y+llDc/vOKu0FJCrcdZvgK3SFD0IYtQKOhve3dnp/kXZhtlaHTsu4i2j8y2sdI1Utzm49kcQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=e5cWzcyq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4775489a12.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709575693; x=1710180493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aizblNvc9Cf2btttMWelCC6kMijS1p5vy42920jDwTY=;
        b=e5cWzcyqyDy+69v+oaErXiT4T6SwOmNPAowtEemMkU4mmWJ4T5hfleUs4acVf8v4PO
         FFiRsFy6LVb6QRv6ydgK1vY59/vytWvEL7lbZt1jjc35GaEqJYxN0XXkKDdN8J0p91ey
         lSbzRoCalAND2OhVnq0e36pM1NdKhfA6mzVtIMgDbaLGhdYMHK+2K+mQUTkIEvR08hmX
         0NLOjA0lvjzFXETVgGw30WodRrfz3g567iEVDAYvaPW4tMpv+42fIaq9c/V638m/2FFV
         F2c/zzjj+yXliFZgtk+UBRi+WaDH6sm/cTE36niNyTsbh+u7Vqiqo8YWi2gC4CUjyEjD
         yYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575693; x=1710180493;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aizblNvc9Cf2btttMWelCC6kMijS1p5vy42920jDwTY=;
        b=B0W7+qtSLnNxBtROybQiHrbOR/3YRZwJDbvb5aFQdYDiCJdlEY5kLzpwajkI6r/IlB
         ysqgv1KhZzTLca5InWPFy/jaK6V6zjjkpvpzb7gbajL6LWtoCWA3xP+yNg6AURqPsZqM
         vmpjhxA2085Fa/Sa2ae5SiSkkCACXRbizz4IY1STNango2lbxNV14sswZNT3VHeGSBLV
         vrietl3ezChrl7Q9ZlkcjIcjqpSqll+X5yzzoolJyUDABVTyrYyMcrhVlZW9d/3yfU4F
         A+EY3lWbqbif96M+3XJiB/Ctl3jG1n/pYQfJLY8pWuVv8nV0uwgK+w9TdKIAnD7JvqY7
         vKCA==
X-Forwarded-Encrypted: i=1; AJvYcCURLSgflkRRjTOn+kfvl/yMldp7zo3huRgA5i9q80gBpl3zgEPMalNMTfDqrpc+pWd4r0T9EOV+uPPyIMxfZp7vfAmCcmfYwz2N
X-Gm-Message-State: AOJu0YzrmItW7SrCDEik5Lcnr9lUORMD7QyzARXasOcNCGJxYYmvH92p
	n2Z7sBuTjLzk0PqsSoQczdd6OBP0WKg0LtdNylL/m2JLIGkNuWew6HJkY93NF2NsjkaLVDn29gU
	o
X-Google-Smtp-Source: AGHT+IFhlrCJ7z/RMUFxQQf2zMzCvbw2MLdNLsKVNf46b6Rg0IEtkQiqwfm6zGkZbeAOroe6+Tng3g==
X-Received: by 2002:a17:90a:8a0e:b0:29a:a08d:4809 with SMTP id w14-20020a17090a8a0e00b0029aa08d4809mr7511710pjn.2.1709575693052;
        Mon, 04 Mar 2024 10:08:13 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090ac58300b0029b2e00359esm5161382pjt.36.2024.03.04.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:08:06 -0800 (PST)
Date: Mon, 04 Mar 2024 10:08:06 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2024 10:08:04 PST (-0800)
Subject:     Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout workaround to host drivers.
In-Reply-To: <ZeCd+xqE6x2ZFtJN@lpieralisi>
CC: minda.chen@starfivetech.com, Conor Dooley <conor@kernel.org>, kw@linux.com,
  robh+dt@kernel.org, bhelgaas@google.com, tglx@linutronix.de, daire.mcnamara@microchip.com,
  emil.renner.berthing@canonical.com, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, p.zabel@pengutronix.de, mason.huo@starfivetech.com,
  leyfoon.tan@starfivetech.com, kevin.xie@starfivetech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: lpieralisi@kernel.org
Message-ID: <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 07:08:43 PST (-0800), lpieralisi@kernel.org wrote:
> On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
>> From: Kevin Xie <kevin.xie@starfivetech.com>
>>
>> As the Starfive JH7110 hardware can't keep two inbound post write in
>> order all the time, such as MSI messages and NVMe completions. If the
>> NVMe completion update later than the MSI, an NVMe IRQ handle will miss.
>
> Please explain what the problem is and what "NVMe completions" means
> given that you are talking about posted writes.
>
> If you have a link to an erratum write-up it would certainly help.

I think we really need to see that errata document.  Our formal memory 
model doesn't account for device interactions so it's possible there's 
just some arch fence we can make stronger in order to get things ordered 
again -- we've had similar problems with some other RISC-V chips, and 
while it ends up being slow at least it's correct.

> This looks completely broken to me, if the controller can't guarantee
> PCIe transactions ordering it is toast, there is not even a point
> considering mainline merging.

I wouldn't be at all surprised if that's the case.  Without some 
concrete ISA mechanisms here we're sort of just stuck hoping the SOC 
vendors do the right thing, which is always terrifying.

I'm not really a PCIe person so this is all a bit vague, but IIRC we had 
a bunch of possible PCIe ordering violations in the SiFive memory system 
back when I was there and we never really got a scheme for making sure 
things were correct.

So I think we really do need to see that errata document to know what's 
possible here.  Folks have been able to come up with clever solutions to 
these problems before, maybe we'll get lucky again.

>> As a workaround, we will wait a while before going to the generic
>> handle here.
>>
>> Verified with NVMe SSD, USB SSD, R8169 NIC.
>> The performance are stable and even higher after this patch.
>
> I assume this is a joke even though it does not make me laugh.

So you're new to RISC-V, then?  It gets way worse than this ;)

> Thanks,
> Lorenzo
>
>>
>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
>>  drivers/pci/controller/plda/pcie-plda.h      |  1 +
>>  drivers/pci/controller/plda/pcie-starfive.c  |  1 +
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
>> index a18923d7cea6..9e077ddf45c0 100644
>> --- a/drivers/pci/controller/plda/pcie-plda-host.c
>> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/msi.h>
>>  #include <linux/pci_regs.h>
>>  #include <linux/pci-ecam.h>
>> +#include <linux/delay.h>
>>
>>  #include "pcie-plda.h"
>>
>> @@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
>>  			       bridge_base_addr + ISTATUS_LOCAL);
>>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>>  		for_each_set_bit(bit, &status, msi->num_vectors) {
>> +			/*
>> +			 * As the Starfive JH7110 hardware can't keep two
>> +			 * inbound post write in order all the time, such as
>> +			 * MSI messages and NVMe completions.
>> +			 * If the NVMe completion update later than the MSI,
>> +			 * an NVMe IRQ handle will miss.
>> +			 * As a workaround, we will wait a while before
>> +			 * going to the generic handle here.
>> +			 */
>> +			if (port->msi_quirk_delay_us)
>> +				udelay(port->msi_quirk_delay_us);
>>  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
>>  			if (ret)
>>  				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index 04e385758a2f..feccf285dfe8 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -186,6 +186,7 @@ struct plda_pcie_rp {
>>  	int msi_irq;
>>  	int intx_irq;
>>  	int num_events;
>> +	u16 msi_quirk_delay_us;
>>  };
>>
>>  struct plda_event {
>> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
>> index 9bb9f0e29565..5cfc30572b7f 100644
>> --- a/drivers/pci/controller/plda/pcie-starfive.c
>> +++ b/drivers/pci/controller/plda/pcie-starfive.c
>> @@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>
>>  	plda->host_ops = &sf_host_ops;
>>  	plda->num_events = PLDA_MAX_EVENT_NUM;
>> +	plda->msi_quirk_delay_us = 1;
>>  	/* mask doorbell event */
>>  	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
>>  			     & ~BIT(PLDA_AXI_DOORBELL)
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

