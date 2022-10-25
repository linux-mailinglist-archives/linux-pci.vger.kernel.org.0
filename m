Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6E60D461
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJYTNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJYTNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 15:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E8BBE3F;
        Tue, 25 Oct 2022 12:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B6D61AF3;
        Tue, 25 Oct 2022 19:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394ACC433C1;
        Tue, 25 Oct 2022 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666725225;
        bh=5F+O2pwC19tirJAAthWqefE6lFYboJT1GO16yUtYi/U=;
        h=From:To:Cc:Subject:Date:From;
        b=ro6XmYyo0oYU/rQAy14hwpZ0QG6BIcUJkiMuVsOupfw5Kh0lt4cgtaLhtjl6TvexT
         yjp315fppox53GCqZXwhdkRZI9IQzxxAtaUtPTLm1D0up/DhdgHWDt04mjWwRRzlAU
         B0N8SJv/RGMEZCUdl3FZFu6UT2ij2W4dDoY0KV7eh2jE4nAWP3Eh5Spo4P8bGOEQb8
         Kp/2U6ip8dE5WrOIwgQRmn2ZYvxAI7Yv44NE9uZvIbFpm5C9k+n8h7LFd4nlJEoggY
         vz9AnVYLOd7xod8H+8x/vZWKk6l05DT3u4jMyoo7HcxzVmHYP17QLgLCXMutcUe14T
         cNydQDDgJC/cg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Drop controller CONFIG_OF dependencies
Date:   Tue, 25 Oct 2022 14:13:37 -0500
Message-Id: <20221025191339.667614-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Drop controller CONFIG_OF dependencies so we can compile-test drivers even
without CONFIG_OF being enabled.  OF provides stub functions when CONFIG_OF
is not set.

Bjorn Helgaas (2):
  PCI: Drop of_match_ptr() to avoid unused variables
  PCI: Drop controller CONFIG_OF dependencies

 drivers/pci/controller/Kconfig          | 15 ++-------------
 drivers/pci/controller/cadence/Kconfig  |  6 ------
 drivers/pci/controller/dwc/Kconfig      | 25 ++++++++++++-------------
 drivers/pci/controller/mobiveil/Kconfig |  1 -
 drivers/pci/controller/pci-ftpci100.c   |  2 +-
 drivers/pci/controller/pci-v3-semi.c    |  2 +-
 6 files changed, 16 insertions(+), 35 deletions(-)

-- 
2.25.1

