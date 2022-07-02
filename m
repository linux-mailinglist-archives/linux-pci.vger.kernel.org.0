Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BC563F8F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiGBLHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiGBLHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 07:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060DD15A2A;
        Sat,  2 Jul 2022 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8657B60C86;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1AFC341CD;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=HoY8a1pQ8+QTg3PV6dYwn+Zs/t2wHp535PSOQzabaig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljA+otHbIs93lLzFjuRvfpFijXlQQUQ4yzwHyPDkgSHy3BzqpWVZNh+lpWqgzD3qz
         LXqWTaIy3Tw9BJDIgG+1gTLV/eAbBkpjVLhyGIPDgn11u4hXhSAt+NElki04UHIQfa
         wdw5dgBryi2nbaJOV/qzh74mbrFghYi1ybUbZluJR9D3NhRUTcAG688xWKPHy/k8vr
         unFXRwMNPFaIZB1IxosKNBfD7DnYh2qQG/ezfJw3gML6NT4rE8a5+rAtImXTerMluB
         ati0aQPV93/0KQp+R+0E5mWKzk8lfu7cUVDFOrItwfJJQp729M19Lugl1ojWgLasal
         dB5qHRSpkoUfw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gs0-Lx;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 04/12] docs: PCI: pci-vntb-function.rst: Properly include ascii artwork
Date:   Sat,  2 Jul 2022 12:07:36 +0100
Message-Id: <9eeaa329cc4fa64829ff0bdaf8f10e68f7283ac7.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adjust identation and add a "::" in order to properly mark the
ascii artwork as a code block, fixing this warning:

	Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/PCI/endpoint/pci-vntb-function.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
index cad8013e8839..7b2ac70e2c57 100644
--- a/Documentation/PCI/endpoint/pci-vntb-function.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
@@ -58,7 +58,7 @@ It is same as PCI NTB Function driver
 Scratchpad Registers:
 ---------------------
 
-  It is appended after Config region.
+It is appended after Config region::
 
   +--------------------------------------------------+ Base
   |                                                  |
-- 
2.36.1

