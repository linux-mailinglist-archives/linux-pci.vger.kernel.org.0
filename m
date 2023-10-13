Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AA7C7C40
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 05:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJMDmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjJMDmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 23:42:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043CC9;
        Thu, 12 Oct 2023 20:42:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d2441b95so1236725b3a.1;
        Thu, 12 Oct 2023 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697168560; x=1697773360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSXJVHcIqJQWuT8bUgk/SrL2Zyf6P1bvJGKGaE142DQ=;
        b=PnyTy/HsK/imxVv7lwI5+FA3H3Hofjt1/+WLH62P3RyikuUo2frtvF2dsMROhkeH8J
         xT/MWKNyRrKaFaBq6ZDaCZThD12kBy+OiahOB6TOYkslhEMyD1mbOhdPdIPjAYujb5J3
         YJ7kEI07qWupLwdyrGdEqR/OFPTkA+UCCzpM5z7QQT84Wnfvu/7amfrjnfhE8cl7ZYfh
         LxYsalP/VNwyfPdfdEaSU8fwKdGC2KiQQOI8dy0yAP4E+1pOskrzCLd1F43hudQ6ZFX0
         RRjx1bUE8JqVVh2Am4AVi1fdQzF0IszYrr7i6WRaDJzkCE4r5JqpwflDl29yGo4sTl8l
         RRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168560; x=1697773360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSXJVHcIqJQWuT8bUgk/SrL2Zyf6P1bvJGKGaE142DQ=;
        b=FEPQynJq9m7x9SsuW+eEj5lNwwFOGl2XHMSOinYPN0AmiMk9fak5MFakTYV+qX/YM+
         8KuJyxPrqPGM6kb43yZkiHZLvBqfwMoRGH/l5PmPzwjY2RfhVfKxO9cjWwkoFeg78xtB
         dY78msA8vp0YP6LvM2jR9ybtOqJiZ9txf8Zc1feuUq6ap04ixD+LSinBY1psETeCVsPu
         edKcLzTnolrq3oztaey5NADj1YCyzJcYRWZvwKuY9JmqcqwpluWcuh+PSiq1fFKGfqN8
         3A9FXEtDbtxdtLg7fgESZghUzXOsW1StaJ1heW2aCfGK6H3KE6QlzEjQrDanQFTWL6N9
         m75g==
X-Gm-Message-State: AOJu0Yyy9bil+yaIuGTpNxwxHtuhDzGOULxlrBeqg9LPiA/tmMYwBiH8
        j0iMuvZOArB1t6ik/nB8H8w=
X-Google-Smtp-Source: AGHT+IG+gUlE9BKcgbqCMwdTos/IP3d6vpyqOsE1mqHpmwe/VaN+o4KIm3FDw9B6jxuMiVMBItEfig==
X-Received: by 2002:a05:6a00:1791:b0:68f:ce6a:8685 with SMTP id s17-20020a056a00179100b0068fce6a8685mr37753840pfg.14.1697168560615;
        Thu, 12 Oct 2023 20:42:40 -0700 (PDT)
Received: from toolbox.wdc.com (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b006933ea28070sm13045834pfo.12.2023.10.12.20.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:42:40 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 3/3] PCI/DOE: Allow enabling DOE without CXL
Date:   Fri, 13 Oct 2023 13:41:58 +1000
Message-Id: <20231013034158.2745127-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013034158.2745127-1-alistair.francis@wdc.com>
References: <20231013034158.2745127-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v9:
 - No changes
v8:
 - No changes
v7:
 - Initial patch

 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e9ae66cc4189..672a1f5178c6 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -117,7 +117,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.40.1

