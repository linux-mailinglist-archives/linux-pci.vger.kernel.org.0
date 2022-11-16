Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5B62CD30
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPVxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKPVxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:53:38 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170F2DE
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 13:53:36 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id s206so20127785oie.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 13:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXIZUSsOu4xgxe2RpVPhJt7UpgTzTJwfMrGR6UJjjOg=;
        b=5NmA1+/WHKnXtj5Ftsb2opp4uq28LXfG2cc1eTf/lWbuQSGqLHCdGod4OdgwvSsHYk
         X9vckY1Av9JZX+oB19ms5KuLeNVsMwOIXVxqlcfI2gucuuBFfqZHO/1STULk4VBDAL1N
         Z0/6Z8qyThasNG7LqCDskkganCw7iDAHRYKNQeyQ+fH140Ro68X65h5C8ZbbRwMgR+ek
         0UiTNfc5yGtUdYDWY9J1Jpt0rmxamvmJT8ZYwQwpibJlqxevbLXx+OrzUBg4nm1UMIU/
         TOmrZRZRlz43kHdoBwo+nBEonPjbPKcgdyMX6sd6Tt8up+fe9y88Kg8bOuYLeuBeKs6i
         yh8A==
X-Gm-Message-State: ANoB5pmlntVZehT7rOgQGfbY9kfWXNRYjGnkoAiLMI7WM/lmITPwvARj
        ric+FW41ca7l5UbFz6o+iw==
X-Google-Smtp-Source: AA0mqf4p2fOiRTHIL4rFZ0fb7QQpgE/yq/JHIJbXmNbEC1cA7wuQr52LWis5ddPM576I7JogAuL6Ew==
X-Received: by 2002:a05:6808:1b0c:b0:359:fb95:6ea9 with SMTP id bx12-20020a0568081b0c00b00359fb956ea9mr2570337oib.39.1668635615493;
        Wed, 16 Nov 2022 13:53:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p30-20020a056870569e00b0012b298699dbsm7904695oao.1.2022.11.16.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:53:34 -0800 (PST)
Received: (nullmailer pid 1035492 invoked by uid 1000);
        Wed, 16 Nov 2022 21:53:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Include PCI bindings in host bridge entry
Date:   Wed, 16 Nov 2022 15:53:37 -0600
Message-Id: <20221116215337.1032890-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Almost all PCI bindings are controller bindings, so the PCI bindings should
be listed under the host bridge and endpoint entry.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I left the entry under PCI subsystem though just about anything common 
should end up going to dtschema rather than the kernel. So we could 
remove it if Bjorn prefers.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c379db61b800..86fe870c3697 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15930,6 +15930,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
+F:	Documentation/devicetree/bindings/pci/
 F:	drivers/pci/controller/
 F:	drivers/pci/pci-bridge-emul.c
 F:	drivers/pci/pci-bridge-emul.h
-- 
2.35.1

