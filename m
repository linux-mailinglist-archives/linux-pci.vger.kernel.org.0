Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9B445D54
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhKEBgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhKEBgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 21:36:12 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF58C061714;
        Thu,  4 Nov 2021 18:33:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x10so5517672qta.6;
        Thu, 04 Nov 2021 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Isv4NdUPTT9r1IHH6rNW3Sw7/j4YRLSLaZpnJdhLCYk=;
        b=qSeOFOu2Xa+LDDt/MLqDZHQkGoXVMUQDSN8K0X5kWrbZVskDBNNbbXght0iGjvVNhf
         vBURinM2Dejbt5vKScPYQHmef44+k+1NC4CrDSnrgmqh1rlvnh6dnmDBg72Itk45B9kK
         V6r/hfRPSJaIUnTgJNTCfpUNt2LEL/i9lJ5CFDvJCa4UHOWJ+Y7urVN5ykPqSgO/EjbT
         GaDgWeld2p6k22IdYXjlexwQAJGpm2KZUQbJTU0neu4RVlcQWKiSAtrCRujN9UgNE5Ic
         YDfzFJ2iBjm7Ha26+lOJgjCDegTIZ7PPxnyMRYf1ad/AaDl+/JdxIY5CBhdZ3zicZpaE
         9eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Isv4NdUPTT9r1IHH6rNW3Sw7/j4YRLSLaZpnJdhLCYk=;
        b=0laScc47RkMMerrER239x+wWoGdmh1+ybumgfENgEbz4syPOLK9UGH3mYd31m087ue
         TQhF700QwXSe0msanHRctwxDwHysAdIzJAdNmaxwcTKmoyOWFNeQOkDDG1bbSHkA8snP
         Xe9UZwcg2BEnMp+3vmaHPbsYXn4tH8bL5wMwut6DA8UsnE5RtUvd1P9M7i8fv1BsysOE
         tfhV2xtwMaEsrSz0sSPGfES87g8xE03KSslU0G2Jx/VWTiq42GwGJBWXFwSIJ3c1WhiQ
         lU9YuYJ1QIajzs9J6LaS1rRq3cqV8ypDXKFFp9/lPuoWpilMqmlKdyiAqY7+xCoX2ugQ
         s8VQ==
X-Gm-Message-State: AOAM5325Y6j2NbFdg3sH2aHUCM6qM+vN2vdeTCwOIlLKLWVPGD91lLOg
        etU8gwyd2/UDhFjvbv8YneE=
X-Google-Smtp-Source: ABdhPJyeHmUSUd9vFde/KwbsQuqCynemMh3YYLPkWI3gm5FmMuSaHtiLXhmLsOvfYixXQrLbZvrB6Q==
X-Received: by 2002:a05:622a:38c:: with SMTP id j12mr58366551qtx.63.1636076012654;
        Thu, 04 Nov 2021 18:33:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 72sm4658501qkj.94.2021.11.04.18.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:33:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     nirmal.patel@linux.intel.com
Cc:     jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] PCI:vmd: remove duplicate include in vmd.c
Date:   Fri,  5 Nov 2021 01:33:21 +0000
Message-Id: <20211105013321.74364-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'linux/device.h' included in 'drivers/pci/controller/vmd.c'
 is duplicated.It is also included on the 13 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/pci/controller/vmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b48d9998e324..a45e8e59d3d4 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -10,7 +10,6 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
-- 
2.25.1

