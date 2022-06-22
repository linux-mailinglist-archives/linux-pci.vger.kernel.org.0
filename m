Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7B55491B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiFVJyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiFVJyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 05:54:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175472C129;
        Wed, 22 Jun 2022 02:53:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cv13so12836741pjb.4;
        Wed, 22 Jun 2022 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwc5cjan8XJuhiO2AI0Z3XaaNZmw6lQvr6pdCpwGjII=;
        b=RCzyHlkdvvSD53hRmnKcVv4COSd1NhKAI5Q44wX03sqC4U5v14UYZv18yac3a3I+La
         Vqigz1/6gfz+Nn/sycVzc7a4Z+A1F4vEMWvkLtQ6A/jZR4+zhFqBL1hB5QjHs2SXWxbe
         mYx7ribRWCRfuuW0Qj1kF8SY7SFzNpbjPiU+jD/4qMevBxACsPImyU9B5rR0c3ZKv6CY
         DWLmr1l93PLSO+Cmpxiyl+XOz/yRZ2G57cMoqyLJGODUVm4mlBaYtOkhq4UymC4nyDf7
         PtJTOFTpfiAwNG22faBVxkp5KTdROSwTKgsPnFRa2FM46dBKFYDwRg6KLG4MDre/KGyd
         quFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwc5cjan8XJuhiO2AI0Z3XaaNZmw6lQvr6pdCpwGjII=;
        b=tkyuUw3C+05tYDRCweuXm4v4M0/6VIFwxbAcHtfPI/gZ6qjQm273YQ9OxiXC38VljM
         CKUF2cJSSQprrSu0JQ0PNwNBi1heQvbLiPI46tMp7FhvRQkyMX5N8A0Bmv7UOIkYf0y3
         pCI+3MRrcyb7FwVcgsvBPDGDET3oivGT+PBocppF8BjB8e4KOz31NPyw+HeuWrQzOkI+
         q8yCqfot73OgEHS8CCtgCmbJK5DPUtJrq7Z3JE/MxBl2DqsJwaDaSwYli9AVjhQSpAYF
         Wmmmudi0bQyaxT3JNogeqw+LcjUWyi1J9CwGmEsQnLt8lLiWSgQaIee/kGQ/vjt4GkGl
         oHtQ==
X-Gm-Message-State: AJIora81k6eVTHmQoygKu6m2zgO00npEq6Nfvbcg5UO89Sx3meZjIZOY
        AP7oxeIawdkRv6du3lFdffLotCDq5mg=
X-Google-Smtp-Source: AGRyM1sFGudijpzT26VAOlGiZRBnGgsqJsM7+nB/njLIsscreYO34kywo99d9jHItdLZZq8UD42HEQ==
X-Received: by 2002:a17:902:efc4:b0:16a:133a:b20d with SMTP id ja4-20020a170902efc400b0016a133ab20dmr20472708plb.45.1655891637012;
        Wed, 22 Jun 2022 02:53:57 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0051c4f6d2d95sm7064420pfo.106.2022.06.22.02.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:53:56 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>, linux-pci@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: PCI: Use code-block block for scratchpad registers diagram
Date:   Wed, 22 Jun 2022 16:53:44 +0700
Message-Id: <20220622095345.27121-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220622095345.27121-1-bagasdotme@gmail.com>
References: <20220621200235.211b2e32@canb.auug.org.au>
 <20220622095345.27121-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The diagram in "Scratchpad Registers" isn't formatted inside code block,
hence triggers indentation warning:

Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected indentation.

Fix the warning by using code-block directive to format the diagram
inside code block, as in other diagrams in Documentation/. While at it,
unindent the preceeding text.

Link: https://lore.kernel.org/linux-next/20220621200235.211b2e32@canb.auug.org.au/
Fixes: 0c4b285d9636cc ("Documentation: PCI: Add specification for the PCI vNTB function device")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: linux-pci@vger.kernel.org
Cc: linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/PCI/endpoint/pci-vntb-function.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
index cad8013e88390e..0c51f53ab972a0 100644
--- a/Documentation/PCI/endpoint/pci-vntb-function.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
@@ -58,7 +58,10 @@ It is same as PCI NTB Function driver
 Scratchpad Registers:
 ---------------------
 
-  It is appended after Config region.
+It is appended after Config region.
+
+.. code-block:: text
+
 
   +--------------------------------------------------+ Base
   |                                                  |
-- 
An old man doll... just what I always wanted! - Clara

