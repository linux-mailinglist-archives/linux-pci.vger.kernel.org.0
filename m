Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AABE58B4A0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Aug 2022 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiHFIxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Aug 2022 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiHFIxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Aug 2022 04:53:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73211C19
        for <linux-pci@vger.kernel.org>; Sat,  6 Aug 2022 01:53:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E6C855C00A3;
        Sat,  6 Aug 2022 04:53:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 06 Aug 2022 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659776025; x=1659862425; bh=P7YY9gPDkFTaW1lt8W8ILrgKp
        aR7t9ZPJa7SfgfyxeA=; b=AjiOc4orsn/su0YKW2quCJuP/QLNk6MNI7o4EYOtr
        En5HIVSEjiMA8FOclkL+GiiaOGPQZ2WLxuk1ernJy+upNacmqD6bFNQyLAui7Cbc
        Ys+lAn++zTubueBb2j33vbUC/fe3uHKcOuRSGknt9pHjuRzxDbaYgLDprFDz/kg4
        XNET4/GRFv4wS/6xY6uY+OmDi8EEYZnRnVIDBPiN1+ovQrTGNTpDgxudmL+eIWG7
        q68DqTsKRyZWEdPZrznNeGhAkWIKHoUZ4XQ8XZfpGum/V4B4TWwVCKraZSJgOEwt
        YmQiyQFetYfj/0KDHzmTwvY371Xz7btcKlYizSh56f9cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1659776025; x=1659862425; bh=P7YY9gPDkFTaW1lt8W8ILrgKpaR7t9ZPJa7
        SfgfyxeA=; b=Jf38Smhz+Pupfq9lmSOkq/PBIHbsZyHT1Pd4f4K2meyTbf3vKUY
        5bIsldQk6WwZgShJmbPmjscHQymaedG8dWSpbF2qCRyJ8YEZcjolJiosyn8FyiYh
        SEUZjW9k6POHa4EsaO2x8wigt6FDfLWsZqlg4goKmfXYZYxLJMuMCrP62DaYJCt3
        7B8k2ZK+HuB9sufzwNbiNHwE8MkhKSlvms0pKatSwsYMY5MVMISrXAm0wNYYfIqh
        8LC3qcsHVI4GOEUyIAIDMpVE0S7MuZMy2cTM48EwS3ztSp3mzc5FlmKBbEmoLDmm
        VU2g4E31uu2NlnMRqyrJAG2RwC43hEPo1Vg==
X-ME-Sender: <xms:GCzuYgtGf5lTJRhVzaCV8i0OoYm_00kUP63slcN94U9hEyCU9AKy5Q>
    <xme:GCzuYtfQOBgbnWRle8NIkp6xN5eht3RVCfZvkYI2cg2Ol984gVSlSSwPsAi6l1t9s
    UsuqyV_LbZdl90ezw>
X-ME-Received: <xmr:GCzuYrxtZksssXGkYfBEPkCMBBzvUwU5EYGZDWDZ6j-HzPWHkxuZx6kZ73XbevFjNbBKFDtgpivjJWv61KV6qCiSsW-kOz0HsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdluddtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgv
    hicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpedvge
    duteejgfevveevuddtieegleeuffevhfefueehueffkefhffehgeehjefhtdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrh
    hushhsvghllhdrtggt
X-ME-Proxy: <xmx:GCzuYjMNZ5cYLd238Boc805Po-Np5L_XesxzBBbsYSuwNrWh1vJ_0A>
    <xmx:GCzuYg81BK5abrARVZQuZOP4mLIg5zJHXV-sj8hU7w4Rk6lJIaXefw>
    <xmx:GCzuYrWtMExSodTzPa32HxKzFsGYaw0VYZOmyJy4Q9lMfudLqCaYDw>
    <xmx:GSzuYkYw5qClCbRu4grwlSIBYSK7RXers6XrAfnFvV0UxoKqb15wBg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 04:53:42 -0400 (EDT)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, oohall@gmail.com, linux-pci@vger.kernel.org,
        benh@kernel.crashing.org, Russell Currey <ruscur@russell.cc>
Subject: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
Date:   Sat,  6 Aug 2022 18:53:01 +1000
Message-Id: <20220806085301.25142-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I haven't touched EEH in a long time I don't have much knowledge of the
subsystem at this point either, so it's misleading to have me as a
maintainer.

I remain grateful to Oliver for picking up my slack over the years.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9f77648c107..dfe6081fa0b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15639,7 +15639,6 @@ F:	drivers/pci/endpoint/
 F:	tools/pci/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
-M:	Russell Currey <ruscur@russell.cc>
 M:	Oliver O'Halloran <oohall@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.37.1

