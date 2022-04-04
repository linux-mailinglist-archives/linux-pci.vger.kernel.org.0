Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BC4F18AE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378646AbiDDPoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378644AbiDDPog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 11:44:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620C393F5;
        Mon,  4 Apr 2022 08:42:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c5e46475ff8816b5; Mon, 4 Apr 2022 17:42:38 +0200
Received: from kreacher.localnet (unknown [213.134.181.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E33F66BCD3;
        Mon,  4 Apr 2022 17:42:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/2] PCI: PM: Avoid leaving devices in D0-uninitialized in pci_power_up()
Date:   Mon, 04 Apr 2022 17:41:13 +0200
Message-ID: <3623886.MHq7AAxBmi@kreacher>
In-Reply-To: <4198163.ejJDZkT8p0@kreacher>
References: <4198163.ejJDZkT8p0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.62
X-CLIENT-HOSTNAME: 213.134.181.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhk
 rgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In theory, pci_power_up() may leave a device in D0-uninitialized
during a transition from D3cold to D0.

Say, a PCIe device depending on some ACPI power resources is put into
D3cold, so the power resources in question are all turned off.  Then,
pci_power_up() is called to put it into D0.

It first calls pci_platform_power_transition() which invokes
platform_pci_set_power_state() to turn on the ACPI power resources
depended on by the device and, if that is successful, it calls
pci_update_current_state() to update the current_state field of
the PCI device object.  If the device's configuration space is
accessible at this point, which is the case if
platform_pci_set_power_state() leaves it in D0-uninitialized (and
there's nothing to prevent it from doing so), current_state will be
set to PCI_D0 and the pci_raw_set_power_state() called subsequently
will notice that the device is in D0 already and do nothing.
However, that is not correct, because it may be still necessary to
restore the device's BARs at this point.

To address this issue, set current_state temporarily to PCI_D3hot
in the cases in which pci_raw_set_power_state() may need to do more
than just changing the power state of the device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1309,6 +1309,8 @@ static int pci_dev_wait(struct pci_dev *
  */
 int pci_power_up(struct pci_dev *dev)
 {
+	pci_power_t old_state = dev->current_state;
+
 	pci_platform_power_transition(dev, PCI_D0);
 
 	/*
@@ -1325,6 +1327,14 @@ int pci_power_up(struct pci_dev *dev)
 		pci_resume_bus(dev->subordinate);
 	}
 
+	/*
+	 * For transitions from D3hot or deeper and initial power-up, force
+	 * PCI_PM_CTRL register write, D3*->D0 transition delay and BARS
+	 * restoration.
+	 */
+	if (old_state >= PCI_D3hot)
+		dev->current_state = PCI_D3hot;
+
 	return pci_raw_set_power_state(dev, PCI_D0);
 }
 



