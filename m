Return-Path: <linux-pci+bounces-9967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE092ABE7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 00:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4221F22F4F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2618B14F9E7;
	Mon,  8 Jul 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lass6E3i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB614EC44;
	Mon,  8 Jul 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476950; cv=none; b=G9VMXy6d2yipXj5o9XWZ42IYQTDwR/pr/TnbLUjyC7TORk2V/oARQFdDYcjn971W4uJrLhqYUtJYCU8nUzdjUuYHqccpl95CQzPnLwDLX4uENxZztVnqcvGxmwVvXju5W5OoFxyqlkUTBUK+J+PQKJvEAP5sVQ5n9kLCnLiziRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476950; c=relaxed/simple;
	bh=ymbu5+bIDcpN0rmlC5oWU/KXdLu7wOWeG7hHztdx8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0RfamCXKDGdJWErg7ymbttbbUO7VdjsJudaB8ud+8wvkwFWierb2H/PYgKaDNkKWANyUXczzeaUxvb9KsnLQu/EyBumhaxMoP2eNs9JLSGkIhY1Y5gui+emNciwhLF8QV4gBLOp/0p+QOtRQM1+YNR+EQnHX7KnqenUj7TLPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lass6E3i; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77c080b521so488829166b.3;
        Mon, 08 Jul 2024 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476946; x=1721081746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WakRVrhzYTWXcephGvejlAmFzJ/7jV1NnXpteDXimuk=;
        b=Lass6E3iMA+UWW4RV+iMJ7WfgOsRHUIiLS+iP7l/NGf2U79oJT4T0SBR+VCJH7f7J2
         0hLfKPc3jVuiYECqICoqrpdsSGwN8MCcRNTnb+wy82wGEElnJBU+jUgYBgShv0vtJAXR
         jXTF6/DrM7ntJDg4yAcx5XQAzUf148SHpQuUNUbN89JwQl+4wo/z/cg9601cINj2lyzt
         rkbaB6iQJ2fKMa8O5o30lm24T552W2Opo78lTQktigPakDiIfTa5Gdqw5FAyjHipBfZ7
         42OUeHP6zIIdfH6qH8tGS9kGL8iRshRLaXe6d9MczLV/j2RBRmiVIOaGzi0uRM4DZjt3
         x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476946; x=1721081746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WakRVrhzYTWXcephGvejlAmFzJ/7jV1NnXpteDXimuk=;
        b=Jko+iYb7CSaYgr5EzxweH0xUGdhsCnQZ6FGfSCg8jmltppfVv1a/9BE9s56TIZL3Xn
         WiZM0eJvXdvNf5yYswy9L3mR5JkKdwdHkM3rhqO3PeZkHfd7cT41viR8j12p0U6NQ2pC
         UAPdcNq1kxxL+vzPzul0gC0V8P6tUBM+DeIasgfy8Nxl9m0JZQB8IuEti9XI2zWxosr9
         rHjJLd7XOQ1CS3xPAa/vURWAJqHCBP/GRoWN4IB7nvBKErlHrqGWzv35RHfrQDgVWRJe
         ajd+nzLNOvX1W2t4YDj7xSd7rS5PSMJxiJdpb06csFwLEUNf1ZWBTvpbyFsHisdMMKWE
         y6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV2zvRMPalTUNAa8JXmR9BdsgT3Mocwt4d8d66gnQqbpoVsWJxr7xcpOeTt124obv7WuFysAiY+AingCVRfArVuV+FMU9pQ7NynGIeAk3DiyXPbbrA4pGl868CZrKvdYLNvvA5Zr4Mvif1NgYDhCXfGsM+/S9pW6T/WIjy3TJwO
X-Gm-Message-State: AOJu0Ywavk2W69P8HGKgDL9NoW1MfptdGOWadsBLq4bFStvIvjflbELV
	qRT2/ukQvhWiwcJdcz20NUKwjpYyKun8cKjBqyUSVJg4Vx3dzvNU
X-Google-Smtp-Source: AGHT+IEZcHx32uwM0SrELtiDJgoF/S5vkZBXbHEgN/9T6mcWUeRzj4UwPkYWYyBBm364aazg6hohtw==
X-Received: by 2002:a17:906:11ca:b0:a75:1006:4f23 with SMTP id a640c23a62f3a-a780b6fe8d0mr40318666b.34.1720476946294;
        Mon, 08 Jul 2024 15:15:46 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b0c:a200:89f2:32cc:d63b:a6ad? (dynamic-2a01-0c22-7b0c-a200-89f2-32cc-d63b-a6ad.c22.pool.telefonica.de. [2a01:c22:7b0c:a200:89f2:32cc:d63b:a6ad])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a780a6dc626sm26656866b.46.2024.07.08.15.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:15:45 -0700 (PDT)
Message-ID: <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
Date: Tue, 9 Jul 2024 00:15:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20240708172339.GA139099@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240708172339.GA139099@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.07.2024 19:23, Bjorn Helgaas wrote:
> [+cc r8169 folks]
> 
> On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
>> Added aspm suspend/resume hooks that run
>> before and after suspend and resume to change
>> the ASPM states of the PCI bus in order to allow
>> the system suspend while trying to prevent card hangs
> 
> Why is this needed?  Is there a r8169 defect we're working around?
> A BIOS defect?  Is there a problem report you can reference here?
> 

Basically the same question from my side. Apparently such a workaround
isn't needed on any other system. And Realtek NICs can be found on more
or less every consumer system. What's the root cause of the issue?
A silicon bug on the host side?

What is the RTL8168 chip version used on these systems?

ASPM L1 is disabled per default in r8169. So why is the patch needed
at all?

> s/Added/Add/
> 
> s/aspm/ASPM/ above
> 
> s/PCI bus/device and parent/
> 
> Add period at end of sentence.
> 
> Rewrap to fill 75 columns.
> 
>> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
>> ---
>>  drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 142 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index dc12d4a06e21..aa3dba2211d3 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>> +
>> +static const struct dmi_system_id chromebox_match_table[] = {
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +		{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{
>> +			.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +		}
>> +	},
>> +	{ }
>> +};
>> +
>> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
>> +{
>> +	u16 val = 0;
>> +
>> +	if (dmi_check_system(chromebox_match_table)) {
>> +		//configure parent
>> +		pcie_capability_clear_and_set_word(dev->bus->self,
>> +						   PCI_EXP_LNKCTL,
>> +						   PCI_EXP_LNKCTL_ASPMC,
>> +						   PCI_EXP_LNKCTL_ASPM_L1);
>> +
>> +		pci_read_config_word(dev->bus->self,
>> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				     &val);
>> +		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>> +		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>> +		      PCI_L1SS_CTL1_ASPM_L1_1;
>> +		pci_write_config_word(dev->bus->self,
>> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				      val);
>> +
>> +		//configure device
>> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>> +						   PCI_EXP_LNKCTL_ASPMC,
>> +						   PCI_EXP_LNKCTL_ASPM_L1);
>> +
>> +		pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val);
>> +		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
>> +		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
>> +		      PCI_L1SS_CTL1_ASPM_L1_1;
>> +		pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val);
>> +	}
>> +}
>> +
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
>> +			  rtl8169_suspend_aspm_settings);
>> +
>> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
>> +{
>> +	u16 val = 0;
>> +
>> +	if (dmi_check_system(chromebox_match_table)) {
>> +		//configure device
>> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>> +						   PCI_EXP_LNKCTL_ASPMC, 0);
>> +
>> +		pci_read_config_word(dev->bus->self,
>> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				     &val);
>> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>> +		pci_write_config_word(dev->bus->self,
>> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				      val);
>> +
>> +		//configure parent
>> +		pcie_capability_clear_and_set_word(dev->bus->self,
>> +						   PCI_EXP_LNKCTL,
>> +						   PCI_EXP_LNKCTL_ASPMC, 0);
>> +
>> +		pci_read_config_word(dev->bus->self,
>> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				     &val);
>> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
>> +		pci_write_config_word(dev->bus->self,
>> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +				      val);
> 
> Updates the parent (dev->bus->self) twice; was the first one supposed
> to update the device (dev)?
> 
> This doesn't restore the state as it existed before suspend.  Does
> this rely on other parts of restore to do that?
> 
>> +	}
>> +}
>> +
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
>> +			 rtl8169_resume_aspm_settings);
>>  #endif
>>  
>>  #ifdef CONFIG_PCIE_DPC
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>


