Return-Path: <linux-pci+bounces-29763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81848AD9373
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC40D1BC2746
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0322172C;
	Fri, 13 Jun 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEy0MV1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C092E11B3;
	Fri, 13 Jun 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834261; cv=none; b=VHAzzxZXZvuvuu2qBrkdOGThtVG5UXZYeCvWn2HfscTQJEBuHKr85iUE0383lQtB4VSkaQLwfSgrZhE/1OX+lbLiNiSIO6ycb90p3g0gUzkFQ1ayQMCLbq4Jo8RNdC6I6QAZFBv5Un4gVln4eOvRpozq+iD/GltXtCB7MIKbGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834261; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAfPL+hoMlyAKc1Hr4zGW78lvCWgtQDl4h634m9BbDzO3shJAmcD5PbYI4TsagXo6koNN8ZTSftrbRBVkhpEF6UEzja9/scX3IIvEo/wfvB3oHS5+T7OaTwytLubOq0zvuKvnGfYbB1tbxW/9/fXDrtvDODM+lbVXbazMWQeKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEy0MV1L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234c5b57557so24232415ad.3;
        Fri, 13 Jun 2025 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834260; x=1750439060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=mEy0MV1LyRQ2fZwdCDLoi9waqsmR6TbJFVMQXWfYci9D1uJLMd/1kSJ6fS04OZ7VXY
         r4zevQvwZbPwMomeAMVE1W4+y2lbnhS2V31oSEZqXyIJpomYUgphTIKlHeA81Xhaqpp5
         WpsRItbxuHEXG+TfltDsvYS1yvGMKfc0P9lo/gJ8b9rTdXzv0ZK//oD1hQHHqcFb8c9r
         W+HJ19T4M6kEo/fcsqLGeK6KMBkIk1iPP1zieLSauwXGGlP5iD72COXCAtufzYdF1I48
         z1ECVUnEIoifzoONpLDV9kZgvxxkI8dfebNL6VaIP4ThYJy8TRJngOP/zh7xtWmlUfjq
         udPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834260; x=1750439060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=M2v9SLw0R/8KbM/ZLRLvnPfmqCPIdVpGYQC3IGQrDSyAvLDYb25N3IGQp677qv03NJ
         i6AsYKy9+A5huT+S8FFw1G5ymK2pZh+eWSXTdCrvBjxKIfw93e5EROLYIFFoWbudsrDm
         ZslK/i3Mm2+2mGFr1EyAB0YClkmE4xbZMKe0utTC9cHqSCDOi2YavC1UF0GJfletOm/5
         z8mqgi2jvRih35tvGTcrWwbsptmDyC6KpWk6+Rkk4uGTBxbPHIpxdGd6O58OBttaTYBh
         wsmwk2s5f/W3xBfbz9HsMwPOyKDI9sGZxYlqhBTte0derYOUMSweKUlvoS2ae+n2egmi
         V74Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXWBgn7vC4E+LiqixjaFCQzS5p905WH9g+bWIubrFd1XEyqVHbXKJezdFjN8EpmUo7dToZi+9XmCrLX0w=@vger.kernel.org, AJvYcCXaY46SBumbLtHS0Jrd3LLq51czPxg0hI391Y1kAm+JKimAcRIgp3q8NwNhWjO20m2ade1LUvQdhCOp@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBc3WkNLpSIBidRqSEQXUCQwbyp8BqF9PZqmcZos37RAFW4rz
	mu83tOSRjBKv/jL9GY0mtAo+kkhMQGlvLDpJ00sl1G09WSb0MtzhcAcK
X-Gm-Gg: ASbGncuZ9+4Yp0OkndHCI8VA85e7XHkBfqhPrg1AulChf5tb6QS7qMzOSd6EuIMzlzQ
	p9eseqbkzC6OtubStDA5nMAKzPZT5e3iCbZORniCX2CbVAVp/JKBnl8eU0S/sMVfPceqY9qMn/5
	oVNFp5lLVJn3/SSXIYPaaA0OkiSqSLraqT4YWVz5bm+NyNjQ7VAkdfhf/PkBnCnwVKaDtVTTFUr
	jUwiRy4HyJkIqikGxpIvYPmZqNjHVgWX5czpOc3Nx0LFxAXu7W9m2NQ61820xsrIs8NKsEhILbL
	ceoPaagTmfgFgthQJOsnWW5qs1l466vj68LtDdqg6yvOc+9QjA==
X-Google-Smtp-Source: AGHT+IGZlaoYzpRe5dnXAmpmilA+8wbE0qcSiy78BVL+eKxMI8k9z867nxqg1IoThq9SVp8FoIbSaw==
X-Received: by 2002:a17:902:cccd:b0:234:d7b2:2ab4 with SMTP id d9443c01a7336-2366b344261mr3162205ad.17.1749834259682;
        Fri, 13 Jun 2025 10:04:19 -0700 (PDT)
Received: from geday ([2804:7f2:800b:8497::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88be1fsm16961065ad.8.2025.06.13.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:04:19 -0700 (PDT)
Date: Fri, 13 Jun 2025 14:04:13 -0300
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
Subject: [RFC PATCH v5 4/4] phy: rockchip-pcie: Adjust read mask and write
Message-ID: <7068a941037eca8ef37cc65e8e08a136c7aac924.1749833987.git.geraldogabriel@gmail.com>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749833986.git.geraldogabriel@gmail.com>

Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
defines asynchronous strobe TEST_WRITE which should be enabled then
disabled and seems to have been copy-pasted as of current. Adjust it.
While at it, adjust read mask which should be the same as write mask.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 48bcc7d2b33b..35d2523ee776 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -30,9 +30,9 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
+#define PHY_CFG_RD_MASK       0x3f
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.49.0


