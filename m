Return-Path: <linux-pci+bounces-20781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22190A29D58
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8DD3A6FFB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 23:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F121C187;
	Wed,  5 Feb 2025 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJxXR04T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523921B1AC
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797405; cv=none; b=AthhgCFDNHdtX9hl4dFUjyOAaKMwTPr2Jk0k3t+qov9thOY28nLR5W3cfRSrPvwP3IPJpSFrzlFlHOnRIu9WMvBIEJY9u58IetIfJ31LoKnxvuozEp4iNxj+VkIBdnT7fBo+P4aNIMYOYjCAIzqeYIWSeM3DzVSyc7ahpUtpU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797405; c=relaxed/simple;
	bh=pr2rmo5su3X65MMD2mF5XWj3uUgPZwN921xr/FoCywM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXZl25jWBA/w5XJWf9VXNfC3ftXcS5Q9WbnyxMfP0ydMvMMLw+MPrtPoLnl5umNX/8JzfzwL43C+385Sft0UckzYtOb9TQBTjHv/tGzpVzVXfoRfjTOF5Ma6BRmpFL9lokYEE3MIprdP35P7BSgGgFeUlQhfT0RXP7IC8ciGbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QJxXR04T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so7391795ad.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 15:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738797403; x=1739402203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aE+HA9kZh2AKZEXcXSOD19hUwawybG1vuk42DzAnKiY=;
        b=QJxXR04TFJYi0GvjW8/8zwqpqT35B7LRtgWVbaA+Ru720N9WeCbtmpLi31Uboyfyj+
         atZW1HFxBxfh3u7vBi2qhmK7hNH1xmkUp8f/ex3Wz7UwVm/Jkr7fMbRzOmeRgZBuyhw2
         zZn72T0stL/ZSbElyLr2yV48U2nQBzSPOs4GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738797403; x=1739402203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE+HA9kZh2AKZEXcXSOD19hUwawybG1vuk42DzAnKiY=;
        b=BTeWl9Wn0NcySeArSHsT/h9Hchn7UKgnPJftvtmfOCF5CUag3pAZBTvtdKPF2sYih/
         opQOF5X0X3+zad+RIiCjUUWds/Nzm4utthuS0B+ZarcI9ifw5w+dWXN9WFZzXz1DxIj+
         coQUQwt+DcZx/BQ5iqTLvU2659L51RCnX9xX6YRdSd0cTHp2q4qXtESPGZqgyl+nBiPy
         N9CtHydOuDHzS2OS4S8V+eW+n4FW2CsLlrcuO6w518US/x3i+MsN5aQ/y9ENTzsZAysT
         oJfsUPZIoCTSrjUwr/Q18yUEWH3RtcrmAklwim39r39LgoZclVLbwuD5FJCjklt9A39m
         xrxw==
X-Gm-Message-State: AOJu0YyyVOe7hOkHEEP4Qze0DjFTdDNsmwkrFmqDstbtUIKgysUimQg6
	Z5BsTW/VqDtMKG/6vtRX22dL/D6mv1dTBkKqpRuokRCadQbVQ+IwdThOIE9mSA==
X-Gm-Gg: ASbGncuSIQbOdyGCh9tIaNa6dor+2Owo7uGDsV8ab9TF5B37xN3DXOxMrAj+Oute1Qa
	xCwUz1BeQvcacX8qDjNPc9YNYCmS0cWpVZ+99bs2no3nKhQ+eBRK7Pw6mGq3mU95Q/hWUioTCRh
	cv1FTCWjN9hhMJHstjYgs8+mhcrfwg+W+YtavT2jwRWEtjLGc/w73OrbXACFsrhIkKAFoZOGStX
	K39dVE+kCJR6UivqMBsUWiVhAHo48W7VhJvgwrKw/kouVhqt8O9tTDwBFATSVhwLgbE8tTx9ZN0
	bta0EnwAXizafEneAoLuBsn65y8RiSGyeM5/cwswGVVXwAz+syTSxA==
X-Google-Smtp-Source: AGHT+IEw7h8D9k0wcxPyuWNUO+tvdgxr2MN/FkdTIUl3fEX1J/ZSsGOCVHq8CAKWHRN2MfkAw7xUvA==
X-Received: by 2002:a05:6a21:9011:b0:1e1:ffec:b1bf with SMTP id adf61e73a8af0-1ede88af9d6mr7790295637.26.1738797403657;
        Wed, 05 Feb 2025 15:16:43 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:2382:2804:f923:2c2f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ad2612sm5812b3a.44.2025.02.05.15.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:16:43 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Brian Norris <briannorris@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI: dwc: Use level-triggered handler for MSI IRQs
Date: Wed,  5 Feb 2025 15:16:36 -0800
Message-ID: <20250205151635.v2.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

Per Synopsis's documentation [1], the msi_ctrl_int signal is
level-triggered, not edge-triggered.

The use of handle_edge_trigger() was chosen in commit 7c5925afbc58
("PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API"),
which actually dropped preexisting use of handle_level_trigger().
Looking at the patch history, this change was only made by request:

  Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
  https://lore.kernel.org/all/04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com/

  "Are you sure about this "handle_level_irq"? MSIs are definitely edge
   triggered, not level."

However, while the underlying MSI protocol is edge-triggered in a sense,
the DesignWare IP is actually level-triggered.

So, let's switch back to level-triggered.

In many cases, the distinction doesn't really matter here, because this
signal is hidden behind another (chained) top-level IRQ which can be
masked on its own. But it's still wise to manipulate this interrupt line
according to its actual specification -- specifically, to mask it while
we handle it.

[1] From:

  DesignWare Cores PCI Express RP Controller Reference Manual
  Version 6.00a, June 2022
  Section 2.89 MSI Interface Signals

msi_ctrl_int is described as:

  "Asserted when an MSI interrupt is pending. De-asserted when there is
  no MSI interrupt pending.
  ...
  Active State: High (level)"

It also points at the databook for more info. One relevant excerpt from
the databook:

  DesignWare Cores PCI Express Controller Databook
  Version 6.00a, June 2022
  Section 3.9.2.3 iMSI-RX: Integrated MSI Receiver [AXI Bridge]

  "When any status bit remains set, then msi_ctrl_int remains asserted.
  The interrupt status register provides a status bit for up to 32
  interrupt vectors per Endpoint. When the decoded interrupt vector is
  enabled but is masked, then the controller sets the corresponding bit
  in interrupt status register but the it [sic] does not assert the
  top-level controller output msi_ctrl_int.

Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * add documentation references

 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..89a1207754d3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -198,7 +198,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
 				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
+				    pp, handle_level_irq,
 				    NULL, NULL);
 
 	return 0;
-- 
2.48.1.362.g079036d154-goog


