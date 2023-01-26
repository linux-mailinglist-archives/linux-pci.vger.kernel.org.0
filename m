Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1B67CCBC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAZNws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAZNwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:52:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC12201F;
        Thu, 26 Jan 2023 05:52:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g11so1878482eda.12;
        Thu, 26 Jan 2023 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE/gMDijDW0z+zONtHRFIciOBfI81+SEAmw/rLX0XT4=;
        b=Ei+bJmKoSFHKEbtMrrEjKYOvPcjlMvW21xOQgvOGWST6I00v82nJyz1r2os2zJIiJG
         /ZkSarHLuN8n8OSSw6tdKIqKctFZpMaZSXKlCAnmeMAEM+5lhHI1i6PH0K9YpPqrCi4G
         Jjku0k66ap2HhAwS2kAmG5e6LG4nyFmexKzmzF82+6tMgZrrwqPCjj/suObAelV3Tz74
         WJsKY+TVR92DLJuetvK+ckB9bXjzlItj6OH2QigAxcO06zqnMz7cvOOp8cUtTIinn+bZ
         4Yg/xoJeYBVDQ4mUbyaO0wqtZ3/n/XrUpP1GvsrCIlkELw39zq+QJN3Q0p1Lqdtr+Ops
         yABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wE/gMDijDW0z+zONtHRFIciOBfI81+SEAmw/rLX0XT4=;
        b=tfdXnSQY70PREaZzvG7VQw7tTxyMyXDtQ4O8kz5QzGDQKb10b+xbDEEhAHb3cnut6u
         UAvjsfOG0TWVIYbhnvm53SxMcjC7G1k3rgYqq+Xw3XwFpJJX1DWTsRx7qLm/Uvv2oFHB
         r+ymeu/Cv3MpqNaWFTPY12/Bws+eHcaaCk+eYK5FJFwQbNbPnKd3tgOV7OnrmBy7io7d
         twYwCkOhHXYp+qzjABrbrSHM587hYBxi2gFsx65M7BZI3JLhEokJuQMda42gQ+G0k9kM
         TJkr46G7SU82uju7k7VLR60TXUYyEtiUa19/ApcAqnJRF1dp9//jX3WS8w6u7eMb4kBP
         oyRg==
X-Gm-Message-State: AFqh2krBV5ENriR4ahNIyvHTzIbyRXiVcX29JiE5cwKVIE0Twu5NlaNL
        vNKF0KNsPDe7BdXjRT7Vnu0=
X-Google-Smtp-Source: AMrXdXs33PzmPBoFqWPLd4uj8sVAAycwH3KoReHsSnb0Nw5EI1IOW6rQmTBWUcYsRyKTRddeTN9XKw==
X-Received: by 2002:a05:6402:25cb:b0:49e:6bf1:5399 with SMTP id x11-20020a05640225cb00b0049e6bf15399mr31854592edb.8.1674741153155;
        Thu, 26 Jan 2023 05:52:33 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id t15-20020a508d4f000000b004a0e2fe619esm591611edt.39.2023.01.26.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:52:32 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/8] PCI: rockchip: Fixed endpoint controller Configuration Request Retry Status
Date:   Thu, 26 Jan 2023 14:50:43 +0100
Message-Id: <20230126135049.708524-4-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The endpoint was left in the config mode after probe, this would mean the
core would send configuration requestion retry status (CRS) messages back
to the root complex. The conf_en bit should be asserted after probe. This
is documented in section 17.5.8.1.2 of the RK3399 TRM.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 9b835377b..4c84e403e 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -623,6 +623,8 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE, PCIE_CLIENT_CONFIG);
+
 	return 0;
 err_epc_mem_exit:
 	pci_epc_mem_exit(epc);
-- 
2.25.1

