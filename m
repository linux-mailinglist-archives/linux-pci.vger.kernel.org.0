Return-Path: <linux-pci+bounces-41117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17CC58A06
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EACA4A727F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DF2D8372;
	Thu, 13 Nov 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GpdDsCqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370B2FBE09
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047487; cv=none; b=ug6qcFCMjz/CrsoUSnMcx4tjiJZs4BUwl8S9J4I+/SjcHtL7abCw44FXXOgph7ylMX0apvfELSHHb25cljkOqyY55pFT68LAZRybXUHxrjmJ9iErCvF2nLsD1JOy7lNinGChhNNex80ueynG+n5gqBF7hbshBo2XAGAdj0eY4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047487; c=relaxed/simple;
	bh=a8Oh4ByEmIDtGdZ8h4OuLqjW5FkDttrFXTOx2NT4iss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFNFqUgAXxCgxzk9Yr9ttxWc1ka1lfErKHLN9CGEvBxAnP5v11T97/m2NXQF63l5ZVzvUIumtawYu3tuzOse5UA+3IaRE9zWbGN00L2yiWPrzXKIv8qclnhcufaGzAMd16j+MFwNczRv3y8ieciq2BEUGURYiBK7RwWnfRgbCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GpdDsCqr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae77516so10861095e9.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 07:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763047484; x=1763652284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iB+JT+rAjTzk5qbj4tgjSnTjnda4G40CL0DtaEMW97s=;
        b=GpdDsCqrLIix28BI6t007HUPegFO3MBRZgB+SsxTYwALow5rm66zBh7t9qjBFivPWE
         9aejZSa4HfhABOr6MBT/H42UMdfZ+lXTQnVFGpLhbdaJ5Uu0o87PxRV6xE4HHyJdDRyr
         hZMlg2jqpoPlhE4vKjAeIumZrnEF+uShmuoRgQitPSYH3UfskwS8yLLUqn1WBrHwV6hp
         Jg52+FUe8trj5HkWCpWirpK17M1P2A/T0h5OtgIZaOdGx1WSuCevnkJu0vZMSgBnjU0Q
         w1sU4r2Hwzyk91khCOMvNt/KezqretHovC9HFa4DHXOffv3WQB2j5AcbCfbLxmloQy1n
         ENyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047484; x=1763652284;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB+JT+rAjTzk5qbj4tgjSnTjnda4G40CL0DtaEMW97s=;
        b=JrGrsvAnT/rXFyPE2jiCGjMxShtwU+f+/9dPEEWFaDT3KJajd4HHLiyPdaWLJmCAY7
         GRKGlMQy4ciUmT0tthqDaB67BcwgckZw29lu5+rT85MOEbPgfxZLOFvui0HSu9J0wMBT
         HEMELUtseC2DZXHic4MeIdssNH+j63DL69Q0/VeuxpYIef1SNJcvGQhm26N+/w14lva/
         LZGv932z76+6y0lPkmCOUJlakrTb3yJlHfndZEyMky92HnZ/EkgkcZhdSlLXH9guMIP5
         LzkR8g8HQB586hGmMxhWB2JJaIlAy3KvNTAcTIjNZAc2nzHTecQjzLZ5MpakFe9hiNnk
         /EKg==
X-Gm-Message-State: AOJu0YwNbLglo5fOoynU5fUFxwatDQb4+axtq4G05+P7ZhKkyT/KQJp7
	bQxbcmIMkzo0FAY8Xu6SejhRdki/43F6qcATsdvXt+Bt1Za6NyiaPuTlUrII0zJchcQ=
X-Gm-Gg: ASbGnctHaJtPgFKY+GSeddznvs8qoMgzbZc7kR0cFpk+OSknzVEV6e/ROslZVnrG6WQ
	3mnqRuW8ps71DSUmoM6jCP3X71xzsYxEk+iePKDrQ79dPNjhPLEEhT0/CPfMvOwmxzTOyCdaO0f
	RICLwaNnId+KQoR2PSf0dr21V8h75Gj6TB2MaFbbiZlFP4XhOV9/zz2/9LK8gloaBP8MSZlYm47
	nvTYMvUq4Z7+rr09m6SQBXAdrglo2tu0Vl+7UN6JOj0XX0nQrOrWB+SIaNzHoZ6ngK1a9nacvRw
	KriqiBwwyAIV5ol3v0f9EXuqmgcD9A8Svr0BsgqoQidJxTRuBxquI4Lr/oIFxjUB5ETd9gtUFQV
	TVXVjTn8fsw+MNa6NDrLVV4BxVO8wMuPy+f+iRteetzl718mcMSoKp+Rltrj62dYNRiCzKUKcJz
	YMpFJ4pvED
X-Google-Smtp-Source: AGHT+IE4kSPN0NcyZr5YwaFByd3zY3e87tD0XqKRmf32VutndhscEu4TOszysUiok7ZPHwh1vTJRjw==
X-Received: by 2002:a05:600c:3546:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-47787095cc8mr69292105e9.23.1763047483038;
        Thu, 13 Nov 2025 07:24:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e97a87sm4923542f8f.20.2025.11.13.07.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:24:42 -0800 (PST)
Message-ID: <c8f7f55e-4229-49b6-8627-2a177ca85d5f@tuxon.dev>
Date: Thu, 13 Nov 2025 17:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029133653.2437024-3-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251029133653.2437024-3-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/29/25 15:36, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.
> 
> Hardware manual can be downloaded from the address in the "Link" section.
> The following steps should be followed to access the manual:
> 1/ Click the "User Manual" button
> 2/ Click "Confirm"; this will start downloading an archive
> 3/ Open the downloaded archive
> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> 
> Link: https://www.renesas.com/en/products/rz-g3s?
> queryID=695cc067c2d89e3f271d43656ede4d12
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - split the help message from Kconfig to 80 chars
> - dropped unused defines
> - dropped dot at the end of short comments
> - re-arranged the members of rzg3s_pcie_child_prepare_bus(),
>   rzg3s_pcie_child_read_conf(), rzg3s_pcie_child_write_conf(),
>   rzg3s_pcie_root_map_bus() to save few lines
> - in rzg3s_pcie_irq_compose_msi_msg() drop drop_mask and use
>   RZG3S_PCI_MSIRCVWADRL_MASK
> - merge INTx and MSI configuration in rzg3s_pcie_init_irqdomain(); with it,
>   rzg3s_pcie_host_setup() takes now only 2 function pointer for IRQ domain
>   config and teardown; also, updated the names of other functions to match
>   the most used pattern accross other drivers:
> -- rzg3s_pcie_msi_enable() -> rzg3s_pcie_init_msi()
> -- rzg3s_pcie_host_parse_root_port() -> rzg3s_pcie_host_parse_port()
> -- rzg3s_pcie_host_init_root_port() -> rzg3s_pcie_host_init_port() 
> - used dev_fwnode() instead of of_fwnode_handle()
> - used fsleep() instead of usleep_range()
> - pass "size - 1" to rzg3s_pcie_set_inbound_window() only and keep the
>   undecremented value in the calling function
> - added a comment on top of request_irq() to explain why devm_ variant
>   was not used

Could you please let me know if there's anything I should be doing for this
version?

Thank you,
Claudiu

