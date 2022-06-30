Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90785624D2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiF3VGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiF3VG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 17:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72CFD4D4D1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656623187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgCRCs3Ju1LT1H7xrn3YHeQT3HJmnLyEcvVhogV2p8s=;
        b=ECuxXhbrqyFI5zdGzdeAdAmq/nJ4rf82GoY5/w57OlfMZ0IUcN/LbChWiq+HYTYJ3sRQ+J
        88Ler4yQzNzXYVFt60vEwOUyzliFtOW69iarSSmBBGtFNxA85MdNjGjXUjyjArrpCsoyYZ
        qY3cwWSQlI+/ymzCPw0dRqCI3Aqv/Zg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-0WRrzCuRPW6FGFA9KWM-wA-1; Thu, 30 Jun 2022 17:06:26 -0400
X-MC-Unique: 0WRrzCuRPW6FGFA9KWM-wA-1
Received: by mail-qv1-f70.google.com with SMTP id mr11-20020a056214348b00b004705c0cb439so648383qvb.19
        for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2022 14:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgCRCs3Ju1LT1H7xrn3YHeQT3HJmnLyEcvVhogV2p8s=;
        b=eexo90VvpZGTzVkVWh25aU5Mz9sI8mxGX0bvQBLK17rzfzxL4dS9/l9Xw9j5awSfdT
         9Qum2vyFBgmQXonpnwmvN2XKnZwzipspF8ycSTayTI1EnLzhlvmbyYO53LSSus5Q5FhP
         X/aa8epMzxoC13IQYf5s6i8W3E+b/X4mtaj4rd+8wvXcvTaGzK3Znt3kw+GfJBbv67gl
         686biyMSJQCQPlez9njc88aF+PC/1u/TwHy8DQGLUE6pi1xGe2nKvlnc7k1vNwkuL3VT
         eMLSAGLhNJvagdL0d4R0HzMam1ykCCYoxvHfw53CtFI23HGUg7QOjeu/H9bcRY/5Uvud
         N0eA==
X-Gm-Message-State: AJIora93TOY28P08xuwCu6rPzFkmraLbNM9OLw4jMHv9+TMHf5jDqSzu
        hWz51GwcPNqmW6FwfgdfLn0OICp1XMesii/aYhZ5oGB6NvAvkt1jcjBtrQxQclLHuEK8NG2ET5/
        aJiv7yb4AUAosKti7RPkd
X-Received: by 2002:a05:620a:2903:b0:6af:41a4:3f71 with SMTP id m3-20020a05620a290300b006af41a43f71mr8265241qkp.350.1656623185645;
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWq9ez6tSed5y9DzhsOiLl8H6BjGzMp//FKEqb9RaQrfBysTvAYMxg4p2bdggmgxJctN+7+w==
X-Received: by 2002:a05:620a:2903:b0:6af:41a4:3f71 with SMTP id m3-20020a05620a290300b006af41a43f71mr8265219qkp.350.1656623185408;
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v123-20020a379381000000b006a6c230f5e0sm7703164qkd.31.2022.06.30.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:06:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, jdmason@kudzu.us
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] PCI: endpoint: reduce several globals to statics
Date:   Thu, 30 Jun 2022 17:05:17 -0400
Message-Id: <20220630210517.1825677-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sparse reports
drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol 'pci_space' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol 'pci_read' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol 'pci_write' was not declared. Should it be static?
drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol 'vpci_ops' was not declared. Should it be static?

These functions and variables are only used in pci-epf-vntb.c, so their storage
class specifiers should be static.

Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2 : Change commit prefix

---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..6f0775b1fec3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 
 #define VPCI_BUS_NUM 0x10
 
-uint32_t pci_space[] = {
+static uint32_t pci_space[] = {
 	(VNTB_VID | (VNTB_PID << 16)),	//DeviceID, Vendor ID
 	0,		// status, Command
 	0xffffffff,	// Class code, subclass, prog if, revision id
@@ -972,7 +972,7 @@ uint32_t pci_space[] = {
 	0,		//Max Lat, Min Gnt, interrupt pin, interrupt line
 };
 
-int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	if (devfn == 0) {
 		memcpy(val, ((uint8_t *)pci_space) + where, size);
@@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *
 	return -1;
 }
 
-int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	return 0;
 }
 
-struct pci_ops vpci_ops = {
+static struct pci_ops vpci_ops = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
2.27.0

