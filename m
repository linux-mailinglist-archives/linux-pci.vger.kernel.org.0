Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A5414060
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhIVEWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 00:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIVEWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 00:22:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B6C061574;
        Tue, 21 Sep 2021 21:20:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so2899162wri.1;
        Tue, 21 Sep 2021 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqGtUx9WPHLk/n3qN2nHQZLutxXdz1HLw9b+FtMolfw=;
        b=f45pCETC8O4XOm2EiwFj/EV80aP0fr93abmF/uVfV4g2XhZU4iMRX5QP9Ok+5w8bJ3
         L7ZhcOEiMrvx1A62PRuNVxGcfc8hhVvDQFb18E3V7XTY2DIyKcSPShOVKZzeAFf0f2xP
         4CMJPbEZ5yjXYTH2Noq3l6zBhXrLRDFSX5kurga1i6DENvTXZ9khMywBWgyN8L+2gvMS
         QG28CwCDq0aYqc6rud7spkyx/sNWr8/j18tGr4iTye5qxkLMHkYBCo+nYBB937eDJ/SF
         IsLwunbKkR4z43Z6ke68BlUErDZgmva0uIX1CzdUCm3qB3QxUgQo+jufs9b5uViZejro
         Tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqGtUx9WPHLk/n3qN2nHQZLutxXdz1HLw9b+FtMolfw=;
        b=smm0qx/mwtB6rPbw1I7bVZPCowOJiDvHljaKxhg2j8XE5Moq9HPNZ8LSXO+xjEvzRg
         C7+VPu/OjdJhLwI5rGxdea/DcPrx9F/ohI2+AlWEv4pfVU5Q6XlWKOakwtxJMHi13U3V
         QA8/FgTa8jkoFATKNYEqKRWdQhiuXzKzGMvQRQt4bxXE2uO7LQK1wMk5ANIzOHCZ6NZm
         HekjIKCBzjd2ECF5LdEt8YWITn2ZAFo7brwpk0Jazn/vmHVp3orkqsF+BAPY45DyAk6B
         7nOBGO8ixP4RpIKOUxL7Kjm9UyNjwkq8qTozGLNBaTWkpZhAXnnw7K9kpAjQ5bwFFr2S
         buMA==
X-Gm-Message-State: AOAM530E01jq2k3clgAwXOm0mCO9VU5tonMI/sWUaVs8iL4OHNLJmLuv
        xvCe6nKb8YIeFH6+HYZ0HqJGk0QXKnE=
X-Google-Smtp-Source: ABdhPJx/bfBAx4qXAVyNkK4+9AR4BoXl+YyvjhmV8vf76DyUMb+sMv0V5B6ijbkTVpzdi6uim7hsAg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr8195117wmi.4.1632284443631;
        Tue, 21 Sep 2021 21:20:43 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id b7sm1089003wrm.9.2021.09.21.21.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Sep 2021 21:20:43 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        Liviu.Dudau@arm.com, robh@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de
Subject: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
Date:   Wed, 22 Sep 2021 06:20:41 +0200
Message-Id: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Request for I/O resources from device tree call 'pci_remap_iospace()' from
'devm_pci_remap_iospace()' which is also called from device tree function
'pci_parse_request_of_pci_ranges()'. If PCI_IOBASE is not defined and I/O
resources are requested the following warning appears:

WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
This architecture does not support memory mapped I/O

Since there are architectures (like MIPS ralink) that can request I/O
resources from device tree but don't have mappable I/O space and therefore
don't define PCI_IOBASE avoid calling devm_pci_remap_iospace() in that case.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Hi all,

This pach was part of a three patch series [0] and [1] but the other two
patches have been already added through staging git tree. I would like also
this patch going through the staging-tree to have all the three patches merged
together in the same tree, but if it is not possible I can also live with
that :).

Changes in v3:
 - Went back to the same approach that was done in v1 of the series [0].
 - Adjust commit message and description as I was suggested to do by Bjorn.

v1 series:
- [0]: https://lore.kernel.org/linux-pci/20210807072409.9018-2-sergio.paracuellos@gmail.com/T/#meb2e6c283f6d391407cb0c1158feea71de59b87d

v2 series:
- [1]: https://lore.kernel.org/all/20210822161005.22467-1-sergio.paracuellos@gmail.com/ 

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d84381ce82b5..7d7aab1d1d64 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
+#ifdef PCI_IOBASE
 			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
 				resource_list_destroy_entry(win);
 			}
+#endif
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.25.1

