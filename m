Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC868446F91
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKFR5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFR5t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD0C061570;
        Sat,  6 Nov 2021 10:55:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x15so13497934edv.1;
        Sat, 06 Nov 2021 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJvNgOJ3Eg+Xa13E8re6uSKuREz5n9LVPX9Yf0TXKoE=;
        b=TugnJHzpQMy/tjjR9izTt7PdOQpLHNM6CBltMFeFUvowQNU/jXBX0dy+k0kPNi76Ff
         Whx7f8YvAjY3KCA4WWMf54KXTFm8upelGd11wkMApLC5CArRixxdTnlxaVtOY1/kD9nu
         iWXH/Vyqltg6KJdOvs/DOazQVpam3NKjeezUCTCnTW4SpD7XXvGGgS78Un/4t39LYXK0
         +Ua09GIkIpepxvSE1nMH3sgBloYPUr1ADo7iIxd8KbHZAtngUa1qNnz76O+w0Rdd9Aqj
         rVdk9VE7Yje0v/QbtzmCKEbluTBZIRAI6E2vIBGAn/a0rzeCkcfcY8/cNVw2zxKqU3CI
         sdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJvNgOJ3Eg+Xa13E8re6uSKuREz5n9LVPX9Yf0TXKoE=;
        b=1XOm5KQSfoOCNipeCOPUgra+nXfQIlg2cDBY3iog2YuqlTg6XIYAGWdQtpo+P6ozpv
         JgqhJJKgu15vx6Kr8km111mwcWLbbhu61NYnw4vFAHgh0rXnKNgtwvVj/wKLxwQwN+v/
         efP4NxTBoZLAUju2ge6SGj4MvIqIgOK4T06ZJcBTVJHbbe8v4jrk/sgzbthuWg1Skilp
         ZdKyouIV4mUG21JZx1vF7EcCwL6ZP7nVnIbWDHw+/P/auSBQ4UCDT6xOP5HCL4d1J3hP
         PDJk8fi0JO/YzB0d53Dx82ZcKfAwvIAIKzb4pQp6T/hSmZkDimEIW47tzD7MNDfXZFKT
         T7hw==
X-Gm-Message-State: AOAM531LFz5sijLoLnAaoj3wefdxXGpcUF5pc945ZqbzRLNe9LSP/F7R
        oFqrG+Kh4urciwGBLgCPT4U=
X-Google-Smtp-Source: ABdhPJzhUcVzTXV2gnDEqC59/xY7vvtR4v652gEJhblGsdHL4q5QUUFF19s8p5ovGj/G0UypKE6I3Q==
X-Received: by 2002:a17:906:730b:: with SMTP id di11mr9046323ejc.97.1636221306746;
        Sat, 06 Nov 2021 10:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:06 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/5] Remove unncessary linked list from aspm.c
Date:   Sat,  6 Nov 2021 18:54:58 +0100
Message-Id: <20211106175503.27178-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An extra linked list is created inside aspm.c to keep track of devices
on which the link state was enabled. However, it is possible to access
them via existing device lists.

This series remove the extra linked list and other related members of
the struct pcie_link_state: `root`, `parent` and `downstream`. All
these are now either calculated or obtained directly when needed.


VERSION CHANGES:
 -v3:
	- Remane pci_get_parent() to pcie_upstream_link() and improve
	  the logic based previous review.
	- Improve the algorithm to iterate through the devices

 - v2:
»       - Avoid using BUG_ON()
»       - Create helper function pci_get_parent()
»       - Fix a bug from the previous version

MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'

Bolarinwa O. Saheed (4):
  PCI/ASPM: Remove struct pcie_link_state.parent
  PCI/ASPM: Remove struct pcie_link_state.root
  PCI/ASPM: Remove struct pcie_link_state.downstream
  PCI/ASPM: Remove unncessary linked list from aspm.c

Saheed O. Bolarinwa (1):
  PCI: Handle NULL value inside pci_upstream_bridge()

 drivers/pci/pcie/aspm.c | 152 ++++++++++++++++++++++++----------------
 include/linux/pci.h     |   3 +
 2 files changed, 94 insertions(+), 61 deletions(-)

-- 
2.20.1

