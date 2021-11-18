Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90314455D9D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhKROMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhKROMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:12:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F7C061570;
        Thu, 18 Nov 2021 06:09:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h63so5391761pgc.12;
        Thu, 18 Nov 2021 06:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zB5XsRc0hZcCafw5hLwjwE1ROreQcocPtbGP32SH7qk=;
        b=CcSVQRzC7FXSFIlS2qpJ/HUOdyBR5TMsGgaMfCh2axue8nls25qACZnuGDAfyapleu
         wo/lATjkWu2ELnZMyXo/2GADE2BsptJIrOlIVpTUbQkSd9qn88B/1VneLRVXfvmZHPUg
         zhoN4krfHxRuyV82pYDbizhtRy3sCWoAGvckBxyxVLY471CZRaovUwagQaoZaAM1Jpgz
         CetmBN4sVXawTd216K+AheZqBtsTjeWaAUZIUTUE9xfcmwApORNxUvtv5/RPWUKi1v/Y
         xBPRXfKDl8wj0WPuiMQLl6k2mem5ATDQqMTvahMapFDmbpujEX0DI5DcCx3XdDZl5SW1
         /uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zB5XsRc0hZcCafw5hLwjwE1ROreQcocPtbGP32SH7qk=;
        b=b/SrhFIGGa/ymKGiuj6QP49KTx6YaVfoC60jwxkg5xpYx+3AsYi5yf3newpj6wtN8q
         ntCMOLYj4qSzNFo2o42AGrQWDZP6AW4oLdJ7/gQRMot5x+Ya1TeAtCUDpt4tPdZIfNM4
         34DKEoPK75KQvnxtOsM66PNHscj809qGix+zx0nK6UKNmzPpkT2/XjjhI8nhtFU/i5FX
         JX1iv1B9hCCFfoNIPQ3VSCNG9PJvaqLGQ3LOl3a5JjWqcc+l0ZHxSPpJSKts/j6MT38R
         JGQ/QWQli120Xenk+Anoy/8EiSv9Z3K7fbETJjwSxnKcHY+hN5BNmivjWv1igJTo2TSZ
         rgGQ==
X-Gm-Message-State: AOAM533LTMLnK2YoV33WA8Fe9I/cKGCEwoYTDnT1hgi5JBzLc4Dm5KNV
        PGOe9e1lBVGL2FOvL6OEUO8=
X-Google-Smtp-Source: ABdhPJxHe5yoN311wNnxMelRGgb5M8SJ/v09H+EE0Bt/IwVrvmRmADVScTGYdONmLDvX0shcdVjBdw==
X-Received: by 2002:a62:dd0d:0:b0:494:6e7a:23d with SMTP id w13-20020a62dd0d000000b004946e7a023dmr15374639pff.17.1637244592768;
        Thu, 18 Nov 2021 06:09:52 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:09:52 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        APPLIEDMICRO XGENE)
Subject: [PATCH v4 25/25] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 18 Nov 2021 19:33:35 +0530
Message-Id: <388b9733bd55394581c447be9f3df42ca2c9759c.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This makes MMIO read errors easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..89ea81ffb532 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -175,10 +175,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * Retry Status (CRS) logic: when CRS Software Visibility is
 	 * enabled and we read the Vendor and Device ID of a non-existent
 	 * device, the controller fabricates return data of 0xFFFF0001
-	 * ("device exists but is not ready") instead of 0xFFFFFFFF
-	 * ("device does not exist").  This causes the PCI core to retry
-	 * the read until it times out.  Avoid this by not claiming to
-	 * support CRS SV.
+	 * ("device exists but is not ready") instead of
+	 * 0xFFFFFFFF (PCI_ERROR_RESPONSE) ("device does not exist"). This causes
+	 * the PCI core to retry the read until it times out.
+	 * Avoid this by not claiming to support CRS SV.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
-- 
2.25.1

