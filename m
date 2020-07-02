Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742221295D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgGBQ17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGBQ16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 12:27:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED1C08C5C1;
        Thu,  2 Jul 2020 09:27:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so30433289ejb.11;
        Thu, 02 Jul 2020 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ydp9/rU211lINbmBkt/cllc/mf44bjuJCoHAfHA0Usw=;
        b=NpRCh9SJGTiDFzw976qg02+hqOhYWf+XOI/6BLfShND0LJxS0bfC/2/QO3HuTCpe2b
         cwRFLlz+beisVl4G4BtwmAmKg9Azu8gKhppUCoBBuH8FlXytLMhVi2FlmUqWq4ifOH6P
         d1H/fEJHoxb2Hxj4NlihsIVGAW3WiKNIKKLqP6yCs6fxRY4LaCgv0pPxnksAcaio1vbt
         zEguDv0OrAy/Ss2rxaKVDbkWrOf0rIneQi1GjJxFIqrYyDs+GFlXAPLZOg1FM5QsSD0T
         85T7KmPZdHkhpAvOrrkQcZT3k6wJ/tM8/0vhxrobltyu1tZRdHB8ruWMynZEKoSbZhmc
         iKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ydp9/rU211lINbmBkt/cllc/mf44bjuJCoHAfHA0Usw=;
        b=kvD/AllQGBsUhoTTuDIZAR8TrmlUrj2dAmLkLmQyTl37sZvTlPv+D/PlXDwphlcbRk
         xYyo71bJxx33dMRxKB+UyOzxW71ufFs1ds28ivF/qUo8QmLdL48f0qh5/xeLW1qA9+nC
         XtMXE+dojdGlNQ9pzGlIWDEFSXUwGNK9PmPL6oj5WYfkKxtKkCQyz8H4/96RK5y2vQww
         KjbBs1zaON9KmU23hvS8HdRXTLiAIXkmVZIcgWE7PPREiAzuBji2cDaBhCstcn1kBqoy
         EliP7DDoGF+Zb9pYbIpypsv6+ZdrOLfPMUEU4huxthomR1jHuLVYAUJUIVH+bdq3V78C
         EUNw==
X-Gm-Message-State: AOAM533laCZ/nMaLDST3npYddTRPWVJt7yP+Q877NlLWmq3v1hx/rMSo
        3ULBJmqHzLDdHfS7lD2th48=
X-Google-Smtp-Source: ABdhPJzQtHicFF0seQCfGlbg3UG2HV9198pH1/Tuaax7fnU1GnrRGuryMso/BkTgUyl5qDyVARjw+Q==
X-Received: by 2002:a17:907:72ca:: with SMTP id du10mr27949850ejc.78.1593707276841;
        Thu, 02 Jul 2020 09:27:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4932:71ef:3c73:a14f])
        by smtp.gmail.com with ESMTPSA id gu15sm7375188ejb.111.2020.07.02.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:27:56 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/3] pci: use anonymous 'enum' instead of 'enum pci_channel_state'
Date:   Thu,  2 Jul 2020 18:26:50 +0200
Message-Id: <20200702162651.49526-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
References: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For typechecking reasons, the typedef 'pci_channel_state_t'
should be used instead of the 'enum pci_channel_state'.

One simple way to enforce this is to remove the definition of
'enum pci_channel_state' and replace it by an anonymous 'enum'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ee85e89e8ed..adcee9e30bfa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -179,7 +179,7 @@ static inline const char *pci_power_name(pci_power_t state)
  */
 typedef unsigned int __bitwise pci_channel_state_t;
 
-enum pci_channel_state {
+enum {
 	/* I/O channel is in normal state */
 	pci_channel_io_normal = (__force pci_channel_state_t) 1,
 
-- 
2.27.0

