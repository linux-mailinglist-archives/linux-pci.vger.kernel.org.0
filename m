Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE68124E90
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLRRAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 12:00:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46096 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfLRRAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 12:00:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so2109041qke.13
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2019 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeqKDFdUfnO84ii4lXKLuvBndynJP0TEKYsVVVEnPp8=;
        b=GeUt53t1wbtNOn+ZhJvgbA3cY/cve2xq3FHu81BHiUMPSHVYqvTDRYtILsdcz+b063
         Y07trchcQ03ZhzFyjU5R380xAlvDqA3qsN8Bg5fpFMvYMGUWPJq0ktP0WTUvWU9UK3oE
         mAgYGqED+FtOgZv0u7Kj+7rqULyZILk5yJoQ5YUoSnX04lRmb/3VZByGv+Kv/RsHLBXu
         z4vgpIUWgqhLLqD5CgriLAZjPPONJ41fcSV8OcF+c+8reRKP7+UR97d4WmtSzOFaQ03V
         Wjy2yvPXm2DsJK829IVoqSXuTZYK6PHqdWnrXIqyQcSlRAsZNRP1+0vf+t7m31SLGc6L
         wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeqKDFdUfnO84ii4lXKLuvBndynJP0TEKYsVVVEnPp8=;
        b=fiRoz/kO/AbF2zTghn3IDC88tAwKod/7cHhDlL7OPOUIln3lHtWI3v54oOuKwfBqqS
         HLP51JM19UR/mCsR7MJxkkVlStqu/eKdqUMXjcSmd7CYKd26Gm434sfTtCsTS70c+SHu
         TINvmgFcv9TWG5kEmkLbDnTd9m2Ui1s2q+9Hjgz/7ILYlMmp81/2wcGA0rRsNeEu1Fex
         xZnBIXQ94PSssMj+KldkW/+0x3CNsbT8A25wn5VoSEAR/UlbSy7XNjjtEPSdVVwP1Ckk
         UKsKNlBBXvCNEkgbpqA1fF8RDaqeDlofJYw0ZZNpzxc9O5Grw3IGlGMunFH7qHydMruz
         l7xQ==
X-Gm-Message-State: APjAAAW2BEYzJWqvYuMe+0xsnnzsDweaiQA9D38msPrq1B6FnNvQiek4
        KGMDQhwMvpu3YT3gCSr6niJ1pg==
X-Google-Smtp-Source: APXvYqw5jDmu9ZkUqf6ud+pAbFz2CZOEk72YgKgv7/B7c2Mmq+Jz7H0KXBY9oMmm07H3UETri8EpwQ==
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr3588970qkk.80.1576688420639;
        Wed, 18 Dec 2019 09:00:20 -0800 (PST)
Received: from ovpn-126-98.rdu2.redhat.com ([71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s27sm799362qkm.97.2019.12.18.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 09:00:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     bhelgaas@google.com
Cc:     jamessewart@arista.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] pci: fix a -Wtype-limits compilation warning
Date:   Wed, 18 Dec 2019 12:00:04 -0500
Message-Id: <20191218170004.5297-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
introduced a compilation warning and a potential infinite loop because
it is no longer possible to be self-terminated as u8 is always less than
256,

In file included from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/x86/include/asm/bug.h:83,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/jump_label.h:250,
                 from ./arch/x86/include/asm/string_64.h:6,
                 from ./arch/x86/include/asm/string.h:5,
                 from ./include/linux/string.h:20,
                 from ./include/linux/uuid.h:12,
                 from ./include/linux/mod_devicetable.h:13,
                 from ./include/linux/pci.h:27,
                 from drivers/pci/search.c:11:
drivers/pci/search.c: In function 'pci_for_each_dma_alias':
./include/linux/bitops.h:30:13: warning: comparison is always true due
to limited range of data type [-Wtype-limits]
       (bit) < (size);     \
             ^
drivers/pci/search.c:46:3: note: in expansion of macro 'for_each_set_bit'
   for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {

Fixed it by using u16 for "devfn" in this occasion.

Fixes: a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/pci/search.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 9e4dfae47252..42bc44d0e681 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -41,7 +41,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * DMA, iterate over that too.
 	 */
 	if (unlikely(pdev->dma_alias_mask)) {
-		u8 devfn;
+		u16 devfn;
 
 		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
-- 
2.21.0 (Apple Git-122.2)

