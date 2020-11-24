Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0176F2C3149
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgKXTrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 14:47:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51190 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgKXTrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 14:47:00 -0500
Received: from 89-64-86-188.dynamic.chello.pl (89.64.86.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id cfed116c7623ef9d; Tue, 24 Nov 2020 20:46:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 0/2] PM: ACPI: PCI: Address issues related to signaling wakeup from bridges
Date:   Tue, 24 Nov 2020 20:41:44 +0100
Message-ID: <27714988.CF3CpBaniU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

These patches fix two problems related to wakeup signaling configuration for
bridges.

The first one is that wakeup signaling may be disabled prematurely for a
bridge (patch [1/2]) and the second one is that device wakeup power
configuration may need to be changed when enabling wakeup signaling for
a bridge for the second (and every next) time in a row (patch [2/2]).

Please see patch changelogs for details.

Thanks!



