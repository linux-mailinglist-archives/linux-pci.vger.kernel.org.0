Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFA5F4DF4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 04:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJEC6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEC6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 22:58:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE095A2FC;
        Tue,  4 Oct 2022 19:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BEB23CE1232;
        Wed,  5 Oct 2022 02:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE820C433D6;
        Wed,  5 Oct 2022 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664938697;
        bh=iXLlB/JyBslVw0glbr+v06sxs2sGy1qV661ipd4xGwI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ccj5VL28hYmZJU2GXBLI57djHsFE1z3W2ZPNZlhvlDgLrD8mCQT9q9eLyIL4XIijX
         pKyJJREieBQIx2McTJhcSUs86E4TqyNi0eb9DttQp3tv07nxKxnrqurg4C5xJylxXy
         uAUFL6IKaERx9I1j7m2GRfF7rCR7TAi7PqV4jGqTtdEQ6J/Hsr6BFFJQL/z4zdE9gv
         izGNdCWsfaPABVRGQyOTMbqPljFfKYut50mIjAmoS/4lnGGoPryLuCejhRKUsdyhSe
         TVv+OlqhonRGPk2wOo7qwi1VhetSS8sWQnojwPZJS/GRe9rehHTabBno4+MC9g0YXI
         mZRcrOgTxugiQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/ASPM: Fix L1SS issues
Date:   Tue,  4 Oct 2022 21:58:06 -0500
Message-Id: <20221005025809.2247547-1-helgaas@kernel.org>
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

This is really late, but I think we have two significant issues with L1SS:

  1) pcie_aspm_cap_init() reads from the L1SS capability even when it
  doesn't exist, so it reads PCI_COMMAND and PCI_STATUS instead and treats
  those as an L1SS Capability value.

  2) encode_l12_threshold() encodes LTR_L1.2_THRESHOLD as smaller than
  requested, so ports may enter L1.2 when they should not.

These patches are intended to fix both issues.

Bjorn Helgaas (3):
  PCI/ASPM: Factor out L1 PM Substates configuration
  PCI/ASPM: Ignore L1 PM Substates if device lacks capability
  PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation

 drivers/pci/pcie/aspm.c | 155 +++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 65 deletions(-)

-- 
2.25.1

