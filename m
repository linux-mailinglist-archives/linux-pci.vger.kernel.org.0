Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0121D6D6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGMNYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbgGMNXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78FC061755;
        Mon, 13 Jul 2020 06:23:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so17143595ejb.4;
        Mon, 13 Jul 2020 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lE8AN0pbCu/dDP6jrScw+PxyAG3fiRl3vN639OZNf9c=;
        b=ayIR4bAOLjTG4FPDTwj9Bv/rT1Mu5DSxUxmly1JRltd3/t49vc11ms35/6SaQTBnDW
         grgTbiRcbvJv/DP8VfCI2t5YIAma/O83HsL8bg6F3jmYn8DjHIHlFyBlPbwgK9NZvLpV
         NhVTBRZ7lKyJjY2HhB4nOgVrjuzjGx7Gbvx/0Ct/jc4ZoZkaXRHDGimKOxD6qy9dBCS+
         sqcnADgH9diLoghHvHkKw+ljTOKr7vUjZGCiVth+JL4t+Oj2ZMh2VG+Nl97H8BDvhtip
         06AOHg8fxgsVax5a7Dn03qBbGWuJCeSxlPhhmGspiYLN45bio5jqhu1ESiQs78Ezc6ow
         QJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lE8AN0pbCu/dDP6jrScw+PxyAG3fiRl3vN639OZNf9c=;
        b=MxAQ13L0fuqCrtaO4VLvpk6UvuA3IjlqTjRnyzTucXKbeDd89FQK/ZApQrKmz6O/l1
         c6SQXLuPlIUzvWoKm81RM2wtZK8+1ozCbgKtRba702qCqN/FYXI0lScOZkRMV1jOfbYi
         jjtRBbQ7C7vhhPhVf7Gt6Egrczp4DOnDFc0Q93WqneUoTIV8KK0TUxEdB9RlZnhq+1+v
         kseFibqktiFtvzeSMCZISWHssfhGbTXbU61kamSF1/+CAlobJasv9YHUR4xYThvH3V3v
         FO7ZVx248+EMXZP1cwLqsKYyB6kpE/h0Gikm7XV8+bnw+yJ6jSttIqGj1zGlkriuKbDC
         s1bA==
X-Gm-Message-State: AOAM531iQHZbf24RQSugO5R3Nj08RJxvpTdIOaYxw0GjBbyy9uwx5T+v
        Kyps4cByktvBlJLMQ4H9qh0=
X-Google-Smtp-Source: ABdhPJxhwheaZHFk6xB+rN51Yz6X0yo6JNfKZG64pSHUWsziY38Td4p53F5FZbITqU6TE36B/dChCA==
X-Received: by 2002:a17:906:c24e:: with SMTP id bl14mr71978064ejb.285.1594646593479;
        Mon, 13 Jul 2020 06:23:13 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:13 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 27/35] powerpc: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:39 +0200
Message-Id: <20200713122247.10985-28-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 26/35

 arch/powerpc/platforms/powernv/eeh-powernv.c | 4 ++--
 arch/powerpc/platforms/pseries/eeh_pseries.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 92f145dc9c1d..834cb6175cc4 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -318,7 +318,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
 
 	if (!edev || !edev->pcie_cap)
 		return 0;
-	if (pnv_pci_cfg_read(pdn, pos, 4, &header) != 0)
+	if (pnv_pci_cfg_read(pdn, pos, 4, &header))
 		return 0;
 	else if (!header)
 		return 0;
@@ -331,7 +331,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
 		if (pos < 256)
 			break;
 
-		if (pnv_pci_cfg_read(pdn, pos, 4, &header) != 0)
+		if (pnv_pci_cfg_read(pdn, pos, 4, &header))
 			break;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 9c023b928f2c..aec6f76879a9 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -200,7 +200,7 @@ static int pseries_eeh_find_ecap(struct pci_dn *pdn, int cap)
 
 	if (!edev || !edev->pcie_cap)
 		return 0;
-	if (rtas_read_config(pdn, pos, 4, &header) != 0)
+	if (rtas_read_config(pdn, pos, 4, &header))
 		return 0;
 	else if (!header)
 		return 0;
@@ -213,7 +213,7 @@ static int pseries_eeh_find_ecap(struct pci_dn *pdn, int cap)
 		if (pos < 256)
 			break;
 
-		if (rtas_read_config(pdn, pos, 4, &header) != 0)
+		if (rtas_read_config(pdn, pos, 4, &header))
 			break;
 	}
 
-- 
2.18.2

