Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378943DA19
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1EH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhJ1EH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 00:07:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41FC061767;
        Wed, 27 Oct 2021 21:05:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so6835738ott.2;
        Wed, 27 Oct 2021 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwuffgxU3wRmVa+DpmHIPcZE6CmK1JPJZJMS0/ZH4Jo=;
        b=YUw1lmx4OIdq79Cg2MrmNj3sAmreSf6/zZ6cCsqLs9Hf0cNzulCsCnTIoCSje7Juf5
         4MW6RqbCUqIxhZ/sgg957aojyu5OyPKUwQ7lwKyjHl/RnX5n2BOzdeHUGfS2xI4R1o1R
         k7pSk3Z4BcLXxu+kcblwePAQW+E/y4Wvc4vQ/TnpfEkDuuWEs+m1Nfp12xc5h4DyYgcd
         cOun6umiPHH1thhpyEVi64FS1aUzGshAXAINyCxx8fJtRlf2d36H8wzYOHjXz4rbxPes
         CZWXhLk+mlHO4E+DABFubVzJHUXgwD2wHVPe2LwduH9vdeQkopq3jjAlXBOcoO+66L1a
         JkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwuffgxU3wRmVa+DpmHIPcZE6CmK1JPJZJMS0/ZH4Jo=;
        b=pzxeULRyDfK534hOYtAlcbNRWknJCU5/mQVcvq0CWnGgZ9P3QBChhHxXTyFLo0v9Iz
         6gZdgLtmZMmPYlf8sPCjJw+ITMygA5VQv8WqrfUjkYn+WanPbsSyq0qcV7cagxsqu8yM
         Tgl5nWjErPWf8GsCC87MuUp9WhNOiMxPYZGoOpJYtB86ACjtmExcmLYYxFJO+S1foj2Q
         Q/5ZGw5Arjvz87VUs6g94Skk33Yu0Dyl8hprTZHu1zxlexU6ifcdNRLbIsyBqF/LT86k
         4Npykw660nSVB0Fo2FIpWULb0h6iOIHXozHFdUpTHtYnwRSekLTp0a7sglS2WZaRbY/2
         ox4w==
X-Gm-Message-State: AOAM530zWtsufeuA41Qn76LDtFumGvFK+8HSoJQV0DZ93LwYASDn6Z3N
        VJlbTqN3YEzFHQSzRFNZKjQ=
X-Google-Smtp-Source: ABdhPJyUsB/5+7FwNb66y//mjG3vnJaBme5QHb/EqdW/iuW79NaMesoAdP7HsruDu3dQtHaezLflkA==
X-Received: by 2002:a9d:655a:: with SMTP id q26mr1516675otl.20.1635393931070;
        Wed, 27 Oct 2021 21:05:31 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.76])
        by smtp.gmail.com with ESMTPSA id v13sm720310otn.41.2021.10.27.21.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:05:30 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     tsbogend@alpha.franken.de, sergio.paracuellos@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
Cc:     Yanteng Si <siyanteng@loongson.cn>, sfr@canb.auug.org.au,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        linux-next@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: mt7621: Add MODULE_* macros to MT7621 PCIe host controller driver
Date:   Thu, 28 Oct 2021 12:04:52 +0800
Message-Id: <9f78c60ccef522115271bd406497a828fe5cd29d.1635390750.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1635390750.git.siyanteng@loongson.cn>
References: <cover.1635390750.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
the MT7621 PCIe host controller driver is built as a module but no MODULE_*() attributes
were specified, causing a build error due to missing license information.

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o

Fix this by adding MODULE attributes to the driver.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index b60dfb45ef7b..668b737f86fb 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -598,3 +598,5 @@ static struct platform_driver mt7621_pci_driver = {
 	},
 };
 builtin_platform_driver(mt7621_pci_driver);
+
+MODULE_LICENSE("GPL v2");
\ No newline at end of file
-- 
2.27.0

