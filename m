Return-Path: <linux-pci+bounces-38491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69072BEACD7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8383A7C6947
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8229ACFC;
	Fri, 17 Oct 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ8X1O3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7927EFFA
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717674; cv=none; b=XnicOAezokTMiLA6MBjv6Zp3G5Hx/hcxYq10f4YgWxzuAdO00KBuThZtYC8ku5YY8QGfWifNiAZhpYatE9vyYiqUt5JdNpIQKycRwHbrSpLqcCwOorWCvoM68G34awIEJfSOLw9320amOMO2CI5LugKpmgOv52m2QyacGNpVNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717674; c=relaxed/simple;
	bh=Oij+wM97x99m1N0mzXYrzpOj9vtTLe4Ci0NQCxPAsn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfb4KjbxeyiPvzoJ84niIZcWr+eHS1cTtkenEGiefQsNBs0t3oNhK9NLUlMqhuMZyUvTtveMpJKaSeKFxjOpjlbsI/bBW+nV3Oce4PXlDgrNitjnpkkRUk/NVGETa2vIhcjMXnpHPmFWNCCGic14EIBygcmw29TGL6Qw0eHyADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ8X1O3x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eec33b737so31713075ad.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717672; x=1761322472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmzDzNS6h2nn3lBWOC9er6/2mXt0x/z2uT1ZIS+7GYc=;
        b=BZ8X1O3xLHo1hDB7ROMUbbhBeE56B5LIeYSoxAcBBq4yN5f3jdFXV/SVXRRySgJ35y
         cEriVlOcKCUy9pXLqiLrqqJJyADnZrseirNqcMYVj7YIfTbOpuJAv1W2GsT7w0NYHmYG
         H6WOGfjLBOFHnv/68eRlOwcTADEvBawXSwmTGXl9YjjE0z9bLx3bzTj6kwTJChtIzUHx
         RFeh+EZqzVVUat75YdxR3LlBC5GELnM+uCYtuQJbWEzcoEZkuE94pf9PDhNKUqxDkqmS
         nN6xqjzVkz0NcBaklvzKF2kK6WbVzTYomHceTnH0toiErczB6zNFeL1+UmS+oA13CNA5
         i7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717672; x=1761322472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmzDzNS6h2nn3lBWOC9er6/2mXt0x/z2uT1ZIS+7GYc=;
        b=Bg9ZdUygngb1sgHX3zFNkm93i10rx5r+08ZYHSpM6vJo6gz0Z7/NaTdY/jt+30n2ME
         LEQYxJh9v+X2aFJLfn93snnSWkaSKXA3mY1oHvSsgm7o5bDhgfKXwSi8+GOgtfKL4brS
         AZ3MZl8+aZNagA7c9gyXIv+BvVmjZxAIPeV54V6luQ/6QCzy4UX7nZpN7z2/j6tP7+1t
         085cuXxf8EeR3yFcmhpK0I+7ggIEk4X8aup419bpBrFRCwjP0d/gkSzIA3KiTsQynQQX
         ppoqiQbxlWswcxzqTbfqQM4JKJvR+Me1tXTIW3sn7NLlkexv9gUheuzEXsJ5F1hovqZ+
         pZhw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOUrE+aBSufqD/87uAkhJW9QjpOlXSFcVyeevYq8AOq+62QgR0WcuoJ/duFE8iSna2pu18lJ0Ojg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gRDJiNrSuV7id5RjQUr+mlOUWMsk60R9glNcw6LRCGewEIbL
	G4gl3yHHSefPj7QwvQovL8s7EjRoZ436L/tOTXAaJucS1XuQGjJrnc/I
X-Gm-Gg: ASbGnctjIzNVpoJ0WjOmj6kT5E7J4W/FTen5Acnp0+p1QZljHAA3QlHbus+PNR1WH3Y
	hHjAPwwJItPuaqz/esmlZSlLldSmkPF9ybqt41YMwrZ/yUYs2IsDWGeEK1azrzTx40tndJagL9m
	LQmY/tUss64mYXHJKj9Y9qxyKRUZrfcMk3oYFWGnQ3z6utQYQJvRTtlPuCkMeadbtHA5+GTI2aH
	TdETohaaX4gUxFVr7VoKsr6O5CD8rgUlo6qSuCEkl5Iq/KfY/yt3KT/NQNOP7sVJPPuapMi4D2P
	a10ULbDOmoeGADgzSDLorBtaEyMO0WQZu74y1p07bhhUBK3NeSe0LhGd4bmKhVOjXzi/XUZKzPk
	7qXdFqMzWk3nvW4aGbBpneYmvBSMyy1nyqhe43UaGxC+6pCUsgqp5trx1sTw5n1/QtH4imc8dVY
	oiBlHHlB1vRgHXt5pggNA=
X-Google-Smtp-Source: AGHT+IHPUYJEehZ0R4uTpkY4LREsjkCPbkAqM2QaS5Epmh67gEiNbiMT9ytygjRT4XX5SRJeF72CLg==
X-Received: by 2002:a17:903:1a4c:b0:27e:ed58:25e5 with SMTP id d9443c01a7336-290c9ce5b85mr44190495ad.24.1760717671973;
        Fri, 17 Oct 2025 09:14:31 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ae78c6sm68109835ad.100.2025.10.17.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI: starfive: Propagate dev_err_probe return value
Date: Fri, 17 Oct 2025 21:44:23 +0530
Message-ID: <20251017161425.7390-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within starfive_pcie_clk_rst_init() and
starfive_pcie_enable_phy() function. This ensures the original error code
are propagation for debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/plda/pcie-starfive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 3caf53c6c082..192d7a6a7c6c 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -180,7 +180,7 @@ static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
 	ret = reset_control_deassert(pcie->resets);
 	if (ret) {
 		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
-		dev_err_probe(dev, ret, "failed to deassert resets\n");
+		ret = dev_err_probe(dev, ret, "failed to deassert resets\n");
 	}
 
 	return ret;
@@ -241,13 +241,13 @@ static int starfive_pcie_enable_phy(struct device *dev,
 
 	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to set pcie mode\n");
+		ret = dev_err_probe(dev, ret, "failed to set pcie mode\n");
 		goto err_phy_on;
 	}
 
 	ret = phy_power_on(pcie->phy);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to power on pcie phy\n");
+		ret = dev_err_probe(dev, ret, "failed to power on pcie phy\n");
 		goto err_phy_on;
 	}
 

base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
-- 
2.50.1


