Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5976FBABF
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjEHWCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEHWBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4A8A77;
        Mon,  8 May 2023 15:01:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef4a74b42dso25848681cf.1;
        Mon, 08 May 2023 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583293; x=1686175293;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V6w3gLLHI8mDJrx5Z1zD+8bpaLRFMCTX7FtIrjGAjHo=;
        b=L0hpfMKvrb1h1GzBLT2PTZbfWFJk8j4kPCjYDK6vnmbDYFd8C425iPEIZgUmrbkTLs
         ENT5rGaJIy7QNQBe5GaPlCGX16x+PYvlRIuIDaOpTwqhH0vBZef5/XXsl4JYZasiFl/3
         XNV7zk/5bRpxh9bVEgRalrX6c6iEFNMgU1d0NBfamFk77chRTmrEK+NEqp0mtwh8TD3g
         dsh+CaQ3MOtKTZMDPFFcG7Pnb6UJthf4qYp7+FH/b6GYpZIhF76BcPBLyoPK0PRNLlFc
         /EMyiSgBH3b0K0wt5920gi/s7NxwNNYinaSP/JaUEvp8yokdinqlzAlc/XYpmM7/6G0t
         3u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583293; x=1686175293;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6w3gLLHI8mDJrx5Z1zD+8bpaLRFMCTX7FtIrjGAjHo=;
        b=dRO4fWOxiTEhnR0EBtij7lriOgfk/zoFziYvR4kzncZtlnvb+oZMbY+j/8mR4O2EZZ
         rAzBcmUImccYDyn2Z3viy6DJW28GN1K8TpSv0xX06j0pxcamtXlkvmJ9EplqXE6fmEgV
         tgoJADpFb48uYLbU+qus96Mi+Oykdcj/VDPL8HxZrYThH5dg8vvuoLueeG+dq3+9BEYH
         9wkXoqGAWSWb/Rl13H2wfGJRa0RAyJtQLVEaeYsctrTB7SCfclpGZZso/VzvBKImwg4W
         kWGFjr/zz9kk6imSNftaHeQgDGrOX2eo5SUz026VUiXz1zyketJael+fwYJEDtYtAuBx
         fnVw==
X-Gm-Message-State: AC+VfDzno9c11VhR8ahhhqTYOPcotWKVFA9lx90NDp0CEB1lp4oLtuWM
        pTdv2tW7Tv4vw8xDs+TUfOB/jGXWz9w=
X-Google-Smtp-Source: ACHHUZ5xlSQIVDOADLv4ZZxya8Zbly69qxm7S3u8hNbRakpLeJ1LeuWwl7jLOLVaIFww+bs+q8fU6g==
X-Received: by 2002:a05:622a:390:b0:3f1:f451:c13 with SMTP id j16-20020a05622a039000b003f1f4510c13mr17767281qtx.53.1683583293665;
        Mon, 08 May 2023 15:01:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:33 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves PERST# asserted
Date:   Mon,  8 May 2023 18:01:24 -0400
Message-Id: <20230508220126.16241-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
References: <20230508220126.16241-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current PCIe driver assumes PERST# is asserted when probe() is invoked.
The reasons are as follows:

(1) One Broadcom SOC (7278) causes a panic if the PERST# register is
    written during this time window.

(2) If PERST# is deasserted at Linux probe() time, experience and QA
    suspend/resume tests have shown that some endpoint devices fail if the
    PERST# is pulsed (deasserted => asserted => deasserted) quickly in this
    fashion, even though the timing is in accordance with their datasheets.

(3) Keeping things in reset tends to save power, if for some reason the
    PCIe driver is not yet present.

Broadcom STB and CM SOCs bootloaders always have PERST# asserted at
probe().  This is not necessarily the case for the 2711/RPi bootloader,
so, for 2711/RPi SOCs, do what Raspian OS does and assert PERST#.

[1] https://lore.kernel.org/linux-pci/20230411165919.23955-1-jim2101024@gmail.com/T/#m39ebab8bc2827b2304aeeff470a6c6a58f46f987

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index fe0415a98c63..7b698a9a851e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -884,6 +884,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
+
+	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
+	if (pcie->type == BCM2711)
+		pcie->perst_set(pcie, 1);
+
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-- 
2.17.1

