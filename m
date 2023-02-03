Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6168A64D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 23:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBCWs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 17:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBCWs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 17:48:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C94ED2;
        Fri,  3 Feb 2023 14:48:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A376202D;
        Fri,  3 Feb 2023 22:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8411C433D2;
        Fri,  3 Feb 2023 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675464507;
        bh=L+j3zyBTSLXoDH9WzKEgDlfEwY4t1m/PDI2fWFFLV3E=;
        h=From:To:Cc:Subject:Date:From;
        b=bMX0KtOXiYKeOA5750I10ZIzIEvztf9yqY+oQAumllUWUlWCwe7jnxvULn916P9AF
         d8MtDtPPjmX5P384kmZ6+0x+5mvc7bz+ugH2aSA4O8ulnKQrFMCatoHh0TJrWI5uWB
         W8h8sExl2uXjBUSoQMwaBNVQctlWd5djqu3H9m9cm71AL4wZQY2wWxItYex2elvk2g
         mvtsuLVEIkKPqxRscLczjX/rQpKYC0O3MFwgF5RnCeDDkwjNOLjI1psX8EhRGGgZG/
         kKNXu0oyqzcGsITDfHdOuEiOV7iIz1AdPl2SaCyuhlhO1eubjo/Uv/V8vbRZzikJP1
         M+Q+Ghez64wbg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Witt <kernel@witt.link>, Vidya Sagar <vidyas@nvidia.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] Revert ASPM L1 Substates updates
Date:   Fri,  3 Feb 2023 16:48:18 -0600
Message-Id: <20230203224820.2056582-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Thomas Witt reported that 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM
Substates Control Register programming") broke suspend/resume on a
Tuxedo Infinitybook S 14 v5, which seems to use a Clevo L140CU Mainboard.
See https://bugzilla.kernel.org/show_bug.cgi?id=216877

Since we haven't figured out a root cause, revert the relevant patches for
now.

Note that reverting "Save L1 PM Substates Capability for suspend/resume"
means machines will use more power after suspend/resume because the L1
Substates configuration is lost, but they should still work correctly.

Bjorn Helgaas (2):
  Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"
  Revert "PCI/ASPM: Refactor L1 PM Substates Control Register
    programming"

 drivers/pci/pci.c       |   7 ---
 drivers/pci/pci.h       |   4 --
 drivers/pci/pcie/aspm.c | 109 ++++++++++++----------------------------
 3 files changed, 33 insertions(+), 87 deletions(-)

-- 
2.25.1

