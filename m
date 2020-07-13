Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3321D6B6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgGMNXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgGMNXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD7AC061755;
        Mon, 13 Jul 2020 06:23:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so17132138eja.9;
        Mon, 13 Jul 2020 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKTGQqjFsfzqPPjmNL4aUYY57OLmCsGI5alt5eIAZQo=;
        b=sor0wqfVidp46y23ExI3rsc2tAIgirfY+l2lliUu1vrr+cY4AhVxnL0vWpCtDi/pa5
         0P/FVcGFyX2Y+3pe62aArh19MEj55T95wEF+4oO9/2bmfXNg6ZpcRhj2+xOarQfnO3Yi
         ClS6N9vgqqhyfuzzULu1HTxbdxjEJ3PCZ1/fQN6Vq9ipdpD8QA7XBzpGnmHXYxqzfHy7
         Im6YnfbXdPENwK0Tv/Tr3ewida6YiRbYRqw18+LV8NcOyemhUVamZyfUC87ZztrdJOXo
         rpPZAOHjeXFIcgipzq9CQ0IbGmW/5P7Avm2qQZKpCVxQroZ2vCz5Rp2R9aSL5UYVBjCw
         lWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKTGQqjFsfzqPPjmNL4aUYY57OLmCsGI5alt5eIAZQo=;
        b=ZO8HLpHhnoCRiAD8nBfO4PJEHW5HNrAgbVJeFrLkou6S5uswkGOEE2hPysI2pwIf0t
         lxag01xPu5xeL2Ds0lvGQxU73zhhvHiA4zTaZokxO60I4rxYTxROG1LNdY7LgJVYmmNN
         auZnQZL3lT5guNoV0P8SiaAVGkd4qoDlWi3dDUKOOUmUY1eON+fXdy/9aLiwkkXFG3I7
         DT0GwlwrLDpP2fojnEEHviigKgeZ08ClCq+xncp6t4KiEjwOv/2Y3buY8peb4SreZ/WX
         AdOLocVSeQuN0FJ0wxNcrLTbWzMWBjw/CQnHVTWLbAwrxTQZC/JXHU3FJ77+qnCMPzV/
         7umg==
X-Gm-Message-State: AOAM532/cP/NCxSSxnyTppgJwAnZiH0qlVPXB3CkCo6wnAPZoEA/gIbX
        JX+x4VDAWpEwIt+07kQ7kcY=
X-Google-Smtp-Source: ABdhPJzOwIZGspjLgMaEq365pJ5/qMDFTMQ2+msioD//dAatGjVwqe5nQfPgFpq7fjw/LM34pCqEZA==
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr78330767ejg.14.1594646587072;
        Mon, 13 Jul 2020 06:23:07 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:06 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Guan Xuetao <gxt@pku.edu.cn>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 22/35] unicore32: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:34 +0200
Message-Id: <20200713122247.10985-23-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/unicore32/kernel/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 0d098aa05b47..401ab356c814 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -37,7 +37,7 @@ puv3_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		*value = readl(PCICFG_DATA);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -58,7 +58,7 @@ puv3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		writel(value, PCICFG_DATA);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops pci_puv3_ops = {
-- 
2.18.2

