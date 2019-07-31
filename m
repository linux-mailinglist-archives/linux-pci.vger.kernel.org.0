Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8C7D10D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGaWUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 31 Jul 2019 18:20:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63324 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfGaWUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 18:20:51 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 1892615acf94579e; Thu, 1 Aug 2019 00:20:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur in special cases"
Date:   Thu, 01 Aug 2019 00:20:49 +0200
Message-ID: <4787259.M8qLqd86a7@kreacher>
In-Reply-To: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
References: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, July 31, 2019 6:04:29 PM CEST Kai-Heng Feng wrote:
> Hi,
> 
> After commit "ACPI: PM: Allow transitions to D0 to occur in special cases”,  
> Thunderbolt on XPS 9380 spews the following when it runtime resumes:
> [   36.136554] pci_raw_set_power_state: 25 callbacks suppressed
> [   36.136558] pcieport 0000:03:00.0: Refused to change power state,  
> currently in D3
> [   36.143850] pcieport 0000:04:04.0: Refused to change power state,  
> currently in D3
> [   36.150796] pcieport 0000:04:00.0: Refused to change power state,  
> currently in D3
> [   36.157138] pcieport 0000:04:01.0: Refused to change power state,  
> currently in D3
> [   36.162635] pcieport 0000:04:02.0: Refused to change power state,  
> currently in D3

Thanks for identifying the offending commit and sorry for the breakage.

The patch below should fix it.

---
 drivers/acpi/device_pm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -236,13 +236,15 @@ int acpi_device_set_power(struct acpi_de
 		if (device->power.flags.power_resources)
 			result = acpi_power_transition(device, target_state);
 	} else {
+		int cur_state = device->power.state;
+
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, ACPI_STATE_D0);
 			if (result)
 				goto end;
 		}
 
-		if (device->power.state == ACPI_STATE_D0) {
+		if (cur_state == ACPI_STATE_D0) {
 			int psc;
 
 			/* Nothing to do here if _PSC is not present. */



