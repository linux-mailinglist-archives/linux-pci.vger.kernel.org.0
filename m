Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030E33EC4E6
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhHNUMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 16:12:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F57C061764;
        Sat, 14 Aug 2021 13:12:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nt11so20455378pjb.2;
        Sat, 14 Aug 2021 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FeRiprFlpPVzPCtA8RRkEVykyAMT4IjUsIViSG345yQ=;
        b=u/GfAISJYwg1MyajSONuDvq48noQQQYe/yRqSD8ziV+3q4eJ0H4KJ4KxsvgzDt4bQ9
         dVidgglWcRDrV+TTZb2N95fFjy8IqQScnOZboiAJbRy8aOsXT1rv7eC7WE6w/hiJdc47
         IYhjSGixssCy93FNCx1OXGrC/AKdOAbcruviR7+PeUKwj1nYg2YvTVSWk4pGJ1dUybKB
         BoOfX5oI2vg1bsc0iKK73H/RJnLHYt0NKwAwxs8LDKG4xwTprtcdj41ds7o2no5o576y
         MYb6Mo+Lv6cbLTkXJCbmpvKFKqjOFtdxHiPALWBbXfuMywXuIFUkOT4t1n56i4CwtgUp
         1p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FeRiprFlpPVzPCtA8RRkEVykyAMT4IjUsIViSG345yQ=;
        b=EeKIeub95VynmSG5Rk7jchMtjdG7JC0Lyb0wwgdpHgzXeB+AoJnQTYoMjm/6XJLNmr
         K9hWuN/MUxVUK9m0N9WJ2Q8usQKqbo19TjerIlKtpWV2u5pOM0DXM/xginnekdcu7YHD
         3OkxxsmGRwTJGjf8wo7UTItF5waTuKAsU2+F4+DWzuww1lIH8/00pms0gdT7fihPF8KJ
         1bqgX2yz9gVz9RSHTakjr+I/eeG2dDeeKiYQmwsU2cMQjFRjDX7ZZIaLjwZtxWL+ua4Q
         dtJmhxnUDBQb0TQ1vFSCS5IloZYCXlxb7PizlxjRGpjGt67UM9QBFTL9wJvNolpAFJJT
         k3sw==
X-Gm-Message-State: AOAM532IRrWEszEE/vf8wVxwqdTeqJw320TjdbB0rq/9wJodb20f2mTb
        xDGT4ez9h7xTlAhCoTMCfA7jFlBsipGmOA==
X-Google-Smtp-Source: ABdhPJxp3w3FelmnYJ8i9OLiKe4sZ9EowDPx3NWLv3+lHAVyBg84TuyeA7+pBt8brY6U08Tl5V/txg==
X-Received: by 2002:a62:bd15:0:b029:31c:a584:5f97 with SMTP id a21-20020a62bd150000b029031ca5845f97mr8451346pff.33.1628971941445;
        Sat, 14 Aug 2021 13:12:21 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r14sm6511132pff.106.2021.08.14.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:12:21 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shuah Khan <skhan@foundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix checkpatch.pl WARNINGS
Date:   Sun, 15 Aug 2021 01:42:03 +0530
Message-Id: <cover.1628957100.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
	This patch series fixes checkpatch.pl WARNINGS in slot.c
This patch series will apply cleanly on pci-v5.14-changes

Aakash Hemadri (4):
  PCI: Missing blank line after declarations
  PCI: Symbolic permissions 'S_IRUGO' are not preferred
  PCI: Prefer IS_ENABLED(CONFIG_HOTPLUG_PCI)
  PCI: No space before tabs

 drivers/pci/slot.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.32.0

