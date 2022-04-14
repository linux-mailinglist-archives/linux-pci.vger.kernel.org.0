Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294F1501AFB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 20:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiDNSZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiDNSZX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 14:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D24E38BB;
        Thu, 14 Apr 2022 11:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE2D61766;
        Thu, 14 Apr 2022 18:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137B8C385A5;
        Thu, 14 Apr 2022 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649960577;
        bh=OExAKGni0n4Oy0ArWcJ2aR6/4OU/2MYPH8WzRih0Q1o=;
        h=From:To:Cc:Subject:Date:From;
        b=hq5+poRb8yTgjJjGY+Upu9uoVdwhYmxP+WHCp1rAt4Y5VWoTeMnwvcwJgSrR8twW7
         uw14jPIg3Uhi3rsugbOQIv6g0+HTqBGaBiM4v8nyQQaEidRLBwPbafBOBJ2kKiMOQb
         kW8KIpKy1xsZMkzO+nkiSGC9WwlPlfmKzYLumz6vda8BYm4Cc+3aQ3/YRdnqrmrKvQ
         LNSo2hnn8ZoXucnltl3SWNQFomVHGyElz5NtPebL2jF6NgdQy4XRwjdHyRKym02b/C
         nfqGGXYS6j2RcncpT/SgH5Tiyt6YJH+sM91bidJT9O/Ha1VWNdHLZydfmwTj0CeFK8
         3wsk6ZP28JXrw==
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
Subject: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Date:   Thu, 14 Apr 2022 13:22:49 -0500
Message-Id: <20220414182252.758742-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is still work-in-progress on the issue of PNP0A03 _CRS methods that
are buggy or not interpreted correctly by Linux.

The previous try at:
  https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
caused regressions on some Chromebooks:
  https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk

This v2 drops the commit that caused the Chromebook regression, so it also
doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
Barebones.

The point of this v2 update is to split the logging patch into (1) a pure
logging addition and (2) the change to only clip PCI windows, which was
previously hidden inside the logging patch and not well documented.

Bjorn Helgaas (3):
  x86/PCI: Eliminate remove_e820_regions() common subexpressions
  x86: Log resource clipping for E820 regions
  x86/PCI: Clip only host bridge windows for E820 regions

 arch/x86/include/asm/e820/api.h |  5 +++++
 arch/x86/kernel/resource.c      | 23 ++++++++++++++++-------
 arch/x86/pci/acpi.c             |  5 +++++
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.25.1

