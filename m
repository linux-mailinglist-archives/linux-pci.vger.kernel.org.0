Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB9708E7A
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjESD4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESD4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 23:56:44 -0400
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 20:56:02 PDT
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1CE75
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1684468561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mUAOOvuJ71E7a8sz5yk0mrvRi53ftsjgLeuc9agjm50=;
        b=Y7EKG+0YRqFO6NLjSdaRvHZbFDkipn57iDx1IrkAven6a4CdcKeiODL6MY8Vt/M0U0EsHj
        iry4p7Mi2Hiatf2VqJnfvnJSbIHbihX45JGGMNV8FWJOTqh7AdPoKXILCuXA8pvDs2ambz
        u0vUXOb0f8TUEySXySyudciIBvs3H2S5efvOXV8jpJNIpT5RJU59utZzUMqEhEyl+Tb6MS
        jdKFJ4t0MZ+Z2qLYRcjzQhYT1zRXx83BAF3zfkxmtL1vrEW5Rna7ZW4aSTGYE6Ltcz9trY
        fEiIzTf9tqfN6o/9utWI8xX20o83hWd06G0OcHogVliIZETWMyJjyBNWsenIUQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-328-d_ORvbF9PZ6B45mPdvOi6A-1; Thu, 18 May 2023 23:54:40 -0400
X-MC-Unique: d_ORvbF9PZ6B45mPdvOi6A-1
Received: from sgsxdev002.isng.phoenix.local (10.226.81.112) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Thu, 18 May 2023 20:54:36 -0700
From:   Zhu YiXin <yzhu@maxlinear.com>
To:     <lchuanhua@maxlinear.com>, <torvalds@linux-foundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream_support@maxlinear.com>, Zhu YiXin <yzhu@maxlinear.com>
Subject: [PATCH] MAINTAINERS: Update entry for PCIe driver for Intel LGM GW SoC
Date:   Fri, 19 May 2023 11:54:24 +0800
Message-ID: <20230519035424.53069-1-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rahul Tanwar is no longer at Maxlinear, so update the MAINTAINER's entry
for the PCIe driver for Intel LGM GW SoC.

Added group email address for support purpose.

Signed-off-by: Zhu YiXin <yzhu@maxlinear.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d274efff10..b97bdbcaf4e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16383,8 +16383,9 @@ F:=09Documentation/devicetree/bindings/pci/intel,ke=
embay-pcie*
 F:=09drivers/pci/controller/dwc/pcie-keembay.c
=20
 PCIE DRIVER FOR INTEL LGM GW SOC
-M:=09Rahul Tanwar <rtanwar@maxlinear.com>
+M:=09Chuanhua Lei <lchuanhua@maxlinear.com>
 L:=09linux-pci@vger.kernel.org
+L:=09upstream_support@maxlinear.com
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 F:=09drivers/pci/controller/dwc/pcie-intel-gw.c
--=20
2.17.1

