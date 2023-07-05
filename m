Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199F5748280
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGEKs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjGEKsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 06:48:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF46171A;
        Wed,  5 Jul 2023 03:48:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A7D215C02B0;
        Wed,  5 Jul 2023 06:48:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 05 Jul 2023 06:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688554132; x=1688640532; bh=bm
        1rZDhTtyYs6D2nwqafptF7MtTTmEoZYqei0YwqitQ=; b=ciOCYmh1a7/03nnbDK
        XYTb4WI+eqF88UGTIfzfrP1O3/bT+y4I4MlW5bbu9X7m4BA0kUyYWvgpr7rs7PpJ
        sghd6RF+Zq0EG7m00DOtd9KwTtjdTA3hei4Srw5R32CFWC5jJvQz/oMVxQ728IId
        7ow56qohaSAkVzue05PLENxQvRuIygwDWSmlEnUAw46R4OZHJTuWNno6wyrPf8bP
        cTGJPKzBnhHK3BGa1OZNVhNFHvdpYjnf0zc0SiAQpbUBOXNKtzwk+dihnHf96n03
        ggPdLDFZ4cSbZWzE3h3974jvMhu7nOzBLIAn2nQN6bORdicQN5pWK3hU2XD1F4yc
        wAEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688554132; x=1688640532; bh=bm1rZDhTtyYs6
        D2nwqafptF7MtTTmEoZYqei0YwqitQ=; b=XmEqP7yOa1x166q6mPPd1phvptpD2
        NOs3Psw4ipDLyNMydkAHtNABMU/WMABF9QTe0Plkl+7mCA2j/wtBssjPlZMkdPxN
        DiGwZVNk414ykSDQ9VDiNrg7Zab96tq96ZGCSqTnEwmidTCez4bqmrunfpnTVLcl
        sGIdjTBMxihr4FrJINv1wd9X3W0UNsSZkEQ8ypn5KWJMaqP+uRlVOLAEYLyr+8BU
        DWKE4Q1Sp9sTXnC+ELOAG7LWBhzFQkWpXGzruhkViFJBEEYR7fgY9mACzgMffdmj
        wbYaG0GNsDihZ7yw8FJNBW0lCB04H1EmmOeMBsoNXRoXvYUr2pvUGzFxw==
X-ME-Sender: <xms:lEqlZD4Ddys2jNn7V7mqgwRpt1ZNtm43fGgc4ygV-vaV9TvZrfDAOg>
    <xme:lEqlZI4xtHfag1qIu_QzEMN1vYFDA5csLj0Q4OB_7JpiKHYMA7-ry5uQMPjV6xf3c
    B6tzDcrpHDqEp-An0Y>
X-ME-Received: <xmr:lEqlZKcFh6ZUTXtpin9hFucjo5j0aqSNigaVqaYUgIywtW8gZ4GdgS8pTnLVWllR0ZFBFLEN6HZO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeegheejueehgeekje
    ffjeehhfejieelfeduudfhgeetieegueehvdeftefhgffhtdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:lEqlZELeaIMsF5xt7nxfutUsfFTyT0CYGUzq8LnjO67axMtWc7Etzw>
    <xmx:lEqlZHKycYjI6vLYlq6t_7xosKOSm5CKhjwMlkyNtK87a3pLcTKRsg>
    <xmx:lEqlZNwCuhy5g82QHGToJuyECoeBPlzS2A-wic2-HTAGB0TSassdCA>
    <xmx:lEqlZEDFUbSZFymqdjw6zOYC6k1_r_TikdEwILEDAP9OYRHnnYKIAA>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 06:48:45 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, alistair23@gmail.com, dlemoal@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of linux/pci-epc.h
Date:   Wed,  5 Jul 2023 20:48:24 +1000
Message-ID: <20230705104824.174396-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-epc.h doesn't define the members of the pci_epf_header struct, so
trying to access them results in errors like this:

    error: invalid use of undefined type 'struct pci_epf_header'
      167 |                 val = hdr->vendorid;

Instead let's include pci-epf.h which not only defines the
pci_epf_header but also includes pci-epc.h.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index f9682df1da61..5afc91d11eef 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -10,7 +10,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
-#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-- 
2.40.1

