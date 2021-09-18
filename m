Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5C4106D7
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhIRNdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:33:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48762 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbhIRNdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:33:17 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id fac171cdf082cbb6; Sat, 18 Sep 2021 15:31:52 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 690F666A569;
        Sat, 18 Sep 2021 15:31:49 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH v1 0/5] PCI: ACPI: Get rid of struct pci_platform_pm_ops and clean up code
Date:   Sat, 18 Sep 2021 15:31:48 +0200
Message-ID: <2341482.jE0xQCEvom@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdejjedrhedurdekgeenucfuphgrmhfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgv
 lhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=56 Fuz1=56 Fuz2=56
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

As explained in the changelog of patch [2/5], using struct pci_platform_pm_ops
for ACPI is not particularly beneficial, so it is better to get rid of it and
call the functions pointed to by it directly from the PCI core.

However, struct pci_platform_pm_ops is also used by the Intel MID support code
that basically is regarded as dead which is why the majority of it has been
dropped already as of commit 4590d98f5a4f ("sfi: Remove framework for deprecated
firmware").  Since it doesn't make much sense to update that code, patch [1/5]
drops the PCI part of it along with some arch pieces that are only needed for
the PCI stuff.

The main modification is made by patch [2/5] (see the changelog thereof for
details).

The rest is just cleanups and some code consolidation on top of that.

Thanks!



