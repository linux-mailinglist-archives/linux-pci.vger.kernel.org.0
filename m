Return-Path: <linux-pci+bounces-140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D07F4EA4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE5B28126D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A24E1DC;
	Wed, 22 Nov 2023 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="sWF5vStY";
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="ZfaABvQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD611B2
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 09:49:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507be298d2aso9224016e87.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 09:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675377; x=1701280177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzvRqyLL8Wwqp7KMFovIxkbpSxyF2HOIdMkB4KZPVAM=;
        b=vhNMRtI9UIgWXktd1ZM0IA0BE6RERRkDY2MCxgYC+lLuRoFPSS3Y4WApULcSdXs8fM
         IB4Q9L7Q6LaGvQI/Hk32pHuOW8PVJpOKFxzFgUacW/RUxiXeaxt8zXxRjNj1wof+Nvjs
         GcAggoCpbBtdK6/Nev7Ok5dveuEbTssNws74fEUA1f491Mlsvui0RwXemrKFQW/mCbBN
         3q3W+pTGzsaWs96/A6vp0hY/ZBdEj/R4angCUiEmVzW2di8Uu63ktzcArV8P/BQeM2tY
         5swrALFx+JwUTfnZTWC3lxuPIAfL4PamoBMbmp71zFufpz2JQVR1Zw5yJMBHkaoimsTy
         XPYQ==
X-Gm-Message-State: AOJu0YwHhB+9ARa+XNpw+RiPKQXBRaVYsWfOnd0pNq+VebuZ7KGAt1FR
	JeZz6xd1kJM0mJkB1O9c2j4Jb/cvKa15HcAw
X-Google-Smtp-Source: AGHT+IE3Xu1zZ9eWg2RhPX4JW+ATE9dY3IvY+y+Zx2sfkXT3d9uL6Ux7m6lLPeLjYp8y+Fd8cRqJmQ==
X-Received: by 2002:a19:8c11:0:b0:50a:a2d6:972a with SMTP id o17-20020a198c11000000b0050aa2d6972amr1782713lfd.33.1700675377363;
        Wed, 22 Nov 2023 09:49:37 -0800 (PST)
Received: from flawful.org (c-55f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.85])
        by smtp.gmail.com with ESMTPSA id a28-20020a195f5c000000b004fdde1db756sm1935242lfj.26.2023.11.22.09.49.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1700675376; bh=w6kKQtmq2TAyKbyhD4agz2mAuAeEftxK8dFOKUjPaCw=;
	h=From:To:Cc:Subject:Date:From;
	b=sWF5vStYwaoE6ukE/oph2gxJpqnAmMFQ1L1t+VpNVe/Ii9LvOoCygHIVljcwWSPTQ
	 VQhk3NyCVCShSOjNM/AO/+Syju4oNb2sHkFa2ZdwdlDx1AbAif/kmSfQGTGkRv8NoM
	 TT5J6IbGgPFSh6qvbgZhnsd6FBGyv04HUhL+QUaQ=
Received: by flawful.org (Postfix, from userid 112)
	id F2DDFAC5; Wed, 22 Nov 2023 18:49:35 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1700675356; bh=w6kKQtmq2TAyKbyhD4agz2mAuAeEftxK8dFOKUjPaCw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZfaABvQnGq3ouO4+rl0ML7oXYexFTXyr6ihgBCeeBdnP18ZWvXtXWSrz734QXQZ8C
	 B3zSgSwtecvojlk4Hu4SYeMXw/QqzDc0lMKh7Nv/K6CfC3nLqGMsirIrqS4mSdSfvx
	 pH/5tcZ4MquvILtTrAjRwkOchnxYRA1A09LvEA0w=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id 8F3A8A67;
	Wed, 22 Nov 2023 18:49:03 +0100 (CET)
From: Niklas Cassel <nks@flawful.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
Date: Wed, 22 Nov 2023 18:48:55 +0100
Message-ID: <20231122174856.736329-1-nks@flawful.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <niklas.cassel@wdc.com>

Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
support iATUs which require a specific alignment.

However, this support cannot have been properly tested.

The whole point is for the iATU to map an address that is aligned,
using dw_pcie_ep_map_addr(), and then let the writel() write to the
msi_address + aligned_offset.

Thus, modify the address that is mapped such that it is aligned.
With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
dw_pcie_ep_raise_msi_irq().

Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6a..bc94d7f39535 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr &= ~aligned_offset;
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.42.0


