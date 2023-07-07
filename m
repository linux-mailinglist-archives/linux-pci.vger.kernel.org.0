Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C206474A8E8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 04:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGGCXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 22:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGCXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 22:23:32 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE82B6;
        Thu,  6 Jul 2023 19:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688696596; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IbokFj70kwmuMJoNgpTyJqzmlBhti36Iy5SeWnIY+Tjgf02NjLBA2gIdlkcDW1IN5xrhPEQprXTCA5jFMITXnTguH3I0N2elxp7NcUtaSxYl/mk4BOmZRYk83Rtr8pGOSrQmRFaTR4VSR4KqX8ejxUj5/swTtJlcMx4kU2oiwd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688696596; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=7pezz7Mu0y2xLl1qQuZUTIdWX+vqDQV14cg2rs2iL0I=; 
        b=bbVIER+Fmsb/0Ml0UnnVTmdTnZklVQOUYI9PX/BNx4Xh/qqjYVydKalP5SFjpRyk1PxqiaKpssKYaN59LGF49JvCTzR82HzRqvnWxbr4UwaV+HZGcOyTRdNecBmNCRDlP7rQMTHonOlAtW/KIqIxWNcnJcBh/AUY3rCXP2wZ10w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688696596;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=7pezz7Mu0y2xLl1qQuZUTIdWX+vqDQV14cg2rs2iL0I=;
        b=DI04ZPM28LJnBJ0JKurB2bCS7VrRIQbiDkPQO01jcfP/PcHTjMt0k2PEMY3QY5qZ
        1xU2nMqnVnhUh1Z9stOGKQzAGxYPdco23ALvyYElujFALSEpS1M6HmsK3WhzWl29JOL
        g7a9gPP/r6d7AbNaVtGwn69dMmQbOvsqe8GBwH78=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1688696594594371.96988380364905; Thu, 6 Jul 2023 19:23:14 -0700 (PDT)
Date:   Fri, 07 Jul 2023 10:23:14 +0800
From:   Li Chen <me@linux.beauty>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tom Joseph" <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-omap" <linux-omap@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1892e291fa4.1219137911620526.2248312811348305435@linux.beauty>
In-Reply-To: 
Subject: [PATCH 1/2] PCI: j721e: Allow async probe
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

I observed that on Ambarella SoC, which also utilizes
the Cadence controller, the boot time increases by 1
second when no endpoints (including switch) are connected
to PCIe. This increase is caused by cdns_pcie_host_wait_for_link.

Enabling async probe can eliminate this boot time increase.

I guess j721e also has this issue.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e70213c9060a..660c13bdb606 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -561,6 +561,7 @@ static struct platform_driver j721e_pcie_driver = {
 		.name	= "j721e-pcie",
 		.of_match_table = of_j721e_pcie_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(j721e_pcie_driver);
-- 
2.34.1


