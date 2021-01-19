Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC372FB87F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbhASMye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390486AbhASK3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 05:29:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC6C061574;
        Tue, 19 Jan 2021 02:28:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so20858483edt.7;
        Tue, 19 Jan 2021 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u2cSE5gzOSboyKKHV6qDmFGcut766K9jeXFzEL5Z9Xw=;
        b=r8qYUH+yluFJ/lI86JF2H7eXiRN9zU0ALHzTEcz0W39Usx0LvnTnrD0uAewx9FToBa
         v0DSSjqZOkCtBfORChdrcBIefKVm0mISUCSxjYpoJHs6AlU1BenrtYK8ArGgI1sBzrx1
         k2DYTGiWPls0ZPCBdmbycY6kLkh98Wszs9M5FnUfXcRfrG3y5N3H/VhRNxUTmRaRLBPD
         Nl6iz5C1FH+0z4Of3IQdngQFDwBVIPAXRxDcWG3beAx1hsjFIrlXmiy20ZHx6myTcmgt
         /pyGtX6kHrGOPtDpqHzEYzfZvruNB3MwuQkyn1ajQI11ynlwJm00ulMgEguEITWQ2AT3
         51sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u2cSE5gzOSboyKKHV6qDmFGcut766K9jeXFzEL5Z9Xw=;
        b=pQ7KhFn4MeQ24CihxIKVuWdYliowW8iMHLKrtKe9TjWz4nockkzc6j4XmNEhCqpotC
         QANubtDPPRZSpI2s6vf8vHFGHB7TKD+J4v1JsdXNrUhEetEaxH1s44iemXFrhbYrSDn8
         mzMRkRLUFFKfA98LxNKvIML7HWq+je0pONVbMdlLkTZxgkyLKmQtJMkfZ4DYY1msl55E
         2vQGbfJXZqa2xSk5B/A55yrE6nfpYSsseGthzI6tdAfYVKLHHTi8sMQ6V39vptcQk5uu
         TO28ua0GcmF02sOLL9qK9QODDen8jQ2B9cWR2akva+si8AY3y7SnIdVF5l3gUlNC+P/e
         +JBA==
X-Gm-Message-State: AOAM532I2IUnQTr0ASkgEp+oOyuhw6WOSrAZ8KN5mGNFiCZSFASsn8zK
        k3fd2/xqKuV3KNVeSZETXOc=
X-Google-Smtp-Source: ABdhPJxejS+EvHlsI5+6icC3b3jje7rF8TtMh/18N7XpsWWJIKztxs0EOOlgQCM2ZR8nTjK85fUhwQ==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr2896943edc.371.1611052099285;
        Tue, 19 Jan 2021 02:28:19 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-140-34.net.vodafone.it. [109.118.140.34])
        by smtp.gmail.com with ESMTPSA id x6sm8961627ejw.69.2021.01.19.02.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:28:18 -0800 (PST)
From:   Daniele Palmas <dnlplm@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 1/1] PCI: add Telit Vendor ID
Date:   Tue, 19 Jan 2021 11:27:57 +0100
Message-Id: <20210119102757.2395-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Telit Vendor ID to pci_ids.h

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
Reference: https://pcisig.com/membership/member-companies?combine=telit
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d8156a5dbee8..b10a04783287 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2590,6 +2590,8 @@
 
 #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
 
+#define PCI_VENDOR_ID_TELIT		0x1c5d
+
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
 
-- 
2.17.1

