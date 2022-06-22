Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699B9554654
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiFVJyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiFVJyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 05:54:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507E22B1C;
        Wed, 22 Jun 2022 02:54:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o18so7885330plg.2;
        Wed, 22 Jun 2022 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3OJUOfLg2fp6Yw9slvyibMLkh1KMdKNRcGBNNwwEN0=;
        b=aWJrZZ+M2w9hzuBrUEi74QTz/Nca41Mgo0VBFDVPrxxtChz9X4xQ+oSNBAYzcOFGiX
         zqhsKq6NCt0/3WRYfh7twNIFnlOW1paAbZMYKZSOMMHPFXh0vRbt65LJswEqYJwM1HH8
         wvvsfnxJGIH7irWLR7Qqh6V4IMKubJke91uMv6VKn/WoSPEE+LT5n5S70OoRfXQ7KLXN
         ubYJY8R2kIGThzm5jYnc4CwUc/5sCJaG3gRM46xlAAmR0oEYDzF7L8LNd7N9M0bp5+qU
         50Jn8B0tsyragIhwsPTTV8G6FvZte0yiOKkEzEmaI1ViFFsCuXSHJRbekwZh4A22xHzB
         Rk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3OJUOfLg2fp6Yw9slvyibMLkh1KMdKNRcGBNNwwEN0=;
        b=VNk+7pXpQMHoPP9HhEWEjuyEiLvtz2E2Nd3kJWd0ugQBKxH6x7UTdQQrQLc2vn62yg
         +JXgq+sVfB3gr+uaTnb4WiKr4w/1SePfHPokqrWYBjbCjO7f95JjAoLx5Zmg7sBtF58S
         J/O/hhG1ycQef+AUVnlP907xrUm4fqrYKlcn4Eu5bGzMZJqdaxCKk7PakQ3CuA0cVlxK
         +N2o55kD9eqXq3ikGzaqQsao4lrQfH/gtEPNx2Too7VN/VMBJ+aQxNfLAtRuLsoDjdXp
         70lvMT04ZFhkAZwLz8wuzX0fVin095Q69eXLpzu850DFfQC7Qges1ZfPOx0ZDfqa6Y+l
         M9PA==
X-Gm-Message-State: AJIora8hrhXLWttfP15HeEKzlzoMRTzss0HDnhTSiAdRyIIRwfByx4Bz
        rDtga+ZoKmrjO4UOQRkak4c1TO7J+Io=
X-Google-Smtp-Source: AGRyM1uOLIWxdusDf2pPM02W2RekyFBvS2fgYtoG0H0WN6AmcHuY4bVqjkR1k5JRlqty32zji3LVXg==
X-Received: by 2002:a17:902:f64c:b0:156:4349:7e9b with SMTP id m12-20020a170902f64c00b0015643497e9bmr33831832plg.139.1655891641399;
        Wed, 22 Jun 2022 02:54:01 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0051c4f6d2d95sm7064420pfo.106.2022.06.22.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:54:00 -0700 (PDT)
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
Subject: [PATCH 2/2] Documentation: PCI: extend subheading underline for "lspci output" section
Date:   Wed, 22 Jun 2022 16:53:45 +0700
Message-Id: <20220622095345.27121-3-bagasdotme@gmail.com>
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

The underline syntax for "lspci output..." section is off-by-one less
than the section heading's length, hence triggers the warning:

Documentation/PCI/endpoint/pci-vntb-howto.rst:131: WARNING: Title underline too short.

Extend the underline by one to match the heading length.

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
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index b4a679144692a8..31a0bae868f996 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -128,7 +128,7 @@ RootComplex Device
 ==================
 
 lspci Output at Host side
-------------------------
+-------------------------
 
 Note that the devices listed here correspond to the values populated in
 "Creating pci-epf-ntb Device" section above::
-- 
An old man doll... just what I always wanted! - Clara

