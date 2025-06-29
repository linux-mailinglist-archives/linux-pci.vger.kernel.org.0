Return-Path: <linux-pci+bounces-31026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B9AECCA8
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4FC3B38EC
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35F21D3E3;
	Sun, 29 Jun 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvoQ+zJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687E1F37DA;
	Sun, 29 Jun 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201296; cv=none; b=aq0Q4QHpIwpg+K29eAwkCneEEqkTJpzNdatWghxT8e3mgicSOrBifrtHQLEu/HTBCYK+/uxFQ/bbOSAJ6pcnf5c/ZkwN5sd1Mmq0ttZSzTqRY3XEDv8c3U0DAAzODnfnEkodCDgmJF6MFLvtle4T18kSUNbTTkf3nlqmEtzQBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201296; c=relaxed/simple;
	bh=TMyeQZWAOAuTwvIXse5kaD0KDoeWmnfqoNhsSOfoCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aivEwPgyaU3WxGzN2ekgGZ5cGiHSwMmUWdnv5p3TdUs4JXSib+Q1sBdZqZjuxrWbNfHWQXrs2zhs6PlW+WhzU6iOY2Ra2RI/U1WesfP5yQQpycRFu+tyEUrP50VgXmF2zai0jeUuYRuBphIKMdho4hVzYWuRuUINjvNspssSbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvoQ+zJG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58f79d6e9so51168951cf.2;
        Sun, 29 Jun 2025 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751201294; x=1751806094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=MvoQ+zJGsD5SOu8I1y3TiFFimD5ryZdbjqTYT2yDg8xqIHiMh8GQ9K12UraKRk5lBN
         2XPThrGBKlgAkTOje8+mgOPwvLWrXH7SYtS1J8QLPe2Q0h1fSA8oExcmMNJ7LCcQCQ6m
         ixHfYG0pGTt5g2SrrAxMIri97JFXEbRrTq8UUOeWT8EF9yPgK6mUTfuMPuAvIhHpMUbA
         UrV13lvIkANj/nuNF8UhQhg6dG/8kgw7MrQZdN1lhL7lrrXoynUDmagnBKCNxrmJIu3h
         x7BhjHtGx5UgNsEBg5Bov5ojoakSMISOTBW08jxFOBanaqUnXjPKqfKlfXe0Fh34cUMZ
         iHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751201294; x=1751806094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=JEB8D41i1YRZEI49+n+VsdX6hagflo+EOZHXeoRK7QLeGdbVdjVc+h6IZTaPAa+HhP
         Q05I8rqfSl0Cfai49M6+j+yPOWkKc7xLFDuN2dTcGiAelCcnU3xvZ65D5z0n/ugwGspd
         DcgNbl0GW6ot9hjBF+yRBZt+Rx4c12PrSJBsIfkC1Eu/XxLyus8PtHRp6tcsy+JLqlD5
         hj1yZtFUcfwlO71BcvvgjXl/Jr2RK5y/SPLMS+pBefc6i2T2QYjUxyrc77RAcJavN8bf
         V2xHEg0E1KxAxtNiwcvYLzIpD0KCDixsrxj0paiB2qndF3vg1DLFf5MEc9JcgUwy7ipH
         2Tmw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSXL52gBUc/VkGdR5RiPNtJH7bw6+wmXi/0zzB+TgbqgPmZNjVu7Gu4dkWK8s52nWDF1yIpvBwBuq@vger.kernel.org, AJvYcCXFxBKvXgTEVhrJj9EKQUJDM+kuBNathYRaPBgVUJaHNr157ekn5LvpweTWC8w3cL3c1Oo1FviJ5hWJQec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4fTBQzG2JgvvTvzPsJXw6S/hhgN6uRR9/XekFi6HrBZfXZuw
	3c+7eenzZLelF82q8E+uRJIe11l4SXVUvNsR7Z4vLebcNSPxBjpgcv9w
X-Gm-Gg: ASbGncsn9qpqiPlD7gYHp4YSE7908rBw/4bgkjllYiy6Oy7N2mgqecJA/nHUYi3euz/
	GKTrrlefXSSQy0vQuDHDD9VYmO7k22UJY/a0Wi1oUBhfk3rtO0pAR/tOxPlsVP3cc2GC0xKXMQG
	dHo6n80g+PkeMflAcpKPO8lbuFt00X67ht53BbdaFFg7FkJZSfgfCLQTbAACgDnzvGjuSCFYeuY
	pQekBjHk8PHm0g5+W2MaRUbhc0EwFYzhDVD60zv0ahQUlKA4L+pRU+G49KcYdm5YfPQNmNp1Ur7
	CGkb397bP04CBXEic2esNS6XAal/p0fFEgzkQMLRz9H2z7ZPmQ==
X-Google-Smtp-Source: AGHT+IGiNquMhzJugS2btiY1s8UNBRt+TPGhGmmXE7yoAsxq4Al8mQ1vd1rQAy8wXSXKKwGcZx27oA==
X-Received: by 2002:a05:622a:244a:b0:4a1:356:5e7b with SMTP id d75a77b69052e-4a7fc9d55ccmr164616551cf.1.1751201293645;
        Sun, 29 Jun 2025 05:48:13 -0700 (PDT)
Received: from geday ([2804:7f2:800b:24f4::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc1392a1sm43185851cf.27.2025.06.29.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 05:48:13 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:48:07 -0300
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
Subject: [PATCH v7 2/4] PCI: rockchip: Set Target Link Speed before retraining
Message-ID: <0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751200382.git.geraldogabriel@gmail.com>
References: <cover.1751200382.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751200382.git.geraldogabriel@gmail.com>

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


