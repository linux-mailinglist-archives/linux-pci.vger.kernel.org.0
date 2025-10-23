Return-Path: <linux-pci+bounces-39078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B236DBFF3BB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CACD188D7D4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 05:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07498267386;
	Thu, 23 Oct 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BqfO9UCG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F4258EE1
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196284; cv=none; b=Iz0NUpfCup1MQt3PnPu81HcNTvGgwd4q3ahCga3gUIASInkMUVL1SMSsJyenD4i+MOehhRTMBirwW3+vXSSiQJngJ63zCnyjHP8xz8vGsdStaJjeqS4gcom/zxg2EbRN6Ksk/08qpapVeFf0zwxLW48nnwFfC0ew0v26H7HV6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196284; c=relaxed/simple;
	bh=w1LmB0SE2C+tSWh9OqT3WGhfCB5JmRvULI6W/A8+/1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxFxXkFT1HvUD8UqA0NcP2vLOw1HhniupDmlvuvJlJHZ1AXHdGSQljPj9o6CFw1m8FDWlWzVRmskWH+ARVjflZ8eWm2xNHUZo3noGGRYj2izpZv8+deHH0dIJ6jjWKzLWZpT/C2GHuy/kaQ5b1scs89zjyXn37NA25OhkeQABoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BqfO9UCG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso3612515e9.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761196280; x=1761801080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBvcm1/+MWpjtuc12IDJ3vwTa6noB7EaiS2kKGjrEYk=;
        b=BqfO9UCGSJI+ZSEmVvCODgujXi/oSa2IOkRElOV7rbxOY/kWFEtmSQ8+BDx/FPzQ0x
         k+nmo6Owt0f+rTXd1KE1vUsknNPXql/pWVqh+eGMgwRvloajCyE64u6PkEafTTO3E5Dk
         j0CdCB7qm6WIYFk+eT6u8pyjjEg3+t0hn/+S2tRfZBZ6MouLTsBjDAdyZGwiMW+Wcv0r
         EDxw92TStEG5qCt6kO5eUAnMjskgBb3xMTLUqJ/IiuiuGg+/Vzcm8NBGCHdA4oA98cn9
         uF3+MLPRDWUEPo+HiRYJHSOAtfB0t7vqchkekROrdYleUUXefTE6OqDfalrhyeQkNkhJ
         +GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761196280; x=1761801080;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBvcm1/+MWpjtuc12IDJ3vwTa6noB7EaiS2kKGjrEYk=;
        b=d6XtGcSiIWYp6b+FAyewR+3k5B9GsJQ1Ock3DF7561DUsZ3fnLGsDkAOqlQZK59bE/
         px4Eo+xuLGlZcMUCavRGrJhRzxJOV3g6Z0JTafs+sFrDI8vdQmwgZ0m7o1Gx2HYJL0GZ
         CgX/c7c9fZpcMIcsfnplGxvENyyPThUOynPHRhZcjC4v7kDLvBZugHavva2S10XLtbi9
         kbbN/Ph9UVUD9deeFt2dt6/TjBKK9OUErkqQfweYtmrGXjx6h0mESMUfXlVVu+T4f0Vi
         gyQNw1292z9U6SoCCkwyqJPgufka/gxbh+5lCpW7qYADwBV30llJavHJz3+fAq5G4EZ2
         OE1A==
X-Forwarded-Encrypted: i=1; AJvYcCXK0xNeh2QQoBwJBex9kkPQ6fOqrKGhPw95d3yXm6yn0nHYptYF8Fj8nytjsWwFb7PHTyolWMsZcY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFmszeuvs0nr0Ad+4W7p/Per4Ellxl8CCRDHN692RniGXpuzv
	E9k1/RuahpFgAYVY+kA9CG5QoY2ymppYw3rIiFjCXGe8DsNefiN+fvtwuEH4U67Wn5A=
X-Gm-Gg: ASbGncv2CpFOoRTj94Gqmk+eL13gWFIk15g6b1HcSEt3mNXF230UZGExBISzSuI13uk
	G9+hM3ZeunqWsn6eKsxD2tXVvNVDIE6Y1ODLhc9zQGLUDlrw1JPILmu2NOFu0i7eLITc2mAIMfh
	aM7yn6B0vL/vg4JNfHJH5mVPERn3TBX8NHnlJdit0yu+B94HHTdqw4QcyFoL6tJDQYmobB1WVqW
	gJuPMMBQ4XjmXJdP2Z3mnkuW9nNvsqlHiWmqFyGiTF17MX9NBbwmw0OF8wiOx5B/axWRGfIPZvD
	VgeV72ubk94O5//t9F9kAUIX10sPSTCSh8oRMEEVvvOHrUgb4m0nmpp1/W7lOX7rww1IiFV1PAW
	NdGA+VxEl1AGNyGGxaeJnlarOLbke9e+vGtDEevKF3IVXfWw7BdVil9DZdBIMFEl1LEbqCcYi6Z
	ap5r2bibCFdhm3bY95AF4=
X-Google-Smtp-Source: AGHT+IERViLl8JWsqBiRvBQnkt+CyM86zrBZonOHrHEOXB8HhThhVqCeU64XpCcFS1zawD1h5Xuw5w==
X-Received: by 2002:a05:600c:450a:b0:471:21:554a with SMTP id 5b1f17b1804b1-4711787c0c0mr138571215e9.13.1761196279421;
        Wed, 22 Oct 2025 22:11:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm53195075e9.2.2025.10.22.22.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:11:18 -0700 (PDT)
Message-ID: <51af454f-6322-47c3-9e93-4fc07efc2b8d@tuxon.dev>
Date: Thu, 23 Oct 2025 08:11:17 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251022194939.GA1223383@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251022194939.GA1223383@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 10/22/25 22:49, Bjorn Helgaas wrote:
> On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
> 
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -266,6 +266,14 @@ config PCI_RCAR_GEN2
>>  	  There are 3 internal PCI controllers available with a single
>>  	  built-in EHCI/OHCI host controller present on each one.
>>  
>> +config PCIE_RENESAS_RZG3S_HOST
>> +	bool "Renesas RZ/G3S PCIe host controller"
>> +	depends on ARCH_RENESAS || COMPILE_TEST
>> +	select MFD_SYSCON
>> +	select IRQ_MSI_LIB
>> +	help
>> +	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S SoC.
> 
> Wrap to fit in 80 columns like the rest of the file.

OK

> 
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> 
>> +#define RZG3S_PCI_MSIRCVWMSKL			0x108
>> +#define RZG3S_PCI_MSIRCVWMSKL_MASK		GENMASK(31, 2)
> 
> Unfortunate to have to add _MASK here when none of the other GENMASKs
> need it.  Can't think of a better name though.

Most of the register offsets and fields defines tried to use the naming
from the HW manual. Register at offset 0x108 have bits 31..2 read/writable
and is where we should be writing through driver, and bits 1..0 are read
only and have fixed value. These fields are named in HW manual as:

- MSI Receive Window Mask (Lower) [31:2]
- MSI Receive Window Mask (Lower) [1:0]

As bits 31..2 are read/writable, would you prefer something like:

#define RZG3S_PCI_MSIRCVWMSKL_RW		GENMASK(31, 2)

?

> 
>> +#define RZG3S_PCI_MSIRCVWMSKU			0x10c
> 
> Unused.
> 
>> +#define RZG3S_PCI_AMEIE				0x210
> 
> Unused.
> 
>> +#define RZG3S_PCI_ASEIE1			0x220
> 
> Unused.
> 
>> +#define RZG3S_PCI_PCSTAT2_STATE_RX_DETECT	GENMASK(15, 8)
> 
> Unused.

I agree with all the unused defines pointed. Will be dropped in the next
version.

> 
>> +/* Timeouts experimentally determined. */
> 
> No need for period at end.

Missed this one. I'll update it.

> 
>> +static int rzg3s_pcie_child_read_conf(struct rzg3s_pcie_host *host,
>> +				      struct pci_bus *bus,
>> +				      unsigned int devfn, int where,
>> +				      u32 *data)
> 
> Would fit in three lines if you want.
> 
>> +static int rzg3s_pcie_child_write_conf(struct rzg3s_pcie_host *host,
>> +				       struct pci_bus *bus,
>> +				       unsigned int devfn, int where,
>> +				       u32 data)
> 
> Ditto.

Will update both of these along with:

rzg3s_pcie_child_prepare_bus()
rzg3s_pcie_root_map_bus()
rzg3s_pcie_set_outbound_window()

that have the same symptom.

> 
>> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
>> +{
>> +	struct platform_device *pdev = to_platform_device(host->dev);
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	struct device *dev = host->dev;
>> +	const char *devname;
>> +	int irq, ret;
>> +
>> +	ret = devm_mutex_init(dev, &msi->map_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msi->irq = platform_get_irq_byname(pdev, "msi");
>> +	if (msi->irq < 0)
>> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
>> +				     "Failed to get MSI IRQ!\n");
>> +
>> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
>> +	if (!devname)
>> +		return -ENOMEM;
>> +
>> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = request_irq(msi->irq, rzg3s_pcie_msi_irq, 0, devname, host);
> 
> Should this be devm_request_irq()?  Most drivers use it, although
> pci-tegra.c and pcie-apple.c do not.  Maybe there's some special rule
> about using request_irq() even though the driver uses devm in general?
> I dunno.

In general is not good to mix devm cleanups with driver specific one.

As it was requested to drop the devm cleanups from this driver (especially
devm_pm_runtime_enable() which enables the also the clocks) I switched the
initial devm_request_irq() to request_irq() to avoid keeping the interrupt
requested on error path, after driver's probed was executed, until devm
cleanups are called, and potentially having it firing w/o hardware
resourced being enabled (e.g. clocks), and potentially reading HW registers.

E.g., accessing the HW registers while clocks are disabled on the SoC I'm
working with leads to synchronous aborts.

So, I only kept the devm helpers for memory allocations, resets
assert/de-assert and the mutex initialization.

> 
>> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
>> +{
>> +	struct device *dev = host->dev;
>> +
>> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
>> +		struct platform_device *pdev = to_platform_device(dev);
> 
> Looks like this should be outside the loop.

OK, I kept it here as it is used only inside this block.

> 
>> +		char irq_name[5] = {0};
>> +		int irq;
>> +
>> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
>> +
>> +		irq = platform_get_irq_byname(pdev, irq_name);
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Failed to parse and map INT%c IRQ\n",
>> +					     'A' + i);
>> +
>> +		host->intx_irqs[i] = irq;
>> +		irq_set_chained_handler_and_data(irq,
>> +						 rzg3s_pcie_intx_irq_handler,
>> +						 host);
>> +	}
> 
>> +static int rzg3s_pcie_power_resets_deassert(struct rzg3s_pcie_host *host)
>> +{
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
>> +	 * power on to the de-assertion of reset.
>> +	 */
>> +	usleep_range(5000, 5100);
> 
> Consider fsleep() so we don't have to make up the 100us interval.

OK

Thank you for your review,
Claudiu

