Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C2591609
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 21:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiHLTmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiHLTmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 15:42:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710BB2855
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 12:42:07 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a4so1521163qto.10
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=ne8tXHS9XvFbtCPNTt4EzOKXPeOXPayChGUIi0O59otgNNRh9hOvuyIoWuZorZKyHv
         Cx7+EyMWJXUQcAOT2DLbJsV63zOs/uLKTtN6cHa40wFglhAzDCSreSR6Xx+drHLTj6qb
         BUGGbbVEu0laNe60mMgy58Av1pISjznYnbJc0h5u8JmQsbDCnAcKSnLf38ain7txGs0a
         VDYQbllmvWLlM8/h0GugU3g+t3LDl3SXlI71LigR8HWnMlkwY4Pp4I2IOB5GHCVV2oZa
         RUaoCvK9oVpjStRCUI4bRnQoPUgE8KjnUszbC7Ft8jNHedvdtrC7Nd4N4wTdzuofOeK/
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=GGldvnZ/lghJEGmDowPCuKmE+4ywyQ+KorjvFe3JDfUtRwGEn2vFdblw6M/bUIKOqC
         u4QCK2jclp4EAl0h/l2L9qUvriBYkO19SwGI2CAltxF76Q7OoKZFriaLco/Y9MX2tToZ
         dffokhnbpfLURH5NT+eZLqK4mqATPxqJKrH60rSdVYz+UrofmCX2Pn1IDp/sXpUlFs3k
         j1JQVIIGYMr7DrVQerpHorxXUrXR0BTfj4dZgH8tbv0SUKckoUFkCxuFO3VOcJt0I6vE
         wf+QMX0ywPe/Ysu0ckL5AJTSJKdUvPEbTx3fR6lNuy0YcQXFREWBmOjvOvfdC1WX+2Ln
         3Chw==
X-Gm-Message-State: ACgBeo0BjHw+uDKDdN+XaXcDRPZAd2uKnhHbMXfsIFl4VXUsevJ9eSMQ
        aLyhBpTZnSaah9aRjvwi0H+PcU5f95uynkjsDSI=
X-Google-Smtp-Source: AA6agR7KSWAqy9lWStTxVCzxXSLzRWMvDTYS2r4i3Gl1z15R1bxmL/BA95zCBx68zG4qMYnlsxLpeg==
X-Received: by 2002:ac8:5793:0:b0:342:ea28:742f with SMTP id v19-20020ac85793000000b00342ea28742fmr5017715qta.177.1660333326262;
        Fri, 12 Aug 2022 12:42:06 -0700 (PDT)
Received: from localhost ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id m20-20020ac84454000000b00342fc6a8e25sm2213257qtn.50.2022.08.12.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 12:42:05 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
To:     ntb@lists.linux.dev
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Date:   Fri, 12 Aug 2022 15:42:05 -0400
Message-Id: <20220812194205.388967-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
there to allow for notification of changes for it.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..47e9f86bd712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
+F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
 F:	tools/testing/selftests/ntb/
-- 
2.30.2

