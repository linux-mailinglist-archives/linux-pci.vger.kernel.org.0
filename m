Return-Path: <linux-pci+bounces-31116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B95AEE9C0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E4D17FBB7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37728725D;
	Mon, 30 Jun 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzpeL4kR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A628C84D;
	Mon, 30 Jun 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320445; cv=none; b=kbiDad2PzqEzJxxx5dMgjUmmpeE2Xq36WgT74S8EHvblVQUckRI+zt8iWdFV+BWCNq4UDWvbVjSobYWC5v95PcDAu/slxZSED8eFyLP3OPz7ThDPVlO8TWG44x6T3qTYsN9hZ8IvUKq1W2D5CgjsUYvhHqFYrQYw9KG7ew1MB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320445; c=relaxed/simple;
	bh=TMyeQZWAOAuTwvIXse5kaD0KDoeWmnfqoNhsSOfoCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC5KLD0WLQsTw6ndyP/bCUHOzFRCgE1RSGl9mE+GzkOGVA4Cmer5Ctex4uBDctJyWZ6dpW0D4atCidCu8XLKpNmldLVGpvzZ6t8Z3ezl37RgUZ+3QDrkzpglzVsP9KDYjsPItUpnWNlsHcQTFwHqCsp092qXFDbqo1EoVUA/7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzpeL4kR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a585dc5f4aso58860481cf.2;
        Mon, 30 Jun 2025 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751320443; x=1751925243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=MzpeL4kR+IzZIGN2OjxMc67kX9Dpfsdd9WC/g+VIPT5Qr0lxmYAfQnnm4Sy0+BbU0D
         2yh8EaJbzSW3eW8qMo6wVTdswXns32PaieawgJl1VmtAtCNgdEr3nZtHVHb+19HSQXtf
         X8LqBAl/qJ7gE8+Tg6q45LYW2nCmCjixJRhgmUd8nfXYMQChFE+954hPt/lx6Uh7qWQP
         k14oWbbCWLUe6X/nlsAEANsrKgHFbqA52gw4xBb9t/rX0bBp64rkJQlHPc9Kimwjmfp4
         HqkHI6SIqv6rIi6AJXiNLSRlaNv5JPFNiecpQsLUC7JdOuneDYqHzTigNeUi4ZdmAku4
         4Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320443; x=1751925243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtc4GJjYIzCc3h+Hv3COhOArvofrVT3IhU2L5CEaYbA=;
        b=C/CnSa3Ht0DwqPjbixzEhJYz3MlzcxYiTozV4aGzTmQaKK2NxGixLSoVOcEfyLjmPP
         uWMdUsoYWj6+0mbCj+FQgG6py5yjqV65uEpZhdPTrE+OptI3SlYbwuVfO2EFc4P6np/V
         zQCjYutduiD2rPTkd7AIaarQ1L0Zxat1hktdsfp8O8dasS71KuAOh3HXrVOCVnoK0JQd
         BHPglbN4KWfAdgZnRmZCZEA26TMkBE8GeGWzw0AalF18k+0vvd/1Z4JuNQ+lY1n3awTD
         cZklKzX1mESBtml5gZBt0DdltLx5t89IiBhQPvQIK2Bj0mmTddWAYWVthFtMah/1piI5
         ldSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgYlH1KmkwmrB0Z3J0WKpg0Aazl4jUmFjTcsaDASBFmkzNi6UUw1tER9QGiaTLg23AGEni+ce9fhPZEp0=@vger.kernel.org, AJvYcCXYouaKnQJv2ucpF/q40R61rHfYrHk4jIxFcQTJ0laM+wYaRI3hpUEErREbbZqnORMOeID+2uktKf0q@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgtZqCMgnxvTUsIEb0uqzsOInlrRksIiiRnLUTIBadw9q7Zx0
	jBmbG9l7eZWxDFx1oktcZGVdyILTzpgjcpvpSm0mKiO3r7Auf7E923MYpLyAkWYL
X-Gm-Gg: ASbGncseYlDKoYKqpWRkwZY052etzXzkOSol7OJ9Mib8T2dGZkJ6vXGqXyHCkLzDr4A
	5pIyR6J1qVswIn+9dPh6V+Ox4uL/SMWQG5Henaajk6ZcCdO/zlw7Z8DGE3NOlvI6YeOUHlZTUAd
	pJxZs+xHUZ86kfZhzOlgbZ7fJy8m/rmPk3C7Lb2ZxJhPyPVSaQTdimQvEWp78D4b6ek47HPguBS
	PSh7LLkW/3oIaSyGywaPoYzo/5C45mElwM9xMHVsRHMqMNI3TdAXreoQ72fUSv0sPld0wIGBjYv
	dhhfKqK8aTbi47K3c5ngGjgAzEBYMCIXtqSuc66hsipT7565xw==
X-Google-Smtp-Source: AGHT+IEl8a6dIg9zoMy4z5faHvrY/Wge5nU0Ym4b/IhHk8USZly6BJFNwucTpW4cMCnQ1wqi4jpzDQ==
X-Received: by 2002:a05:622a:2d5:b0:4a4:30a0:39c0 with SMTP id d75a77b69052e-4a7fcab1a7fmr246749051cf.28.1751320442648;
        Mon, 30 Jun 2025 14:54:02 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a81b8ea2a4sm21766721cf.75.2025.06.30.14.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:54:02 -0700 (PDT)
Date: Mon, 30 Jun 2025 18:53:55 -0300
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
Subject: [PATCH v9 2/4] PCI: rockchip: Set Target Link Speed before retraining
Message-ID: <0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751320056.git.geraldogabriel@gmail.com>
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


