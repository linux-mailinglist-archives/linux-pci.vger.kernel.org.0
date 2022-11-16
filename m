Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11662CB6F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiKPUvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiKPUvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:51:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A172627D5;
        Wed, 16 Nov 2022 12:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31682B81EB6;
        Wed, 16 Nov 2022 20:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653F1C433C1;
        Wed, 16 Nov 2022 20:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668631866;
        bh=8WkS0KoSIEQDcVnrOtMBRMpT1esiNNbOZ77Wa5K5uk4=;
        h=From:To:Cc:Subject:Date:From;
        b=YaaJM+O5UkOayhpkKt6HqIxEsHTCrkIte76musMkiVEYg8sHuWUwD56DcfzMtlphV
         pmxm7NLHBR7iX6klYzQkdbIvEUxiEXLu2VGxkszaFBsJyeuK4GjLPdWT7c5kuaeOv1
         BRGRGRpwDOUQyKiG9ppR+7Rd/hU6xG2G7hcSDecZlF7us+Dw8apUcqEt0vYfARdR6A
         lu983HrqwE6rna/i/CZKeY4VLo/urpnBy7aH4Jyub2o42h1AxS23ABIRviZP7PToik
         jln8QU6+4HhepEfGPb4Z0pgU7ow/2t+OjQhENpuDdDVB8byqLGCLsfWmFcphQkLgI/
         F95iLfChQ9SVw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] PCI: Allow building CONFIG_OF drivers with COMPILE_TEST
Date:   Wed, 16 Nov 2022 14:50:58 -0600
Message-Id: <20221116205100.1136224-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update CONFIG_OF dependencies so we can compile-test drivers (with
CONFIG_COMPILE_TEST=y) even without CONFIG_OF being enabled.  OF provides
stub functions when CONFIG_OF is not set.

Changes from v1 to v2:
  - Retain "depends on OF || COMPILE_TEST" instead of dropping "depends on
    OF" completely so drivers are only offered when they are applicable or
    COMPILE_SET is enabled (many thanks to Geert for pointing out this
    major mistake)

v1: https://lore.kernel.org/r/20221025191339.667614-1-helgaas@kernel.org

Bjorn Helgaas (2):
  PCI: Drop of_match_ptr() to avoid unused variables
  PCI: Allow building CONFIG_OF drivers with COMPILE_TEST

 drivers/pci/controller/Kconfig          | 34 +++++++++++----------
 drivers/pci/controller/cadence/Kconfig  | 12 ++++----
 drivers/pci/controller/dwc/Kconfig      | 40 ++++++++++++++++---------
 drivers/pci/controller/mobiveil/Kconfig |  2 +-
 drivers/pci/controller/pci-ftpci100.c   |  2 +-
 drivers/pci/controller/pci-v3-semi.c    |  2 +-
 6 files changed, 53 insertions(+), 39 deletions(-)

-- 
2.25.1

