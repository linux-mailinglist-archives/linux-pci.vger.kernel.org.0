Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFE74A8F5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 04:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGCZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 22:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGGCZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 22:25:20 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8858B6;
        Thu,  6 Jul 2023 19:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688696711; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hfya/VD4HCGSX9BIWKXyqEpBVt029ogQGcFDDA7NLfz3K/PMe8U7D6qTqIvUjF862OHu2jXUbuZyItXNiW1S8Vz+Cp7+Ww2r0w/y4XBB1gN6wZZh5SCdCulcjSyahSU+faTiRC0jCismLLI832TDe7Dff0lsMD7r/BzL9L8Q1Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688696711; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ik2eT2U2tcZUtukNJ6ARDpEzq7gr9zv2EARephZUF7A=; 
        b=WcVRMSUVebWK3HY5pO24PDR8WJ/zT6Mnw2nOkPnZlxeB80inJYDdHVdg/atLMtj353j1hs3rvGjdZ5tYwpK0yg4dlU44U9QBzfd/YFZlaeCCDYZpvSEhDKP4e08KQ2mrfyHg08XOdgVlLO5H4+nVT2KZYIxsFPEtzbCv3Nq9d+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688696711;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=ik2eT2U2tcZUtukNJ6ARDpEzq7gr9zv2EARephZUF7A=;
        b=VPcqvnAogxc1aNwjI32fgfI12Umh4Cui7+azKIRc3GZJX9kInDbptI9lZ5xY0TfD
        um/x2CV2zg8apK+QYZ7i/Ttk9guKKOoyZiMjOKbexg+H9tpeNefZjBUXTGmZ0AIVObI
        eQ+NhcjyGmprHYWBtdjwwOX+76KwuBF1UhkMWjaQ=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1688696709492195.79904115078568; Thu, 6 Jul 2023 19:25:09 -0700 (PDT)
Date:   Fri, 07 Jul 2023 10:25:09 +0800
From:   Li Chen <me@linux.beauty>
To:     "Tom Joseph" <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1892e2ae15f.f7e5dc061620757.4339091752690983066@linux.beauty>
In-Reply-To: 
Subject: PCI: cadence: Allow async probe
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

I guess other platforms also has this issue.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index e091fef9c919..5177f18e1dfc 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -174,6 +174,7 @@ static struct platform_driver cdns_plat_pcie_driver = {
 		.name = "cdns-pcie",
 		.of_match_table = cdns_plat_pcie_of_match,
 		.pm	= &cdns_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cdns_plat_pcie_probe,
 	.shutdown = cdns_plat_pcie_shutdown,
-- 
2.34.1


