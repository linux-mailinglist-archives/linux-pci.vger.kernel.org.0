Return-Path: <linux-pci+bounces-30282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C04AE26E5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 03:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC081BC49CC
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CA433AD;
	Sat, 21 Jun 2025 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+lcaOgW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA517BD3;
	Sat, 21 Jun 2025 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750470519; cv=none; b=Sbe04o+vW5kZcdV0tuxIs3JfviCRyiPjoGT0hhCTGFpoFjYeDQoxo4tvzFFzwtFvrTvx2mxHfU58lzJxusK+4YS26DZ8cEOazbzgjgg52KrltQO8VhKK7MNEwgR5qMO6m/De6Ll54yDnuHBKSCyWef9aNQncs5IVsv5ePnKATiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750470519; c=relaxed/simple;
	bh=TMyeQZWAOAuTwvIXse5kaD0KDoeWmnfqoNhsSOfoCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLQkEvzN1RN50h3xQVma8qaa6XsQem1NatVVBZAtbk1E0j9lOaP0QPIC8ZzcNMUYzw+hwzyvjIlV8q9Xln1BrI1PQkETt2pQeUorsuny+fum1Ph3LVPKXb3BFoJMsn3+fwyyDOl0xJayNv5PcUUifRRHspLhNfoqRfNyKL7NoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+lcaOgW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b440afa7so25720955ad.0;
        Fri, 20 Jun 2025 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750470516; x=1751075316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=h+lcaOgWxsZWqJTWk2z+vtmy7dKE+VgiPEdm8X5FoICO6H9C4JaNHITxW5tA1FjdxE
         SamvN31tHNRUrmXVAjZGkVidXY+/dMJ9ahNm32fhZu2G2ugwvWvnsXf8hAtQKhtGvknz
         GIlkEbgQ44RX5So3mNjDT+Z9FxJfHld9cPLDwbUIpPjXN3e2+Uk9Cr2rklQfYghAhX67
         qNKt3b3J1fuj/8uDDtcVrUVRdTFFNOka7hKj7nU5RSAP247iav5KnVTEPc+CXMksv+Bf
         P2jrpQGNUHAwgRRLmQVH/msOmKB6mbEfnJEA0dzyC5TnyzJwip4HY6R6gS2DtH0hNtTx
         ZiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750470516; x=1751075316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=UWu2XGoZZ1kEVvcuQ+YdSXprekwOUwaqSMgzEbysWzCl2KHASdV9lTohYiunfGGige
         8wIrtOZ1sXJq3c6ZaClt7QgMN4OXOM2XTkAr8s1N6O/jA1XELazRZ71wV1rqiYFr2DNL
         ERS3qr1DyGjzprcUNEy2L6Vr4zUInS7bRnpq1AYM0IGmb5RJxcZFZP+sgmS2lBORNZN0
         m0EOjNu5RQqC09wOoKwwfbnMKzC3i7C/FVDHU/QOGg+pcXN2oOrN9YHnOmLzvDBxUsZm
         64OeI021CXCbhvzgSZRwruWtDMRpry+48Ga88WX/VxMF+ECtqn1PYvDCGXv4CR5WoBuz
         pCJA==
X-Forwarded-Encrypted: i=1; AJvYcCUw5k8KyuZqtqhJGRjeNN1sede0oWfeA3VdAOojwN/k7x8ZQZNlJGl4DlDRzY7N767TK5KN0RuuICRt@vger.kernel.org, AJvYcCV11NeSGRl44aL/ju8BJD1kBcU34UBkjCoXhUT+Ggqp4LZovXEYUZ7qATkaQwEZSAJGj725vpqArnK9HCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9vbb2gVce09uWj136B/EmHffgvDTQLUh1gIXexrlsZc0j540
	lMmjI5pLvTZ5AfJ9gXeppIXOvGUWdRzp9A6b0po+mOOQp6WdjlsZikhm
X-Gm-Gg: ASbGncudLWSNAz3//bPfFHOby0ujHEAMFs+CV1jxFelWso3VmRwNW0QyUCLgEIdrLle
	S2xsCMQ6bjWv2j0QKaUR0PZz/UhXV5pRqYbrOTbRQesdRNUiNjgDb3wAU5uPAyVMve5iqU6LMTf
	w5VXY3YAhDN4ehnpc8SKv7C8p/aUEsf2YPNvhclz5l+W6FIn2TU+AmWIrYo16fu5M3p2EsNmJgI
	0I/UXHBg320xwvZh5fu6b10Y8tKLnzKZ1XO0tgPaZaEMN6XogRdq72HpPLwfkJncv0mx7yhWHgP
	VRYhjZiaOzHXbDRanNhPWXvbXIaeSWJGkrJjDEOq+a1477IXOfPhoVB44+B1
X-Google-Smtp-Source: AGHT+IGm/Jggfckdj6HI8cIvmve7CSJ/pB5QUFvBniX73YqNMzADesGHqX4F1bRZCdJ5ROCygqCy0g==
X-Received: by 2002:a17:903:1c6:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-237d9852f68mr72238635ad.27.1750470516535;
        Fri, 20 Jun 2025 18:48:36 -0700 (PDT)
Received: from geday ([2804:7f2:800b:d1c8::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8398dcbsm28491955ad.48.2025.06.20.18.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 18:48:36 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:48:30 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 2/4] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1750470187.git.geraldogabriel@gmail.com>
References: <cover.1750470187.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750470187.git.geraldogabriel@gmail.com>

Current code may fail 5.0GT/s retraining if Target Link Speed is set to
2.5 GT/s in Link Control and Status Register 2. Set it to 5.0 GT/s
accordingly.

Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 65653218b9ab..25890f6c0e17 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);	
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-- 
2.49.0


