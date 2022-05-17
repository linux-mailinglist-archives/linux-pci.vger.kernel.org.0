Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059952ACC9
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiEQUff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350301AbiEQUfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 16:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50A52B2C;
        Tue, 17 May 2022 13:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA349616E7;
        Tue, 17 May 2022 20:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D267CC385B8;
        Tue, 17 May 2022 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652819732;
        bh=qzd2QVWtJy9wJyXpi03zRg6PCfu4G05Seli8kQ2WBfI=;
        h=Date:From:To:Cc:Subject:From;
        b=dDXexWqjZpelT8RXlw4QdHHoHREjKRON5ZIRTHT25t+nPTapjiDAVee49dW9E75/n
         ZvyNLBgSnE8H0jbF4gSiveFQ7k6DG9gzJzl8+2YfBL+MuqLSSfoFMPyFRZ4pLMKihi
         S2nAsN0B93U7I39M7MDCbAss43EGwKP0VIDEbc5QKbkUsLWYdmyRP3TsiNisZrgj6S
         fPseAVcGXm5HSkCRtpT5wYFyAbCijFODBzfu8BklnFlNEHGXnurmfRzWm28cQQs7gG
         +hjR6eF3A2H5yEIIL802cP3bfcdaRK5YwB6co6xRJyp3djUe/xLp2LoXk5+tRwCAhC
         udROXbdAI9tKQ==
Date:   Tue, 17 May 2022 15:35:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stefan Gottwald <gottwald@igel.com>,
        Steev Klimaszewski <steev@kali.org>
Subject: [GIT PULL] PCI fixes for v5.18
Message-ID: <20220517203530.GA1102878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-fixes-1

for you to fetch changes up to a3b69dd0ad6265c29c4b6fb381cd76fb3bebdf8c:

  Revert "PCI: aardvark: Rewrite IRQ code to chained IRQ handler" (2022-05-16 15:58:47 -0500)

----------------------------------------------------------------
PCI fixes:

  - Avoid putting Elo i2 PCIe Ports in D3cold because downstream devices
    are inaccessible after going back to D0 (Rafael J. Wysocki)

  - Qualcomm SM8250 has a ddrss_sf_tbu clock but SC8180X does not; make a
    SC8180X-specific config without the clock so it probes correctly (Bjorn
    Andersson)

  - Revert aardvark chained IRQ handler rewrite because it broke interrupt
    affinity (Pali Rohár)

----------------------------------------------------------------
Bjorn Andersson (1):
      PCI: qcom: Remove ddrss_sf_tbu clock from SC8180X

Pali Rohár (1):
      Revert "PCI: aardvark: Rewrite IRQ code to chained IRQ handler"

Rafael J. Wysocki (1):
      PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold

 drivers/pci/controller/dwc/pcie-qcom.c |  7 ++++-
 drivers/pci/controller/pci-aardvark.c  | 48 ++++++++++++++++------------------
 drivers/pci/pci.c                      | 10 +++++++
 3 files changed, 38 insertions(+), 27 deletions(-)
