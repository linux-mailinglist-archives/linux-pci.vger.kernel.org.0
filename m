Return-Path: <linux-pci+bounces-29131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27536AD0CF8
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D073A3406
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872220CCCA;
	Sat,  7 Jun 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFS9Bvfm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046F20B81D;
	Sat,  7 Jun 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294128; cv=none; b=sZt/ow2nOgzMtZ9JTB44gEOKlGapuT9rwe+wOWCO+89blwXiw0s6//RiTjItneoDSnyjjxI6pp8OJ8j6JepJU6TinVdynOFdVVCmFyQPPQ6GzQ0aX5jB6uu7ydqhSV46kQu7Nz1vq/UbQ1gfCM0wScKmbQJ8e1HALJls3Kg5yLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294128; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ihA6QgMlxCReV7s4FvdtZOVTI7ejAMRlSB9bbZob/aVvUGlMbuV8uw4MHS3FhF2WERkQn9SDscMX0o1pQonO52g5nob2kyoXfIGFEoDfZAZNg9NFok/3mbRehk8bpOfKz5INvJeefR2QQBZficAyL8il0H9H5QypiKrCNTbUS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFS9Bvfm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso2366226b3a.2;
        Sat, 07 Jun 2025 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294125; x=1749898925; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=nFS9BvfmJWJ3+9HzNWOBbeCflTQrffA7KJE3KK7wZZTjfmk1+eNbrtBVFrZ1nvV8wk
         VhqzO1R+/gFY/26r51FTAOSYK/8Ziez6LMYvuKxoQegL2XPY7f/Bg9bCz1bZSmWe7c6K
         g7cBhuEEAy/1MS5/slJcSP5zSRrngzl4A/onlatPnh7xBoNcUdS7GzPya+FQTVXKyEG4
         2it+Dv9/jK03RBft/9pIhK3K9dBTf+sRuFHop9A3yK0dYZsvvnXwCfrZtX8dMwBmABQG
         7DLadhggVIrYblBk9VmdTo85wKCyvlLQden+0RQFPD+ZEdtRmGsjMuUDzIChjN2H+o6T
         kNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294125; x=1749898925;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=hgVE5XQ/NtCKYafVJzY/dJGacDFs3EWYv6OV9AOqvVg90SGenqNPX12FD8Ynt2PwI6
         /ivcH33crgkIJ1a492MlAAbAxZtVXyGlPYoVrIQ0igfSMWSLf2zFdzVkaRcWn79WPSX6
         SJZKv4GpTbqxYQO8tgrtHJ/Rx0ZepyAeZmUqg5Q81foYicFKHffvd75fBP/1nGm/o066
         S0zf8X8RyxEHF1xqxopQaqrSV3B1VB2CKPZDvyU86EESMLj66f+saKWdDI2HOyEir6z4
         mB54uukHZLQ+BDBGwE4sVPyqrXb02MBszI6O9D1aNwe8nwAO9m4yCpI9Scx5Fy5L/BBL
         QL1A==
X-Forwarded-Encrypted: i=1; AJvYcCUz77H33b5/GHiCBnGvmMy7jFX8HgVPJmJ8SJLpjbkyx5kwAv31dwdgWpL+U/d+jbj5G+SvAZj0JevQ@vger.kernel.org, AJvYcCW7TF+U7r5guYED7md9yQWQsaeqLzZNE08qXNC3GW1rNw3UXS6SV6OfhQMY7vNFc8qJxFChPdiXuIUCHHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8B28IqIdZfcYCaYdqFXh3V2JJM815AfUularmO2PCc8PiGUu
	6x82ihmrBuu4rYdKMvdjhh3AK66lBc78vFzC3fOXIrJVaF0TNpa2Q/8A
X-Gm-Gg: ASbGncvUitPZN0boyl6FggV4gqCNwbHAXTrN9KrCBM371rVnj4ejOF7sNJogcAIL2oC
	xQNKUkotEFviy0wTrsxkpCWyI2V/StD6ceA+NOc+xvQhX2O2RCOzEkM6EgeuyOxYIxzycN1ujXz
	O+7El0ul0nbLbOnD+YvSnFU2fmDO7svyXQFigbBeohVfVrB9sYlIzJYuvd/Ol4jLrFYq2cXfsfl
	MNTXFg3+PVJDIkClbWrxKE9R8wSjqe1ht79BGzFpfSu7PZLQGRySsT+su9t3hH77zWs45Of7NkG
	RW+lQx8RMmXBGaRQU58EJNJrGknPkpU1469PbzE9nENcyCw+MA==
X-Google-Smtp-Source: AGHT+IFYL9anMnNxKV2ckcM3gDwV1GsmgLUpZL8PFIBko5cIs/9IiYHRWTIxEtw+MUY9myL9CJHr3Q==
X-Received: by 2002:a05:6a00:2e07:b0:746:2c7f:b271 with SMTP id d2e1a72fcca58-74827e7f485mr8075913b3a.9.1749294125519;
        Sat, 07 Jun 2025 04:02:05 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bc9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c6649sm2538048b3a.113.2025.06.07.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:02:05 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:01:59 -0300
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
Subject: [RFC PATCH 4/4] phy: rockchip-pcie: adjust read mask and write
 strobe disable
Message-ID: <aEQcJ7L5AlxP2Z6w@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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


