Return-Path: <linux-pci+bounces-29643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FFAD8277
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492273B4DEC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294F1FF1CF;
	Fri, 13 Jun 2025 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrKae9ic"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96391E0DE8;
	Fri, 13 Jun 2025 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792151; cv=none; b=srPoO/m4PoSoCDgIiKOm4DJCaP05Xi8NoUW4ccqDzgJ9CH2ezgAjWtwbW/b9XJv73Yf0UIEPsrYVsU+CW67DwQwAwj2QcwIKRZWk7/xw42Fr1DpJ1+38XyY3Q0VTkxEkP1J1LD3qXDSzJm8AqkNn2LrE6//GGTzGrZcAGUDGVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792151; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvXRInun31NdoFVNXT1Asf/VZk+XctHCAdXxRA2ZOoLqQ/Ah0v/NMah2RhWSxXrUW3PI7gR467/p/duWoIRdBxY7rgTyJYxeePYU2sUOJwlthMWCIp3VHjRPo4VM6YNWttHPSffRfg2ilOyqv6o4mFbdtVf0PR7HvISSPmSA09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrKae9ic; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ae05d224so24975465ad.1;
        Thu, 12 Jun 2025 22:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792149; x=1750396949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=nrKae9icIGGTKWfOHcxCnwgpIeLEmerAeM8lKMpD2aJ46mZz0Qkd/+rRRjDd4KKmSR
         pR85IsKz0FrVFxXg+GHIB5XFx5WoMnN1+6sqR/AGNsecsk75EzcXeW3Yygk/yMRh0EDz
         bufxofyfQwBItu1ylbBrQ+8TzHIjEYc299alYRFJob9zT6JH8r8pOfMPWkrozSrr/wS8
         CJKYoGHn7F2eaB8eYVtgXPU2ADmxvxtZRdqzcXGMfq8m0GrweS78+0w9VNxKFS0r0dsC
         1WEQUnd/hvtVdPjBuExs1mSonxXxaBYFJi5KW/6Uqg6yhM0IzmYwV2IiD349usEy1u/S
         lBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792149; x=1750396949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=TY9BC/K4VB1p5db3xlzocYTL6W+SkHo3HMTQdD/DKyFx3u6c86Jg9cFr7nqXVHrxnx
         dOuVOMs4xb+9so4CIBMmBJMVQatDJNbEHBgBNZt4TALeKJy+ZA3eqC+4q861u4aEezFa
         vjZOHkewJs72QcBih43O17FtAEtIlTyl4sxO8yWoMp+RLpNw00+omfpcIO8I36YBdVBI
         qqhexGWVkoNrh4kD25y4uSQOT40pHg6sNwPPOm71Bs5KYzR+DTWSx4yRu+D58gNtqMse
         5TNxoMus6Wo0yrUEx9+PjizPX7udFqJJLOW9z8bQaHovQQRBJ3/Dv/KqDgj7vhSXCTQu
         Vk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTCdF7vsh0/Mp9WhkqlwBw8J4nsA3GtKOtpz5HCJ19bUfzIvjDlGY6HzdLfgr3mCg1ykgYREEpDq7g@vger.kernel.org, AJvYcCWCEe1AFil6+t9eRe5kIYN5t02eX2omZsVmjnuDwjXvX4LmUD98t4/H3fr8dBABUWo3nK+G9EyYvSiF9/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZv6qmOa5smntr2PhTS5JnajCyaMANoDcGFclUOBzkix5Ed9UM
	XmlanOa0M0XwN5V2sbmcQ8sO2dG5D1VyAIoFl0cuSPMI4OMAkziSYbBW
X-Gm-Gg: ASbGncu+w/P5jOy5CKKknmyQEiRZHPkvStAUfkuTr7lzs6x26mFA4cNKeVm5MMLXR3J
	xoyurNPpr5C9iylqD43H+jr9f0v0lbr5iKZV0qXeHeAea4gyl5Jn6YG8VAXo8PNq/ImkHpTjBiS
	JA6SQtSbXLbXl0ECOLzd3/hwbhpPCQu631G2idPMvCokHQb8KTMpyQDz6fKDda2N6rZ3yUnrKxD
	+w176BZgnrZ2KR8QakwI/lrkgbm72AwW3cF2hAAOlcr/NNusN09JkCbSOaMxqrTh5Gu6EcT9oWX
	0Y9Ecfysp7ToLqQaRCxiOxz7Tp+0eLZmGY0gAL1Yw06ODLkFZA==
X-Google-Smtp-Source: AGHT+IFpkN3auFoUSur2HmEifJee1D0zvlbAS430sg92+kqbhRCmj5VMxWFWrFOefv7KFe5llBsOQg==
X-Received: by 2002:a17:902:ec8b:b0:235:1b50:7245 with SMTP id d9443c01a7336-2365f876f73mr16933175ad.7.1749792148844;
        Thu, 12 Jun 2025 22:22:28 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78565sm6223145ad.124.2025.06.12.22.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:22:28 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:22:22 -0300
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
Subject: [RFC PATCH v3 5/5] phy: rockchip-pcie: Adjust read mask and write
Message-ID: <e8bc1e12ad3c7c38bfef25e696ffbec2b25f312c.1749791474.git.geraldogabriel@gmail.com>
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


