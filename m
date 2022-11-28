Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5D63A0A7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK1EnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK1EnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:43:04 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 20:43:03 PST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065F12AA6;
        Sun, 27 Nov 2022 20:43:00 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D1F13101920D9;
        Mon, 28 Nov 2022 05:25:49 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9ACAB603E021;
        Mon, 28 Nov 2022 05:25:49 +0100 (CET)
X-Mailbox-Line: From 7ced46eaf68bed71b6414a93ac41f26cfd54a991 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1669608950.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 28 Nov 2022 05:15:50 +0100
Subject: [PATCH 0/2] DOE WARN splat be gone
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here's my proposal to fix the DOE WARN splat reported by Gregory Price:

One backportable oneliner to replace INIT_WORK() with INIT_WORK_ONSTACK()
and one patch to change the API and thus fix the problem for good.

So that's an alternative approach to Ira's.

Please review and test.  Thanks!


Lukas Wunner (2):
  PCI/DOE: Silence WARN splat upon task submission
  PCI/DOE: Provide synchronous API

 drivers/cxl/core/pci.c  |  58 +++++++-------------
 drivers/pci/doe.c       | 114 +++++++++++++++++++++++++++++++++-------
 include/linux/pci-doe.h |  47 ++---------------
 3 files changed, 117 insertions(+), 102 deletions(-)

-- 
2.36.1

