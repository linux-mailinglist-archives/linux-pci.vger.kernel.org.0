Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268F3A8944
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFOTQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOTQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 15:16:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9735C061574;
        Tue, 15 Jun 2021 12:14:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so166161pfa.13;
        Tue, 15 Jun 2021 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eGDD0cu3Pgx6TFQsGNoZXQexAU8DmN7fTdJUtR4CrFE=;
        b=Ru5oPYe17Y10X6yOOlv2TbMeSn6j1B+/6NJr53yCf9arQsuSRCMO1ORb5RF49Y9Eap
         9v+MKzGyawQkOnl66xTAd5ju4zK4N2vAHHjJ9wFUexh/7g/oJp1Uj9zRcXl2wWMvvrJc
         1l+QCLQ/nqd5tonRRO0+jab82UgVhFF5y6ToAAJkzxJas0zfy4RiBOotd2JZofqoDIIN
         YNdZdIBipagewrO+AruYUgudLGWY1Bzn/jFsBE33KCsLUutH6zccvE6SsKGqB4njzGP1
         tQSIU+N79+WBFbGWDcxrJjaD/M8jE04vV7XucolbzvE0S1fvBy6d90VnehO40qLKnjoc
         8FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGDD0cu3Pgx6TFQsGNoZXQexAU8DmN7fTdJUtR4CrFE=;
        b=gChy4N4RAP3Hm4i8G5xbZWZ1SmtvksEa3TyknWSGOhr3iqn8ctxSmwh/9myzAX7d66
         rx4kkh9UZkoyOMyUAwdhfoH25iPMVcjFO2/Dl43rNhNY4DvdPD1qzZLoS8fuUSwSPpUH
         VIHm8uDNeld3fUuXb3mLsxJIMPB7LD/HplW8OvSAMQPJ248VQacXRkW00rDObHgtYbAA
         ErfrP8W+J8KidXxO9IO3ZWWYng4BngRYl3vKGJyeTjTEGzHXh81A8ayho9IYPiwm0wXh
         3Awm3s1olF0n+VVC0J0bp0UmZJs0Ei9WJZo99P/XMEHzj8TxhXCMEkti4WWYHpQRvyxi
         E8zg==
X-Gm-Message-State: AOAM531rcf4tZbNh3gW3WXPcspj2oeFfwVXOj2CLYD5qBk+BDatu/9Xh
        sP7b/nhoXKlLAhcOXTikAVYYl9HR0fmHTw==
X-Google-Smtp-Source: ABdhPJzofqKDRnoydhjd9+uGjDnGEKUFhtlYwE1LXKp79pjovHO2ByurtHlfviQDYMsWJQCzNOQXsw==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr1052392pgm.22.1623784457873;
        Tue, 15 Jun 2021 12:14:17 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j4sm3165008pjv.7.2021.06.15.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:14:17 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] PCI: brcmstb: Add panic handler
Date:   Tue, 15 Jun 2021 15:14:01 -0400
Message-Id: <20210615191405.21878-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2 -- Dropped the "add shutdown call to driver" commit as it
      was clear that it required further debate.  Since it
      is actually unrelated to this pullreq it will be
      resubmitted separately.

v1 -- These commits were part of a previous pullreq but have
      been split off because they are unrelated to said pullreq's
      other more complex commits.


Jim Quinlan (3):
  PCI: brcmstb: Check return value of clk_prepare_enable()
  PCI: brcmstb: Give 7216 SOCs their own config type
  PCI: brcmstb: Add panic/die handler to RC driver

 drivers/pci/controller/pcie-brcmstb.c | 135 +++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

-- 
2.17.1

