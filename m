Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB006D9733
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjDFMqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDFMqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 08:46:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B80526C;
        Thu,  6 Apr 2023 05:46:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so67606wrb.0;
        Thu, 06 Apr 2023 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680785191; x=1683377191;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCN29vskBafnakAsgOwL0xAYz0jQ2OQylSDUBlv5Yhk=;
        b=o2tDiqHMt+Y7SL8lyBWRDhmkqxpuwuHx0FS+cA8EafmtFkPG4SMp+CCmZ54sRtvJNn
         sEUspDoDaTNDVGdGWhF5+T0ALtYdrkyOHjiYsbUwRZowcSxa9hUMG0y53G4ESiNBY828
         1c04e0YrlxME/stwFrzB1z/jmoSsSsWx7VMdBuBslmXzwOrun4IfAkQ/PhIj0DJVitWT
         VPJXSFtS0adVlTnHaQ/48TET5Hwrvxqz+fmeVPam0CUpehoLhVnzT1C/yJTcu/4fYk/H
         5HbjjVOhk0dzrpkTdIbjgsTpsjGIMgPFCbleEiH9txyeowXd97fXCL4jNNaaKgg8EUv6
         S8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785191; x=1683377191;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCN29vskBafnakAsgOwL0xAYz0jQ2OQylSDUBlv5Yhk=;
        b=d6d8mfAcma5tRfUVD0xLS/4Rid5erLxDTDJKYTOUXZhhURwhEEAOX4MdUSteLS2Aye
         IVw3P9RKh4ukGrpwcnQ7C43uTrL77xY8d2mD/0Rc42k/iFNv6nmuBWaVtzVkUzZJHwKV
         3jJk2XRrHq7Q7j72+0pwoGWX51Zo7OwsTGoITfBb811IqpB5aCNRIeOl6vMQjzU6IQqc
         5xlpRRARdxL72QJf1qiX0vocAE/lK/vHaFgrfUJZHQCY/wE/mJd+FrVWUKSwPVjPsWou
         a6pumKfCwpB0Sg/0FU+mVCEe2IvW/T/jP1yGYyzkjmBRoRjNzABfqVVVhqLOw0DwJvbL
         xm7Q==
X-Gm-Message-State: AAQBX9ecAlcLz5sgh163dKmf6V/MKdaVoUeZjVcAQJeVgchKb/J7arDy
        DUDiKNW9l9fXtHR6T9B9EgBWLUtbPbI=
X-Google-Smtp-Source: AKy350b11p48GM3ueUjsojMlShKtYoudnB+YW33Ln2hRAV3WSga1fy1K9ep1qrteY36jFqsL5QIWjw==
X-Received: by 2002:adf:df8b:0:b0:2c9:d91b:a6ff with SMTP id z11-20020adfdf8b000000b002c9d91ba6ffmr6472571wrl.21.1680785191242;
        Thu, 06 Apr 2023 05:46:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002c5534db60bsm1686714wro.71.2023.04.06.05.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:46:30 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v1 0/3] PCI: brcmstb: Clkreq# accomodations of downstream device
Date:   Thu,  6 Apr 2023 08:46:21 -0400
Message-Id: <20230406124625.41325-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current driver assumes the downstream devices can provide clkreq# for
ASPM.  These commits accomodate devices w/ or w/o clkreq# and also handle
L1SS-capable devices.

The Raspian Linux folks have already been using a PCIe RC property
"brcm,enable-l1ss".  These commits use the same property, in a
backward-compatible manner, and the implementaion adds more detail and also
automatically identifies devices w/o a clkreq# signal, i.e. most devices
plugged into an RPi CM4 IO board.

Jim Quinlan (3):
  dt-bindings: PCI: brcmstb: Add two optional props
  PCI: brcmstb: Clkreq# accomodations of downstream device
  PCI: brcmstb: Allow setting the completion timeout

 .../bindings/pci/brcm,stb-pcie.yaml           | 12 +++
 drivers/pci/controller/pcie-brcmstb.c         | 93 +++++++++++++++++--
 2 files changed, 95 insertions(+), 10 deletions(-)


base-commit: 99ddf2254febae9eab7fb0bcc02c5322243f5c49
-- 
2.17.1

