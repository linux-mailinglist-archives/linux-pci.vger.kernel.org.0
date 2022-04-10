Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E44FAD7A
	for <lists+linux-pci@lfdr.de>; Sun, 10 Apr 2022 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiDJKyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Apr 2022 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiDJKya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2022 06:54:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD3D532DB;
        Sun, 10 Apr 2022 03:52:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so18933558wrg.12;
        Sun, 10 Apr 2022 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=llW7B1Y8UIDWugQLg5yHg6HiFsiJYRF+SBU4WWXD+G8=;
        b=G/dS4LyukZp8n9RVmx72lelpZ3SEp0b35k0GgH3ZdLBH7wXfS5mfd37PLtjwRmCdhf
         ruo82X4Vl00/0jTd2sAdjQPQiD+/HMU6mBft13MpGr0afxLg6p6uhRFP1J5rNbzPs0zY
         kvJ68y1JGTvw35K4a6nL7rKKfL0J/q1tlcmd2wYcO+NiKKKTrv3OJfJhWqjb9dGGQouK
         +cmzPtFu5eXRKst12VgNUzRrgGfCApLh13zEzunDE1LMoi7i9Bk70vAUMQ8fZRaiLMcS
         ay8IxA8HcyvWvi9qQhj8urd8/MoYFpKQ+eaPBS+GuFNZPpgatg1ved4xPcXogpPA/iER
         bVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=llW7B1Y8UIDWugQLg5yHg6HiFsiJYRF+SBU4WWXD+G8=;
        b=iysxh9KIJttZ7K+SPrtDa/xawjqY+lZIvgQvMvhmMCSrfYtuAn+3TRlBteve7az3VD
         D4CjK6gA8l3+oIKMIQmx6ggYN4mJbg0jvqWCfl5p/5kVbNtLpIYiV7Vt7q7BFrjy9YJx
         lqmOgLBL8VndXqluJ1TwCUCFjdBmh5a05FmsnJqJbITPRlulIWyDE+wSvndlw/6lEKas
         XN814jgs7uK/8b3VsZNGQ1RxjX9VP96Tkde+035bpUtdNaMqOvFK96HF0ccUqEjJdafu
         cieTZDeJ9FSRg3W7IVIfHsXMciGTLVuFNsN4bCC4xHMR4TpQcP4Bp0g31ANid6Zp5TqZ
         LGUA==
X-Gm-Message-State: AOAM530KuJecup7Iy/s8OUtwh7viCB/nXB4xnwp4Wsg06z3jT2fnBJ6x
        d+jSS17JNBAgCkii3MgYeYmh4CEpG68=
X-Google-Smtp-Source: ABdhPJwOpNT65O6BbSHz3h2v6wRqe+hMG44eZU1wuU5+FPHLUbzesu1wSW5pQZnYSlOSlvHXJpni0Q==
X-Received: by 2002:a5d:6607:0:b0:207:97e1:86a with SMTP id n7-20020a5d6607000000b0020797e1086amr8809286wru.603.1649587938073;
        Sun, 10 Apr 2022 03:52:18 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id j9-20020a5d4529000000b00207a5b7f613sm666740wra.69.2022.04.10.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:52:16 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        helgaas@kernel.org, Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V7 0/1] Intel Sky Lake-E host root ports check.
Date:   Sun, 10 Apr 2022 13:52:12 +0300
Message-Id: <20220410105213.690-1-shlomop@pliops.com>
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

Changes in v7:

Apply Bjorn Helgaas suggestion to avoid negative logic.

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

 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.17.1

