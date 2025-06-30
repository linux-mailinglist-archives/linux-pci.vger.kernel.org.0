Return-Path: <linux-pci+bounces-31118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E62BAEE9C9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1173A5941
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48C239E7F;
	Mon, 30 Jun 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApC94354"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A91865FA;
	Mon, 30 Jun 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320578; cv=none; b=pLx9yFmuXQG7FnzeLv6ivjB/EOmthRLIbVFAVtwNh4B/6J+KHumxfDsTexFNQewjE/92S9mXm02Mj6TOURft29X1p4q5uo5O1PyuDmk38ZpzPiv4USoJeggmA5WjlLSj2mTpZKRlHaKdn+qi+UVPwa4Pa6g4CGGLT3DjskdxUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320578; c=relaxed/simple;
	bh=CNxK0279ukfbz74d9Orf//2RsynVo3ZY3ta36YHi0ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7C5SIKvml4pRzIuhh0zk9xdIkKkghpFwUOJVM44rHL4oP45plfYsay9zXNLShQFBIoXm4ugF12FGJD6vu2es5KeP/wX4D0xfwGOt+vDck161Wy3ZIgrzdjUF15MlTUlnN49aHoqt3O7sxc2OLPgb0pbrMVquL6IQdqXKxM7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApC94354; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6face367320so30273896d6.3;
        Mon, 30 Jun 2025 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751320575; x=1751925375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=ApC94354db43zSoRe00Xwbwv8ntF+QlAtlyfSf8htrC9VwN4EaUTpCh5ro4Vuaiv/y
         wW3/9hVg1+ogTpWOjgby1lk+6bkGOpO2al5I0HKVtHCORd4ifA+QeIWu65bCsn2U9fLr
         mkfr25omB6u3550PmBTBR2rnCXcJTLM3t17yC+FrNa0FLUBpbc/FfQmL1jTbOtvllhHi
         BE55RrlbBT82m1eKMBB9F0EhBFXrMu24ICsc0x4CpQEBHJOvKVVV9GKVquPQ5H0KtH6Z
         xd8WRjQng8myc+lGCS0xS+jWdzPVdlHQefBtubONKr/dumjWn+npVPm9TEC0xAgEE/0r
         ZeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320575; x=1751925375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=Ax41gUlN3q6YOxMKzCBGzpMMyJqlHeiVAyZf4QSIwe7uOFqzOOwsYleHYD81YGSQe1
         UVxJD4sXNfzQ8q5SXCv1d9sSTjaFTzBBkUkPULWpsv906fyjgRhAIOxZQSw6c/mRMC5Y
         A+C0iax9kYGLvT77+AjVy+uAuNmFDksrB1Yu3G7gx+nlcER11UdhyV7otSAgJ5q785Rt
         t3n2OnmtaEIC7UFmrPezewt2C6V1oJ3eFR2q2Dd79TT49/u9RwwDxfASnyu39uwm6UBE
         apJFF8nv4DgIKnPTAMuSJdHsjaSxXTPJvbti7g+5M2LA0YDwyMG7pO4VeAEb09LM5war
         Ymfw==
X-Forwarded-Encrypted: i=1; AJvYcCV/sAUbV8wIBuwtIweF/oTs5qQae19L864EPvT2zbnNKHn79izGxaqtOt5YqlzIRSOJ9m9OQuyoARbS@vger.kernel.org, AJvYcCXtGapJLlNB+8OMxxl5zytWKzEWctEI6Xlbu5EjawTijUqek2KCVBz+dB6+/rZCOMswN8NuXdW7kH/UdY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuJ3HxaCBMk2O+aV6RVuB+DECYpL7Yp8X9Se7GYTkn0ixfgXh
	mYQdtqXneKOrOFEd0J87Qr+3V/ZGQMHyVcny9KEPIYfw+8wiGFg91K/e
X-Gm-Gg: ASbGnctoeyRwYMDO2BT4zvRKslgNeqRaKnScW8cDj2yutZc0YkMjizON6CislSlDUPA
	MAKnQFXTMCt/mmxGvGPmWlgWieO+PcpIsgW7/BZocFYzM91TAOpVBF3/0qkIQ4nN2x6aVNtkz1V
	/KNWk4+FejrcVimlCCKADIsHkAjx7wmMTZf+tnlWVmJpmImRdAHzxNpoNa5qdRwq44UTDCnHJZf
	9TLWRaCO+LRnlziLy7deA3iHmK/D9WXRY6yNorQiOxlgagzzKe4IcOX+9jK9qN7NMTgIUB0qMLU
	XZEynekn0ueEsmLmOxGZJA73876w7pvv++y7P6n+KQcznaN8qQ==
X-Google-Smtp-Source: AGHT+IHlwnZKtQx0c2S3ULgdwUmNGv7rh1cxRLFpfUvaYKGpyKAJS0ZlrmwkemijKiLME2PiK3LvCQ==
X-Received: by 2002:a05:6214:1948:b0:6fe:8c28:f3af with SMTP id 6a1803df08f44-700131c4c3bmr220986626d6.40.1751320574701;
        Mon, 30 Jun 2025 14:56:14 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771dcb9csm74286306d6.50.2025.06.30.14.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:56:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 18:56:07 -0300
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] phy: rockchip-pcie: Properly disable TEST_WRITE
 strobe signal
Message-ID: <d514d5d5627680caafa8b7548cbdfee4307f5440.1751320056.git.geraldogabriel@gmail.com>
References: <cover.1751320056.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751320056.git.geraldogabriel@gmail.com>

pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
be enabled, a little time waited, and then disabled. Current code clearly
was copy-pasted and never disables the strobe signal. Adjust the define.
While at it, remove PHY_CFG_RD_MASK which has been unused since
64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index f22ffb41cdc2..4e2dfd01adf2 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -30,9 +30,8 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.49.0


