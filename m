Return-Path: <linux-pci+bounces-225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C27FBB62
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 14:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B945B21903
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82C57896;
	Tue, 28 Nov 2023 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="PhcWpGng";
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="e+F6WINF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FFEDA
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 05:23:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a98517f3so7356788e87.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 05:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177831; x=1701782631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBP9+ANTd+YeoKcJdvljTdpjHWIRh3Hzh1C2WywAX6M=;
        b=uLi18yyoFRK7FVUmAziM9rfAozGSA8PSdVHoIwFRdcoIXmJgsaQ/Ia1LknyJpE81UI
         kHn6S9z3vttp2KoeGpCJoo8s/G7LAJy2uU8DDg+b0G+nNhaXlfFjOud0lRt0x3S6W+8i
         aEvS0ldHY9sUmgvmZE3inQPvpi7BK0Z5rTflwFQ4OiyYo7JhDuXuw0o0NPBAXGtetwmq
         8ZlDK0kMQC1SA4+hJbHbJFZcvkZnvdIK8D8JE/0Ddxfg/8UeZzBNe6kkJj9fu/74kwSW
         Vd36Kvxa+Lqo/ZSBRaRtQijp4fRUksU4qvNrj8SMp8Og0/Ryc4jumME+qY8hEkgcfnYY
         yo3g==
X-Gm-Message-State: AOJu0YxoNpxYVaFvbgNIvX4NNJEg0cadvANKxaXfsEhRUi5qBEJB0rkH
	nHEduxCdb6L1gTSJ0rdRsV7h6kMfX7aZ42mZ
X-Google-Smtp-Source: AGHT+IF5wv12ufUx+xWJWt8k6hNJkP+AYQNgUlmB5VfzR2E6/qUQb4gfBE4XkKcarw5CbzoHoFD0UA==
X-Received: by 2002:a05:6512:10ca:b0:50b:b00b:e3ef with SMTP id k10-20020a05651210ca00b0050bb00be3efmr5875051lfg.62.1701177831496;
        Tue, 28 Nov 2023 05:23:51 -0800 (PST)
Received: from flawful.org (c-55f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.85])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512324500b0050bc194d414sm23473lfr.303.2023.11.28.05.23.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1701177829; bh=e8b9fnxitWkWXRKnpPA0xPmyNbp8/i00cz0k+pMYsYY=;
	h=From:To:Cc:Subject:Date:From;
	b=PhcWpGngiVr9k/pKFETuPulU4Xw+BEF4rhpNrKsTPWyA2euoSvpr6OJ2vl1zMpn9X
	 qvFa7JsMgf45efr55qoUXsL71BrXpncrN6JuE+iFtx4b0CvNfjvv7ONdX8oF6PB4LG
	 MY8OVf/as2ZPTfPDnrKp8Nf+K2om4gDpaQw21haM=
Received: by flawful.org (Postfix, from userid 112)
	id CE4CAC7E; Tue, 28 Nov 2023 14:23:47 +0100 (CET)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1701177803; bh=e8b9fnxitWkWXRKnpPA0xPmyNbp8/i00cz0k+pMYsYY=;
	h=From:To:Cc:Subject:Date:From;
	b=e+F6WINFMfpxgoTfFvr+d3wQUfBdnMgKRkQI/0gAeDbhBVd4UnV1/Oc7l9D9b5pq9
	 RWw+7CaBfs57yKXtnmAYqG/ugMJj6zAaj7l7sfAsFldi0BcDREFSiyprLAWhQRBdRm
	 UYqJC4F6oIQdsFelaAASeSDXcLMrTwKD/B0YkL+Y=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id 39130A7F;
	Tue, 28 Nov 2023 14:23:20 +0100 (CET)
From: Niklas Cassel <nks@flawful.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
Date: Tue, 28 Nov 2023 14:22:30 +0100
Message-ID: <20231128132231.2221614-1-nks@flawful.org>
X-Mailer: git-send-email 2.43.0
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
using dw_pcie_ep_map_addr(), and then let the writel() write to
ep->msi_mem + aligned_offset.

Thus, modify the address that is mapped such that it is aligned.
With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
dw_pcie_ep_raise_msi_irq().

Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Clarified commit message.
-Add a working email for Kishon to CC.

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
2.43.0


