Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7C7A997F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjIUSP2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIUSPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:15:01 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D4884BD;
        Thu, 21 Sep 2023 10:39:14 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59c0442a359so15400667b3.0;
        Thu, 21 Sep 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317953; x=1695922753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1F+jNn4p2YFYWnyRLpXhofZQpKLhDAtPlwv/PrP4WI=;
        b=H0ivDVGLZ79q0aLnFpwiEeAAEEUUWflb8Ah/Xysl9WQ/0gc6IuHUuyZWGMEeiKaive
         GfdMS0KYesiM0LBArEnDShfy5Dm4DkjfynAtPKtCsXUQG5abkB3R5/RrdYgtePJ4y7OG
         zf3fCC6oXa7PalM+vcECQ8kx7uzkciFQXvjklD4pNDh5RL6PR8tBLyh1rDX2tz4J1a36
         3YMqqi+9ewHFarkWLv5y80On08yNRJT6F6aVLl4TDEUbkoduC6oFbqYZ4Wite5aysROQ
         y2MRfL6Lr0jKSK6UbSR9v5hFs/fr/a1yc4hkcciaaxEIpcfSmsgnjEy3N/Bv+EdkWuB5
         7rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317953; x=1695922753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1F+jNn4p2YFYWnyRLpXhofZQpKLhDAtPlwv/PrP4WI=;
        b=BUmppY0Xah5LyQrhmwmhVAfQsODbT7qAdbFFbsT64YEz4O9+8Wq4o1Yn+ElIZJSzxY
         ZE16fZdF9vtvo9WJNeHc1R0mCPWxi1oLFMa0cyUY17CnqfeNe/lLZzSVs+N6sxGh8dsD
         E1y9KQ3Vps2jJ3MZcPRKB02ILWfRCtx87anD2Bx6Jw0k28j2sStRfULH3362Np3R+Zjk
         ksyYgAzUJiNiMYxxMIxKePiDt+EzrM/8haOfHnUUhd/+AZqqT6r1ndTVXEktIeWyxmdx
         /cah79wRSt7bCNQefi6Ngwd30M+3OWtTiBISccXwBNBHXrWBRP6Jl3GGdGcVaJ7zAUmC
         dYVQ==
X-Gm-Message-State: AOJu0YxkPKKkAO2ryOKM8keCwXA9SZLbmwBqkluQDh/f6RGzXuYD54Wm
        abkq6MlD9xRR8juQkGHqqMqykjj145675u2I
X-Google-Smtp-Source: AGHT+IEex6NSKgWXUjJK9NtDKEBemVHgyoAvkJToFZZV4i38mLrQmkXb+UjR3aIEY0G94D6xXHU65Q==
X-Received: by 2002:a05:6a21:7795:b0:15d:42d5:6cc1 with SMTP id bd21-20020a056a21779500b0015d42d56cc1mr717960pzc.33.1695275776544;
        Wed, 20 Sep 2023 22:56:16 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001adf6b21c77sm502841plb.107.2023.09.20.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 22:56:16 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 3/3] PCI/DOE: Allow enabling DOE without CXL
Date:   Thu, 21 Sep 2023 15:55:31 +1000
Message-ID: <20230921055531.2028834-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921055531.2028834-1-alistair.francis@wdc.com>
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
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
2.41.0

