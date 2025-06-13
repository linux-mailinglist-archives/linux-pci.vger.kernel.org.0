Return-Path: <linux-pci+bounces-29745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87501AD90C6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A3D3BAF26
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13096149DE8;
	Fri, 13 Jun 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4DTK97L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0541A5BBD;
	Fri, 13 Jun 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827197; cv=none; b=Q7jbf6v9N0YBp2THoVRC6ScL6AViwH8DJUeikKPLSovHww7H1UMcCVknI1hv644ra4M3Nvey/Hhm3MlwZTq3ixlUGlaaGh7widuMkn48aCIYF8R+GXcGYS+mCTWfGwU275cKmSA4Hrvy05x94EGP0T82Gn5CFDi180lahseBj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827197; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNei1UugsVTWfi1mrETIKjjkTIvr7xTSmqI9XAd3XFMz+HhCD+xtyz8ZXz91GuoDvPX49yCXV9dLeRjash23oC/sRmi4pCmop5KVN9VvvM64qs3YMXDbx5lAZ7kkKAZcgVSR3sYufuw3r9vhYKo1udykCm2Be8ad+PxAY5Cdm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4DTK97L; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so2911456a91.0;
        Fri, 13 Jun 2025 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827195; x=1750431995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=Q4DTK97L+suPraLAIsC2rcBJ2DUN/4QqJuQvBfJMeGUYXeAXlhElIFj4DLWm2/Yocs
         cQtJMsLAIjuIjRX9snM9lZLw97yoPr5VEwK/hzHpwup54qeNh3lv20Oz5N952F/nMbyB
         qLHFOg6Pjh7acykg613UJx83PLDy8C4HAoqD0zFC5X8CH+gcDyWzdwctxrOtDMONdsJi
         9QxCVz0EwVhUb7QkzmKo0tRADoqCY7ra25/LMlf827XEy+UNNWekt7DjlaMg3Ebn8aUg
         G0A/aNvlUsmYc0fV9PhabK+mk+mHs6+BjhCNagzblpAum037HFiKeeRhNBQ7C9H7+MqL
         JvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827195; x=1750431995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=YtpmqofNICL5zdbEODPOLNYKKT/1Urq8NqEjBwQzqjqAMUst7xCEH4xR/3+jjFE4O2
         r3ySsjbliA5VN2LGMDMBnoQ+mbYHPcGE1Z2zEZ0RuObvNnEuajJiv6aEa4DlJ7GTwoah
         xd1clxePGwrh2oV2ssg2xBvO+RlMj4Ib7ofNXW9XPjLW2SrfK6M3/cWwI2nmc02tllbO
         OOSvesbJgHraLK4KVCfc1eBJVqzmrNqjxxtFFppAxKiCqR5pdRo500bVRrX6F2Bf5Di9
         hdrkecREqBOKwCBiToyzWq3vsn3GQHcWEvC4XoEvXQLpDcK5CZ8dTaKNAOrPJ5A+4BTl
         CpVA==
X-Forwarded-Encrypted: i=1; AJvYcCUrLB/Fui9LzUt/rTrZ8gcO9EPqR+zx3AXQ1Is1tVbh2wr8UREGTE/bBQLQ5G+Qd9jmvxQvnZjKhNxqfME=@vger.kernel.org, AJvYcCWef66kSLNOtfyXI5nyPK2QuHpf94SGS32SNZi4SnJUFh+EX9nVySwjWPmKZrsc2ZneTLcUXg65HrPU@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwgI/7qg5/3znD63E2SBAMnreAwGBdXHNBffGqCp67i2ZypSm
	H4x8FmfWhh0W0y1tPc0d3pofJFaKz2RL6kx9ozhn0qifq4ojLdeIahdy
X-Gm-Gg: ASbGncutUkrap6ihKP9zEmvSHjnrbtuz1peZfBMutVs8vYdoGdJV8WuC2pNlqmp6+Px
	L1uNHOGNG29iMDLH4AxS/xmG+tIPC3U8bo6cr6i3QLEVMUYMojUlZb1nPpDKZFWsQTm7LpOgkYV
	oRz572pdFv+kGunK9nzsXpvrUjMqAH5jaRkLLg1FkdC85H1JQzhrB2U2OSumG48B9ZKS2j9wsOh
	k11rAkcmp9GGtqv6jo3hv3s5Hnpz60qw5swF8fcdhcE+BneHU1MESgB4Om0TpyKSij6bJelFCN1
	6M5ga5U/Bm4+6y7Onh2T3CXgxi7PZixhCE5LJrk+zvPgWYebL3mlbmYNKeRi
X-Google-Smtp-Source: AGHT+IHrDxh6U4VAfIfK65vuTtcjHspUUqpNcD7PvyW2ItZ3xJVTxhDo3I8Q61np12P96HXNsZ4NXw==
X-Received: by 2002:a17:90a:e184:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-313e9036d04mr1456076a91.3.1749827194621;
        Fri, 13 Jun 2025 08:06:34 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b499cbsm3885857a91.26.2025.06.13.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:06:34 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:06:28 -0300
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
Subject: [RESEND RFC PATCH v4 5/5] phy: rockchip-pcie: Adjust read mask and
 write
Message-ID: <b32c8e4e0e36c03ae72bff13926d8bdd9131c838.1749827015.git.geraldogabriel@gmail.com>
References: <cover.1749827015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749827015.git.geraldogabriel@gmail.com>

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


