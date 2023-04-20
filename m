Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385686E8E6A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjDTJpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjDTJou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 05:44:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E972B7;
        Thu, 20 Apr 2023 02:43:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-63b7b54642cso668970b3a.0;
        Thu, 20 Apr 2023 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681983817; x=1684575817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GL/FkQKGL/P5lWSjTq7c3Pg0SaQ1eNQckaMYnyh+DUk=;
        b=RhhzFDMKZ1kIqLGtozulZoedaUTHVms6wb7ySjjZL/ubfFgxvE0Gx0jC0mJUqdVEBt
         VWot2xAfxFc2dHWxMlcwBWGk38ZAb0/RmnJSJInmJeV5nVgo+2DqCuZjio543R/OFDLo
         1o0lyU+jTpPauvg2a22g928ZVIItgitUyJ1AKWdtaxMUY1lbHa0JsPsisdmEtHTFUV9L
         WVjvuanX6Syivyj1VKvYFwf16MlYl2w9SaigCfuQ9xQ/NxrYuc/tEMjVkpSfTMSK/pEE
         CRabIEBsaFWUt/w+RI6I36yNrxaqrr7xG3JFU8uxfsAW/EqWMM9z7+flucJv0yPWtcr4
         z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983817; x=1684575817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL/FkQKGL/P5lWSjTq7c3Pg0SaQ1eNQckaMYnyh+DUk=;
        b=QkWkkBetIIkD9U1f1uExW3Uu1rsJ0GJXuspsQq8QCs7V5Mnjbzhgb2xiJo2wUY5GzG
         hUASMZgUutiQxBNfE1GMKbc+NhblZVu1Idu+NwuaBw3k4WuIZpRaugaS/4cELltpqExX
         n358F/E9wVLzy7aXtEyrteGdQqn8feOvHMLhvHCZWK96QeNSVBC8Q27Pu9Wqy+xmtql9
         aSLW+O3gE0sDFRekLe6wWakIGYMzDKYV3jAdL9wLasEsNDAcBhUCJ9AekEFDQQWNHPPs
         6e17WuyVCF10mpG4D9JqKc/cXeX4QuVpikoF/BFffhKYYpg7LNy1bmc0hyR4i+dyJ5yh
         EJTQ==
X-Gm-Message-State: AAQBX9dMOH+g0t/AE3mNqhOxFdqo23wAcDVl0dhhRGWcGEr2adXwio7D
        zBXLHTCEjLFwluWWrJyf74r0cj4NyYV6Y7Fu
X-Google-Smtp-Source: AKy350agXIMzaDUBQ+NbW1h2m4IjePZmdznEitmY6vZEOJ2v+aRFxDaXT2nUm7/CTZEF5+eUe0EUkg==
X-Received: by 2002:a05:6a20:440f:b0:de:13c4:5529 with SMTP id ce15-20020a056a20440f00b000de13c45529mr1428465pzb.62.1681983816675;
        Thu, 20 Apr 2023 02:43:36 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id t1-20020a62d141000000b0063b8ce0e860sm874336pfl.21.2023.04.20.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:43:36 -0700 (PDT)
From:   korantwork@gmail.com
To:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: [PATCH v2 0/2] PCI: vmd: Fix two issues in VMD reported by Smatch
Date:   Thu, 20 Apr 2023 17:43:30 +0800
Message-Id: <20230420094332.1507900-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

Fix two issues when building kernel with Smatch check.

v1->v2:
According to Damien's suggestion, I split it from 1 patch to 2 different
patches. Change 'inconsistent indenting' patch's title from 'fix' to
'clean up'.

Xinghui Li (2):
  PCI: vmd: Fix one uninitialized symbol error reported by Smatch
  PCI: vmd: Clean up one inconsistent indenting warn reported by Smatch

 drivers/pci/controller/vmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.31.1

