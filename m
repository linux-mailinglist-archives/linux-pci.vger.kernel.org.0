Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88543DA1E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1EIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1EIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 00:08:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886FC061570;
        Wed, 27 Oct 2021 21:05:44 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so936823otj.11;
        Wed, 27 Oct 2021 21:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+tBzyjdtiL7WiGh5FMDAmWBmKCfNS0J8B90yCIvOhk=;
        b=CM/XdogpcvHEPwFAcgkLE7uiWCL/8qMOeb400V/JbUG3sXhNda00BpX1XVkThtVz11
         3lmjPzMgUv1IsXtuktrulzSI/4iOsQshS0zm0yp6RRbJvf9rVpkmbHBQW9M9Xdo1JWrJ
         bWrYFpJVBLGkYcoP04qyYITNUZUTAsLaR5Gotgd66KTIttiqNDQJ/TFoMgSBzJsSN1CB
         H/3yamELti7rjNVt5Hfa/72Ar8sXSquXOmmOAmxINU4vewfB5gvqktr3nscliwJBnQLE
         ngcuJZ9vCOvejdYMH8SpfVMgy73rz4qXioZ0moTAqMBAO+Se+s0zgUxyFWrBX5xFOar5
         StGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+tBzyjdtiL7WiGh5FMDAmWBmKCfNS0J8B90yCIvOhk=;
        b=SkPTbQeqFxZQ1PbJ9MsCez4ZZYdkVLZTfdy5BD+ySmnl60+QU33p/MeFhM3OIb4QoU
         nljCxw9L3WTKuw2ooSj2dtW4sk4c2Qu+GfC7wLrZJJFmfDcuWbGruG/xSlhGJSkIy/+r
         e25op0u5sp26nXOMlWmkZUGTRnou4924ONWQndfqEc7qfunm9X3fnyFnGeVNOHredH3n
         D27MKA8hPQFC9cRRQxPZesyIZrx2Lr6owq8CK5uwtEwKiTkT6uo3VYYNiUTnfM6ng25M
         /pHNp3Ovz0zUT+CcfQZhLDwFpaOCaDyaaUAn577E6YD4WzSjFY7Z3dNDAsWOx5k5pFRb
         jzAQ==
X-Gm-Message-State: AOAM5314OK5dNaM2iuhTS3/6HOh96MSdK9q1EMWE36ROAFAQa/EE4Xjh
        3C8S+ARo+S4zuKCL2wS21NM=
X-Google-Smtp-Source: ABdhPJz15h6Ua5d1nPpoPCyg4sOtLDX9RCc0IWLc+3V4EGGO8S09ewc0W/q3HfQeCpnKF5E0JShyCQ==
X-Received: by 2002:a9d:4b16:: with SMTP id q22mr1559700otf.72.1635393944151;
        Wed, 27 Oct 2021 21:05:44 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.76])
        by smtp.gmail.com with ESMTPSA id v13sm720310otn.41.2021.10.27.21.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:05:43 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     tsbogend@alpha.franken.de, sergio.paracuellos@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
Cc:     Wang Haojun <wanghaojun@loongson.cn>, sfr@canb.auug.org.au,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        linux-next@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v2 3/3] MIPS: traps: export a missing symbols to be able to use it from driver code
Date:   Thu, 28 Oct 2021 12:04:54 +0800
Message-Id: <8c0287f7197e3d056e3954711aaa4501146de938.1635390750.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1635390750.git.siyanteng@loongson.cn>
References: <cover.1635390750.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wang Haojun <wanghaojun@loongson.cn>

Since commit 707a4cdf86e5 ("bus: brcmstb_gisb: Allow building as module")
the brcmstb_gisb bus driver is built as a module but modpost complains once
these drivers become modules.

ERROR: modpost: "board_be_handler" [drivers/bus/brcmstb_gisb.ko] undefined!

Let's just export it.

Signed-off-by: Wang Haojun <wanghaojun@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 arch/mips/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6f07362de5ce..409bcc755b89 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -104,6 +104,7 @@ extern void tlb_do_page_fault_0(void);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
+EXPORT_SYMBOL_GPL(board_be_handler);
 void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
-- 
2.27.0

