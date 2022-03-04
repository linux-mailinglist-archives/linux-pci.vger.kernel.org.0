Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA20C4CCC5E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 04:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiCDDwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 22:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiCDDwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 22:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0D17DB88;
        Thu,  3 Mar 2022 19:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D96AB826D4;
        Fri,  4 Mar 2022 03:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE9EC340E9;
        Fri,  4 Mar 2022 03:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646365895;
        bh=7+fO707x0WrVZkp++sBHfClqiE5cFjIMHZkZxzrlSrg=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5YW105F0lX/sN2XrfyUPAGY7fJzq7cEjhhx6Uxau9uReCtqdvQH9XWHos/t1LylO
         To0zRXTdmeEvROK2RxzbwSkgORlQsayPByc61Hmmqm+BhHRGx8FVUcemHlB32HwhuE
         +FWuDld8OcISjIi+UBS3gpe59cqlvuHvkg5KuxV5cDbOaBzfGEA9Ww+EOSuUVkV4Vh
         bK/iOdKT9kS2AyROuKTdBDNP9BOfq8AEfip0NSyhYMYNFkOpokz3kcprR6orHIVWBg
         c5YZWphlATCNTurSQQxPmxe/uzOfje3Ijuivz8Qt92tFw9SAqX1c+YzzlqEhr/qVEs
         JYl2aaFJ+E20Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] x86/PCI: Clip only partial E820 overlaps
Date:   Thu,  3 Mar 2022 21:51:07 -0600
Message-Id: <20220304035110.988712-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is based on Hans' extensive debugging and patch at
https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
and applies on 7e57714cd0ad ("Linux 5.17-rc6").

This is basically the same idea (applying the 4dc2287c1805 workaround only
when an E820 region *partially* overlaps a host bridge window), but I think
it's a little simpler.

This also adds a little dmesg output when clipping, which should make
future debugging easier.

I bcc'd several folks who didn't have public email addresses in the RedHat
bugzilla or Launchpad.  If you review or test this, I'd be happy to
acknowledge that.

Bjorn Helgaas (3):
  x86/PCI: Eliminate remove_e820_regions() common subexpressions
  x86/PCI: Log host bridge window clipping for E820 regions
  x86/PCI: Preserve host bridge windows completely covered by E820

 arch/x86/include/asm/e820/api.h |  5 +++++
 arch/x86/kernel/resource.c      | 34 ++++++++++++++++++++++++++-------
 arch/x86/pci/acpi.c             |  5 +++++
 3 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.25.1

