Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDB7EA282
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 19:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKMSED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 13:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 13:04:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20944F7;
        Mon, 13 Nov 2023 10:03:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507adc3381cso6284988e87.3;
        Mon, 13 Nov 2023 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898634; x=1700503434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O0q/lzuG/y6HTyakaCBvtK6ZK/WSABJjsotgMFppjk=;
        b=ACbHE/IGA3UTuZilHmpQDpV3QTnfeJwgumcLo+9/v6XtofQql7PJKH4ORIhIMFRQlg
         EuyoPr4I61FKWbPAe8Rs4ySlQawcHubk0gAlrirf+x/GG20snMxYAegcQwlaXAq8wl4W
         8noo3xBdO3Sfrf8/QGCJSL/6BaBeMDTKWTJT6Dhu3lBS43AMZcLI/1KY+zgFCX11ubFk
         2bcunBhxHpp5uSbFZPYAr7+/X+hj6oH9H8vJatp/WK6SFIPjP7v0CDGsp4Zx/GEVRe7P
         NoN90tUEmsY7K4BamfTsoTxXGw7vxfxiV9ttvHEt0nw/JxHh70oKG/LPXi7JdpPNkcfD
         4ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898634; x=1700503434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O0q/lzuG/y6HTyakaCBvtK6ZK/WSABJjsotgMFppjk=;
        b=IIN4m+bvceJGAL4zfiToDPlA99F0MaRzV299KRQ4LoZPKDo2IMrjGHHqQhIMwW+1am
         NB3Fnp5dDZ/WQhiCdsUXaepBcmK7/8VQyPKPrqm7rCmPLCt22ssLO0c77EjctXupouj1
         +tOd9lVFB/fvSz/VzdGFA0DzT1Sk3/eMwciEfLNAhGOlmSjK4sZs7MBndyn3y5TPJgJN
         V94XqMVnoTsB1Q687m+DBhYul+LPkqGOZsJTmhn2CQraSene6BOf2Jk+jGRJxsCpKvOf
         cTgBm6DglnuPpvRuRqkFqa2LRj/WmEWU8WSgcm3USh+YRabYEZJShVfaJt8S8waOTzfo
         OyaA==
X-Gm-Message-State: AOJu0Yzdp0te5EBFTiwM/l9q/ya2KagGUHs4L0MetfKqxPeycBDc7VHy
        +hGLDBlawDnCAlH3rrFzFIRo+VN+1/RZ8Q==
X-Google-Smtp-Source: AGHT+IFvxHvtwQFnCbx89TySZ5USbYzzV8ToIEUPQcEA4JAAEGrkRqMEgQWbXpqPN1Gnl9/L56l/mA==
X-Received: by 2002:a05:6512:3d02:b0:509:31e6:1de5 with SMTP id d2-20020a0565123d0200b0050931e61de5mr6654349lfv.47.1699898634002;
        Mon, 13 Nov 2023 10:03:54 -0800 (PST)
Received: from desktop.localdomain ([109.95.114.4])
        by smtp.gmail.com with ESMTPSA id ko14-20020a170907986e00b009dd701bb916sm4329966ejc.213.2023.11.13.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:03:53 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tadeusz Struk <tstruk@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@kernel.org,
        Tadeusz Struk <tstruk@gigaio.com>
Subject: [PATCH v2] Documentation: PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
Date:   Mon, 13 Nov 2023 19:03:25 +0100
Message-ID: <20231113180325.444692-1-tstruk@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6eb84bc5-dd58-4745-8e99-ccc97c10fb63@deltatee.com>
References: <6eb84bc5-dd58-4745-8e99-ccc97c10fb63@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tadeusz Struk <tstruk@gigaio.com>

Update Documentation/driver-api/pci/p2pdma.rst doc and
remove references to obsolete p2pdma mapping functions.

Fixes: 0d06132fc84b ("PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()")
Cc: stable <stable@kernel.org>
Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
----

v2: Dropped a section that talks about using is_pci_p2pdma_page()
    function by the client. Suggested by Logan.
---
 Documentation/driver-api/pci/p2pdma.rst | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 44deb52beeb4..44efed79d908 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -83,19 +83,9 @@ this to include other types of resources like doorbells.
 Client Drivers
 --------------
 
-A client driver typically only has to conditionally change its DMA map
-routine to use the mapping function :c:func:`pci_p2pdma_map_sg()` instead
-of the usual :c:func:`dma_map_sg()` function. Memory mapped in this
-way does not need to be unmapped.
-
-The client may also, optionally, make use of
-:c:func:`is_pci_p2pdma_page()` to determine when to use the P2P mapping
-functions and when to use the regular mapping functions. In some
-situations, it may be more appropriate to use a flag to indicate a
-given request is P2P memory and map appropriately. It is important to
-ensure that struct pages that back P2P memory stay out of code that
-does not have support for them as other code may treat the pages as
-regular memory which may not be appropriate.
+A client driver only has to use the mapping API :c:func:`dma_map_sg()`
+and :c:func:`dma_unmap_sg()` functions, as usual, and the implementaion
+will do the right thing for the P2P capable memory.
 
 
 Orchestrator Drivers
-- 
2.41.0

