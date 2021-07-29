Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6773DA6C7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhG2Otr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 10:49:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55988 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2Otq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 10:49:46 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 10ccb49542306252; Thu, 29 Jul 2021 16:49:41 +0200
Received: from kreacher.localnet (89-64-80-223.dynamic.chello.pl [89.64.80.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 868CF669F44;
        Thu, 29 Jul 2021 16:49:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: [PATCH v1 2/2] PCI: PM: Enable PME if it can be signaled from D3cold
Date:   Thu, 29 Jul 2021 16:49:10 +0200
Message-ID: <1791325.tdWV9SEqCh@kreacher>
In-Reply-To: <4668274.31r3eYUQgx@kreacher>
References: <4668274.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.223
X-CLIENT-HOSTNAME: 89-64-80-223.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrheefgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedtrddvvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvvdefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehuthhkrghrshhhrdhhrdhprghtvghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhosggrrdhkohestggrnhhonhhitggrlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

PME signaling is only enabled by __pci_enable_wake() if the target
device can signal PME from the given target power state (to avoid
pointless reconfiguration of the device), but if the hierarchy above
the device goes into D3cold, the device itself will end up in D3cold
too, so if it can signal PME from D3cold, it should be enabled to
do so in __pci_enable_wake().

[Note that if the device does not end up in D3cold and it cannot
 signal PME from the original target power state, it will not signal
 PME, so in that case the behavior does not change.]

Link: https://lore.kernel.org/linux-pm/3149540.aeNJFYEL58@kreacher/
Fixes: 5bcc2fb4e815 ("PCI PM: Simplify PCI wake-up code")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2491,7 +2491,14 @@ static int __pci_enable_wake(struct pci_
 	if (enable) {
 		int error;
 
-		if (pci_pme_capable(dev, state))
+		/*
+		 * Enable PME signaling if the device can signal PME from
+		 * D3cold regardless of whether or not it can signal PME from
+		 * the current target state, because that will allow it to
+		 * signal PME when the hierarchy above it goes into D3cold and
+		 * the device itself ends up in D3cold as a result of that.
+		 */
+		if (pci_pme_capable(dev, state) || pci_pme_capable(dev, PCI_D3cold))
 			pci_pme_active(dev, true);
 		else
 			ret = 1;



