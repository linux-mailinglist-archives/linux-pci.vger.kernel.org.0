Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E68818D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407579AbfHIRsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:48:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407544AbfHIRsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:48:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so2287649wrq.9;
        Fri, 09 Aug 2019 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxWxbYpuDLyPXJqWZEZbXyDs1NKMpHde29lzAKbggBk=;
        b=OOVxdg+Ib93B4i6HLZkuF3U5I7Nfa+4oXlZd1sTHg4efRRm4HpQCGfW3u1tXv2WnUb
         h89gmI+7eF7EUy1c7T7ZrQrYgcWWhXPhK+WtubcXLEG4iJlKYTFI9HdLoYdzbw6+MsTN
         +h+D7mkp/z0TaFcs6Nt44qqEYm9aIFFre3F7yw5WFFIivMkST67+3yI3gO4Cd+35K/U2
         iJf0Kis92Sx1jt6CsrKC54pahdLBcDtvOsuCvxLSE05akq8pvhpZcmeKhr71lcFYb4RP
         88jL9fje2+Qs52Vvnuij7bueFor34SoLDVXcjbyfaotcL/+fSSpw16BWj8cDQdiMJEBd
         S+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxWxbYpuDLyPXJqWZEZbXyDs1NKMpHde29lzAKbggBk=;
        b=A3TLqmFWscD0/AKzWEzY8ApHnPNn8bmqE6kTQtFxf7+B8daOlkhwNbAYMXicEPmC+F
         VkUKydz+MUFKDyZ/fLuzOQf64LyzU+UWtNgFEfnHgXuscr3nl/ruLAhWwzYEmmCRKxBG
         RPnU9xdsMhiEESIwzRfxCu7WSNUIYAPfxk5qhSOLz+JsVK2oly2lt6JirnHnnv6p/LCj
         svB3GZUz+eFNZpXi3C6+ZaQAFv9NfhW7wWtAd5C9FI13R5bqvSfcharxFapHiD2jCcje
         pQyGxdKDT/GobAJIoKHkiCt/VrftZeCyZxx+1eSfVKv+tOf72TjmtMAhsmjf2iRfpmDy
         0t9g==
X-Gm-Message-State: APjAAAV00V72pyS4Rb2BYLs0b7xtsGtnKddONemNvQbat4IWf5XrJ4Cr
        PVSz9tFiyci2MEAtoMqV/3N6iGOb
X-Google-Smtp-Source: APXvYqxLmMILsJg7Nrrii86zP9ONrvZaK6dvnxrQ40Kwd4n94z+khQE7MzpijvusbGUgTAr+BX5A5Q==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr1237597wrp.113.1565372913877;
        Fri, 09 Aug 2019 10:48:33 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z18sm3999182wml.10.2019.08.09.10.48.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:48:33 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
Date:   Fri,  9 Aug 2019 19:48:24 +0200
Message-Id: <20190809174825.2572-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809174825.2572-1-marek.vasut@gmail.com>
References: <20190809174825.2572-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

In case the "dma-ranges" DT property contains either too many ranges
or the range start address is unaligned in such a way that populating
the range into the controller requires multiple entries, a situation
may occur where all ranges cannot be loaded into the controller.

Currently, the driver refuses to probe in such a situation. Relax this
behavior, load as many ranges as possible and warn if some ranges do
not fit anymore.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: Update on top of 1/3
---
 drivers/pci/controller/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 0f501acbc3bb..ee760bdc7786 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1049,8 +1049,9 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 
 	while (cpu_addr < cpu_end) {
 		if (idx > MAX_NR_INBOUND_MAPS) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
+			dev_warn(pcie->dev,
+				 "Too many inbound regions, not all are mapped.\n");
+			break;
 		}
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
-- 
2.20.1

