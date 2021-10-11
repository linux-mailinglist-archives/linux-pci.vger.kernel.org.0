Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601F42961A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhJKR4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhJKR4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 13:56:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277DC061570;
        Mon, 11 Oct 2021 10:54:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so11500270pgc.6;
        Mon, 11 Oct 2021 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZImDxRTs4nwbSxsAKdaHyup0N9fnqvqZDCDk/+Vf0Y=;
        b=eT5FFReQfb1LcNkIwafOPSuleoxZmsTsEcyXNFqnLbBwjR6De+HHX2hPGC3hRgbQ16
         zE4jTh/rIAcYWSvPmFrEjULaYVLLRN8sqBUeh3K65+oqfDf7Bu4yvx+DGFUPHfgW0eOJ
         sBzf9i7HOnuxtcl0doAhD/UylSNfLnlYbRb+SeJMJeS8czBpuU+6J5kjGzdnCdeMiVUI
         mvTh4fDdQUD68Xt2zYHW61FFfUd4TolDMj/0x8MLJ+boiRdwCdHR32iwHpHBgpXUp1lx
         CRowfDvAxBA9Hj8CQ1nyvrBG4bEd5NCf7J7x6nl051mfFqZ0twgWmbSxa8CGO8w0ocgW
         QOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZImDxRTs4nwbSxsAKdaHyup0N9fnqvqZDCDk/+Vf0Y=;
        b=d28QBHkMwF/8XJyfNIniQP/NXueEPq6DqsBcvsWTTXvZF7vfD7hGtkcYWHxJ/yxZRD
         A5dJh4fZ+gamEz0827snd7Ovli2YsRH9K+dfBByPfki+NT8J56diqKPHOnxlO5khptDg
         P1rPf5BSR5Ak4dQPw1a+giUFLD7l3Oxz+0o1f4v59z66MXPNW9OaI3mwCxTLPMqf3ZXg
         HsqPZ3rP3Vi86/w8UYdnnSXl5T0G4/KBCkW9lY/en4DD1rpTCqk5eFsq7ENztGGf+F31
         oduYCigKzjRuyb+iQnnzkRDDlJC1zzqf+Dr/XCcQTYhlNgPET2T7kOl/bUXfgFR7WAgl
         VT7g==
X-Gm-Message-State: AOAM530/5d5yybt5aVxwTIU+aFbLHwpcN45eCe0RHqUDc4YI4bUieUjH
        Kn6E/2cRZkH5HGEEY+TrXzY=
X-Google-Smtp-Source: ABdhPJwcO9WvA1cydLG6eyMp2ilpUV2ifEztZqKXTT4rpCG1e+IESlx7wRwodAB2FzQ9t8pAvZpn/Q==
X-Received: by 2002:a63:7504:: with SMTP id q4mr19249112pgc.103.1633974877421;
        Mon, 11 Oct 2021 10:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id v22sm8605011pff.93.2021.10.11.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:54:36 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 07/22] PCI: histb: Use SET_PCI_ERROR_RESPONSE() when device not found
Date:   Mon, 11 Oct 2021 23:23:58 +0530
Message-Id: <9cc65876240166eafc256e0b3f0b9af61a125c42.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
read occurs.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 86f9d16c50d7..1392732b104f 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -128,7 +128,7 @@ static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
 	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
2.25.1

