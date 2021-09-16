Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4EA40D51B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhIPIxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIPIxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:53:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D2C061574;
        Thu, 16 Sep 2021 01:52:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so13939367edv.13;
        Thu, 16 Sep 2021 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxWwwXaPtwzixrTvfV1r3DRbHfKM5D2dTw0M8rpmnPY=;
        b=mEdyFAlsg0ymfoR3fwHqBitnOcRVHfsX57UH/NOESZ0BThMDh/XUVh2ZK3XufQmydh
         l2NZHDotBMQFVBlaji4G0IGapldaoDCLOS3RqDvC3nfr0D7xJoEYHWsbsfM7aAoKTo2I
         ty+4IKwqUULbj4sMWA4/fZ5AzWCRU6Tobm7EOWfhEMhHwK6IDlqxflqByh++SEGgi0zB
         i2WUKjPRWA38wk4M8ZX64gfpFcC6ftPLYOAq1DConnkC80NBi/AJAhCY8Lo0rvsUn379
         bn8TFyZi8V+lKu0F3w8kdNrq3PgGSGlSx8hfItJ1pHgn958ZlLIA+N3sB8MFa+5CTCLR
         wtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xxWwwXaPtwzixrTvfV1r3DRbHfKM5D2dTw0M8rpmnPY=;
        b=ajDL61L/0eLlwVE891l8Zj6LVp8Am67zNLdbVJLD/UiONkJAjPlczJbbRyb6ebAkre
         U2wrz8oKkyYNY8U+1X6zXAwBoZAPpjP50pZDpkHriueF7t7iFOlqGm9CJfEbksbwm3aY
         ObHtyDYnNlhn/gz4yxxSGnk6mjs7gI2Bx2LBqjEW6LG1paZHtXWS+C+btVRWOQRUtMaz
         dAqa4VaUQsuPRq5wnZywCLC1lu71aX2aSTrKVdTVFw4PSjsrUICuzdUIKdBBtzjNVU9w
         uyDC58/fJ/8xwD4Npth0fobGvDS/R2coqMbO24QqUB4z00usO1SQjcgb7uCT0FWKWcdh
         3Qfg==
X-Gm-Message-State: AOAM530oviuh95mYTpUBGMJEOF4Nq94OifC3ckahoKsW0/d/QSMyX8Ft
        nXyQUb6pKFNiIN7cTE94lDL0J3vpvx8Lsg==
X-Google-Smtp-Source: ABdhPJyQvZuZNGsMPNbOZX1r8OE9RMP6c92Zf5N24D0TH1SP8H37hvejDLHSmu3d9oZy4/BSM7vIKw==
X-Received: by 2002:a17:906:ae9b:: with SMTP id md27mr5010598ejb.380.1631782329996;
        Thu, 16 Sep 2021 01:52:09 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id t24sm1112961edr.84.2021.09.16.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:52:09 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 0/3] PCI/ASPM: Remove unncessary linked list in aspm.c
Date:   Thu, 16 Sep 2021 10:52:02 +0200
Message-Id: <20210916085206.2268-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

An extra linked list is created inside aspm.c to keep track of devices
on which the link state was enabled. However, it is possible to access
them via existing device lists.

This series remove the extra linked list and other related members of
the struct pcie_link_state: `root`, `parent` and `downstream`. All these
are now either calculated or obtained directly when needed.

Bolarinwa O. Saheed (4):
  PCI/ASPM: Remove struct pcie_link_state.parent
  PCI/ASPM: Remove struct pcie_link_state.root
  PCI/ASPM: Remove struct pcie_link_state.downstream
  PCI/ASPM: Remove unncessary linked list defined within aspm.c

 drivers/pci/pcie/aspm.c | 121 +++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 57 deletions(-)

-- 
2.20.1

