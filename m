Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A95FBAA4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJKSme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJKSmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:23 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551E8285E;
        Tue, 11 Oct 2022 11:42:22 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g9so9497144qvo.12;
        Tue, 11 Oct 2022 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpuVq5iO2zl1W3X3kc36q+RPKt7tweIdU1vHs5t+3eg=;
        b=Gj5Nqr+LDbbfdcwkpISaFWC3XdZGLsNhMyp9yQ7I2jPcpQFr3j9ML16AFN5gJP5fqd
         BggKYoQCVRge/F/uQcDXmxPixlp26y/RiwefonggUi8wI5Tlwj9BOqncJN50vyboUfsG
         e1KfLU7BdpAPHtq7FjP0mMGBepXyaQm3kwLTR2uAqZn0I/OboA/lrzEZJh+vYUoBmKj4
         FoOnn8aDImOV0axl6bToLeNcYB88xFfEQfErGYk5v0Hq7aRZ0/L7CfN1yJtl2G6pIo1X
         yM5JxaruyYzUbEp8e/GyPnWxEHcvIzLSnOuA99XIpnKk3U32vJyhVpxYqW4undxRX6Ip
         8REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpuVq5iO2zl1W3X3kc36q+RPKt7tweIdU1vHs5t+3eg=;
        b=hRSGcfagrpAe3/N9VvOg80ElYyBqpIEDfI3sBRyTYiA7QJyIjqeLTbqlvToh+Jb4wc
         hTFO8O9BMEsa9RahUcqF1f/8SascYaai7guPP4leJUE75TkU8i1rgMA+TruqvAflf/kR
         evtlakjc56j35v0oMtxYcrZS9DgpXlkLqoTlP83cWqI2eERKTxcsMcT35kHIGw5DgqDo
         rnkaJtt4ZtUR5F75AtGuTiSr9dVBPPdM5DBimsncj7g9VufF26UTuqmn6VcoHgxiQp8X
         0HwOwEd6a120uM8xdY6jnbw9CZYWbaA+gwkZDapDk3EiYOIOMg7xATdX6jSz6BPK97IX
         JTvQ==
X-Gm-Message-State: ACrzQf3ZtH4hcMT0YJ48m1oFVd7gNUnJ1TlXw+rURFRl13B6PhXDfBe1
        9xNz7XOhWIcEsAFt3gWY7TPBtkXlUIo=
X-Google-Smtp-Source: AMsMyM4cEoY8/pxM0W8zIScP7/MI6kym/0Bnwf2jYpcX+HtPFjAmBxPBvLmmdBInV4CuI83G8h7/kg==
X-Received: by 2002:a05:6214:2aaa:b0:4b1:8f0b:97ac with SMTP id js10-20020a0562142aaa00b004b18f0b97acmr20181393qvb.84.1665513740738;
        Tue, 11 Oct 2022 11:42:20 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:20 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/5] PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits
Date:   Tue, 11 Oct 2022 14:42:10 -0400
Message-Id: <20221011184211.18128-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set RCB_MPS mode bit so that data for PCIe read requests up to the size of
the Maximum Payload Size (MPS) are returned in one completion, and data for
PCIe read requests greater than the MPS are split at the specified Read
Completion Boundary setting.

Set RCB_64B so that the Read Compeletion Boundary is 64B.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e3045f1eadbc..edf283e2b5dd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -53,6 +53,8 @@
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
 #define PCIE_MISC_MISC_CTRL				0x4008
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
@@ -900,11 +902,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	else
 		burst = 0x2; /* 512 bytes */
 
-	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
+	/*
+	 * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
+	 * RCB_MPS_MODE, RCB_64B_MODE
+	 */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
 	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-- 
2.17.1

