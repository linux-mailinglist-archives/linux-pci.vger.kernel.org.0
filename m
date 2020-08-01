Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F36235210
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgHAMYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgHAMYk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7550C06174A;
        Sat,  1 Aug 2020 05:24:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w9so33998813ejc.8;
        Sat, 01 Aug 2020 05:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Ef8IUcnocHoCROk98NuQIVshhmZka7ZCelapJAaYyI=;
        b=tE/fjtx1OYaqRRakblDmsU7Cnv83ftTXHcpBU2sObAMVsHdeeD511d9uE4CQXW/ML4
         9ou6kcbOTCYlmoJ0BO9fpP7W3JJjmWv949Gl3o20KOci/t0eNHJAqYZ2Gxk5TopcRyvh
         XLrXHaTzRgX1modYGbrCQebf06ionlzqNcQDrvnR7iTys9rnsAiAjUDK29lVQ0B44zV/
         xLk1t7R97tRvTLpCRVbiLlyZiSK49nLlimS8r/LHu8RKfg7euo0rzECAOimgYpZk2+B7
         QVbgypX/3v6luzZE15+a7OoNY9AhGTRacKHp3DnL+ZdWO2O7gG/HZVrRUPIAMzfjSFbQ
         0qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ef8IUcnocHoCROk98NuQIVshhmZka7ZCelapJAaYyI=;
        b=KYLkXIOW9XRGxhlotqORzUbqGxgbpsvzNo/nkZTsHzCSRYScNE6xFdp1yD1CsuhVYT
         TC7Kq2ZDyq5hftR0lXejs7VMXwV2qfBGscTMsoSFrt4rKOIUNSl+adM6ozOJmLNINnEm
         YmEm09NkV7mwJEWTcPBgMT6mtcv0AnnWC86SqpR2chHMhwMpbA4DcLHrzAnHmUX4ByMw
         b1fPi6poq3vJDG8013ogK2/JwYj09b2ww3x4s7dCv1DVgxmZKn3juXi9cFffICRIFCfr
         Mqy0OSpz9Sma+p8eN/GLxfnvox2WzRYOsh0ymW7tNZHm3Syws8f2M8sm56IXz9/jwd4Q
         cKig==
X-Gm-Message-State: AOAM532tnMT0jGUI8VgZN1sBl4PM0gnaeCZjKX6nos9GuPMG4DwuF8hH
        s8FB3OimGL/zfGM6Too1W1U=
X-Google-Smtp-Source: ABdhPJz01/oRMdN4kVKWwAkYQUYeZyQfsFmTxzv+VPQbHpGFpIXoIwXAq4Azmv82DQf/ASMIkfxYUw==
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr8170598ejb.10.1596284678498;
        Sat, 01 Aug 2020 05:24:38 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:38 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/17] intel_th: pci: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:40 +0200
Message-Id: <20200801112446.149549-12-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/hwtracing/intel_th/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 21fdf0b93516..176c9088038e 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -32,13 +32,13 @@ static int intel_th_pci_activate(struct intel_th *th)
 {
 	struct pci_dev *pdev = to_pci_dev(th->dev);
 	u32 npkdsc;
-	int err;
+	int err = -ENODEV;
 
 	if (!INTEL_TH_CAP(th, tscu_enable))
 		return 0;
 
-	err = pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
-	if (!err) {
+	pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
+	if (npkdsc != (u32)~0) {
 		npkdsc |= NPKDSC_TSACT;
 		err = pci_write_config_dword(pdev, PCI_REG_NPKDSC, npkdsc);
 	}
@@ -53,13 +53,13 @@ static void intel_th_pci_deactivate(struct intel_th *th)
 {
 	struct pci_dev *pdev = to_pci_dev(th->dev);
 	u32 npkdsc;
-	int err;
+	int err = -ENODEV;
 
 	if (!INTEL_TH_CAP(th, tscu_enable))
 		return;
 
-	err = pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
-	if (!err) {
+	pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
+	if (npkdsc != (u32)~0) {
 		npkdsc |= NPKDSC_TSACT;
 		err = pci_write_config_dword(pdev, PCI_REG_NPKDSC, npkdsc);
 	}
-- 
2.18.4

