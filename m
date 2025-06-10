Return-Path: <linux-pci+bounces-29370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B51AD44AF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334EA189D0F8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99944283FC5;
	Tue, 10 Jun 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhJ2xPQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E228314C;
	Tue, 10 Jun 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590398; cv=none; b=NNP/eYTQu0Bh0hhDP5I7UM+//oWdU0sSCFcPOS/wF9rO9hYUX6A54yTcifaVr3WBUywphr3lR28uXgECGWujHbt6tQHyiM3nV9mJLqtqJ8BF2y2a5B765sdUt6/xq2sTPp8XXjsaGzyiXjigFPtahQMo18wFBvLEcb/VRMO/ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590398; c=relaxed/simple;
	bh=psl2yGFKwIeajZS8qg8mt/cUrID+Wsj3xhRh7GlCvFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3WPCI/W96DDx4oVHBVKakp0xNzk0bZ5+Vg4huVIiWoEfbYR1Y7SJ0N9zt9G9tmWB4I6nfKjwyVtckWqL8Je7+QKN8ro7q5aqmzxZrg2exwQSmcRgmsx2YxI0/UTogXcKU0Ifn75fMJvS7kMlOLSNeZnvKaIBwe3eaZh+7O5qBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhJ2xPQJ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7b69c1efcso234870137.2;
        Tue, 10 Jun 2025 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590396; x=1750195196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+KcteMx3KUNTcvwakQQLo/YUGvViEhrbAatOOYWoE=;
        b=JhJ2xPQJYNq8gwxP9O2sCbI/jIGQ3SVGKLa6oKyhSZvR08CjZqjqa8mW2oOiSxBBAt
         mP/vhYdh+bzdtjarQ5BgEsexq5+vY75uHz4AgMGlCN443Nzfhlsjzab+yVHN5t/ppcGN
         qmPJXPaTVqf9yEwioCdwjJ/k4fBLyF054Gzd617MGdHJv6gNpRQ1YHOvF/T8x6uqHFjy
         r6IqQQEgLD5LClB+XCpHOGFf3VsUPaAuLQiP9VqdqRMamYqz52x6q7yDKgjYFUYyF9c6
         2ESgkpKhO+Cm6tzj7EnZTidiGhyEDo8J3yydGZl4QXUkmaw4APRagEiTYzAjxbwY+cX+
         cp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590396; x=1750195196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW+KcteMx3KUNTcvwakQQLo/YUGvViEhrbAatOOYWoE=;
        b=C0GHgxriSD2afUYvfMJIqIjCEMVJi8BWpWgsIwHKp4Sgajm44H26Boq0wSVRgAERFV
         VSmj6yb5MtZ9JpCGDvlrJ2h806Lg9EMYmE1OMzVDQT9phHozipbnHXPwPy4O1EPxNOw8
         Xb0p64377RilHMWhD+PoXlmrqALjqfcmf5KzAUxsOxtijSmJPk9qtX/wh0LI39+O9znO
         G56lO7oyMD+Dmb4ZkxxSpMVZajHCuJWg6+4d5Q50yfWBzu0mVTIeTcFHXpuiPQYTex9W
         uiC4ak4pCN/H8iob4XknsgUUd3zWAbyTkfDCfKtBVERHQe9BNE1M4K6Wjavs7kPyCqqS
         sfBA==
X-Forwarded-Encrypted: i=1; AJvYcCUtFw8cPARGbXh/JS3jcLM5jSFgvF3AbJA2nmjxQpZU8PwLNvrMonEkaTj7xwkplrnlIfeayjQ6Efxkk2k=@vger.kernel.org, AJvYcCWvGPYEPuzQ0yahJhO8+jKHkMR7rnQKn6JE5c/HeqVOEIwkv4jJ2uI13qC3Pw7VHjEs23kKEnPkM7h7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cyvv83MwpeF4k90HJLlSZKeBzK0FIhLKVbStx6adCzNOwrLh
	SWOIb+1e5dmLQnFQmOepB5iVHNccvHDtd0w77VG4wC4Y7XI8k5vQM/Z9
X-Gm-Gg: ASbGncsUKocrYumIXIdyQWDaPNI9zCtMfxj83EUBVAX9efaa4OsizZvWhRX/H3g+zPg
	FF4yYE9UERAFmYCSpeieX/IKX7tVghRM4ZQJTMCeugH1nIQzyJHM1f1Ao9e5u5pAxfkujG+6vuW
	LD9nHAA6zE8JOioqfvhDiwHdsqFTLt9CZF6NVxg9QSpMxGwTuaSpwqVFAqbpk9t8toUbBzPEca0
	XxKAbigNutfYA6kA7+BV4bRJJOCwHtywyIeDkCyKBdqOg/+nxDT4wmG6NFHkqtEv7P/vSBWdVgg
	gU2MK6AvN8nXEmQzvCGmSoq+PpGNHMxHRNjTdSlK6YIYbfoKVQ==
X-Google-Smtp-Source: AGHT+IFUKOR2IsRTBdY8aOGnyv438Gl/440UbjAA3/JAat2G2nQmpyhEiA+RhR87ZqQsV+IyUokALA==
X-Received: by 2002:a05:6102:4b1c:b0:4e5:918b:5321 with SMTP id ada2fe7eead31-4e7bafde5b6mr1050769137.25.1749590395586;
        Tue, 10 Jun 2025 14:19:55 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ce9::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7baeb6337sm382957137.3.2025.06.10.14.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:19:55 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:19:49 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] PCI: pcie-rockchip: add Link Control and Status
 Register 2
Message-ID: <28ae3286f3217881ae6ea3aecad47ae4567d6ec7.1749588810.git.geraldogabriel@gmail.com>
References: <cover.1749588810.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749588810.git.geraldogabriel@gmail.com>

Link Control and Status Register 2 is not present in current
pcie-rockchip.h definitions. Add it in preparation for
setting it before Gen2 retraining.

While at it, also reference other registers from offset at
Capabilities Register through standard PCI definitions. Only
RC registers have been touched, although in principle there's
no functional change.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 5864a20323f2..90d98aa8830e 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -155,17 +155,19 @@
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
+#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP)
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
 #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
 #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
+#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL)
 #define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
 #define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
+#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP)
 #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_LCS_2		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.49.0


