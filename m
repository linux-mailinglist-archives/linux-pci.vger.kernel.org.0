Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5044FF0E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKOHLt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhKOHLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427EAC061202;
        Sun, 14 Nov 2021 23:08:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so28505624wrd.9;
        Sun, 14 Nov 2021 23:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZWiJqomYd+qZWPuxyxTZWhBZhOmR5lNYj163C1SPLk=;
        b=aMKsGwB9RBYwnkCb4l4QcYCANUPkP43m02za2ZhNNhxGm2j2vXuuCmNwiAMbN5aqzC
         l830JCZOiMo4RvTSLnubEFU4FvCICIXgZcQw3ZOKoObV69cUm1PF7CmCwTP8nLb7d/pi
         d6M2WI6Ooj9+7PkOfBVB2jvt06k8uFjU15lmaWoVgbOaSfw5SjPDkRU+2B2JXPcaHzrF
         kds0I1Y4bthmyD5WT5Q8d4n3Dfcq4PPUbXIH02IbtZFrXYj4duK/+v5uFkg2D/RqEhAp
         EsbeD4YmwkLOwA31zD5OuIGLUAwSW8C7EbQk3c1IxUYnVnDz17XXgwWE04eYDvf7N/JJ
         EdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZWiJqomYd+qZWPuxyxTZWhBZhOmR5lNYj163C1SPLk=;
        b=oMhS/4K4z5aUrm7m8q6mEDgx6Wfp9PlXToaiXrl8vA54CKJTE8u30JBxsqCZMUOir4
         JGLJ5Obel5pYLSlkXBIVdhv8zDJOjETUGAYnPD8to6cwcN+fu6Iux6BDxTT7BMAskClg
         TZdHS2reUO5z1GduHRusCmZL0/RtIoucr8reO4EiWLZhRzKYuk9v0X1zz4AxuvulDS/l
         LTwn9kW6MEObgkicJ7C+QpmCq1yEnbKP3X9GR6Fp+/1/suCAI9ADdVb0TS+edRJpKRhQ
         Es5DMbVWqEe0yoMnfZfJuMSo3+3ugWzXAKRscv8PcRcmW2XCoUiAi6jUR/hA3yHbWxmy
         kHkw==
X-Gm-Message-State: AOAM5314ADI3IjnzARTL/NaAo6cC9ts/GuIXhFgmVJG3VA99srEI1VZQ
        kLn1rWa/p8kXG4QG6FNw3O0XLfH2+Cg=
X-Google-Smtp-Source: ABdhPJwZ5Op7IVXa3DEKLNfbB3npzfNOsOBoYL6LT/2asdQTyjRCMlpxsvsSSHjwMsO/B58mfxfHxg==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr45441284wri.137.1636960096568;
        Sun, 14 Nov 2021 23:08:16 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:16 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] PCI: mt7621: Kconfig: completely enable driver for 'COMPILE_TEST'
Date:   Mon, 15 Nov 2021 08:08:09 +0100
Message-Id: <20211115070809.15529-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since all MIPS specific code has been moved from the controller driver side
there is no more stoppers to enable the driver to be completely enable for
'COMPILE_TEST'. Hence, remove MIPS conditional statement.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e917bb3652bb..105ec7dcccc9 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -332,7 +332,7 @@ config PCIE_APPLE
 
 config PCIE_MT7621
 	tristate "MediaTek MT7621 PCIe Controller"
-	depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
+	depends on (RALINK && SOC_MT7621) || COMPILE_TEST
 	select PHY_MT7621_PCI
 	default SOC_MT7621
 	help
-- 
2.33.0

