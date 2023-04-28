Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B776F20D3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbjD1WfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbjD1WfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:35:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004119B0;
        Fri, 28 Apr 2023 15:35:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso15822381b3a.0;
        Fri, 28 Apr 2023 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682721307; x=1685313307;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vOstVtn4U8mVVNUS55u/MqJkN03FQpeD41b7DE/zvQ=;
        b=aQkEHaPbVzJTVRn5eLWNhdigjeLnXKk61110YoRAN3h3EK2ggBAeoddYsq6XUGiBfm
         hPSYUu3gSFNsiWTG7ZEwBn7uCxK7bE+WHELl5usL7qr85b3rAztOCoCRACKrPNgEAM2N
         b2hM6es99qBqw2gtEyU/rFb82TXY5ezHANUCJc9AdTWakdh/BXr92AqMvJSR3bbzYLdt
         sBBaf4JaPcb8qgVO0n0jjgpXrHRIlxAkvXWSNRDgBtGP43TokEFpzPfpeTlRbAllzCeD
         RzXn9xcjd9je7/cKKc2nzOI7Vl9lzsUlU27EI6NngJAMBtIpIEkvV+DrYZGk1ATWygjT
         f17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721307; x=1685313307;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vOstVtn4U8mVVNUS55u/MqJkN03FQpeD41b7DE/zvQ=;
        b=l5EhFRF4aKQm6xqqCKPalysxcvXZYBZwRI2q+OiaX140zZMkUi8hgxN+rq+cWAT7fc
         jpaIVuwCHEkPwfk0qGRdKl7XdiQUaEj5ueFlTk4VV4AqppoCLNq9PAIy0M756ZsCopw5
         XKStbFMToIB0pEU2FCQEUrLcS2XQVvN9QFIDw2n7Q8r4awG17bogxVQNPjDPbYj46Mdw
         SryCIBMHNV6dpwsAUCxfJkifleZG2QmmgqnbvD+be5J/31qz5iZ8TT9FsoWYy2CvC0RY
         0K/IRIacmlpMTLKUxs3V8J/45bp00B4n98CqBll3KtqmfkFBwo+sqUB9FBkcTD8MPuoU
         G4sA==
X-Gm-Message-State: AC+VfDwX1JNeTOT0j8FNB6uVwzhi/XHzrOEcHoKY8K+KBWiHV903CgU6
        02gT+k3lgCZY3yRJv0M/j19OnP36rLo=
X-Google-Smtp-Source: ACHHUZ6QG3ghkGKfTSWfvYQJQSzF/pfh+oV51JpO9QHWz6Ekec0JtrzTBlBQ1pF31lSqfXmD5cLtJw==
X-Received: by 2002:a17:902:e551:b0:19c:3d78:6a54 with SMTP id n17-20020a170902e55100b0019c3d786a54mr8053221plf.14.1682721307102;
        Fri, 28 Apr 2023 15:35:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm13657847plk.62.2023.04.28.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:35:06 -0700 (PDT)
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
Subject: [PATCH v4 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
Date:   Fri, 28 Apr 2023 18:34:54 -0400
Message-Id: <20230428223500.23337-1-jim2101024@gmail.com>
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

Note: (a) With this series, all downstream devices should work w/o DT changes.
          Only if the user desires L1SS savings and has an L1SS-capable
          device is a DT change required (brcm,enable-l1ss).
      (b) No code changes between V2->V3 except to remove a dev_info()
          and change the string of another dev_info().

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
  dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us}
    props
  PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
    device
  PCI: brcmstb: Set PCIe transaction completion timeout
  PCI: brcmstb: Don't assume 2711 bootloader leaves PERST# asserted
  PCI: brcmstb: Remove stale comment

 .../bindings/pci/brcm,stb-pcie.yaml           |  16 +++
 drivers/pci/controller/pcie-brcmstb.c         | 105 ++++++++++++++++--
 2 files changed, 110 insertions(+), 11 deletions(-)


base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
prerequisite-patch-id: f38de8681d8746126d60b3430eaf218d2dd169cd
prerequisite-patch-id: 23e13189f200358976abf5bf3600973a20cf386c
prerequisite-patch-id: edfbe6ea39ed6a4937e2cec3bb8ee0e60091546d
prerequisite-patch-id: c87dd155e8506a2a277726c47d85bf3fa83727d5
prerequisite-patch-id: 579841e1dc179517506a7a7c42e0e651b3bc3649
prerequisite-patch-id: b5b079998ea451821edffd7c52cd3d89d06046a1
prerequisite-patch-id: b51b3918e554e279b2ace1f68ed6b4176f8ccc24
prerequisite-patch-id: 333e5188fb27d0ed010f5359e83e539172a67690
prerequisite-patch-id: bb107ee7b4811a9719508ea667cad2466933dec0
-- 
2.17.1

