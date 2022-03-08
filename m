Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7089D4D0E01
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 03:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiCHCad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 21:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiCHCad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 21:30:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573335875;
        Mon,  7 Mar 2022 18:29:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso1053150pjq.1;
        Mon, 07 Mar 2022 18:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QSuESpufqs7Kco7tr3h1WvshGx1ZvFTZ7zDJj6YKv9s=;
        b=ERMBqVtP4RG2wSFoN7dNS48qoUy+oDTlmwysg/RWa8LW1TPI72NeqA2w00H2+KJ9KQ
         tx4+/dNmvBvld2bfHuWrWl03qjxYuQF97DasciOpONK3HEeEzbAZRjwtIXvkIipmCtvd
         Ccgmc4SH6zCccoMSZP8ML1S5mrdq2iQnZbv0tTI/HJU7aweufKdFT7z7SQgFRQytFfBH
         XTUoX7OGszjB9ZkcXkGeuwbejWtm423OQOr7Wrk1lWn92gL8YGUaIgmDOOhhlbg/i217
         /1tK0F/a3MNau4T2tgpqRC9gsEbxMm5zducAcKqBAWLNPNUyTZBGA2iVq9oFYijmUbjh
         xB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QSuESpufqs7Kco7tr3h1WvshGx1ZvFTZ7zDJj6YKv9s=;
        b=Fsz/+OL7nLC4Ybb9CiUXZUzshR0UGzEHv9m/+FSb6sKhSNU9C3tTvqt9ZSyc72E5Va
         UDJsBDHRi0EHOAW6/SLnopDicTsF9hTadFIzZ7rV9eqeOX2LEdK2dmg0/oE6hWBXRb4J
         GjyKDFLWitqG/wouIzLm73qApVV/0Ma/Nec6p9IJYBXIQYH0q0q1ts4dSasfLumxBcZr
         4bSN13+1b4GT/naI4eq+xLwJsOowcAxC12yQALTKaVtr6rRE0dSfj1+F+S4522fP8RH0
         weBMQO+qAIt1U/WEduStsRKRJ6kParQ2W7nLCLsfsJmYH96SXKhroaaWNxNAAD3ZcGz4
         sUQA==
X-Gm-Message-State: AOAM530+dAJnrtjcUOwioGVBxg8uGRxP8fWiRzr0X+Rj86t307DAFFVY
        E8NCwCm3KNmjRgnSPYrHH8w=
X-Google-Smtp-Source: ABdhPJw/SgD2uHFXuTNAZ2rIvuiv0kmHE+m9F+eu6yLyoDj0/PMa0R3tzAU7NOg1lx+/vYzVA0tSQg==
X-Received: by 2002:a17:90a:d206:b0:1bb:e73f:9592 with SMTP id o6-20020a17090ad20600b001bbe73f9592mr2172614pju.17.1646706577507;
        Mon, 07 Mar 2022 18:29:37 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pj13-20020a17090b4f4d00b001bf2ff56430sm657900pjb.30.2022.03.07.18.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:29:37 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] PCI: imx6: Add missing of_node_put() in imx6_pcie_probe
Date:   Tue,  8 Mar 2022 02:29:29 +0000
Message-Id: <20220308022929.30002-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6974bd5aa116..bcc338ab6c11 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1050,6 +1050,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		struct resource res;
 
 		ret = of_address_to_resource(np, 0, &res);
+		of_node_put(np);
 		if (ret) {
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return ret;
-- 
2.17.1

