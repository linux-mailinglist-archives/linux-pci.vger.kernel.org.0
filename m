Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFE4F08AF
	for <lists+linux-pci@lfdr.de>; Sun,  3 Apr 2022 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiDCKWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Apr 2022 06:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiDCKWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Apr 2022 06:22:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268032ED6B;
        Sun,  3 Apr 2022 03:20:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h16so4228764wmd.0;
        Sun, 03 Apr 2022 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=062yGinyulA5bgMq3Js/9yqeNFliRt521zdOAHdLn54=;
        b=ezYnk1OCyJwqt8+rupsB4FHu0mUqGmRL0mWbtzbCb5S4Cy6ftYmQBUqx26P+rHkGhf
         5SeUjcj7+nFQJj7aIcFWEpfOyjeSV0oOjNnHSyFSGowRDU6XTjWR1eBF35uiDD6QAMZr
         xnLp9Ak82Ji66RtHVu0p0AHXedaDwCUSExJjYAPLAY4ZbHCVaVzLXkKLp8FYTjZDKbF7
         UgaRW9741asYS8GjtJnqkCyeLPtqL984AeK177yABEhYruEVHyM6C99woo+VPwWKmih1
         KY5hD2uq7qqIiCFMnZW9SMk5JHP+jxf6xnQT0O2lNWeU26z601x05PdDwsaGX74iplht
         VTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=062yGinyulA5bgMq3Js/9yqeNFliRt521zdOAHdLn54=;
        b=qgOvOKFDvzO+ma3G+kiGduQaKyu3OogPREDOy5Wi7ukxuzxAr/t5lJ1fCuKzxI9lCx
         9VFCL34Vb2IWss2zm2Bnd8HKT7KJQ8ZTHCh/oyEEhpn9yLnYz91Fpk5ei2v8mhQuvozJ
         h51ookCCI8CUxDff5CXtzBRFj0HhXindCV3wshr4cPuh/qejzEwlsmP9owoMcC9pXL7r
         uqF/tc4tDKSIrJKTIkg/ZBELuhiXfLW3M/BI9RZ2NmM0c5iSmiCKEVYnS13YW8tpV5L1
         Mh65FfeQG6mJgivBI9jm3shRgBRP1v03IwI/nG22v2GnOQ0mq0NQteLljkLiJzz0Dl2p
         u/Tw==
X-Gm-Message-State: AOAM531nQEJSq0h2MD5k/2vYBH1xdeYmBZ4Obyn6DkdXAQWMParv1Izi
        C5NaSQQaLuXPM0ys0qbHWBtBGvMEgrI=
X-Google-Smtp-Source: ABdhPJzaNU3EkfG0guva/YQ3Cm9BKpjetMEEPga+GubdutstjeNX2+pnIw+RBvHg0Zr7RDr5RpzqGw==
X-Received: by 2002:a7b:c195:0:b0:38c:ea91:c0b3 with SMTP id y21-20020a7bc195000000b0038cea91c0b3mr15149400wmi.38.1648981213224;
        Sun, 03 Apr 2022 03:20:13 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id k23-20020a7bc417000000b0038ccada7566sm13639895wmi.11.2022.04.03.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:20:12 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V6 0/1] Intel Sky Lake-E host root ports check.
Date:   Sun,  3 Apr 2022 13:20:07 +0300
Message-Id: <20220403102008.7122-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in v6:

Address Bjorn Helgaas comments, e.g. commit line length and using both
"Sky Lake-E" and "SkyLake-E" in comments.
The comments in the code now use Skylake.
However the patch subject still refers to "Sky Lake-E" since
Andrew Maier's original patch used that name.

Changes in v5:

Address Logan Gunthorpe, Jason Gunthorpe and Bjorn Helgaas comments.
Fix indentation.
Update comments.

Changes in v4:

Address Bjorn Helgaas and Jason Gunthorpe comments.
Replace the implementation of pci_is_root_port with a simple check
pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT and remove the added
IS_ROOT_PORT flag.
Update patch text.

Changes in v3:

Use Jason Gunthorpe suggestion, that is add a flag 'IS_ROOT_PORT'
instead of 'port' and then just ignore the slot number entirely for root
ports.

Changes in v2:

Change comment and description based on Logan Gunthorpe comments.

v1:

In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C,
D to the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.

The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C
and D, respectively and if all exist they will occupy slots 0 till 3 in
that order.

The original code handled only the case where the devices in the whitelist
are  host bridges and assumed that they will be found on slot 0.

Since this assumption doesn't hold for root ports, add a test to cover this
case.

Shlomo Pongratz (1):
  Intel Sky Lake-E host root ports check.

 drivers/pci/p2pdma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.17.1

