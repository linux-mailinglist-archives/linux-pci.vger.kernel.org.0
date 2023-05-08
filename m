Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3FD6FBAB5
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjEHWB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjEHWBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAD5269;
        Mon,  8 May 2023 15:01:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef302a642eso26151771cf.1;
        Mon, 08 May 2023 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583289; x=1686175289;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx7R4p6+ULwhZBgQaCubAERbN+8P+zvr1pwVtO5ok9k=;
        b=RlrbD63gcvBMuVfwPkuCe6vwtmO08hiUnG+bTXqPdL7Yb5V14uvN6Ay7P6u7sqMC16
         +R24z8RxV9VeyhAYLQ2JsOnY2JZO197fhmlNqz5x79OTysJroBBM7f2bARwf32WdiTSq
         FmFuxUWAJHayyUtj7SSPUpWlfxdZGaMXaBdhCrfBfPQjFYPsaG+SYANG0qGG2Qgyd+jB
         WBpLbEJ3V8ijeABbqjlHwEebId116LBgFb9/2Z0I+dIZika5WLrrbZ3extlUhXBcMH2X
         ZLYHYt9FInR/ce/UpfCw25neNfRVZPmvP8rbYHHNLzy9Ky4WPJbT/3qNT1JS7bHr2F7d
         2lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583289; x=1686175289;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx7R4p6+ULwhZBgQaCubAERbN+8P+zvr1pwVtO5ok9k=;
        b=TIsx+eN25r0R5F3qc4KgsMoV8Wifp1su/KxkyQ/mHg9dQiY2T2LNcDcSq2Vl2OyneL
         vZ2Y6NU527IyZbyR6dwvNzcWQFbuVCTUJWFW2FH0Nni/AS3Z+gE9D+ebtc9nqmJlhkIW
         VqsZqiTrz2ffn6EqgZs2YazG5jgfYDJ9ZG9+nfSmN1D3IsBQ4ht74alB90zCDd/jc9Hr
         mXtUG0cFdtbL4qYod5g73mUTGLpSktamBbuVEbCOEZnJ4XSMHRy7wTJ3061moH1W5nbh
         BJwSY8v70zsopRgIpKYLqNcQwbTUrEzQFL1LlFodA6YZZPXCv+vjwQmbyYFXVG8MkCbt
         MzYw==
X-Gm-Message-State: AC+VfDwutIKZ3xvMORMyENDsTKQFzF+ltuYQnP9y95kiMtDu41eJaCn/
        JJCpnJdDZ8R0vxJw1iZbM+K7g1oXFKk=
X-Google-Smtp-Source: ACHHUZ5B7IvYMAUFY+o88TUST+H6hkwz8ujLWToCVfKCazvJvZjt4iAVsy7BpOwqXMmUsM2kElZJkg==
X-Received: by 2002:ac8:7f14:0:b0:3ef:3fcd:3c15 with SMTP id f20-20020ac87f14000000b003ef3fcd3c15mr18113236qtk.49.1683583288894;
        Mon, 08 May 2023 15:01:28 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:28 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v5 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
Date:   Mon,  8 May 2023 18:01:20 -0400
Message-Id: <20230508220126.16241-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


v5 -- Remove DT property "brcm,completion-timeout-us" from	 
      "DT bindings" commit.  Although this error may be reported	 
      as a completion timeout, its cause was traced to an	 
      internal bus timeout which may occur even when there is	 
      no PCIe access being processed.  We set a timeout of four	 
      seconds only if we are operating in "L1SS CLKREQ#" mode.
   -- Correct CEM 2.0 reference provided by HW engineer,
      s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
   -- Add newline to dev_info() string (Stefan)
   -- Change variable rval to unsigned (Stefan)
   -- s/implementaion/implementation/ (Bjorn)
   -- s/superpowersave/powersupersave/ (Bjorn)
   -- Slightly modify message on "PERST#" commit.
   -- Rebase to torvalds master

v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
      driver probe() time.  This is done in Raspian Linux and its
      absence may be the cause of a failing test case.
   -- New commit that removes stale comment.

v3 -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)
   -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
   -- Put binding names in DT commit Subject (Bjorn)
   -- Add a verb to a commit's subject line (Bjorn)
   -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
   -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)

v2 -- Changed binding property 'brcm,completion-timeout-msec' to
      'brcm,completion-timeout-us'.  (StefanW for standard suffix).
   -- Warn when clamping timeout value, and include clamped
      region in message. Also add min and max in YAML. (StefanW)
   -- Qualify description of "brcm,completion-timeout-us" so that
      it refers to PCIe transactions. (StefanW)
   -- Remvove mention of Linux specifics in binding description. (StefanW)
   -- s/clkreq#/CLKREQ#/g (Bjorn)
   -- Refactor completion-timeout-us code to compare max and min to
      value given by the property (as opposed to the computed value).

v1 -- The current driver assumes the downstream devices can
      provide CLKREQ# for ASPM.  These commits accomodate devices
      w/ or w/o clkreq# and also handle L1SS-capable devices.

   -- The Raspian Linux folks have already been using a PCIe RC
      property "brcm,enable-l1ss".  These commits use the same
      property, in a backward-compatible manner, and the implementaion
      adds more detail and also automatically identifies devices w/o
      a clkreq# signal, i.e. most devices plugged into an RPi CM4
      IO board.

Jim Quinlan (5):
  dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
  PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
    device
  PCI: brcmstb: Set higher value for internal bus timeout
  PCI: brcmstb: Don't assume 2711 bootloader leaves PERST# asserted
  PCI: brcmstb: Remove stale comment

 .../bindings/pci/brcm,stb-pcie.yaml           |  9 ++
 drivers/pci/controller/pcie-brcmstb.c         | 91 ++++++++++++++++---
 2 files changed, 89 insertions(+), 11 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.17.1

