Return-Path: <linux-pci+bounces-29761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF0AD936A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60FC3B2F71
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D82E11B3;
	Fri, 13 Jun 2025 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjAHP6ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC741FE444;
	Fri, 13 Jun 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834233; cv=none; b=juJq6SNZhN1DXjlA+t8s+4j+HkMiJbcAXbxmneWxfWa8a8k9GfIyoza9/cGatjx5Eh9acPZPnb7aEENmVISp+54kQF+QPK9yA5rXrXrYk2SMoFUerxD+bBPfzwJr8Z9BkucY0RnJS0zE1heTUF+Ab6TgEAtt9PzZ1FM6to4TA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834233; c=relaxed/simple;
	bh=VBXSmkbEwyUiveQ0xzMAjdlDhL49GOnb+RhKgEw0Lrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdBZsCpgDxtncmzB/sUTrmcHyOu4Vx29qRC3kFiHyCvcrc3GLTAhgMb74COG1OiyAKKqkQ9hFtLwy7ZRoAgmjvTlb7Cj0x8tP/Ha9PwOupveoOVlT3SzJLkPsJbKiT0eNMxnzhVqnJ5+hpep68kWRR2Jp0vXKyqDaM50oIN2y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjAHP6ep; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b9dfb842so25057255ad.1;
        Fri, 13 Jun 2025 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834231; x=1750439031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZG2gbmHCn23d73eIBj2Su1Pr4mdTTmU2U/OMW+hTCg=;
        b=DjAHP6ep9t5Rg9SwUGMzRU4vLfJ8Iax162xJcNPzX7I9MHkjPmTG2GXjQDF4tKamF0
         GZoM7aiKg44kxzBUZsKV68edHBSmltfFJ35t/wu6On11WA654SskgRY9qDMzixYCQJvA
         jEpHkUu201DuoAXZkIbUD2ATRNZaqrKifdSULnzkUY0hCnotzQ0pyalZUCMFESuyUxDx
         QoxhA2ujYyTigb3/+/hn3IQ9TDr59CrjMOImxzvRdAmHoCsNDsUI0D2Qg8ipk7Jbj/2b
         TwAJh2hnADetsRoTcQ0JpNYSRWlCANU4X6Khq6Dgb+Z7L2DgvizFEhkST6DDJZai5O4D
         j8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834231; x=1750439031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZG2gbmHCn23d73eIBj2Su1Pr4mdTTmU2U/OMW+hTCg=;
        b=jYajYjJhZia2zSCI3W8qWsRV8QpvjW8EKi4b+BwYQ8m6gvqEqGoDj9g8WdN1S7WXrN
         +PA1PLqbAI/XjT37oy1gPRJgi93y1DBlqGhTsN063LvBWxuLe6/kSti8HedPbrrOUnTQ
         JD2QjMo/aIHxJ+xANmqiz5MKbWC0bFN2GMB3P3JJuJflhbyFueiGWEcql4A2+h2tBGXc
         Ys4FO1q3ZhBRvc7tr4lxd/zyMRlKNQDbk/MGn0rTeGBhjIud88dRxxKuiJLXMl1OJjVE
         ytTYLZsgOf4cRIXzEe+48HGmZNF+FChppHa2Oa4vKruBZnALUj1aHLp5uHmYpRrfN6Qi
         98cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDBlAW1xzbOLh3UtAcHPKibx1E1U+4sBMcWBq9td0UMkoLmWJE+2jPF4Zep9zfb2gu7z/86uz4v1D30LI=@vger.kernel.org, AJvYcCWQxqITbAJKL7deXtIYNajDTXJmVdpBitSkQyByb7SBYGzi33QOZyywZ49Ba8xi7YLU5zR/MdM++FXf@vger.kernel.org
X-Gm-Message-State: AOJu0YzDayqTYRf1vf0RgvW0rz97lJEm9r35zOV78J6dv2AMHo5YvzrJ
	3A6M35G0VZITTBIV1bVtvZJxTpd7dqa+9ZRoTjoP8nkxoU3JZ8JYLNJPeq4rqwgs
X-Gm-Gg: ASbGncsjfp6aSgIZPoHKAgdk3Ga3PraLulFxRDPUt8ofiCxxidClAQxq8LbmPF3EkiG
	Mf+ksyFDu8OEyFnREQKwWpy1wWLGgczn6+YRRgvNiXjXcWSjeBfsTGFVApauvPRgeFhRkNNu5IR
	4NB8wrXHhKu/wdvaRFQKKEUJs2WpuZiwEyXHfCN5I73o/TfD1JiNrRirVQXstgwGXHn9txggosi
	419cOUD6pqvRB2q29M9OsIURsbjj5nT2T9e9w8FYYEhZ2fqHYcSW/p1l/r2oYmRNjbAEUvwisYH
	s36PYc9Ds8lm3BAdCg28cuGZe1zu8WqXb1byM09ELEQBj4yPrw==
X-Google-Smtp-Source: AGHT+IFLJ9bCor1c2WHJ7wrTZBUINfNRlAF5VdRV17WHMRfQOATSlzvrkpLZD8EH22C2Gl67bbMhkA==
X-Received: by 2002:a17:902:f683:b0:232:59b:58fe with SMTP id d9443c01a7336-2366b3169f9mr3651525ad.1.1749834230599;
        Fri, 13 Jun 2025 10:03:50 -0700 (PDT)
Received: from geday ([2804:7f2:800b:8497::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb54desm16813665ad.179.2025.06.13.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:03:50 -0700 (PDT)
Date: Fri, 13 Jun 2025 14:03:44 -0300
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
Subject: [RFC PATCH v5 2/4] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <1966f8ddc4a81426b4f1f48c22bea9b4a6e6297c.1749833987.git.geraldogabriel@gmail.com>
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

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it to 5.0 GT/s accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8489d51e01ca..467e3fc377f7 100644
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
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-- 
2.49.0


