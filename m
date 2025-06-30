Return-Path: <linux-pci+bounces-31100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353CAEE6B2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1CF17FB1E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F081E7C12;
	Mon, 30 Jun 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7grCwGu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DB19994F;
	Mon, 30 Jun 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307715; cv=none; b=BzG6qorG3pynIAsDdKYwX4rujKp/wT55YtLM1VLDtwjej0GeEpwqseVFF9/EmjGhruvwxTIetU7SFQX2eUph3G3o82peFPbg5zFSIDw/9FfPy5k1sSI05N3zg4bx4/aFiC4QCLWy5EWfEYEqgIYR3gKux3MdwaSeFrt8MuS9r+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307715; c=relaxed/simple;
	bh=TMyeQZWAOAuTwvIXse5kaD0KDoeWmnfqoNhsSOfoCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKKU1FtLTCNDbm98im/M5W5dGcx0wMOl7KG+q3erVjRBr6UbMMrkSe6RjOmW3EChWjh/EIF45cTNiXe1P/mScx5Ny/1Q18kVZ6Hc8h4QbPLQVreTKISsdRVjUWncfXTKQgk6RiUJ140DYBmnl4JjeAR8ndJo0AFIvSmzCmfwQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7grCwGu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d402c901cbso437817185a.3;
        Mon, 30 Jun 2025 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307712; x=1751912512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=O7grCwGuem3TmJHIbXQFr12Tt4n/5zBjaa0WZiUm6IoL4+ZQ+ri6910rscLRDwOra2
         suYmMg2LSEd+DSZWtQElK5EQuyUmUEmTNoJh6HsWqainBylxL1tDEixqKJ3fQMZmraPY
         VWg2bYDjJsegqwPrzJRg3HXesQk6+hc/96VsZGMp2ui0zaK8OE+ZexnXD/0/ABPO1si8
         pduzLHG52Xl8vUONZBNzPbyPJW+PhHjxnKz12C/IoyLb0O25A+MFGkT1VXqeG+LlDp3a
         5C5sAD49BJJtAKG54sZYQ8AqivAgqvGTK9yT9qg+6aaZzR3yVLsVxijMhajrVg0XSJtm
         GSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307712; x=1751912512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=Ap39uUXnGq9sDbWf/B1VqMp3Bfl42Z5h6rarnbMm9jl/68IOO7v2lViewzwyAI6LJq
         n+pVYkI+TRUu49dmQMA5yVMDjcn+e9zGSvpxNTdOVNv5S2pCfGD3tt95omWwOyu+VSj8
         F4NutuywNqYirYEzeUvePkD6HKsy47gwWX54FDmQBLzSOJMRV9mlUY5KznKxcDQECdJx
         Qq5YtwiYjmFJNFhAj/tPXPTUYwpwiUZdY+vcSzJDRAZqrXmAm/R0qtVQ1+xFpmhD/n1p
         lOZTQpx8wkAS6Em2BCSExn+n8Ec9tn5adU6LYp+oGxOfgVbIoVcc+WoX2D/By69tI4eJ
         ovvw==
X-Forwarded-Encrypted: i=1; AJvYcCUsEkbspo2Var1PtfaSKqTIq3WLe0V5diwS8eJMuVQ4StqG8zKKp9OItYDlfyqyni40tojm/+0XERaS@vger.kernel.org, AJvYcCXgDqBvL7Xtoh+W4BmpvX9Kqtc3VMOH4V1C0xyl58j0l+0mEMgr9arGNwijgGusZRtLGy7oBKIjz5C3jfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+eocnXIER/Z+Hj35aNYiLP8G8wk+3M9r4yKvn9eRhgVmDXSh
	iMr3Ezt/V+EfEJrKdRehhiCop9UyBORgMCZfO8igSHFoQEfw1LKN2CTi
X-Gm-Gg: ASbGnctDiRfE8MVOso1aY3c1x1XfmbyToMcVCvSm215aqKzyslNLlSfPuy3tPRuksb8
	IT4gRDmmOKeVEMNUqPD1eijNx5Fi7OZuH9Pa+xe1cysO5fjwwV3FlNPbVgRbLa2V4RltdH8oaOl
	+XZY9okvgGCML4DdHXDSIAMJsjWf/EMx65G4GUHVb9UwXs85736iCfBOrp9xquoC/Yc+zHBeOWu
	nB+wE4bFo7XOwFkBVgSAJbTW2g7DW3N0ddkdOaCLwMwgXm+zth4CnyA+84Gz3Ku+W/4KcLnTOBH
	zPDcCaoQOFMJpz8lT/FwBzrxc3qca42HpMUcmShtAbg4beg83w==
X-Google-Smtp-Source: AGHT+IGFXYnf/fQlbC+mgz+nw0wr9dI6eGoPSadvUYNWqwtuJXJ0qea9pKfxGAKJwViMNZt8vtKyPQ==
X-Received: by 2002:a05:620a:2910:b0:7d3:8da2:e9e2 with SMTP id af79cd13be357-7d443990ab8mr2006431585a.27.1751307712420;
        Mon, 30 Jun 2025 11:21:52 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443201824sm635775485a.53.2025.06.30.11.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:21:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:21:45 -0300
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
Subject: [PATCH v8 2/4] PCI: rockchip: Set Target Link Speed before retraining
Message-ID: <0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751307390.git.geraldogabriel@gmail.com>
References: <cover.1751307390.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751307390.git.geraldogabriel@gmail.com>

Current code may fail 5.0GT/s retraining if Target Link Speed is set to
2.5 GT/s in Link Control and Status Register 2. Set it to 5.0 GT/s
accordingly.

Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 65653218b9ab..25890f6c0e17 100644
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


