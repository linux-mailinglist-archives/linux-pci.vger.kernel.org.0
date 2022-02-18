Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136964BC2FA
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 00:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiBRXp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 18:45:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiBRXp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 18:45:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3B54BD7
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 15:45:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d17so3596829pfl.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fungible.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9dcpe70j9Trk9rKuKWmAu1MvnVHF87exvDoWtSGUqM=;
        b=izfsjtjHsgBrGj/HgT+90+NGOW2SCpYve/CDRyzzE70F6IiYAYgdiBY9Xw1PDE0KWf
         ArV6JKEbQN0Q3oA4CgY3P/VpkjT9tX0KpoeF3z5Blvi5LIRuoQzzGX7H4goP158WmnGk
         jjSomPs3lUieIujKxjUxu6WammqpqRRnCt07Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9dcpe70j9Trk9rKuKWmAu1MvnVHF87exvDoWtSGUqM=;
        b=6urN6Qi/0B0YSY1oW8/G6SpvtY5CgUdg5p5zEivgGY4jZGzv1cSqKWHNcGDgEUkWJn
         jYLazum2F9LWI3xbzb0e5iASmZt8yb8J6QH6Ip/RjUMvytSnbfFYTG85lvWH1Ohw2Hn5
         gUNM3aqT7tFw5ER6zGv/C9CS+ZNdWQSdnjgFt/16G53ccqyCW/cUplqWVyMKERYmqSmn
         sYuYmlAieGQRHA0Khfde9RXijkT/9n9IuVKiIvI4LvYrraapJ0xTJufOjFlAdpzg6NuR
         Wq3VIQRwDrtgO5rijBt7N0++3BPXSKE77pGIZzIF8opqjNLWSFWJGHx8gIepKWqFn058
         p1Rg==
X-Gm-Message-State: AOAM532YKjfT+IUbkLVo6sqbW3/NTil4TJN7TtemNdrdQwLVSpu1+4oj
        MIuDDoxTTndFIas16edISNEg/A==
X-Google-Smtp-Source: ABdhPJz4KxX9mxNmepaO9xMZbFoCSrG8byaEdenOFOn0ok+SuAUAeN5YAmCL3GDwMicfMNUldsgRgg==
X-Received: by 2002:a62:1881:0:b0:4e0:1b4c:36f8 with SMTP id 123-20020a621881000000b004e01b4c36f8mr10156028pfy.26.1645227940283;
        Fri, 18 Feb 2022 15:45:40 -0800 (PST)
Received: from cab09-qa-09.fungible.local ([12.190.10.11])
        by smtp.gmail.com with ESMTPSA id g126sm11723406pgc.31.2022.02.18.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:45:39 -0800 (PST)
From:   Dimitris Michailidis <d.michailidis@fungible.com>
X-Google-Original-From: Dimitris Michailidis <dmichail@fungible.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, d.michailidis@fungible.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH net-next v7 1/8] PCI: Add Fungible Vendor ID to pci_ids.h
Date:   Fri, 18 Feb 2022 15:45:29 -0800
Message-Id: <20220218234536.9810-2-dmichail@fungible.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218234536.9810-1-dmichail@fungible.com>
References: <20220218234536.9810-1-dmichail@fungible.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Dimitris Michailidis <dmichail@fungible.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c666407..c7e6f2043c7d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2561,6 +2561,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_FUNGIBLE		0x1dad
+
 #define PCI_VENDOR_ID_HXT		0x1dbf
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
-- 
2.25.1

