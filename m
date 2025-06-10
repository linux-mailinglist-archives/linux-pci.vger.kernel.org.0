Return-Path: <linux-pci+bounces-29374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E48AD44BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05B2189D355
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02A266595;
	Tue, 10 Jun 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0y3COLL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036E282FA;
	Tue, 10 Jun 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590755; cv=none; b=GY/O61MOsem1/DRb+g39BLDEr66UOta4NK4nyXOf0BI+OgCBVCZjLmAh0dr+H24/mXCQqvtHdK/s79gugP81Drk0xY8JSFeT6ivW6mIByss3s/JXrmgP2H1eXL+jWL4y6OP//HOWCjs7dlypdFITFJZyeFBFwBkjHp0ebGshSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590755; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfCPq6MRH6OsG2c/IIoTW1XJuLKWTsDozRkpHS7yJdCfwjqytj1XcFcSf/G5YZ6LCpFv2Hq2pPp7M7w+JFZpkWH8lYTkGd+oQCUXdRM6pdnRVFzbE7W7hdEyH2O1LceuZe/qa4zYBZOYmaI3L9gS5W7WJv9WPiuTlCzlhcQ/3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0y3COLL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87ed3b792a2so806404241.3;
        Tue, 10 Jun 2025 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590752; x=1750195552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=b0y3COLLLk8x8IGGD7UFW8H8bi26veUY31gGv85iFxL/QeGFX5XW3+uW8rQk5up3pr
         8/nWOcamueAbC92ogXb8tlkp6UYFQz+9rFugAT+/AfkrFPuthrOelR4JnWyLDGb9TdIU
         dS83lKbuO2kfJuDOwrUPiGTxmmc1kglnbuWvohspv89bA/7z4NYAsrFShgYPa2ERUfy2
         R8MgtZPO0CM4su0hxAiuo+wpb3pAhVe3aHzipdYpNzANLT92e6gfHXZTBFVLXDqvoA3e
         6lCnU9L/U8jeulx7KxEeHM6tqnucBBINK7snFSzZpAY0zpW5paC3cIZCZr5PoMVGUA01
         3ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590752; x=1750195552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=PQuim3FOFBli+bFORnUje2Wvr3br2Wq55sMEigan8jZMKviyPG7q9ftFqyKb+6X9xr
         FiLK8MHEjgiTycscQ/nfKKf6AovhGl809EwVNiWY3lKhY7OWK7Jy0ehzgo2fR/jIF6lR
         AEwVCuHCDPc5B5VXL4sFSXfkm6OOBg9foQmaq/lqzJChIT5H/F5vwpAUuJLZ5iT00/Zv
         S0nRJZbvJ8+CQswvXsVIwFVsjMy0HmaKrXz2KjI7wza5xf9bBcly4LBFLhC6MZqsN+5o
         SJFWM/986pZrk2+FZFiGFIgAkt1FReBOBjcZHSlhDUTDfQ7qxXmcHTPAUdOqyjFTQPrG
         zPsw==
X-Forwarded-Encrypted: i=1; AJvYcCVhCIm045SqhBVP7clPieU3rKpxGgWSahpTSsm0mCYVNGCxbPqy8iTszYBg/YQUkB0b5w5jyLu40XjA+tk=@vger.kernel.org, AJvYcCWp5MUy+fHa+V4lKTfAZaV9AxcjLE0BnV9SNrLJWP+rXVpg+KoYkVqPIWXV1A2Kk55PPnXF+/10xHkG@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOoml9xXfknAll5J22/zL70iEqnyouHqM/MrN48lyHoiJAe4H
	GPQT7eLehAE460V4a3Rqw/K4O9PR9lHF1guN4CC9EGP+HdvmnTo0bHLL
X-Gm-Gg: ASbGncty93CjUtTF6uT/SXQN3hcOz4K9+Su3QGKnY2BILOb1M3G8pK1X9Qbzw3HtfiF
	kWe41kZibI+i23qYfVpRCgVvnmq9ZGxHZqBc9mOB0Mz6Nk6ttKvsTn2IGYKp2x6sCvvbadvRSc4
	MectXg2O8Xh3uST+0doyhSW1dgu0OgaEhgmGAHt4kFGF/zBlzJ90f+c+qHx64BCNUu5ZKEQumAB
	bmhwkSEukOp6d5PgPCKmcgHDWMRiItUBvhy+slpioavSkoIrVqk9XEjsQbZlytWduY1WaSRnxzM
	AlIfB1/pdSue/zy1uIPMAwfS3uM6BtoYxwrhIbfWZIAVNXqU1w==
X-Google-Smtp-Source: AGHT+IEYCVf9ZTSqj5YgISDZOrt+1R+QNbwbWikBaMK6UitqswT/0tSQ42AOnMjbILWu2QKm252CUQ==
X-Received: by 2002:a05:6102:54a9:b0:4e6:dbbc:16d0 with SMTP id ada2fe7eead31-4e7bbb8d8f0mr604930137.14.1749590752616;
        Tue, 10 Jun 2025 14:25:52 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ce9::dead:c001])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7bb030493sm356549137.19.2025.06.10.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:25:51 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:25:45 -0300
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
Subject: [RFC PATCH v2 4/4] phy: rockchip-pcie: adjust read mask and write
 strobe disable
Message-ID: <f0451239a23e9c0c97692d2cae0d7d3068d6dc85.1749588810.git.geraldogabriel@gmail.com>
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


