Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04801708EFA
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 06:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjESEsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 00:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjESEr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 00:47:59 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48A10EF
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1684471630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6wpbLqFlaeJI5g0d9AKBZ9EuyUo9hDFrgG33AHlBHc=;
        b=U40vs4kibc3nj+ZYNGzwRcoi2T8bbTYnsuArr+oDHNc8sugXvu/K2Ie7/welNi/LUbkHhm
        FgtULmQHx3NOyVeGXR/OBBYJxBY0oG9ea2bL252nRdbSq1kRxtIePLSdUdFOS4YoGOB3JP
        +3+lA12+BU4SNRWGqPuwvluTwvofTU32WuvZKyI89BrMOr/CAXzh2YivNZakOcpUCLezkK
        sQzpuyv8bfq0F92djATZGdkTC5DzlPi08ukMacwmc6lgDXrnxDX/YKBx8oIrJ1q85PQ0nw
        XOAeyqlpSCLpplStzacusHHvKPA1JYE4OJEZED/WSitGCsbZYwN70HwgzoldsA==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-43--Ng_9YZuPDSvpiAB1RdjYQ-1; Fri, 19 May 2023 00:46:05 -0400
X-MC-Unique: -Ng_9YZuPDSvpiAB1RdjYQ-1
Received: from sgsxdev002.isng.phoenix.local (10.226.81.112) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.34;
 Thu, 18 May 2023 21:46:02 -0700
From:   Zhu YiXin <yzhu@maxlinear.com>
To:     <lchuanhua@maxlinear.com>, <torvalds@linux-foundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pliem@maxlinear.com>, <qwu@maxlinear.com>, <yzhu@maxlinear.com>
Subject: [PATCH v2 1/1] MAINTAINERS: Update entry for PCIe driver for Intel LGM GW SoC
Date:   Fri, 19 May 2023 12:45:55 +0800
Message-ID: <20230519044555.3750-2-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519044555.3750-1-yzhu@maxlinear.com>
References: <20230519044555.3750-1-yzhu@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rahul Tanwar is no longer at Maxlinear, so update the MAINTAINER's entry
for the PCIe driver for Intel LGM GW SoC.

Signed-off-by: Zhu YiXin <yzhu@maxlinear.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d274efff10..6091bbb0e1d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16383,7 +16383,7 @@ F:=09Documentation/devicetree/bindings/pci/intel,ke=
embay-pcie*
 F:=09drivers/pci/controller/dwc/pcie-keembay.c
=20
 PCIE DRIVER FOR INTEL LGM GW SOC
-M:=09Rahul Tanwar <rtanwar@maxlinear.com>
+M:=09Chuanhua Lei <lchuanhua@maxlinear.com>
 L:=09linux-pci@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
--=20
2.17.1

