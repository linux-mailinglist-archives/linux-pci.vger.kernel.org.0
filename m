Return-Path: <linux-pci+bounces-31121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57CAEEA25
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 00:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A1A3A3B7D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4323185E;
	Mon, 30 Jun 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh9hMiAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B12405E4;
	Mon, 30 Jun 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322308; cv=none; b=KtlEWOkZhcr+j6UTtuvoilhmpb7mkiHtmTKYpbRESf/OZeg8HLJNJYAIebcFTpZjBUCs8l1p1lBKDsxAFwpo607fp4HXczdln/e53e336PyRFnEYKS4cM9l36mpZim8J9NTwVs+ZmpVQ4dIqwk4fhS8HL7aYWzzxvi2ZRX9TT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322308; c=relaxed/simple;
	bh=TMyeQZWAOAuTwvIXse5kaD0KDoeWmnfqoNhsSOfoCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM09I9ioDFX62NhpPoYMj6abPYrOfN36+Xdad9F4aSdRtNqFGONhHP1xM3mSxPjkEjWq7UWjqhB7481uqZlQJkaRUD46spKFDEv25iSnxxBUppn5+4DEnlEIOtkNbNivyI8SQMM+KGI8ZJKhJBiGEZZP9eueTSwCOlFV3xiX3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh9hMiAx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4323fe8caso16869211cf.2;
        Mon, 30 Jun 2025 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322305; x=1751927105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=Bh9hMiAx75fR5CZ+I2aTVMiWLqcjZ2WnQiwAOtyr6TRXmLBwsGr33sATxgI6kDCMCq
         BmHw+iMc+u+b4W7+CLZVDCTSwHfBEuz4iOy08MvgXEFbAefcNUFbzrxpNH0si0Uf4prE
         bbs9a+rPKqE272shl9YmvaAc6t7ju+S9K0Jy3KNH04a4YylwQBUl8tE5cQMYDsxSU5aC
         Ltj62fkTamUBXr2H5IJH7IobKD3tQcvpAuereE5KHkLFnnvcTWNq7zzy9Nzy5yleK+0z
         SASfH/RU+6fNjxkZNHZuzo/Y/0CsV8or6EIEsGrAp+6ByTkR95UDvHirlNQQCN0Hz61V
         O4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322305; x=1751927105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=rpzkaww9mNjiqoLZj8lszap5pJrBv+tN8qo6RNJpFKKDmBeJ4yt8VCusCzu9UKfVtL
         XI/NxAhxg1ZuK663KduFe3dzxBNNLUQLx6klSx8fFKbT4T5bvgnrZPPVXoW1lSEo/sXF
         wiBppreIqS+GlBdmryAhWbr7Ga5XL5d6UahITfMIBCqfWa7vwltqAuM0MCiK//VgaZSv
         hTGqcer+TpQx6H74rMd0/nwKqBXalRgyFmlCHXdqMy4zkfnaz2sdd9d9blFlXQIGY7t3
         9dFhgh/9sF8Cn4pjfBvyVba2e8tdf7lMabZStgKyux7/2zbDC9+6E35/3r93YBD6gKW0
         vvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssZyVJXq1ROoCLlCpc9b44LvRxluJbnx5YWUDU9v4WNsbPtR/Y61ewW8todPUWpYnE1GiVPsz2GgE@vger.kernel.org, AJvYcCXqF5vJGtIJCDEquKGxIy5GiL8wyAWlPqgOxMUOzYwP9Kauf9SgUlZsWxlWSWBfVxaIFVbuJQ09/JyVZyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgVTai33oc+PbdxfsrjZwfRBgq8CwciCk5OAg+o9R7D6iRLtD
	N2Si7ay95xcrvZYRK+jFLRBNtMIG9T5GemWLMlewe2iv6AEdV1N7Eu72
X-Gm-Gg: ASbGnct+bGzvaD/naKdrmSQOZmNyTEHapPnhUExCQWJ5ggkoSwjIX/WXt1aSrA/0Lfb
	QEWvokQeAKE3YH4A0oF/7Or69UwUuETRjtw6ERzyludS3XmoP5izytDRJMiqqUuMBePPEl+P/tB
	ARFghSt747jdPHN+T9MEACowTU8j3ygxl4ZsA5sKV5cqquKcaRnxeYHoDNO7SxpNVDlnhrmNqP+
	u3a100uig6q/esN/0j2YjLY6KS10sHNibKsSeNT91koHTLD5vgwDNS1i+S4LTi4AyOzVr2qXR4H
	oghbkkFJ0a3TOogK5iZIksINV06zhwjxnsMBvHUPV3fKm6bDZdOHss00Ehl/
X-Google-Smtp-Source: AGHT+IG9h1D4l6+m606c2ZMkubhW0PPh4r8jC2GsVBPvZvgF1tRRF5vtygFfuvF9SKUIZpKpOhqztw==
X-Received: by 2002:a05:622a:144b:b0:4a1:630b:e12b with SMTP id d75a77b69052e-4a7fc939ddfmr221177041cf.0.1751322304620;
        Mon, 30 Jun 2025 15:25:04 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc138d7esm67054191cf.21.2025.06.30.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:25:04 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:24:57 -0300
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
Subject: [RESEND PATCH v9 2/4] PCI: rockchip: Set Target Link Speed before
 retraining
Message-ID: <0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751322015.git.geraldogabriel@gmail.com>
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


