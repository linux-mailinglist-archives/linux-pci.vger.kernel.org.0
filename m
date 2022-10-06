Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE45F6BFA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJFQud (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJFQuc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 12:50:32 -0400
X-Greylist: delayed 16799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 09:50:30 PDT
Received: from 20.mo550.mail-out.ovh.net (20.mo550.mail-out.ovh.net [188.165.45.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8FBC479
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 09:50:30 -0700 (PDT)
Received: from player714.ha.ovh.net (unknown [10.109.156.164])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 9199E211A2
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 12:00:38 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id 3C67B2F572EBE;
        Thu,  6 Oct 2022 12:00:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004facaee04-fba3-4d9d-bada-ccf9502b03c9,
                    1B208DD073E4D188871243D3B3D058A636382E4D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Kitt <steve@sk2.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/ASPM: Call pcie_aspm_sanity_check() as late as possible
Date:   Thu,  6 Oct 2022 13:59:50 +0200
Message-Id: <20221006115950.821736-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14079941288775550566
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepudevveffvdfgledvgfekveefvedvheeuuedvgeejudfggeeuhffgvddtieevvdeinecuffhomhgrihhnpehsthgrtghkvgigtghhrghnghgvrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pcie_aspm_init_link_state(), a number of checks are made to
determine whether the function should proceed, before the result of
the call to pcie_aspm_sanity_check() is actually used. The latter
function doesn't change any state, it only reports a result, so
calling it later doesn't make any difference to the state of the
devices or the information we have about them. But having the call
early reportedly can cause null-pointer dereferences; see
https://unix.stackexchange.com/q/322337 for one example with
pcie_aspm=off (this was reported in 2016, but the relevant code hasn't
changed since then).

This moves the call to pcie_aspm_sanity_check() just before the result
is actually used, giving all the other checks a chance to run first.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/pci/pcie/aspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a8aec190986c..38df439568b7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -889,7 +889,7 @@ static void pcie_aspm_update_sysfs_visibility(struct pci_dev *pdev)
 void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
-	int blacklist = !!pcie_aspm_sanity_check(pdev);
+	int blacklist;
 
 	if (!aspm_support_enabled)
 		return;
@@ -923,6 +923,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
+	blacklist = !!pcie_aspm_sanity_check(pdev);
 	pcie_aspm_cap_init(link, blacklist);
 
 	/* Setup initial Clock PM state */

base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.30.2

