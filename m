Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C7774E63
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjHHWe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjHHWew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:52 -0400
Received: from out-73.mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4F1BDA
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OARNfgYqqI88j77QXNxHtR+yC6FyBlqX15NF2v91/5s=;
        b=lozfXp23rVPsktvtX0gQPBInuNuig15+ZDtuPcOb13UrzI+pPqoY2CJAbTcGLRNR3hpifa
        Lk4NFkJOW+/QvdT7VW8ZrfhLaMqDztMIWavX2Oj+hUmGh41afMdVPFemFneKZ857g5VIxG
        EVKpXS7FQqH0cq3Yd+NENo3KiAtV904=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 09/11] PCI/VGA: Fix a typo to the comments in vga_str_to_iostate() function
Date:   Wed,  9 Aug 2023 06:34:10 +0800
Message-Id: <20230808223412.1743176-10-sui.jingfeng@linux.dev>
In-Reply-To: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

s/chekcing/checking

While at it, convert the comments to the conventional multi-line style,
and rewrap to fill 78 columns.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index d80d92e8012b..9f5cf6a6e3a2 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -79,14 +79,16 @@ static const char *vga_iostate_to_str(unsigned int iostate)
 
 static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
 {
-	/* we could in theory hand out locks on IO and mem
-	 * separately to userspace but it can cause deadlocks */
+	/*
+	 * In theory, we could hand out locks on IO and MEM separately to
+	 * userspace, but this can cause deadlocks.
+	 */
 	if (strncmp(buf, "none", 4) == 0) {
 		*io_state = VGA_RSRC_NONE;
 		return 1;
 	}
 
-	/* XXX We're not chekcing the str_size! */
+	/* XXX We're not checking the str_size! */
 	if (strncmp(buf, "io+mem", 6) == 0)
 		goto both;
 	else if (strncmp(buf, "io", 2) == 0)
-- 
2.34.1

