Return-Path: <linux-pci+bounces-29732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92733AD902A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638016979D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34501DF271;
	Fri, 13 Jun 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt6RVj+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E621DE89A;
	Fri, 13 Jun 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826325; cv=none; b=pccGOIwmgX4sSmk0vvYw1DhxqugFoA1Feaqtx7s7xPxONeiHN7cAAmZLMMBQjxvz7WsPngeFbYnYVMR0WKiwGgl0ilrZawNU3Tjrrk6ml9fHtfs8CxdqREzTXjjS+r8+JwnEvRNRmhOQfPJrvSkJiljRp+DTUGLOBQVZczJ4lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826325; c=relaxed/simple;
	bh=I6GWAxCHn9ykIre5Iu/5nDrUj5xXpxLWH8Z1EPm68Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHY/I/NJa4WtXFIXV5wDbHpA7k00HSZqN+XH324UbRX9i9g0jVdzrBxJ5KKYSLr4AMVdrl1UVZO0d0rMZQx/f26KlpeGNZVfxiziWaSYCm3+WJMHGE6B0i+wQ+R5dZZxyv7sUSxWHiVkFODasdtamz9LlBJJLG39CBY/b/eVyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt6RVj+p; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e8f394bb75so1264173fac.3;
        Fri, 13 Jun 2025 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826323; x=1750431123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jwmmYn5mR6/LEUkoHGVPsLNEcwThgX3SiiTAZydAvs=;
        b=Dt6RVj+plHXM2/ZiyX5tlz5L+MMcaCGmEuHaneSpgUQdFT8miumczyTAEJYi4ySrXR
         XW08/dAU17TjWk8rFedzecChqa4qGLnKAnR5tHfR4MZ3A+Mw/36Wm4CO2h9QCn2GEiRN
         LkFGQJdN3t7BSkH6rfWZuSmSXyDLcfdISyAQO//X/nf+NawXFTOVR9x8EkXnColDTS1D
         /FELEUn8a1OpAhwMLKyRUK6Tp0FsN7z+sIzhvaaM85RKkABQj645nAv4DcSayPjcAHKK
         r6Fm9DYhYZAlg/gwH4fZbFcYS8o3WGefRVWjbHPuXvXWR4TBKisKPX7ddGwe4nu3+Ti8
         i3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826323; x=1750431123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jwmmYn5mR6/LEUkoHGVPsLNEcwThgX3SiiTAZydAvs=;
        b=fZSNReaOGg7SyR5Y5cGnIPSo2y5V60vWLaNxKq9dRNaBqlK1DINE5UuMtcB+SgFF8w
         2rdvk0lr28xr26A3ij8PlED2B0GOvHzDlGZMgdjiKeXIoAvXJCoYYp2wA+KkHn3QtWZg
         V+a8c707tRywXQvBo4OLpq4tkclKlnS01h+GKOh4eqR9RKdr4EqZYatnewoa7cfZ5lds
         dEvRijYzgNB35yQ5jFzURIavVKBMc/Y2vD/UULBLTr/WDlQ71OAI0nAi2VFjgESwfmK6
         fY4Nx08GQ5bVJc0wOsxNvmWO2ffPaVBldWqp/loR+TMX9qIyTXb35GAeSNPC9blCEcs1
         fk7w==
X-Forwarded-Encrypted: i=1; AJvYcCVZVrL0rqrNVE008KRp/4OXG7/n09iqM98jJKD2w/yHkJKqkbB6kI2EP0jTGi03AFMgJIEDbYyr48yP@vger.kernel.org, AJvYcCVgcBo9ZA1BRW/p/yWMcRVFZDH4buFchDJKW4dULyhYM+N6FGd7SctqMWS/c9PPEJqLh+lEZkuPdT2gZhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPax0YrvgKzcpvbag+TYr9LYhxne0aIabEwPrxpIrUHI14nOyZ
	q7puViM4Y7Ye1upRcHEc4FK0Bch8mC+/PkoU78SVDsaiqFRhCjE1ty/ZBXi23NhE
X-Gm-Gg: ASbGncvTFWAvKbBNEiuQz3qbBpnqckEXuNy4jJ7jjR183cTG9UIWd2D+YkkKy/KbFj1
	YL/KherTtpmi4oT7QFN5K/rH8GQxKBQwkp1nfKvMRJS4vS8+EJB9UfZ70Vt0vfyfjid5MlNb0yZ
	hCxyivA92I1n8NurwWjaELc/9cNjw96HWZE/K4W2zJLHttEdrvRX0awdQFN28JlQ7Q86cAlzwKl
	fjonr66gv9ILo+aRPqscoBWPN6DlwAFRaP0C15M8iSWQDgQHoVs6Ug1zfmmH+JetiKAfZxKNCDu
	FqHaZMg+K9ItmN3+or7IgyOmUfW0N+re6YuiFz/bXYyw3jy5NA==
X-Google-Smtp-Source: AGHT+IGiKHmM9XBYxdjrLGBWI4Cw7gLU1AY8vPDUar8VoUJyUwWHPMwWLh675rm2NoddelERdbgXzw==
X-Received: by 2002:a05:6a00:398e:b0:747:ee09:1fd2 with SMTP id d2e1a72fcca58-7488f79d9dbmr5017356b3a.12.1749826311724;
        Fri, 13 Jun 2025 07:51:51 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b0d07sm1667046b3a.114.2025.06.13.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:51:51 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:51:45 -0300
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
Subject: [RFC PATCH v4 3/5] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <affaa12fedbb6e34696242d1f2f2dc5634b72005.1749826250.git.geraldogabriel@gmail.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749826250.git.geraldogabriel@gmail.com>

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it to 5.0 GT/s accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 65653218b9ab..7a0b6ebb7c27 100644
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


