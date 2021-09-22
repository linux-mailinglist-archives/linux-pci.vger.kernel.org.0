Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33936415207
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhIVU47 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237892AbhIVU4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:56:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68364611C9;
        Wed, 22 Sep 2021 20:55:19 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gv-00CP8z-P4; Wed, 22 Sep 2021 21:55:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/10] of/irq: Allow matching of an interrupt-map local to an interrupt controller
Date:   Wed, 22 Sep 2021 21:54:50 +0100
Message-Id: <20210922205458.358517-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922205458.358517-1-maz@kernel.org>
References: <20210922205458.358517-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_irq_parse_raw() has a baked assumption that if a node has an
interrupt-controller property, it cannot possibly also have an
interrupt-map property (the latter being ignored).

This seems to be an odd behaviour, and there is no reason why
we should avoid supporting this use case. This is specially
useful when a PCI root port acts as an interrupt controller for
PCI endpoints, such as this:

pcie0: pcie@690000000 {
	[...]
	port00: pci@0,0 {
		device_type = "pci";
		[...]
		#address-cells = <3>;

		interrupt-controller;
		#interrupt-cells = <1>;

		interrupt-map-mask = <0 0 0 7>;
		interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
				<0 0 0 2 &port00 0 0 0 1>,
				<0 0 0 3 &port00 0 0 0 2>,
				<0 0 0 4 &port00 0 0 0 3>;
	};
};

Handle it by detecting that we have an interrupt-map early in the
parsing, and special case the situation where the phandle in the
interrupt map refers to the current node (which is the interesting
case here).

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 352e14b007e7..32be5a03951f 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -156,10 +156,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
-		/* Now check if cursor is an interrupt-controller and if it is
-		 * then we are done
+		/*
+		 * Now check if cursor is an interrupt-controller and
+		 * if it is then we are done, unless there is an
+		 * interrupt-map which takes precedence.
 		 */
-		if (of_property_read_bool(ipar, "interrupt-controller")) {
+		imap = of_get_property(ipar, "interrupt-map", &imaplen);
+		if (imap == NULL &&
+		    of_property_read_bool(ipar, "interrupt-controller")) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
@@ -173,8 +177,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 			goto fail;
 		}
 
-		/* Now look for an interrupt-map */
-		imap = of_get_property(ipar, "interrupt-map", &imaplen);
 		/* No interrupt map, check for an interrupt parent */
 		if (imap == NULL) {
 			pr_debug(" -> no map, getting parent\n");
@@ -255,6 +257,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		out_irq->args_count = intsize = newintsize;
 		addrsize = newaddrsize;
 
+		if (ipar == newpar) {
+			pr_debug("%pOF interrupt-map entry to self\n", ipar);
+			return 0;
+		}
+
 	skiplevel:
 		/* Iterate again with new parent */
 		out_irq->np = newpar;
-- 
2.30.2

