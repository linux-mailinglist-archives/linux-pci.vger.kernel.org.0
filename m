Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020865A31C
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 08:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLaHkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Dec 2022 02:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiLaHks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2022 02:40:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29091099;
        Fri, 30 Dec 2022 23:40:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bn26so2453281wrb.0;
        Fri, 30 Dec 2022 23:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRto61P8hgbUD9Adp/jPx7dLuXOhVXQgxTy/8DMBdG8=;
        b=hWggnJs4RDX4JorexSlF3c14+vA2UoPxtxFB0RJIPz9SA1NiL9MrdaAngRiE3LDjLZ
         qkguJw6zfWXDU8GLghPpp7mr0ZQtnQIlRffkaU2oajBYOWE1Ttfy3eKtXz/sZUZySXCw
         f3/rjUOjGHfaD2R6O8QnKYf/Gvh7B8wfpwfSTzvmDP8Ya5SMfNwNwdO35zQDU59Hleiw
         Finqu5bU4Yokky+rZLeXWBFxforL8pZ9hK+7UBqcgD+3dCr9AUShp81FKx6G25q0EW0I
         TSiVM/NsliJxpxrhCZR7zTMx00X+ABuKyUnpYBHQh9k4TlZ0OJPn/sNXLL5Ipz7Pias/
         yiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRto61P8hgbUD9Adp/jPx7dLuXOhVXQgxTy/8DMBdG8=;
        b=PDImDCAhGEr6lXR2Ggqoo8zpIgnvr3Je0E3o2dValvNQO/GflrzX/eNqCqYY43bkvB
         dsKo+fatCJxXfCZXFWmcXkq+EghDN+NJUP31+A9vFGTj8hjhJi4TyBMzEn+g25T7mZUP
         slnhfhYq0SKgaX7BAVLEYAOo2PiOvMhTGv+6fOcvengyn16h9O4JtLxaQ8xXEpcoLUsj
         AVtD0VhBJhu4R+Nh/5e8YK859/UDHyYRugcjysNaaXchtRlLptgWqklt+F4Ww6MUoPwN
         AyikApp9/yqPytZwb417l6hKmYKISkktNf7jgMx2b3ptWaOASWqL2RX5ksWuD/orjlKt
         /F8Q==
X-Gm-Message-State: AFqh2kptuuC7DkvFzUctnhb4zoM1AqQsn9LzQdgLVjI87vM2ep1Yzpxf
        Bg7ZzVKEdhazNrzKQhvDjgMj8mjToq4=
X-Google-Smtp-Source: AMrXdXtNyEy/kq+4DO3eJhYC03SqtSgnCMH+g/BnSE57S1IHRmKQXC5nIJo41AAnmMjNJb4XFdK68A==
X-Received: by 2002:a05:6000:1c05:b0:261:d8be:3046 with SMTP id ba5-20020a0560001c0500b00261d8be3046mr22534292wrb.0.1672472444106;
        Fri, 30 Dec 2022 23:40:44 -0800 (PST)
Received: from localhost.localdomain (188.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.188])
        by smtp.gmail.com with ESMTPSA id x2-20020adfec02000000b0025e86026866sm27194005wrn.0.2022.12.30.23.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 23:40:43 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
Date:   Sat, 31 Dec 2022 08:40:41 +0100
Message-Id: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
to sleep a bit after call to mt7621_pcie_init_port() driver function to get
into reliable boots for both warm and hard resets. The needed time for these
devices to always detect the ports seems to be from 75 to 100 milliseconds.
There is no datasheet or something similar to really understand why this
extra time is needed in these devices but not in most of the boards which
use mt7621 SoC. This issue has been reported by openWRT community and the
complete discussion is in [0]. The selected time of 100 milliseconds has
been also tested in these devices ending up in an always working platform.
Hence, properly add the extra 100 milliseconds msleep() function call to make
also these devices work.

[0]: https://github.com/openwrt/openwrt/pull/11220

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Hi Bjorn / Lorenzo,

As per Lorenzo comments in v1[0] here it is the patch with changes in commit
message and introducing a new definition for this needed extra delay time.
I wish you the best new year for you both.

Changes in v2:
- Add a new define 'INIT_PORTS_DELAY_MS' avoiding to reuse 'PERST_DELAY_MS'.
- Rewrite commit message and add a link to openWRT discussion.

Previous patch lore link:
[0]: https://lore.kernel.org/lkml/20221209071703.2891714-1-sergio.paracuellos@gmail.com/T/

Thanks,
    Sergio Paracuellos

 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index ee7aad09d627..63a5f4463a9f 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -60,6 +60,7 @@
 #define PCIE_PORT_LINKUP		BIT(0)
 #define PCIE_PORT_CNT			3
 
+#define INIT_PORTS_DELAY_MS		100
 #define PERST_DELAY_MS			100
 
 /**
@@ -369,6 +370,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 		}
 	}
 
+	msleep(INIT_PORTS_DELAY_MS);
 	mt7621_pcie_reset_ep_deassert(pcie);
 
 	tmp = NULL;
-- 
2.25.1

