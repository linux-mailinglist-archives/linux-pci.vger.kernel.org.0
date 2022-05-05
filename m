Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DEF51C818
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378637AbiEESdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385340AbiEESaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:22 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77C5D644;
        Thu,  5 May 2022 11:21:01 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 27807f26a92f6163; Thu, 5 May 2022 20:19:40 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D246266C2F5;
        Thu,  5 May 2022 20:19:39 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 03/11] PCI/PM: Set current_state to D3cold if the device is not accessible
Date:   Thu, 05 May 2022 20:04:07 +0200
Message-ID: <10104376.nUPlyArG6x@kreacher>
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
References: <4738492.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduiedurddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make pci_power_up() and pci_set_low_power_state() change current_state
to PCI_D3cold when the device is not accessible along the lines of
pci_update_current_state().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1207,6 +1207,7 @@ int pci_power_up(struct pci_dev *dev)
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
 			pci_power_name(dev->current_state));
+		dev->current_state = PCI_D3cold;
 		return -EIO;
 	}
 
@@ -1335,6 +1336,7 @@ static int pci_set_low_power_state(struc
 		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
+		dev->current_state = PCI_D3cold;
 		return -EIO;
 	}
 



