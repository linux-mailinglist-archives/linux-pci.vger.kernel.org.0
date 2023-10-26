Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFF7D874C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjJZRK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJZRK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 13:10:58 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67291;
        Thu, 26 Oct 2023 10:10:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id aa76c98fa7cf63df; Thu, 26 Oct 2023 19:10:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2337C6673DC;
        Thu, 26 Oct 2023 19:10:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH 0/4] Add support for drivers to decide bridge D3 policy
Date:   Thu, 26 Oct 2023 19:10:52 +0200
Message-ID: <4534521.LvFx2qVVIh@kreacher>
In-Reply-To: <b992caec-68f9-4ad0-afe3-99f83d73232d@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com> <5735975.DvuYhMxLoT@kreacher> <b992caec-68f9-4ad0-afe3-99f83d73232d@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgu
 rdgtohhmpdhrtghpthhtohepufhhhigrmhdqshhunhgurghrrdfuqdhksegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, October 26, 2023 7:06:13 PM CEST Mario Limonciello wrote:
> On 10/26/2023 12:04, Rafael J. Wysocki wrote:
> > On Wednesday, October 25, 2023 4:05:42 AM CEST Mario Limonciello wrote:
> >> The policy for whether PCI bridges are allowed to select D3 is dictated
> >> by empirical results that are enumerated into pci_bridge_d3_possible().
> >>
> >> In Windows this behaves differently in that Windows internal policy is
> >> not used for devices when a power engine plugin driver provided by the
> >> SOC vendor is installed.  This driver is used to decide the policy in
> >> those cases.
> >>
> >> This series implements a system that lets drivers register such a policy
> >> control as well. It isn't activated for any SOCs by default.
> >>
> >> This is heavily leveraged from the work in [1]
> >>
> >> [1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/
> >>
> >> RFC v1->PATCH v1
> >>   * Simplify the logic, use pci_d3cold_enable()/pci_d3cold_disable() functions
> >>   * Roll https://lore.kernel.org/linux-pci/20231004144731.158342-1-mario.limonciello@amd.com/ into series
> >>   * Updates for some typos
> >>   * Re-order series.  Patches 1 and 2 can potentially apply to PCI tree, 3 and 4 to platform-x86 tree.
> >>
> >> Mario Limonciello (4):
> >>    PCI: Make d3cold_allowed sysfs attribute read only
> >>    PCI: Refresh root ports in pci_bridge_d3_update()
> >>    ACPI: x86: s2idle: Export symbol for fetching constraints for module
> >>      use
> >>    platform/x86/amd: pmc: Add support for using constraints to decide D3
> >>      policy
> >>
> >>   Documentation/ABI/testing/sysfs-bus-pci |  4 +-
> >>   drivers/acpi/x86/s2idle.c               |  1 +
> >>   drivers/pci/pci-acpi.c                  |  2 +-
> >>   drivers/pci/pci-sysfs.c                 | 14 +-----
> >>   drivers/pci/pci.c                       | 12 ++++--
> >>   drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
> >>   include/linux/pci.h                     |  1 -
> >>   7 files changed, 72 insertions(+), 19 deletions(-)
> > 
> > Any chance to CC this series to linux-pm and linux-acpi?
> > 
> > 
> > 
> > 
> 
> Sure if it needs to spin again I'll send it to those lists as well.
> 
> Here's a lore link for you for now though if you want to respond to the 
> other patches.
> 
> https://lore.kernel.org/platform-driver-x86/0cd6648d-21f1-445d-95f6-20f580bbcfd1@amd.com/T/

Thanks, but I'm not the only person on linux-acpi and linux-pm
that may be interested in these changes.

Also please note that the material is related to ACPI and PM, so
quite relevant for those lists.




