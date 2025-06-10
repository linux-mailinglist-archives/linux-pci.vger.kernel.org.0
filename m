Return-Path: <linux-pci+bounces-29371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2112AD44B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5417900E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF12283C8C;
	Tue, 10 Jun 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFQXNv6U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E844283689;
	Tue, 10 Jun 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590413; cv=none; b=JOEoAH0+k0jI5/NNChuGD+BG83VBlbic/go3uKNbYFnCGH8eQjapMLFCrpw5hoY/ol3oK+qMKpxDxC8eXvov6B/UC+FFOeGCMYmt40B1Eae7++2J1j0K4s6RQdA6D4Qy7pp0MvZjHNJSTMx/ZAiqKGak2Zwkp06KgVEsyyxwPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590413; c=relaxed/simple;
	bh=QOALSA3vQkgShMU13h5qOd5nTj3JQw5+SeYowgENkng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR8ma+HyX4KqdyiE/EDnBAPMBrx2GDzu4T3fS12OKdiHVzNsojIZrXzfZH3IndUbNZFTjEpuDvvzThf0BUt62c8l3Q0veiBxQNioLMZdIP2Yn/r2qdhnVLasmzRSKlb/b4RcyDaG9qUcmznU4njMLYnMQAJYjJS/0nrkA/uVfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFQXNv6U; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5308b451df0so1813026e0c.2;
        Tue, 10 Jun 2025 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590411; x=1750195211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMyHEENm3aAi7+mpl/5ALuPQmurPsDkuZW0WhOp/NzQ=;
        b=RFQXNv6UEn5dHB+kSGfqLmqyYDhVBeRUrPXP8Q4iJOJPTktFYN5ZFkv+EVwsqrMBpW
         ZQX+cwPYaNIh0a21ovBnyyYlqiTrjhbVO92gJVaWYwAHr+CRAkogqZJ6QeQqyRvxosJU
         LD82+T9Ne3J+Xo51zL9TV8J+W+vbXG8nJ1RLl9DTgjQ1c3DdrX0MzccxChajhede511m
         d165I+MzSbn1YgabwhQhKlET2p/aA9Gf8JxBmkcHIBhMOaliC/juG7GFmjOxxI7q372l
         3C4tocTI6quKnAjiqG4DwZHKY99qzZG5ksmZwBpXstU643sgAX/93DLmO7wZIMNlaSGN
         Xutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590411; x=1750195211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMyHEENm3aAi7+mpl/5ALuPQmurPsDkuZW0WhOp/NzQ=;
        b=aWgdIFy41JejtWzV9Y37qO99lIE3hGvMcWC1//sTtx5TX4a87HYAvL/dxNTTf6PSW0
         /zdEI3g7P5pfPdfT2JURoQGKhe0KQyT4FSkshzOxHdLjnuSJMoNY5NA5PekMBC73k5v9
         ICtCfCfiIZDscUwlu93r4BV718X8KPvb6asPb2SdMMFoUMiwOaMiUKLJ+0pZvZnUjvPf
         0LKdShxKwExc60AJcq/FqaEzHjuc50A6TpjnR9c9YDq+iptD/OrWiDzYP5BVEOCuhWsL
         DWoCJTQ49Fzf+x9rokzfjZOxpAYnCqXY0zDnG/haO8xvzgDs0c/JVCRzNcAyqneEBlZR
         Mp8w==
X-Forwarded-Encrypted: i=1; AJvYcCVvGgJbMvZjDQIdcvQrqDPwl142XIw0NVZEG/oEwglV8MH1IYEn5EgK2YddFzR6WRxWmdJWaGcAeZUGn/A=@vger.kernel.org, AJvYcCWKBg+gOtCaze5FzYhWJgj0/tPmXS3nCj3HU62MYlHsO+VUMvYGmt4x2zMSHjndumyZto10PBIzcBrQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KWB2/2REayMLEbJmNsUzWRilFIHr7VnYtktGE8/BAvGs0izR
	90BnUM4qIOUQqEUC17A6PmNMdRwWWvPdxX3YmKQ8MKRHxQF7G6fsO0aQ
X-Gm-Gg: ASbGnctIBzSVdj9s6OPD17emHakoLJD8hikOlHq1dZ26KkCGqoQivRRXPodSqemePHF
	A18Y+alLROaqFlCEQi30fP4QS/t9umrRO1xEiEJZzjWSG/hy+MEJ9BJEPsLm0+Uv6W89Sel/PNL
	OEEj95dwR9VIlcHih7uTTlOZ5bZBdfBsBHJOd+7RV/xLFbrd5vDBpEaAxcRdxAM7mREnBT7o2Pu
	pqQehSiclrOKL0jNp+Y+VEHONyeGtkpYvVF4EWwUrGnYjtCSa8aWr/w0uZJ42mUNw8x/NJDneI6
	DPFRFsUCL0gTuXXT9YG06tK+1yABZ9W9jQIRLNIzJ9poDcst4w==
X-Google-Smtp-Source: AGHT+IGMLQMogM9Y5TYRZq5x/+RY965YqubXBP0wkzvzdldN6Zcyb449bg6gGKSbqhDtgv+1p5DKOg==
X-Received: by 2002:a05:6122:511a:10b0:530:66e6:e21a with SMTP id 71dfb90a1353d-53122c960f2mr547052e0c.3.1749590410872;
        Tue, 10 Jun 2025 14:20:10 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ce9::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113a7e71dsm2065694e0c.2.2025.06.10.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:20:10 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:20:04 -0300
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
Subject: [RFC PATCH v2 2/4] PCI: rockchip-host: Set Target Link Speed before
 retraining
Message-ID: <87ca44fc3c34c5ffd3035d0d29b4ebabefed1c63.1749588810.git.geraldogabriel@gmail.com>
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

Current code may fail Gen2 retraining if Target Link Speed
is set to 2.5 GT/s in Link Control and Status Register 2.
Set it to 5.0 GT/s accordingly.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..fd6f1a1d48bf 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS_2);
+		status &= ~PCI_EXP_LNKCTL2_TLS_2_5GT;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS_2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
-- 
2.49.0


