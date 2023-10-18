Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD67CE23C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjJRQIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRQIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F212A4;
        Wed, 18 Oct 2023 09:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF17C433C7;
        Wed, 18 Oct 2023 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645322;
        bh=RV/P7kJFYdsVBoZ+ji7+q8m2XyaiNUuw2458JJByd0U=;
        h=From:To:Cc:Subject:Date:From;
        b=ukab3BzRusfmS0p4gmUeazgI41oeSTLX5mvl4B4a6k1bNMgjZxbnXGl78zQ8pl7VX
         /rltTLX/a6LssTALdHBfJeStJd0qksdKReS2rVftE7FTFnxb66LahH5g9hsVf4NHQC
         DtexTZaRFMhl4Lv9qhFwwiKQGfIRLZm3Tb+EwHTDUceLbXmtf+r7haZ9/ZHnpemQDa
         eda95YbXCofhW62B9rRVFrclUFLcTgzg5+5Mpv7qXMz1gszGY8tt34yk0MRDQB79xY
         ZWqki4nCTZ2rjesiJ7tElT7bP7iWCJ4WGZr7ltIqY6yRhjR7L+j5jlWzGraNnLmX2L
         z+NOl+GcxqcQQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/8] lspci: Decode more DevCtl2 fields
Date:   Wed, 18 Oct 2023 11:08:28 -0500
Message-Id: <20231018160836.1361510-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Decode several more DevCtl2 fields and show Interrupt Message Numbers more
consistently.

Bjorn Helgaas (8):
  lspci: Reorder PCIe DevCtl2 fields to match spec
  lspci: Decode PCIe DevCtl2 ID-Based Ordering Enables
  lspci: Decode PCIe DevCtl2 Emergency Power Reduction Request
  lspci: Decode PCIe DevCtl2 End-to-End TLP Prefix Blocking
  lspci: Decode PCIe LnkCtl Link Disable as 'LnkDisable'
  lspci: Print PCIe Interrupt Message Numbers consistently
  lspci: Remove spurious colon (':') from PCIe PTM decoding
  setpci: Fix man page typo

 lib/header.h |  4 ++++
 ls-caps.c    | 20 +++++++++++++-------
 ls-ecaps.c   | 12 ++++++------
 setpci.man   |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.34.1

