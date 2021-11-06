Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54717446FA5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhKFR7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhKFR7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:59:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867BAC061570;
        Sat,  6 Nov 2021 10:56:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ee33so44988457edb.8;
        Sat, 06 Nov 2021 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVNgp650gA6Ms7xDttu+x/dbokUGCCpvHvXoQbmsXx4=;
        b=PRVM79vsK7ZtX6av9dL7ybwaaaS5qpuLQXNlP0HEKB7cFYCSQvIjhuOKIEfBJp2oLW
         lrPNlKhHg0jxE+QfckdTIyCHWjM6ZL1HySVG+XBaEoUU8FtCDEgkmW368hLxML1IPolv
         0ZfSWPI2B94hYDyBOTLZlPbgrJXYyBisOf7+cB4wqozDegQaP7qPxuuz6tuOt0oDGYq7
         0DVP8oTPegOtkTWwAO2pzs+kclapjMyU5fu98mo/F89CO0TTSN9kSPA4RXMF9KxWY2EY
         EmxMFOXJcal5sqrlNl/gTglKZRSZLs5T+/odOs4y2GCWadTUe/kKWYWc10USZS3ZuKiQ
         bUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVNgp650gA6Ms7xDttu+x/dbokUGCCpvHvXoQbmsXx4=;
        b=jxZG78Hu15sPm8eAznR17S3NKHhIZbOwfqv9b8j1uwf3Z873xqTWU/95jYvzme1hI0
         e7JFTOa4Huj+YAnt43DGT86qTDFg3+i/NKMkdgNsNBVDj3JiRQvAqhIF34wZ6teQ0Mbz
         1Kc/mce6Cn8TQPDtlG2WUYoAevjYlhFLJNIMNWUXsjK+ZmRyJmZ6pRvCg6BqNKmBtFXK
         sUz3DqTGQMXkXaNNS2qDMvWllqsnpqRKhZ5jEms6LWo6gwLlsBzcPmQZsT8tZd4dpRGl
         LY0oxGC/6qTIr9rZnQqOfo2Zr77Rldse7hr1CEOIkQDLy0b/RXKNBMJp7wknSFW2CPyB
         GPgg==
X-Gm-Message-State: AOAM531+b76gjESPhl0RvbdhzdbcezLozmXMbb1Pz2MuhgyZ5EelkX53
        5/BLIjolzpfxYeKrI8eeKUw+9fHRU7o=
X-Google-Smtp-Source: ABdhPJxE/sm4JUdbzwPUXvy9UHLpaFnDcnsOPmN4KlsbmwKriI/7Vpdg2cA2+R/n0gS9+XenRh+3uQ==
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr83206085eje.218.1636221384195;
        Sat, 06 Nov 2021 10:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id z2sm5802224ejb.41.2021.11.06.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:56:23 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Keep insane devices disabled
Date:   Sat,  6 Nov 2021 18:56:19 +0100
Message-Id: <20211106175621.28250-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The patches fix issues that allow enabling both CLKPM and ASPM on
devices that failed pcie_aspm_sanity_check().


MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'

Saheed O. Bolarinwa (2):
  PCI/ASPM: Never enable ASPM for insane devices
  PCI/ASPM: Never enable CLKPM for insane devices

 drivers/pci/pcie/aspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

