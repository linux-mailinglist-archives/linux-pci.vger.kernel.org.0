Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA246589E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhLAVzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353204AbhLAVzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:55:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E7C061748;
        Wed,  1 Dec 2021 13:51:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o13so55202036wrs.12;
        Wed, 01 Dec 2021 13:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpmprtYs1zzkd2ypJgJU4YoRdsGFG26a01JTF8ywYGA=;
        b=H3Nu5SJHd7C4bi1b2m7iILOA/7YRSiWGVuzQyhEApkOuLOx8MawpV5zDMKT70cW52q
         vqPQ5F4Q0HjsRgi/UjSwuy/oyV7SVOVEPqWHyNxZfs2of0KFcmo73bopY6zJgy86ofbA
         Vv63HCJL80fv/BmtoFjONKubycm74ipJ07532lsofE/4AFWRko3uw0JvAhoW+LleOVwU
         yuq1MRGKYrfLUGfyuIbybK/4+riEF0SSE/Xv7b/pvkvlCm0UzXFOhpr5+oHNjkunEoPT
         2QVyUXTy39Sdhdjwhxeu9fmbp19Ln86X8gmK6HE3k6B1Nu1mlbFY8OMR18Wjkj4BSQpI
         RDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpmprtYs1zzkd2ypJgJU4YoRdsGFG26a01JTF8ywYGA=;
        b=2AFeUJEcgKeXRVCQLSfsMrxMgV8LbpeXLHqcJlmAo9IBxkQwmVQd5HHS7PBbrOzBUx
         Ft0TIWMvehBfVIVX3gfjmb/p5JvQ7EyWtpWM/tMqfi/WCB0aNKG7NKE++Xk1f6uSq9r9
         DNEleOGx8IvCI3DVVVPg6avamv3oFW4u73gUWu/yIJv7cWjwgXOqj9vCV8yXWVxucHpt
         opJ1G/mPo96cjAJyQrfxwMAOOPO6N0vSuR/8JDZWI9EPZOZGT5OOrmXOnTG1bRPrl6RT
         DlzVFPZDIYhKckVJzQ5WnnwXo1JwVcdPpcQ2weKFZ2U4IJQdpkTntE6gmzxnDuZv7Ajg
         FB1A==
X-Gm-Message-State: AOAM532sIsOekZd/IPNBbYz1J8ZpmabBw+Dx3Lt/KVbtPAV9WvxtKrt1
        672PqPgWqWiU8qsPKbALhqss8Mg8ewk=
X-Google-Smtp-Source: ABdhPJz6Vod6cOigId5BjxWLpL2kixofNNnqdA+gjt3UhkJFkDTDAzFeM+TIZTraVSEP1TowL6r1/g==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr9405501wrv.597.1638395494249;
        Wed, 01 Dec 2021 13:51:34 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:33 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v2 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
Date:   Wed,  1 Dec 2021 22:51:26 +0100
Message-Id: <20211201215127.23550-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT7621 PCIe host controller driver can be built as a module but there is no
'MODULE_LICENSE()' specified in code, causing a build error due to missing
license information.

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o

Fix this by adding 'MODULE_LICENSE()' to the driver.

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 42cce31df943..9da7452f565e 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -561,3 +561,5 @@ static struct platform_driver mt7621_pci_driver = {
 	},
 };
 builtin_platform_driver(mt7621_pci_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.33.0

