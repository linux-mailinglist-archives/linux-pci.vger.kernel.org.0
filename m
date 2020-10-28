Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3451029DA2F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgJ1XQW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390099AbgJ1XPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:15:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165AC0613CF
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:15:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t12so645430pgv.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iUnZeYRK4vIboje11z8E0pGSWAL3LEqKSuUfRc5J478=;
        b=Nx7qGJFAN71ZNXZS3f/KvFge75PMmyvgSthe2fi9fuuLd9kBiRU+g/gxnwfOCtD7XQ
         cd95k9wwthMblc1KvxkKivjN7csRKnTWHMcWD0bnSjjFYPjYueviYqoNkImusTWN6iv+
         UzJqLs6cL7xMjKy/ajuzP1dzmfANQ0kwv0BaAMtdhfRbysZpdZpWkqD254KzizOWsEAU
         kA/rLsDWEOnCdo5er+cV4yzeXeLuCcp+Cn0FnYVAT2zx8DThFhMq/aTyZBXNJF9PM0Q8
         Tx8QymHd+glDouMxYxSCtuEVwOshLcYd6BINi2oqhCRdFUedHxxpEHcuKLQdvG+Dkx2/
         SM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iUnZeYRK4vIboje11z8E0pGSWAL3LEqKSuUfRc5J478=;
        b=rToAS0fWlAciBrfnCGV4VimEO/gZgkyhQnj8bOPbaxFHeDswGd4CUjz3zMT11ykULW
         VxEetDDEP30t8Eu/Og0hNN4EdjmbafUPv7GQqf3G2jwD67oFb7nk/ayypMFUcCCADkBg
         UNLtWHLdiW/aAW9SYCEj1mmeoF01sTRbKDetX0eMeUy7fQ6oMK7cNkJXrOsGEQkoB0u5
         fu2yQQakRNxeRgelFR8f/jt+td5OBHLdh7Q1+ToFxRX67ruSTKlRkRj0XuXCZDvKFXmS
         ipy5sdvfxxnhTtnkMsCXlY4x2yQEEIW3fAdqttoL47RA7wBfy91Wt+GhrsrLlbu4zLni
         SBsA==
X-Gm-Message-State: AOAM5318yKl8M8DrP0NntObtf5i9g8Xa0ur59rOG/C8+Tin5yFAW7OKv
        Fo3/QI/wvNiylV/M4RivSr+GuLrXwLUy
X-Google-Smtp-Source: ABdhPJyhZ1xZSKNtV7pkxJxe2Ej0Li1jfs80R9AeGKbreMvPVV7BAYH0YSmiEUDAktMxvXMu4jWO66TVxQmY
Sender: "rajatja via sendgmr" <rajatja@rajat2.mtv.corp.google.com>
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:3c89])
 (user=rajatja job=sendgmr) by 2002:aa7:8c50:0:b029:160:1240:493d with SMTP id
 e16-20020aa78c500000b02901601240493dmr1287008pfd.31.1603926948983; Wed, 28
 Oct 2020 16:15:48 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:15:45 -0700
Message-Id: <20201028231545.4116866-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] PCI: Always call pci_enable_acs() regardless of pdev->acs_cap
From:   Rajat Jain <rajatja@google.com>
To:     0001-PCI-Always-call-pci_enable_acs-regardless-of-pdev-ac.patch@google.com,
        linux-pci@vger.kernel.org, "Boris V." <borisvk@bstnet.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     rajatxjain@gmail.com, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices may have have anomalies with the ACS cpability structure,
and they may be using quirks to support ACS functionality via other
registers. For such devices, it is important we always call
pci_enable_acs() to give the quirks a chance to enable ACS in other ways.

For Eg:
There seems a class of Intel devices quirked with *_intel_pch_acs_*
functions, that do not expose the standard ACS capability structure. But
these quirks help support ACS on these devices using other registers:
pci_quirk_enable_intel_pch_acs() -> doesn't use acs_cap to enable ACS

This has already been taken care of in the quirks, in the other direction
i.e. when checking if the ACS is enabled or not. So no need to do
anything there.

Reported-by: Boris V <borisvk@bstnet.org>
Fixes: 52fbf5bdeeef ("PCI: Cache ACS capability offset in device")
Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2f923d..ab398226c55e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3516,8 +3516,13 @@ void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
 
-	if (dev->acs_cap)
-		pci_enable_acs(dev);
+	/*
+	 * Attempt to enable ACS regardless of capability because some rootports
+	 * (e.g. the ones quirked with *_intel_pch_acs_*) may not expose
+	 * standard rootport capability structure, but still may support ACS via
+	 * those quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
-- 
2.29.1.341.ge80a0c044ae-goog

