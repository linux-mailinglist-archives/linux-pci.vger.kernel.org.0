Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46F62741C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 02:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKNBVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 20:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNBVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 20:21:05 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78BBCB8;
        Sun, 13 Nov 2022 17:20:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 200305C0089;
        Sun, 13 Nov 2022 20:20:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 20:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668388855; x=1668475255; bh=k6S4rjX3gX
        pRdqMPullBe3RUcP3ARpy8cb2vFcrtPQU=; b=DvPvrVoct6bkRnpDJNC00JWKbN
        OpNk46Dxx6mRpQXlGOBq4o4ZL4DwP7OdJuTI5ih32RPBRHHf6njGmlfOEfSLART9
        /oKe9ZLCrznpmwv4Pe1WI4yrhdz4VW+zr63Qf3Vb0e1e+OXx9PJiwUF9n/tFXlD7
        dR+6W/3xbLdtbYJsx8bppUwn+h3iBPWbuldrXQPmmYTobgDqI9o4SK0FkmZyxaZP
        bDdb5wu/8DuW7/Hz8SbdWh43/q6540mXCoW/5U07i8GlEcOtsGvOqUqozDg1Pjl9
        f+faQrz+CBQx6cypyJnsvfiDP8+p9dFWvZerhv1rs3KTTqOUh5E9fmDAEVqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668388855; x=1668475255; bh=k6S4rjX3gXpRdqMPullBe3RUcP3ARpy8cb2
        vFcrtPQU=; b=PriKt6IeLSXC3N+uTlB48+Z0MQxYORWpcu8C2kIPLfCeL0s0w1r
        vKomMaqy2Opo2Qg2nKZL+giw2ZImgFiuCDaOlcCluVgwBtGaLSnNMEm0Z+yowntl
        WsI/aZXtBrOwOzuGRbaG5tkV9lOTn84/2Cv+c9G8aqDPd/wYonsRpg0A7MvCtEIt
        VRsJ4Jqn54eIiKlJw7P8Wj/qXapWJahoeKIrZ56opuztH8qUyG45t1GvF417Vd6c
        2rtxOvxXstRJpPxsxtTblqQXOqRHpSu94OPB/oA5AP04kr9U3TXoqp1MT37ARTe5
        mGBWLm3VYqkHwtq+OZqVZgL5WRFE9oZ5BJg==
X-ME-Sender: <xms:9pdxY-Qkw5UMasTTDLabo94twEQDM2JCFhMGIxZSAgmdqCs2M2HScg>
    <xme:9pdxYzypYRlIsxaCTn4B13QiH0-IR1Wn-qFskuZN6f34CN9UrzFK97Bsnue-ZY9-8
    H4AQG12nsu7Ph4v0Q>
X-ME-Received: <xmr:9pdxY71OUY8ozMP4FL3LLS9-fBZ4VD-pkoq-tYxNX4BAGl0dcnzBvKcf340K-EJtaJrhRwg2MH1vaQpFEMD26Zw32uTeMd9Y0Nr5cZ4zIXX5TKT_RZUTdG_nt69lyw_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcuvfhh
    ohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomh
    drrghuqeenucggtffrrghtthgvrhhnpeefvdekveeggfekgeehvdelteeiffehgfeihfel
    gfdvkeefvdetkeeuueevleehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithesjhho
    hhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:9pdxY6DAe9Om9H8798wi8HGFEkiLaTvDMZM77xngvHvbEZFap6i1hQ>
    <xmx:9pdxY3iIhMqNXbancl1jk_XO5KpbF2VBnqnU2gEx8wFxP3WbuN2vyw>
    <xmx:9pdxY2qHkKwtGsy4bt4MnBlXAoVpKMYnBtaCYtm2lvqh4h7clgAFtg>
    <xmx:95dxY3j6t1YjNewNqg8RrI9Y-56dyEIznCwMqZwEj_jSBp8hZwrJRQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:20:51 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH v2 1/1] PCI: mt7621: add sentinel to quirks table
Date:   Mon, 14 Nov 2022 11:20:36 +1000
Message-Id: <20221114012036.2870067-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With mt7621 soc_dev_attr fixed to register the soc as a device,
kernel will experience an oops in soc_device_match_attr

This quirk test was introduced in the staging driver in
commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
using 'soc_device_attribute'"), and the staging driver was moved in
commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
controller driver") for the 5.16 kernel

Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision using 'soc_device_attribute'")
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
v1 Link: https://lore.kernel.org/lkml/20221104205242.3440388-3-git@johnthomson.fastmail.com.au/#t
v2: no newline in middle of Fixes tag
---
 drivers/pci/controller/pcie-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4bd1abf26008..ee7aad09d627 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct pci_host_bridge *host)
 }
 
 static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
-	{ .soc_id = "mt7621", .revision = "E2" }
+	{ .soc_id = "mt7621", .revision = "E2" },
+	{ /* sentinel */ }
 };
 
 static int mt7621_pcie_probe(struct platform_device *pdev)
-- 
2.37.2

