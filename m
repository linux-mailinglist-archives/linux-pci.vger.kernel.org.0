Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5893661FCE3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKGSKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiKGSJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 13:09:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2061D264BB;
        Mon,  7 Nov 2022 10:06:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A445611EE;
        Mon,  7 Nov 2022 18:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86128C433C1;
        Mon,  7 Nov 2022 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667844375;
        bh=SDj38zhZ2y6S5wzKuopT3v98OgXjZ5t/qd6hJPfIq1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=gXtmlImi+vjgkpCX3LhfMyz3zFTfaEbT4u/U6S8Pw9RvpKVbkdsOYDOrzCs9ms5Ev
         73rDkC0ASYixrRLsG4wPx1kv9Lt8nE9oBHLEQY/jKrHD6+w83nCK5tW6rmfD1khPHa
         AnUPD9FtPcjhWJOC35YDIMYOTUL3ELWV2Me0J8fowbOzfHO0I1jL+PsxKT7xA5NWoz
         Cw4GRFQtad1E8VEFMIgwchcxZwifrcGntDmUeJBRYSqcf3NOI+1piCumZyU2HUZR18
         CGhJl4lKkdwH4P4vVily6EKSX9jSDZMEbtt1GuZe3bIGAKnpzeGgIj7xZ8duX9KhiC
         80Akdomf9Dh+g==
Date:   Mon, 7 Nov 2022 12:06:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     wse@tuxedocomputers.com, Konrad J Hambrick <kjhambrick@gmail.com>,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Thunderbolt DMAR errors (bugzilla 214259)
Message-ID: <20221107180613.GA406714@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

See https://bugzilla.kernel.org/show_bug.cgi?id=214259
From comment 42 of this bugzilla:

v6.1-rc4 on On Clevo X170KM Barebone:

  [    0.000000] BIOS-e820: [mem 0x00000000694af000-0x000000006b2fefff] reserved
  [    0.739226] pci 0000:05:00.0: [8086:1137] type 00 class 0x0c0340
  [    0.739266] pci 0000:05:00.0: reg 0x10: [mem 0x425a000000-0x425a03ffff 64bit pref]
  [    0.739288] pci 0000:05:00.0: reg 0x18: [mem 0x425a040000-0x425a040fff 64bit pref]
  [    1.587809] DMAR: [DMA Write NO_PASID] Request device [05:00.0] fault addr 0x69974000 [fault reason 0x05] PTE Write access is not set
  [   23.594763] DMAR: [DMA Write NO_PASID] Request device [05:00.0] fault addr 0x69974000 [fault reason 0x05] PTE Write access is not set
  [   44.074761] DMAR: [DMA Write NO_PASID] Request device [05:00.0] fault addr 0x69974000 [fault reason 0x05] PTE Write access is not set
  [   64.554820] DMAR: [DMA Write NO_PASID] Request device [05:00.0] fault addr 0x69974000 [fault reason 0x05] PTE Write access is not set
  [   85.031314] thunderbolt 0000:05:00.0: failed to send driver ready to ICM
  [   85.031403] thunderbolt: probe of 0000:05:00.0 failed with error -110

The initial report from wse@ was on v5.15 (faults at the exact same
address).
