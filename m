Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F749602F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350794AbiAUN6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350819AbiAUN6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:58:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE8C061574
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 05:58:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B709B81F88
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 13:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FD0C340E1;
        Fri, 21 Jan 2022 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773493;
        bh=JVf6h0NMxUJs4pkAAdBauLe7+1uoLIM13xiPaULE9O4=;
        h=From:To:Subject:Date:From;
        b=egmlLUVDl1ca6YzBuZn1oCfvutaKqzIOO7TOtehhziWXjgHlWmizmpR/PHEB5yO4W
         0NNGs40iQttMGUFf5KHyTWaOwDaQ0IdkvVO80GjuqcUBCwwthhfl1f7isaqXPCeWvj
         HqzlYUWBbISBIB++E2Q2F9nv23qABX3FfsKv/B3AZ/fXnAHZWTeBkBo/2m1kGk/YhN
         xlAnIW5h7Sfh388UZVBH3rSLLZ6OAjUCOsnK+ulgZ6JgejIVXWk4yIe2nzAhXbwSuz
         +1bD49ku1G+l8JN7/jJQfanzzJMpSbCdFBNYFkbv0fiJFbzFCiuolPdo5r2/tTFm5c
         cr0JmqM90W6og==
Received: by pali.im (Postfix)
        id 8B9A0857; Fri, 21 Jan 2022 14:58:10 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Date:   Fri, 21 Jan 2022 14:57:13 +0100
Message-Id: <20220121135718.27172-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

libpci currently provides only access to bits [23:8] of class id via
dev->device_class member. Remaining bits [7:0] of class id can be only
accessed via reading config space.

lspci in some places reads class id from dev->device_class and on some
places from config space because it does not have access to all class bits.

For some broken devices kernel reports different class id via sysfs as
what is stored in device config space. Value reported by sysfs should be
the correct one.

lspci has -b option (Bus-centric view) to choose if information from
kernel or from config space should be showed. But this option is not
respected on all places because of missing bits.

Same applies for vendor+device ids, subsystem ids and revision id.

Export all these information from sysfs via libpci API use it in lspci.
With this change lspci should now respect -b option for all these
information.

With this change are in libpci and lspci also available subsystem ids
for PCI-to-PCI bridges.

This patch series is based on top of another patch series:
https://lore.kernel.org/linux-pci/20211220155448.1233-3-pali@kernel.org/

Pali Rohár (5):
  libpci: Add new options for pci_fill_info: PROGIF, REVID and SUBSYS
  libpci: generic: Implement PROGIF, REVID and SUBSYS support
  libpci: generic: Implement SUBSYS also for PCI_HEADER_TYPE_BRIDGE
  libpci: sysfs: Implement PROGIF, REVID and SUBSYS support
  lspci: Retrieve prog if, subsystem ids and revision id via libpci

 lib/generic.c | 55 +++++++++++++++++++++++++++++++++++++++-
 lib/pci.h     |  6 +++++
 lib/sysfs.c   | 39 +++++++++++++++++++++++++---
 ls-kernel.c   |  8 +++---
 lspci.c       | 70 ++++++++++++++++++---------------------------------
 lspci.h       |  2 --
 6 files changed, 123 insertions(+), 57 deletions(-)

-- 
2.20.1

