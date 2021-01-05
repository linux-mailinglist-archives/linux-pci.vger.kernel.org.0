Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14B12EAC32
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbhAENoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 08:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbhAENox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 08:44:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE47C061798
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 05:44:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q18so36283978wrn.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Xh8qZOWXZauoXa9vZ+K50zm9g9s+n1GKQJc2m0FrV8=;
        b=T9snQ9bKRyo+aHfNWsQiaTwtbweBwUVEbh1FBzR8gZDwjxw5kJ6Urcd3PHcyKp/i7F
         YuuVOjdv/SL6s2B62e00kEz7gzKjGyM2V1HTtHWdXpI5mqFGqPxqfdRX6ZzDCk98Dz8z
         V5Xgz1HalBD2/m+gbbOqiROSZG74t8xD+3fXm9RHa9aIrBnOi/OGvclNG4gq3cjC7Jyw
         hIee/qStDHEI+TPdS8nxykvg/q4+5JRFMwVloX2jOMhP1ty/hfMDlc4ymKMzyfJpWahd
         b74rKOQUOVrhYyGJB4NoBfxZKS7F5XZvn1Z0ajOcrwYWX4skrHOFTFE7Qte7E80ToxCw
         BD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Xh8qZOWXZauoXa9vZ+K50zm9g9s+n1GKQJc2m0FrV8=;
        b=XSqxVisGkgQPFsC6S1+liRCXhbEH8EalWdmIRwOVPUM7f65As4IeQEhjkCRraferjj
         7d65n4rTYb7Sl9aWstHKbuh06OtZZ+5F9Qd0+nBgCPXkefvblQXxos4vT0Ta8X5zBFlg
         Tc34hiB7vSzvXDixGNN6uAyvOaHUtDbuVh4DXHRiR32FZJmqjn3n9OQ3vfxkZ82KoIe2
         J2SJ0SBPbvVjnDLfBjpGr3rbPvR8FdkK+yBw2IY4XYwlwe35PBjVHjJ2pJejzNH1HYlq
         ed2WaQK5yMmkHigfB/KqltySWox4hGZX+c9b4kzPk98QE6ASER2oJblBgu/guUGtUIP9
         bWxQ==
X-Gm-Message-State: AOAM531he7jheS3mjZJBX2CgrlnGRi/9V5kL+8DYyo9WPI/7FNsRBAn+
        hOS6Q2v4AEU3IJcgRnCuciU=
X-Google-Smtp-Source: ABdhPJwLkmDD5Zg3fZC6NkuylnaqkeVxjvv3JjNRuhSiiF+n5kQbFv7JVfDkAm/Kbhghi2ev482tTQ==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr80583385wri.345.1609854252040;
        Tue, 05 Jan 2021 05:44:12 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
        by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:11 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com
Cc:     devspam@moreofthesa.me.uk, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI: add a REBAR size quirk for Sapphire RX 5600 XT Pulse.
Date:   Tue,  5 Jan 2021 14:44:04 +0100
Message-Id: <20210105134404.1545-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
References: <20210105134404.1545-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Otherwise the CPU can't fully access the BAR.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16216186b51c..b66e4703c214 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3577,7 +3577,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 		return 0;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
-	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
+	cap = (cap & PCI_REBAR_CAP_SIZES) >> 4;
+
+	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
+	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
+	    bar == 0 && cap == 0x700)
+		cap == 0x7f00;
+
+	return cap;
 }
 EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
-- 
2.25.1

