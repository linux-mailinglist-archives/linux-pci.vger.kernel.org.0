Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC643658F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhJUPP7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhJUPPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:15:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB6FC061233;
        Thu, 21 Oct 2021 08:13:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so811532pjb.0;
        Thu, 21 Oct 2021 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWK0fPhiFvF9dyvSZCI83CRyKYd+k4snQIY5xhFTQVg=;
        b=WVXnrDKpBkRsnqHYlJch8EoBuAARA9XFKQRF8x5Gv2wL29rXOafMDIpA+eBkyyok3P
         pB8vJ5wNh6f9MspxxjVwvnd1HTtHhrWk3mlEPGBSPWVyBOM06eJ7OAJF1+tkAjZU+lS+
         +SpXqolra9sbekn0GqO3G6PGYsC5+AVtxGw6qsmph82e+9QLdwCpN31nrKOu8/EpDF9V
         G1H0T7a1bRArKt8zlqOAOW5k3o/V4qAI38QvnJcrqacJ/KgiSv3YLYFh8wnp4VqVcwQW
         VBeFQAxA01rwlWu9wcQF9JGj2qMvx3opSdu7VoceIRt1vj0WzqSoEATbWK95nm+xWxpX
         9ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWK0fPhiFvF9dyvSZCI83CRyKYd+k4snQIY5xhFTQVg=;
        b=7BsOoh4KLjOa0I8y/yGH5MM/Mon8zVjGetQZkEnQKO1gIa0HhM+CVfnnm625tNQ7de
         hhb8M8WdPqqQrkfPRe7s53saxRX2saf1zKk9BvaYpmBOWstUJlYfsH6k3/uZavnW2Kec
         HgDKMpiUzmnigFyt1t+jQLFfbLKgdTFafR8qB3aQhAQIlO2MtdzHWbzEuFODQnMS2j29
         Mv0H4UnlKaQ/CRzZlxjH2bTFc+/LapCAxNeSGdBG3WZr8Zr1Ye7HdOR+jkGlmFzzLLnT
         8u4UNgnBPvL2fEyaxp081c7yn2koBXVzd06xupCf1PMTcfOuNB9NZkxeemVlnIX9ii6N
         Sr9g==
X-Gm-Message-State: AOAM533FLHE5VOQm1g/IWoTBXEsnfiGyHRBP70uEql9oxk3YA72dQTxH
        7ET09R27+dvb3n7xTIEuPqs=
X-Google-Smtp-Source: ABdhPJyGJ4astve2/4iTWtMqGX88sDxmNxOV3i/wr3/3IzZRoR/OJj+5bCEstpuFYEt72kulysyHng==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr7318159pjb.7.1634829186527;
        Thu, 21 Oct 2021 08:13:06 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:06 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org (open list:PCI DRIVER FOR RENESAS
        R-CAR)
Subject: [PATCH v3 14/25] PCI: rcar: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:39 +0530
Message-Id: <29e534503de9502e4a30a1cb970f72c20243cc7e.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 8f3131844e77..1324cb984ed5 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -161,10 +161,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
-	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
-	}
 
 	if (size == 1)
 		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
-- 
2.25.1

