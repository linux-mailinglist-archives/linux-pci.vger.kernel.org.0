Return-Path: <linux-pci+bounces-31123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A517AEEA29
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 00:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE303E134B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB62356BA;
	Mon, 30 Jun 2025 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6QB3IW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D023ABB3;
	Mon, 30 Jun 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322339; cv=none; b=NM+SKOwQcrKA8ghH7rBQFL4Es97TMw267Qq9YDiKHrUTZ+OsO4Q8aIJqoHlWamyEJUoGO5RZmRPHU6kPXAOn1TSGYljEnf2yORBxyJzWIQOtHop7jihGmoTwPIPt4pCDyQRULHfhoih4t2qtJTqcwE17H8iMVPCahDX5eXcAAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322339; c=relaxed/simple;
	bh=CNxK0279ukfbz74d9Orf//2RsynVo3ZY3ta36YHi0ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3X6nYrh6pRiORxo08u+xtE8d8woqVc2z+JLsHg49VS/Vu8QdkZeMIruB7m69gDxtba9qd7aD8qna9c1c9iLF7UbUNIFLBuai1uoBIS8SPgwaxIiHlc3csaqn+ivxfoOayUJ2kuBdkmuWXNZJRSFYUjJ8CGsuBk8qbl867ITyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6QB3IW5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facc3b9559so36372536d6.0;
        Mon, 30 Jun 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322335; x=1751927135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=c6QB3IW507XREmHj3sjfMGKKrRxndyqXRf1JS8IewcDA/DjlZZtn+k088KefDiyUn7
         O1TxIPKZQgwsWuT3/JhwV3xyGzSXbYjgQKv+P2IXxVEgifZ3dPzdCJDRoI4QBindIk+O
         DEVxQGe8PDvBUYdKUL/uwTn0/vX/RlaTB4ARQ2gWF3ZN9HZx+eRq4uiOTnlnRnB1+zc8
         xt+zp03GIhLj8aRRNWZITEJnpBi71OwZjflFq+BcCB1lE1FCcXO+HnPAlfMHPSZ6Q8dW
         QMRqPwi+nBFZkSgmJlZimYycCG9eP02ftkhjBOd1MuyTXvLWsZos6dNT7wJmXOFN8p1X
         Ztlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322335; x=1751927135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=pS5ORAhvp4o2lDdXOLQ09DFmnbCOvu91dxsxKNdthEC+fMvJ/BAnJ2eEOdEFcvpYK2
         7R7N1HbKno+24VPy+AMb2EFhaWPrKetyoyyUxpDMsrxCr7GbifyBiXPPYZlVflwG4j8z
         4DtcBzp0dMFEhBSay6w0AABdN/ak4nWkiE16DsobP9Ujp0a1WcUt+zuq7tawjb7XWzmR
         EyrCTuR2p2Y1vGjGZkKeG4GXC4+6yFaPU1QK+Fuh3sU5XbkGb+h6zEHGVoElvhxLhl74
         fMoHkmEliAD5DFVYzVsCGcfNgHD0lP1Mupxf47KA5Yt2ijd05JyamwYkHWRIO9YOP0I4
         HI7g==
X-Forwarded-Encrypted: i=1; AJvYcCW9TxMPrPDENEQfJsX40jEu6L/ZDFmZGaEqmHo0kFauD6HcBODREXrjBMMbm4Auzrv6UM4PpWW64g8RbPs=@vger.kernel.org, AJvYcCXwtLACxkDIhVJtNOa6ZD7b4CXsCemhlh2dIEjpexc07fQF0unKT1BRJ07BymvvdW85deI/WEzwu9ui@vger.kernel.org
X-Gm-Message-State: AOJu0YzxeOu6gi2r+ZviTUUbXxBg51qo0/2SmzLlQI8fXsz6o9zbaX23
	usU00ld+nwmnamlmHXzlRbFT5SRVQbNCDv36+odgyIPCYtikt75xqhaz
X-Gm-Gg: ASbGnctzDG2B9aAGJW1ZWXRIKewWboL4UlPVA1VEVbzN2RyHBxAgYkI16cJ9RiSKRUN
	okIOhTNESv5ORP1ozrG0erJYFrPpObnNPiRdx4p1Qix//841UpTUz3uGFDzBxiIdkdxFFTjTTEX
	26TFm8cErOQjOGj5JGwK4RzlroXYX75NjLGTry8FlZ1xc5SYSwn8HmpiMmHBzmk0VGWytAicACJ
	2YnRcbH7D5filx+lGULrihImX6ZEmN414LbUQGqIzW0c4M5K0yp0g8xaYmPbp+TAbIBXkskvo43
	XIqEblzd1gHnUyqoitsNcjj8LHW5+vZuUn17aWuWyGOWazWJkQ==
X-Google-Smtp-Source: AGHT+IE4iPMoQHELkr+tznv/l/wb/8KLRUH+p7JvVVca5CKnURWz4GeCY3XtHhceEVufm737DrAHNQ==
X-Received: by 2002:ad4:5ba5:0:b0:6fb:5249:59fe with SMTP id 6a1803df08f44-6ffed7a5653mr221531976d6.2.1751322335383;
        Mon, 30 Jun 2025 15:25:35 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e349dsm74788696d6.68.2025.06.30.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:25:34 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:25:28 -0300
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
Subject: [RESEND PATCH v9 4/4] phy: rockchip-pcie: Properly disable
 TEST_WRITE strobe signal
Message-ID: <d514d5d5627680caafa8b7548cbdfee4307f5440.1751322015.git.geraldogabriel@gmail.com>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751322015.git.geraldogabriel@gmail.com>

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


