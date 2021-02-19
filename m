Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97C31FEC2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBSSZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:25:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43850 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBSSZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 13:25:41 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 31c2e862370e9c6c; Fri, 19 Feb 2021 19:18:19 +0100
Received: from kreacher.localnet (89-64-81-29.dynamic.chello.pl [89.64.81.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9A3E4661E07;
        Fri, 19 Feb 2021 19:18:18 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 0/4] ACPI: PCI: Unify printing of messages
Date:   Fri, 19 Feb 2021 19:14:32 +0100
Message-ID: <4822757.tvZ08WQ2Gl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedurddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrvdelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This series gets rid of ACPICA debugging from non-ACPICA code related to PCI
(patches [1-3/4]) and replaces direct printk() usage in pci_link.c with
pr_*() or acpi_handle_*().

Please refer to the patch changelogs for details.

Thanks!



