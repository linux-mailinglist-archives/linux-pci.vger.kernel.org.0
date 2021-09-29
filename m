Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2158841CBA2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbhI2SR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 14:17:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41846 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345830AbhI2SRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 14:17:53 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5d0b7b55353e48ca; Wed, 29 Sep 2021 20:16:10 +0200
Received: from kreacher.localnet (unknown [213.134.161.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E399466A71A;
        Wed, 29 Sep 2021 20:16:09 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 0/3] PCI: PM: Simplify and unify some helper functions
Date:   Wed, 29 Sep 2021 20:05:37 +0200
Message-ID: <7312660.EvYhyI6sBW@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.209
X-CLIENT-HOSTNAME: 213.134.161.209
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekvddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudeiuddrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedurddvtdelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhnthhothhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This series is on top of the linux-next branch from linux-pm.git:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

which should be included in linux-next.

Two of the 3 patches in this series, [1-2/3], were included in the "PCI: ACPI:
Get rid of struct pci_platform_pm_ops and clean up code" series:

 https://lore.kernel.org/linux-acpi/1800633.tdWV9SEqCh@kreacher/

and the remaining one, [3/3] is a new version of a problematic patch from that
series.  The rest of that series is present in the git branch above.

All of the 3 patches in this set need to be tested in order to verify that
there are no more issues that need to be addressed in them.

Ferry, please test!

Thanks!




