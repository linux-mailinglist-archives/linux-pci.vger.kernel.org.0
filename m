Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F49664817
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjAJSFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbjAJSEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:04:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E0C84BF5;
        Tue, 10 Jan 2023 10:02:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 071CCB818FB;
        Tue, 10 Jan 2023 18:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C5EC433EF;
        Tue, 10 Jan 2023 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373772;
        bh=3TkgNGFutzwKLFf4bqMOUvkvszlVhZochLWy+jcc/p4=;
        h=From:To:Cc:Subject:Date:From;
        b=SoiSZ+kjFzj70arH8udHwEKHRHi3QawNfbI22gUiojNMcDWvmm7/ly1WwAUIN6my8
         i2DfhAEyXx+PjcTYGfSAMucGtV1yJifqucDMrLpy3YBq7mUc/4uGk0WytYUYNcxDZe
         fxmVaisZO7QewInuYnOMc5rMdDHzMZULV4b5banwy7tfQAfj0t5MUeEaGAgdbRWkIc
         bMHIzf50hcweUhe3z47OkOzKNYmu8avyqGOLWZHwdA1Al7OqiIk8DuS2JgL0jhzLXc
         dr7ISkGIuR/CvWey+0sFTELfyD6ApqPBZ0KCWeFLWTU3QywOBrUFJ5gbBSR8mUfjjc
         SvLMPvIefw/FQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Fix extended config space regression
Date:   Tue, 10 Jan 2023 12:02:41 -0600
Message-Id: <20230110180243.1590045-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") appeared
in v6.2-rc1 and broke extended config space on several machines.

This broke drivers that use things in extended config space, e.g., perf,
VSEC telemetry, EDAC, QAT, etc.

This happened because mmconfig-shared.c checks to see that ECAM space is
reserved in E820 or ACPI motherboard resources.  If it's not, it assumes
ECAM doesn't work.  07eab0901ede removed some E820 entries, so it looked
like ECAM was no longer reserved, so we stopped using it.

The machines where this broke don't reserve the ECAM in ACPI PNP0C02
devices (which seems to be what the PCI Firmware spec requires), but they
do mention it in the EFI memory map as EfiMemoryMappedIO.

Bjorn Helgaas (2):
  x86/pci: Simplify is_mmconf_reserved() messages
  x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

 arch/x86/pci/mmconfig-shared.c | 44 +++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

-- 
2.25.1

