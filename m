Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A844FF0C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKOHLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhKOHLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649DC061200;
        Sun, 14 Nov 2021 23:08:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so2373665wrr.8;
        Sun, 14 Nov 2021 23:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ANGiNP5p9JTK/GJaWthHiw2NR1mnyYlmnBjAbXXOWc=;
        b=ZYh5gng6qA1mldCFf8+WAla4FSnHHhrjLScNwkaIq06tUttGj3t8nmNyOB4HnN/oT6
         RucPL/c3+T8giwO79oW2Re3LAqQKCAGjKARwBXE+idRj1Zi0odU8Xi8NyzdGZ8m8KY0h
         xNHoWDI8W9BOGNhmjOitJhs9Y3vebkte/32idyWiS5hbYQi+pMNVo8JLFstPsWscz4wI
         tjrl4TtHu0Vu9MeByC5ONu7cC7f4H/b4cIepLcW4ixy4nRLwT5eTcGyqpd7ZvJ/ixVv/
         8KLUd7P7YKsK3likFsuFkxc2KTtnAPb/oplIo2DvjJOoviP8sBcLcLJTWYV9fPwMeVi6
         pc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ANGiNP5p9JTK/GJaWthHiw2NR1mnyYlmnBjAbXXOWc=;
        b=aMMkvqbAMFFX9ugxUdLdSwzW7zsOKtQtMUoNa3x4CvjoHWQ9dETqu9x5mn0jgSuCjR
         Ll1vDCM5z0HPccwso4mdpikWeXTaoNpGTiLjUsj1+aN6SQ0MLXWmU1pqn/Rl8ZOimEl4
         xJ7xf9hBI27K9weky8eR4knZ/JsKAXfTTX8C65j2HUo/bFDdc3RQ7j+4zpybpSiSMOVj
         PlEo3dDEt7nXHlqHMUm2g4kkRr165dSpa7afHre6rGF5MNM5NvokKCNh9fHLcKTx4uLG
         3Y0rkw7yIoDnMD7uSDX3+tzPeQXRyDaII/zpNlEP5OKIW4V8bIRaXwchhFrsbTDKLQJQ
         tTXQ==
X-Gm-Message-State: AOAM5316ygVPzHgUgTIUWa7aAO8YFBZyVAAR3tU3HAqmZ9vMfKYnjD6D
        dOHh4diSVjMwhkeulqSkve4pePmhXDY=
X-Google-Smtp-Source: ABdhPJzuz6FLWMxMp5cLt5GjNJN3Ev8LovJ1RWfT5513h2yOzAnLIk5iWLV0c+vbIz7m/8UfJ8EYhA==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr44792515wrx.292.1636960095584;
        Sun, 14 Nov 2021 23:08:15 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:15 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
Date:   Mon, 15 Nov 2021 08:08:08 +0100
Message-Id: <20211115070809.15529-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
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
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 9cf541f5de9c..a120a61ede07 100644
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

