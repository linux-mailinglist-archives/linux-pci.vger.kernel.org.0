Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1F563F8B
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiGBLHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBLHu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 07:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA415A1F;
        Sat,  2 Jul 2022 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDFC460C3F;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007F0C34114;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=EL8lFPgfa0gTSpmdFqzAqi2G88NizQmx11K0ZM8LpBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku0joP9hVRaYI7/0QcRxgT++84V5zzltOQvcrYXc/d/ArBcWwznXGfi7xS7UVz/Yp
         IVZ0sIAaH517DBvtJ7GmVJDSjm9cR70P+c5JNXadrGWvfNZ+/cBTeLACJKeiFw9xjK
         RnQ1dq0hBaE0iWXf5HKCfXR76btl19a9y40REV3OzMK7GCt52Tk1j68gsObxXPjINa
         oUoEITJW6TT34bKkixRGUI1YURvfBMvPBZlb9S/z8Hyi+e67nvRgl2wQZalqzzt2lU
         68UVSqVXJi+spdfR82wyCDDuHX7jOLz75h/vVdkO6OPQhZyH1Mj6zXSLtyJiHgfKv+
         iYJpAA5SNYfGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gs3-Mc;
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
Subject: [PATCH 05/12] docs: PCI: pci-vntb-howto.rst: fix a title markup
Date:   Sat,  2 Jul 2022 12:07:37 +0100
Message-Id: <47ae1b19414346e6b07d57dbaf68a2b4cb273ccb.1656759989.git.mchehab@kernel.org>
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

As warned by Sphinx:
	Documentation/PCI/endpoint/pci-vntb-howto.rst:131: WARNING: Title underline too short.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index b4a679144692..31a0bae868f9 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -128,7 +128,7 @@ RootComplex Device
 ==================
 
 lspci Output at Host side
-------------------------
+-------------------------
 
 Note that the devices listed here correspond to the values populated in
 "Creating pci-epf-ntb Device" section above::
-- 
2.36.1

