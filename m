Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CFA0305
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1NRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:17:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1NRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:17:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so2482691wro.5;
        Wed, 28 Aug 2019 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeQmuRlJii9blLs3gsvZZwNMRSX9X8xvwY0ILQq50Ac=;
        b=XOCTjKm46R75ZeTeiDtsqqXNciUbDOs/OsFliD4+CAEV8CYSdRwZUNhV6+OdOymVgq
         KYB/jUKzaX6AIPrhdzKoKL/Ngt25jxRZqAhwLUtXounHnT28vq37iuyre+GaTkbUIzWQ
         DaAh6wDdlc0jzJQl107Rp/iX4IWkcia3Z8XolH4JNtGY9vWuCMxNtJEsA/MLG+x0y0/j
         uVAk3qhj65pWYDd5PCn2e69n+4e2l9JkLxIqGg2ZbVu7TmXWjou3Gq5Hs8S9VzZyxaOC
         8V+W1fzXdeSBIkEpTAt5d7jAtyyQyhbqpAdHToXdn0HHdiRYcLTZhJuhg0tTlzJ4AcEd
         pHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eeQmuRlJii9blLs3gsvZZwNMRSX9X8xvwY0ILQq50Ac=;
        b=Yp6XNsBfJKhNkIWKqhqhPD+avVJVKNBKQH7SmcVd6sTobklcknZzaj8ovDqvH0EjUS
         qTScbcVla4ACzr2v3sHzYa4M8hCRT/Ln7yCIY2YDYvSlPVeskAZslhOdokbUKSHQ2iTI
         XnXP6PyljSi2Xu2YlMp8xozMTv9kPO7NceRkfe0Tfgc6Gny8Sp+5A/eEEh788zFGohxy
         qicBOdRrhtk7HhjlQJE6piW/HwPjeiq7KhshQHmx/CVLb1scMYS7fbzmEO4FgsYHpiGU
         rBtrIv5WPtr2HPrOW4AmcxmANxfJuEuPAPONiNjWIt9yaB0fbxvXVEGzGQJuyHvP59x6
         D0Ow==
X-Gm-Message-State: APjAAAVkYyao2/Eh/VQRXFPC8qZsS0WE7+s2OmH7UIdkRaEdDifWUEnt
        opo0TFsE+fDjWP3rWrNj7iI=
X-Google-Smtp-Source: APXvYqy5Qy3waAJF/k854RzuCCkef9hGw6sTkPYxOmArG8eDMvyktKS8ytB9OU/0bnJpuSY2i3SvmQ==
X-Received: by 2002:adf:cd8e:: with SMTP id q14mr2194051wrj.187.1566998255405;
        Wed, 28 Aug 2019 06:17:35 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id w7sm3114987wrn.11.2019.08.28.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:17:34 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Move static keyword to the front of declarations in pci-bridge-emul.c
Date:   Wed, 28 Aug 2019 15:17:33 +0200
Message-Id: <20190828131733.5817-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190826151436.4672-1-kw@linux.com>
References: <20190826151436.4672-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the static keyword to the front of declarations of
pci_regs_behavior and pcie_cap_regs_behavior, and resolve
the following compiler warning that can be seen when
building with warnings enabled (W=1):

drivers/pci/pci-bridge-emul.c:41:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 ^
drivers/pci/pci-bridge-emul.c:176:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 ^

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v2:
  Update commit message to include compiler warning.

 drivers/pci/pci-bridge-emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 06083b86d4f4..5fd90105510d 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -38,7 +38,7 @@ struct pci_bridge_reg_behavior {
 	u32 rsvd;
 };
 
-const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
 	[PCI_COMMAND / 4] = {
 		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -173,7 +173,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	},
 };
 
-const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 	[PCI_CAP_LIST_ID / 4] = {
 		/*
 		 * Capability ID, Next Capability Pointer and
-- 
2.22.1

