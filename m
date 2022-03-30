Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B54EC62A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 16:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbiC3OKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbiC3OKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 10:10:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83439197AE9;
        Wed, 30 Mar 2022 07:08:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso46415wma.0;
        Wed, 30 Mar 2022 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LT8OJ5d/6dP2y8yb0uaYNPnpW+7UZtTuX+R7l9ZvQAk=;
        b=qRFvLMW9jLZednEE4rsSbN8iRPATrk9gULqaawI2FNrNglA33rNRXLx0+NI1qwDqkb
         zc5Zhv7qCkwAOCyvPIMJgDg6Zja1nslSKOPE5Zp1k6Xs3WALj0PB+qK9/k3d5Ja/GL4W
         sIC3dktGRBpSQ4ee9GaV8U7NPEFSqIZY/kP/yp15QCOq6xlAlAfqMDsx1ImLeJ46Qa4V
         KL6OFYxWEdAFdbnZtOKRgR6FBm6moxbuuXxDtFqYp0OtA1/PIv0/6dpxO+FUSAF9zsXZ
         D+cP2MKDzZDoWFdG5zc6pzVM8FGuy0/rjymC6i2WCEc99DMLcQcdz2sKasZiC2njv497
         Sgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LT8OJ5d/6dP2y8yb0uaYNPnpW+7UZtTuX+R7l9ZvQAk=;
        b=ZXEla/UZ3nfrA9ztwtyc/21A2ouVyWIhTfPWeknxJegJlTXmjjsxxKzjUHTNMXLHY2
         VIDnFcT6L6u1h67mwe36c77m3HX3qfNxUjbsRMKSJiE8OdOGnu/eISR8W5CLM3z/TFOZ
         r/b1AsPCkCEd/17vjweVGvvQF1Sgo268dT9O8LgqkXBUuDsmeQPFxGpLtBAAVbJEBTCC
         qg42Vor/FzVrwWyUcZyM7LRYa7PKO7Rbc7XDWX+nataktrMCEWvugTXn0YUXAPtrK5l2
         4inAq+njb5rjQnSBE+b1vjZYNtMy2Yv5XFui8vO/EA9xQx4JY9eWyUHCcEuXnuDc/ZAh
         SCrw==
X-Gm-Message-State: AOAM531lK/l6cKrsVx9KytmeibU0K+tjYf3+0NrQiAugjvlAwS5lQcI8
        h/TMpO8f9pqjb0YaoL2P+Apq06ytHDqRTA==
X-Google-Smtp-Source: ABdhPJxIVgflvXtchMdw2LHykOYJNAgxaZWJR/JP/a+r8LVB7uu5Rlu7IRUUXPg7LDFN54Co8k7vUA==
X-Received: by 2002:a05:600c:1f11:b0:38c:6ce7:69c5 with SMTP id bd17-20020a05600c1f1100b0038c6ce769c5mr4745555wmb.64.1648649308456;
        Wed, 30 Mar 2022 07:08:28 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm22272782wry.32.2022.03.30.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:08:27 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V4 0/1] Intel Sky Lake-E host root ports check. 
Date:   Wed, 30 Mar 2022 17:08:22 +0300
Message-Id: <20220330140823.28826-1-shlomop@pliops.com>
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

Changes in v4: 

Address Bjorn Helgaas and Jason Gunthorpe comments.
Replace the implementation of pci_is_root_port with a simple check
pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT and remove the added
IS_ROOT_PORT flag.
Update patch text.

Changes in v3: 

Use Jason Gunthorpe suggestion, that is add a flag 'IS_ROOT_PORT'
instead of 'port' and then just ignore the slot number entirely for root ports. 

Changes in v2: 

Change comment and description based on Logan Gunthorpe comments.


v1:

In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
the whitelist")
Andrew Maier added the Sky Lake-E additional devices
2031, 2032 and 2033 root ports to the already existing 2030 device.

The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C and D,
respectively and if all exist they will occupy slots 0 till 3 in that order.

The original code handled only the case where the devices in the whiltlist are 
host bridges and assumed that they will be found on slot 0.

This assumption doesn't hold for root ports so an explicit test was added to
cover this case.


Shlomo Pongratz (1):
  Intel Sky Lake-E host root ports check.

 drivers/pci/p2pdma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1

