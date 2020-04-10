Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B471A4AA1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDJTiC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 15:38:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgDJTiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 15:38:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so3371692wro.11
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2020 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rAbC8xJySPaHafi+vPb6FusBwDap8yUWP9nVyVhE2Qs=;
        b=cFna/Smlk5/5S9QjKWJudvbJx/O9HhtT5XLS5nXjHXbG7xcYgcwvLu28ZCrqFtGn3v
         5UWYdbQNaxE3rHuPgy2QYAyqstPilZSy291siVBxawIivFczFpcvNAj+JSNSreGzb3jQ
         2vla7cjaKAJve/H3zqcAjzXaiMfmmSWp1B02HBTqtiR56ujvWU3v8cAX3i8fmIC6NMjC
         owJdxUFCqtSJ0smx+I5+qxr5L6vOs/damzo6OHo/DV19ZaymBvehNe9S28sNftp8XU0y
         A0MdHMqNjmw+sRweujyEx3qu/YooDME6m3zdewVnL/PBGW1xf8r3lhEzbOkNBZuSW0MR
         uoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rAbC8xJySPaHafi+vPb6FusBwDap8yUWP9nVyVhE2Qs=;
        b=FdD7fgSRhHNrawbRSesAr26RlxRI6n6LLTZmqvISAMIzsmClx1zwYtg0DHqQ3p/kzl
         Izoge4KwViixux4cnfe9OqcdGjkVXx/MKupfutSAjsHRm1SnWeeNKb/Yrxfa2B+oAnQP
         ZtjZ72F/9NFhC5xAlaoWht43jWSZRtLMM+2skjb6Fc225kOWUuEsfsNnGVY5n1uv8dG7
         mcrmXUHkBiPNtIqlyFuZYeMiPhOMoM1q7i+d9qOWajfq8NTCdRiJSBZ8uKFEjEgX5JKt
         z2uVhpUUHf1fz4QkNk8fDfn7kSjtPRYRw9jUKNSna3fzxWHUwPGp9UwKqKk4FLC65CRx
         Lepg==
X-Gm-Message-State: AGi0PuYablN16ZJ/Q2+z44+kA8N01sGUNngT52OQFK0kBjCUT2lHrfdj
        VxnGGOuc+M9bv18JL56w0Qo=
X-Google-Smtp-Source: APiQypIoap0t3cPlWY6YXOqnoarNEsMg1lUa0doESGnf/pTmRw1NXAurQcfGAn+5fH+kKfrl45TLEg==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr6002872wrq.193.1586547478953;
        Fri, 10 Apr 2020 12:37:58 -0700 (PDT)
Received: from localhost.localdomain (51B6D8A0.dsl.pool.telekom.hu. [81.182.216.160])
        by smtp.gmail.com with ESMTPSA id w12sm3352609wrl.18.2020.04.10.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:37:58 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3] Replace -EINVAL with a positive error number
Date:   Fri, 10 Apr 2020 21:37:46 +0200
Message-Id: <20200410193746.1815-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..d5460eb92c12 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

