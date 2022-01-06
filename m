Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18AA485CEE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiAFAH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbiAFAHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0074C06118A;
        Wed,  5 Jan 2022 16:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA60AB81E5E;
        Thu,  6 Jan 2022 00:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA08C36AEB;
        Thu,  6 Jan 2022 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427648;
        bh=7e7h7G+8Us/sLyTD6q0Hif8nF7Obr/tfz8j1T8HZEsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doFh3KTAdOd5jn+Jvk+pzEuWyAOL1Yljo/Vh7gIdONaFL39/5LbRzNUCbkX84Acei
         wEOfSkWls7+rv2IyhAVIMGuolNkX+rMxFYlU6UIe/pOjjYJyyqKpcnsr7duiz2P+sn
         qfBOU0QyO3zizcwV/wfLhdON2AezyOaoppAGTB7gdG5FXMfUv5cIDIhFvOxzOGFDQQ
         yvpPNxJsFeibTXQPF99RFXQ5zsUd3pPZJKEaWw01qXvAmJqNdvRp9Wd0Hnb4ezUZqY
         +tGGdK5NThKQVR8pivTFmk0cIJXnFo3vRlgKXCYjbf9UBaq+3GTGNcwYg8tUXDOy1+
         KucPswP+8lHqQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 09/10] vgaarb: Use unsigned format string to print lock counts
Date:   Wed,  5 Jan 2022 18:06:57 -0600
Message-Id: <20220106000658.243509-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

In struct vga_device, io_lock_cnt and mem_lock_cnt are unsigned, but we
previously printed them with "%d", the signed decimal format.  Print them
with the unsigned format "%u" instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index b7e6c1228fff..95e37817074e 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1156,7 +1156,7 @@ static ssize_t vga_arb_read(struct file *file, char __user *buf,
 
 	/* Fill the buffer with infos */
 	len = snprintf(lbuf, 1024,
-		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%d:%d)\n",
+		       "count:%d,PCI:%s,decodes=%s,owns=%s,locks=%s(%u:%u)\n",
 		       vga_decode_count, pci_name(pdev),
 		       vga_iostate_to_str(vgadev->decodes),
 		       vga_iostate_to_str(vgadev->owns),
-- 
2.25.1

