Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093A31A48C2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJREi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 13:04:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32913 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJREi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 13:04:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so2965637wrd.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=clJNAroYTWV4rFME+VeIhbSZLGr3iQaW6NDSUMyrTgw=;
        b=Zsgv9kCVljCLqf+YGQROdXGVEXPTnzPCEGdh33LEiZPIoB7NmPFXtz8SjfR6CyThAG
         UldYA2MTp5QMk7BljyEWQpWvPyma8T8rMu7P1Dq50pZHNYBrQYk+sjpyu/IJp/GDpWU6
         wwd+jZss2f4SU8BQ9MQTD07Gr7PceCrZu9PCRrRHteX+qmxYPXD1od+KEO1aKpFUkAut
         5aNn4GdCecNw77LIbhh2PBrQsQQEDaeY/7G2HM9X83c2m4G66OeRy+MIUsOazlyZi5vc
         q6rKsfprkpck8rSnl7oEm0Y8BGYucGacdz9cZibxT3VlwppCRMaMuiNmqly1viiyifnE
         GQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=clJNAroYTWV4rFME+VeIhbSZLGr3iQaW6NDSUMyrTgw=;
        b=H78zPuQPbSUMT+fr+lsGJ8hrrKZtetoYfvedr06r1oSfiH2NTA/Xn3AP+EnmMgR+nC
         RCzsEFtxagVOHBXmc7uMIiyiMm+YExyJkdhe9ookEjiE2BHivL83PqVBPK/xSqNA9/GT
         xFu8f5/Tpfl4OAtw2M5Go9ws4khJXnP0nG5MRncqJ4aHT3X6dsoGR5PyfuUxR5C+uiNl
         2XeR56H5tx8XpW29oyaPPYczu3RaWkTQGvEliDnonFzUBtRUNStcyrsh55ruZCUVxnpU
         jjrFm1G53iGdg5ZyjbImx2HU7yzPKL5JZt+bEdy6KAfyitoLEx5vLjN5EX5bmXds3/ud
         QidQ==
X-Gm-Message-State: AGi0Pubs0xvJHWO924cC/CcxzgwL7JwWNMl3F9slWerqcDzWAHBL7KSi
        vAtykUc2QwBjRw9kwfMl3GY=
X-Google-Smtp-Source: APiQypJcwA9ruUEe2apJn33UO87hJUKxsq/WQ113A0tWfgdLthJpd7WsiQ3WAWjkCxMZnCTb1hdFtw==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr5710400wrw.101.1586538276009;
        Fri, 10 Apr 2020 10:04:36 -0700 (PDT)
Received: from localhost.localdomain (51B6D8A0.dsl.pool.telekom.hu. [81.182.216.160])
        by smtp.gmail.com with ESMTPSA id 5sm3422353wmg.34.2020.04.10.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:04:35 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] Replace -EINVAL with a positive error number
Date:   Fri, 10 Apr 2020 19:03:30 +0200
Message-Id: <20200410170330.1964-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 451f2b8b2b3c..d5460eb92c12 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		return pcibios_err_to_errno(PCIBIOS_BAD_REGISTER_NUMBER);
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

