Return-Path: <linux-pci+bounces-29641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658DAD8273
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFC7A24E7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424051E0DE8;
	Fri, 13 Jun 2025 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFzeEhuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E72F4323;
	Fri, 13 Jun 2025 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792122; cv=none; b=gs2R0TU54GBUNKg0KCWkQA64PxgBdP2OcEakswpX7jrpk0k3GbE/JOr46cF69LmYkBgZbmPC8e6QHqewBNRaL9JjwrFcOQq+EKvUBsgUGDRuPLfBgeVgJ5zJOMOdBM2CprfxVopVUHphyGd3fmm1mZ//CyGhLuCy1PuFpObFOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792122; c=relaxed/simple;
	bh=n7ceN3GYDnocXMrdSj3yjky9/X56b5mQH+tlsVT2D8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRAF+J39UBPfO8GrIbDZ/7l6GNlsIwx42ZndJqCt3uck0ComcdNxbDu8vT6Xi1gAE+uRKlRXwUtWp2Hz49ixvpPIfgTdFdYbhnDWPgipn/L3LFCu0a8Ie1JvnfvE6PLz3GdOnYkuPj0JnhnDvP5jipJ369y41kNGSMK9xF/0cD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFzeEhuu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234d366e5f2so22751665ad.1;
        Thu, 12 Jun 2025 22:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792119; x=1750396919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jifCCUYB+xoFd1mhgCPlAVXrt+Ids6RCsiMOlk39VdI=;
        b=cFzeEhuul0wMpbgl9z+oYcJfN8MrvIYJoLH2A2iGtRPW2z8gGHWOOHWINX61R+wbTC
         2G0cae71mwT09GUPZ4v8G0VMt9qYO+NqGW/m2BUBgWx5tnY7yeGKngXB+aDugRc4gBrh
         Oqj7YAkFt6WG1Jp8TO1J6N4Bp4b0WWhMrYTZSEC16qumbdNxbcXkiL3EKHldneZnxhx8
         RfFG1dSCrPGoEDy7DSG62SiBg5y4Mv2MaLMc3G0NmHSpwzkLFte7aOWe22rHR+K8TWK6
         QDLPgJVm0uR7e+ceW4J2WXGDdsQXhEeZUfyrnUSmRd82SZTuGAzgJAx2myOew0SLgZ+u
         1Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792119; x=1750396919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jifCCUYB+xoFd1mhgCPlAVXrt+Ids6RCsiMOlk39VdI=;
        b=M23SDsX9IHURcVE3b2TIYh9xLViZNBchQs1QuxoAVWv6BztsY4NAclt3eLZ6s23Z7z
         l12cKJIFTxLs05WRwg5oKJ4lZkriWfD7Z0uFV5U4EumzLUUC+SDEPzLGbv2RbtX0qXOp
         maEvHE9UzpW4f7GfcjRZTIUVsbu4soZcs+kYYvVBlqnbbwTSdBA6AAPY0EcNzmPxa4zV
         OHHTCOjn9hYCRZcK4WMcKeCVwoJ0fNF5UwEkEbCT+pNRhlacpSnK12RIcQEwL0m+/n7E
         EBUk//vEwuViFLi7J8y0Ny3XkXaw9xBjqthh/W/k9ze//bPZYJ7PJLh07TXvPVI1JHXX
         OmyA==
X-Forwarded-Encrypted: i=1; AJvYcCVg5etV1a/wKEuhxf4wdGHkMtEz5jweti1e+xIS2sLlfGLUAq2eJ0bhfcNN7F1g+8kNZhetBHjtQPJNtts=@vger.kernel.org, AJvYcCXi0jjGmbb108v+gSLU+YkA+Vw3G0p6nVWBYSZgUIHTLuadwtddrBrtv25wM5x1md/PAEr7SpsnzWjH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9BpemIiMorH3FXNSIkD16tt7i3jqC88pg0pW6975unshziBw
	2QDpOGQbg8ui1p+4x2z/u0xmuXOWzIVwpFVWag2s7qQy3NIUdVZ24iTz
X-Gm-Gg: ASbGncvlQjpTRkLy7nxmLJED24chyW5aDOpOY3+FuEiEKumvTjE5YP0XXxQOraIL6nO
	y3YY0pf7acNdp3ndqx04DF9FyRBp+kABtyl1kfPimzHNG6mVwxXiTBY0biP6A+ibwIPDml0UGVO
	32qewIfeOuimAvIFilC32Ufbc6c21N9/FExPUABh/2UjZhuKpLGFIbtb2aFvxdEpncf6r/UUu8b
	pdvTvm6rutEJHfhkHIvmhmiEo6H2L+1S+OQ6ZhRZ7BEsx5alX9sn9zLjS7KtUd79JbOmrmCWoLo
	I8fnwUHY2eLEEsfg0zCEULv44Bmey0y8wOj+qV8HLX/gMmPClA==
X-Google-Smtp-Source: AGHT+IHrnaZGWEeRSyMjWDgSp4aRGI9qMBO/Gbg6WE+lbmNGxeLn+NjsdsLBxmiprq5lNvsVXHE1qA==
X-Received: by 2002:a17:902:f611:b0:235:ef56:7800 with SMTP id d9443c01a7336-2365db04d46mr22958265ad.30.1749792119296;
        Thu, 12 Jun 2025 22:21:59 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78181sm6257875ad.122.2025.06.12.22.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:21:58 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:21:53 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/5] PCI: rockchip-host: Set Target Link Speed before
 retraining
Message-ID: <ad9dc26689ae2c9e811d093ba18c9e579b6747ea.1749791474.git.geraldogabriel@gmail.com>
References: <cover.1749791474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749791474.git.geraldogabriel@gmail.com>

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it to 5.0 GT/s accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 65653218b9ab..68634ae8caaf 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_5_0GT);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-- 
2.49.0


