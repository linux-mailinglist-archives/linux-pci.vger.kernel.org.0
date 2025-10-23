Return-Path: <linux-pci+bounces-39135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84CC00B29
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 13:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41DE1A61BFE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215D2FE059;
	Thu, 23 Oct 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ke2f1D9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621592FB627
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218595; cv=none; b=Od7HfczpdzBnFA+aZuCzgb5yI14T7g8T1T9oSiLNFsQnCvpoklBzWc8XMEPZOqrfDie801CsmXFk3rfy79Rwhq3mPvTYfRZZmsUnfIXThe8LAHLoZ4qIhQeYtEZWTFHufMHPK4AY+qv5O1hwCSndZlbeOQU15UJ6s8fo7F7P4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218595; c=relaxed/simple;
	bh=EejjgDdqkl4dBbr+6AbIsNlOUfcuNaN1bBULFXf19rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy92IgWiRynlfrMRfUk91QgMsPGcxlLZ3qZAz0wv1LG1I1MZgaOeaoRjP5oR2tRRBblcnFiGDMGN9/9UM6rr3MhCSmIPHezNHJtq4++9A/gmiWvYEmn421F/f6+D+JVwrLDBm/ig4sftnc5w4gtDLexablGl46hkZVg1PFrbvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ke2f1D9k; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427060bc0f5so413739f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761218591; x=1761823391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDB7YhxbGJEC3m48FGyuTUiZ3NJbd0w6RqSoQlZXD2s=;
        b=ke2f1D9k+NzuFAjLYXCRVzkDbFZelDzS6YTAq0oFB2X558cZegQ1PnqhxvtPyIUrtH
         v4vkRmT8GjXcIun0l0dR9SWb6vvj+DsIpkuwCdsru1hhup1jRIQ7+I2jL5rlEKHFA/PI
         YeMJXuj0RQ6t3PLQnoTNA/d/rizUFebpxLZG1UD5ac5SHf4Nb9/ttWmTPZWOedsAe37z
         KBpFy+wOH9IZHzx1O4KuEa8WizZ2btQfmmpahTXEEcsIlR9LrOb5ncOb4g05GY2/svgp
         uxAfa9pbwU/vBFwRj+jsGceuqsonxcRpOGPwBsydrBlTKwfxE/I9eJyIEKAN4ZbNNp+0
         UV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218591; x=1761823391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDB7YhxbGJEC3m48FGyuTUiZ3NJbd0w6RqSoQlZXD2s=;
        b=XUKalspvMS7ZVvmsCo/LtuFEIlhJacBGuFjfmkTl6PgVdYje/c4cpkcwuXDEZ9NViP
         Lz+Fp+gVkFK/UfxJivSECs8gCJE/QncF1L2xIYYL07zOSaulYmtxEYHZcNPO/FzDi15j
         kgroU55xNArVmPPVHA2XU5M6mL/5Wd/I57y3q3b7QyDcA2Cf7JJUsECFmTwDRkwDhqNI
         yCJKie9+CFHdXsv5rbmWvZEJ9DoraF6wqYxnVtsvBnEokMMjYgft8PuEa/o+0zJVuOrd
         uSbVK+WP1PPYvjLr8NlMNuAjLbhYSIiwWT9ZVVKGBxgKgPw1aab6ukcA5BgrK13sOry0
         2Vvg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSf4iWcYvOd8avPBGsH+QQ2SRa7yzRLnivKoni7iWf44/gtYjQsxAfEYfPaJuPjFZS3n6G4tFS8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SS5wB4wWTLfL3zTvRimfjiMKtbNKXeu2G3JHxR5ICCetzYBe
	9hIZMXuEQ5s7UlQCocBAiLUax7MOohaeJR4pgC9mopNSx+95ntcbRvLbCE/eIbU/CgPNOD0HHGO
	qJ7QJ
X-Gm-Gg: ASbGncsArd4J1W3MamcrKYlS40nltM8k3SRm4Is0SKFuUequHK6YOZyoTfuKaPDq/V6
	A5p1NUCBM2d44ln+kpCoRvxBIF/2zrQh49QHhUI572dfNQW6wMqGGFe3BWRofS5OUIoEXGlru5f
	F3j9nZFuVk/ZhZ7EYAqU3OG3Q7ddG0TB1HrB8NwxkgfG5Ww3CE7Ehr9PYNGUonT9AGC/+IS/fwy
	mZCp4ahnOl7AeQsN4yRu6swgmM1Z9NybcflNdUJPqWHJ/ftNd67jNu+p+L+icUUVAzR5bxojYQX
	88jI1FK9uyfCUI3MlXvR/mwii6bjJiv4PqC6rpvAmNIrHlasSfhU3yeOAkcTvk+lEA7eLBBnNp6
	Enzlqudugqa0zu+tSOR+6BzVAIbpEbHc3E4zf0NSK+c1UFiUPfRXszz/4BYfNLc+kGPh18rVSZV
	xFtxKxIZuP
X-Google-Smtp-Source: AGHT+IEMbLOeinwVvTuX2oj8cLK0836RwRcKtO4iOIjx+CcUWlYhQo8Bx0cOvk+DQVI9vd0jTJuklQ==
X-Received: by 2002:a05:6000:4185:b0:429:8cd3:886 with SMTP id ffacd0b85a97d-4298cd30f25mr236889f8f.11.1761218590672;
        Thu, 23 Oct 2025 04:23:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298bd78c69sm1639717f8f.4.2025.10.23.04.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:23:08 -0700 (PDT)
Message-ID: <f09bf940-3d45-49b1-8d7f-9c1a96acb187@tuxon.dev>
Date: Thu, 23 Oct 2025 14:23:07 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
 <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev>
 <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 10/23/25 14:02, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, 23 Oct 2025 at 12:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 10/23/25 11:00, Geert Uytterhoeven wrote:
>>> On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>>>> only as a root complex, with a single-lane (x1) configuration. The
>>>> controller includes Type 1 configuration registers, as well as IP
>>>> specific registers (called AXI registers) required for various adjustments.
>>>>
>>>> Hardware manual can be downloaded from the address in the "Link" section.
>>>> The following steps should be followed to access the manual:
>>>> 1/ Click the "User Manual" button
>>>> 2/ Click "Confirm"; this will start downloading an archive
>>>> 3/ Open the downloaded archive
>>>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
>>>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>>>>
>>>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>>>
>>>> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
>>>> +                                          struct msi_msg *msg)
>>>> +{
>>>> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
>>>> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>>>> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
>>>> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
>>>
>>> This should include bit 2 (which is hardwired to zero (for now)),
>>> so I think you better add
>>>
>>>     #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
>>>
>>>> +       u32 lo, hi;
>>>> +
>>>> +       /*
>>>> +        * Enable and msg data enable bits are part of the address lo. Drop
>>>> +        * them.
>>>> +        */
>>>> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
>>>
>>> ... and use FIELD_GET() with the new definition here.
>>
>> Bits 31..3 of RZG3S_PCI_MSIRCVWADRL contains only bits 31..3 of the MSI
>> receive window address low, AFAIU. Using FIELD_GET() for bits 31..3 on the
>> value read from RZG3S_PCI_MSIRCVWADRL and passing this value to
>> msg->address_lo will lead to an NVMe device not working.
> 
> Oops, yes you are right, I went a bit too far with the FIELD_GET()
> suggestion. But replacing drop_mask by RZG3S_PCI_MSIRCVWADRL_ADDR
> would still be worthwhile, IMHO.

OK, you mean updating it like:

+#define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)

// ...


-    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
+    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
          RZG3S_PCI_MSIRCVWADRL_ADDR;

Thank you for your review,
Claudiu

