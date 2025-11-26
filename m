Return-Path: <linux-pci+bounces-42140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2FEC8B2E4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E0D3B071E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC13274B48;
	Wed, 26 Nov 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NAsy67xM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F627056F
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177736; cv=none; b=I6cjWdt1bBUujflhLrJFURcg91+9HV4uoPsrvjMdUgGV8jFqIPO21fTJEeMpE92eN7AcN/mNWoN6phniJvPhFrIM+k/F2J2qkxBFr/wf5jcWJT1rJXeL0ZAhJKHev+X4xJERlUjCEO0SqHoFVFDcFEc/XzOYBj77K1JjxL/h6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177736; c=relaxed/simple;
	bh=wOW9mr8lkvb1dXWEhI4QVzanyGbtM+zavyrY1/ZkNe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2/rBJ/lsZzYSjhpgBBF0nPF1odU1aCfTO8jfSJyFyXiiGeFOoY6O1qfUFT5UU8wiFlT/R9KDgbc9NamIqhju9rGiMgko15LiDaKSs3azdfRGBCxEMoNIAwkmH6xLm0tik1wGonJYF96Q3TGp48zeTL5Wa66HJDsKsUFQ/SY+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NAsy67xM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477770019e4so57759165e9.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764177732; x=1764782532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMbAlPYdoISwPLiWW5sRnyteylPcxj4Xm9aY2it0S+E=;
        b=NAsy67xMd2XMwexj7wKUsyD+WCvDYM8wrNYzOK8dManO7VtZc9mgyN/9kqEWqrYS41
         yKGDmy0l7D9HI2R1zAqYhIamolDIajtSjz3HSZWMflJwDlU+CSqxhAq3+1MPdbqSWvdJ
         C6ZmG7GMVtDdcO+8e6BjDZpw41m5dPpcwMFTVIfytpaLAArPNc+zqMWZshGfkMcDzwn8
         GeDJ5RMKOJKrS40wYMsj1/ThQpvzRNBMFKl4zqZQweMxmRYBEiCM4OnfNzwhbQSYEbtY
         uZxEkcYyT0Mujod8s6QewbQprGSU0H2uwTsObNH6HEvYx9e0yCbU1S52tEORUWjwJ29w
         a4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177732; x=1764782532;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMbAlPYdoISwPLiWW5sRnyteylPcxj4Xm9aY2it0S+E=;
        b=pZaSI7aUSuwuHaV6M6Y+Ikzmczv0x+6MXesXTy8dSRZoygNddatps1JDuSkhiscFYk
         gUirlq7YpoCjr4K8luGRDo9x8IDLA+uWx1igM/F+Sak1z3keLbtorbQ7Jiu+IqzG7XrU
         P+G2F0eDg7V0NSXGQAae8/61X+Ca4a2LaJxgqT8KDqL/NLBHaeIg8MzzRLogL6iPmsCU
         QAqDBi4Jjzt4qhhCWgilmmRVKFWVvXrsdU8Y8o/5DAUn5RkUOe2F+rIJ0ozTnX/JoGXV
         MbbY+o7flK8JXXKUSCzTpszaZSRn2v3Pj7fDwaAl5jE8km6qygAQxpydwU0ybloga9zp
         G4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUUUn97aeajPiO7ICs0HDRIgQyCKkxhmDHCvqF4VTmIGTEeOQY3N1/4UZVDh/Bq7bNs4HqvxLmGX6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52CtkMl6JnxOZ5WSjEREl/ff+XyNKi2b/LuMTNM1n9x23qNoY
	eFnm/gg8yoIaHXFrxezR1G2HynOK5AKEpI3Vlj5UuUlvRB/wT+DnUdSwWyKkKwjre90=
X-Gm-Gg: ASbGncusyH1hREWBn7Wk0WsmgpOzfHwd2v2FJysrb2wOYNCItmT5a6HhnIH/ScrBD4z
	0FKTSjdG3T39Ew7F9x69lDsp0dND6gs6WgdhPSXKm8BrhZexjt89tZkpt7tJCQofywl/g5m0ulW
	M6pVRBEPsyRVUN2tVa0jY2Vp6c8VvKUkOh0YVprK+/Qe9mxpnw1Q7zMQi4sZh3NzIDfpYkKerwY
	QQoA3IlwHl6DAixEyn3WzDMqPXJACDMJDQHHK4z+s1cGEkUFRKyIKuTB0zs7/d72pFRyc3n2o6p
	UcxlS/RvUvReDA9oCb3hBvpyxMsJUZ3T13rXbf2zv1LN34p5af077KSmNFV14dK3i025F6JghF4
	AIVgHcMhQe2osB2x6i+rE5VaHUpWA+AKj4OSxywiCl5hP0WjpnbgpHGI+3JUNONDasnYsvoMzYE
	/1nHFZOhTlYnoWlOlJY4M=
X-Google-Smtp-Source: AGHT+IFveJWow1MlKZhvBvDFWET9HTrn614Fkdf0VqG8AOTAuNxSS7l7a/cBAeHUgCNj8XRXHc1RFQ==
X-Received: by 2002:a05:600c:1f0f:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47904b1b27bmr75298265e9.17.1764177731802;
        Wed, 26 Nov 2025 09:22:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c44dcsm52202665e9.11.2025.11.26.09.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:22:11 -0800 (PST)
Message-ID: <2e7ecbc0-6ce5-403a-b794-93aaff1ddf39@tuxon.dev>
Date: Wed, 26 Nov 2025 19:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251125183754.GA2755815@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251125183754.GA2755815@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Bjorn,

On 11/25/25 20:37, Bjorn Helgaas wrote:
> On Wed, Nov 19, 2025 at 04:35:19PM +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
> 
>> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
>> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
>> +				 int where, int size, u32 val)
>> +{
>> +	struct rzg3s_pcie_host *host = bus->sysdata;
>> +	int ret;
>> +
>> +	/* Enable access control to the CFGU */
>> +	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
>> +		       host->axi + RZG3S_PCI_PERM);
> 
> I suppose this has been asked and answered already, but it's curious
> that you need this for config writes but not for reads.  Obviously it
> must *work*, but it's unusual and might warrant a comment.  "Access
> control" must be a hint, but only means something to experts.

After initialization, some PCI registers are read only. To enable write
access to these registers after initialization, the access control need to
be enabled.

This is the quote from the HW manual: "Some registers with the RO attribute
stated in the PCI Express Base Specification are writable at the time of
initialization.
 When writing to these registers, CFG_HWINIT_EN (Permission Register
(offset: H’300) bit[2]) must be set to 1b."

> 
>> +	ret = pci_generic_config_write(bus, devfn, where, size, val);
>> +
>> +	/* Disable access control to the CFGU */
>> +	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
>> +
>> +	return ret;
>> +}
> 
>> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
>> +{
>> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
>> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
>> +	struct rzg3s_pcie_host *host = data;
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	unsigned long bit;
>> +	u32 status;
>> +
>> +	status = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIS);
>> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
>> +		return IRQ_NONE;
>> +
>> +	/* Clear the MSI */
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
>> +			       RZG3S_PCI_PINTRCVIS_MSI,
>> +			       RZG3S_PCI_PINTRCVIS_MSI);
> 
> Other writes to RZG3S_PCI_PINTRCVIS are guarded by host->hw_lock.  Is this
> one safe without it?

It should be safe as RZG3S_PCI_PINTRCVIS is a R/W1C type of register.

HW manual describes R/W1C registers for PCIe as "Write-1-to-clear status
. It can be cleared to 0b by writing 1b with a readable register.
 Writing 0b does not change anything."

With this, it should be safe to drop the guard from rzg3s_pcie_intx_irq_ack().

> 
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
>> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
>> +
>> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
>> +		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
>> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
>> +			     RZG3S_PCI_MSI_INT_PER_REG);
>> +	}
>> +
>> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
>> +		int ret;
>> +
>> +		ret = generic_handle_domain_irq(msi->domain, bit);
>> +		if (ret) {
>> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
>> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
>> +
>> +			/* Unknown MSI, just clear it */
>> +			writel_relaxed(BIT(reg_bit),
>> +				       host->axi + RZG3S_PCI_MSIRS(reg_id));
> 
> Other writes to RZG3S_PCI_MSIRS are guarded by host->hw_lock.  Is this
> one safe without it?

RZG3S_PCI_MSIRS is also a R/W1C type of register. With it, it should be
safe to drop the guard from rzg3s_pcie_msi_irq_ack() as well.

I'm going to prepare a follow up patch to drop the guard on
rzg3s_pcie_intx_irq_ack() and rzg3s_pcie_msi_irq_ack(). Please let me know
if you have something against.

I can also prepare a patch to detail in a comment the "enable access
control to the CFGU" operation in rzg3s_pcie_root_write(), if you prefer.

Thank you for your review,
Claudiu

