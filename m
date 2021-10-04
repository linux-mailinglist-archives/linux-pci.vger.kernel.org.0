Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8D4210F9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhJDOKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhJDOKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD1C061749;
        Mon,  4 Oct 2021 07:08:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v19so11641869pjh.2;
        Mon, 04 Oct 2021 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=WEUa66Fd7WtoDf/7Q8UM0ovCljnLKeI51nGJW39td75KXO3U8ACM8fup/QKb83eEnY
         5We5vSmFdYsjyhUd+BXEy6X5npUgLcRVji1T8id5/IdsPYDffHPrdeaJG0vcp92GFYgi
         /6cPJrhvm3IRtDg+CimNj7eF2wU/5hwajfSjBiZFgJUU2FKT/HNmgWrawEp913St+qtS
         /UehFaW02zzrxLTQPZT3rPz0B/JK9PUF3MRNhNTHfHAXJCZIMrSKgiNUCGjl/4AKrB2a
         uvfiedlgTlMHTIz3lNS7YMTHLlXplBBRz1W+93YjBV8x+zquGy421afJsMPsjOnaue6V
         ZNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=Wl3+duQdMbBgEy0KFkJHMVsfqUj4pMFqQYLD4m37h+8IzsIz2XX+mB63ONQ33YZqNa
         3Bir36OOmk+qhLsuUKKN39zbTfiHj4iwwUILkvlh9XuJV872vBHQysT/LtgSJU2Ee0dI
         vJU4SUJTB6tMTQqPER3RlEm72Ec9YDARzVBRJGkvxUnB8apsD1SxtA5CwwbO9/aDJeW5
         +cPbtJR73CeNrORheSW6zSFPRrJ6+wI57XDZwFYl4SsfEbUMigTWJFx8vucpu/cbFXdq
         h1qSKR84JeH0QZkpCvECsQj0EXqKjt3uBYVT9j1j453t2jrAkyn1Gzi7FPXpSUnPzaGV
         2yCQ==
X-Gm-Message-State: AOAM531+wnIxmk/BYFGJO/nMJrOcoJYkgngRriYCzD85ivkzXVXB+x0e
        ckzlZMdykCUH9jy3kVpuZ1Q=
X-Google-Smtp-Source: ABdhPJxiXt3ftOJK3flYITskQM3Ai/Q5NEFZd6Kg0s9wJr1Y2Z0LU5DHKJF6ULES21X3Rgeej6QwzQ==
X-Received: by 2002:a17:903:246:b0:13a:22d1:88b with SMTP id j6-20020a170903024600b0013a22d1088bmr23318540plh.16.1633356534168;
        Mon, 04 Oct 2021 07:08:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:08:53 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
Date:   Mon,  4 Oct 2021 19:36:30 +0530
Message-Id: <71cec6aef2535b48911bd98bd010012643eb0bd0.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dpc_process_error() clears both AER fatal and non fatal status
registers. Instead of clearing each status registers via a different
function call use pci_aer_clear_status().

This helps clean up the code a bit.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df3f3a10f8bc..faf4a1e77fab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_status(pdev);
 	}
 }
 
-- 
2.25.1

