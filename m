Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A1841BBD0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhI2ApI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbhI2ApI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC5C06161C;
        Tue, 28 Sep 2021 17:43:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so1825029edv.12;
        Tue, 28 Sep 2021 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlIYojiY2l+5PvVT+yckjTN7OAGIe2SoywvUozflH+Q=;
        b=Sf4mH3nW8UlkBWeuAm4Q0ZWnoXKkSldDLmkUvD7JqUysBsxR7MC91I5/4CEQnm0fnM
         KX8rHR2MRRHPUhK7ccm9RoccNM2PvlT8P+8PQz+oNVQADqTAdH3WRDYpziOpIesJxhjm
         gUkOETZreH1E0LlyPkwtASdG24JnJckVSJjdKs6By6AvPCNYqC5mQctE+Ob/E0mui4FE
         4RcVClN6WawPgIanxxwcr4UXV2RuycamQp/S8SUU7a/8ZuETsQTJgygxthlIFcDDUe6o
         bpU0x4QIGdIPA1fGUcUdQIU8lrHmrRtDN9NJjxMBTV9mCTGwSCk1poGEZDlKRIvE5vlG
         yaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlIYojiY2l+5PvVT+yckjTN7OAGIe2SoywvUozflH+Q=;
        b=zl+6i0vAJIIPu5/1idTIFT3SKFjGfy6ubu854EOHSVkKpN8aJdU5iaQvi5u76lwf4I
         4+8UpVH9BVQ1n25JK5OBO18mZPWTy6ENT9hav+9Tyi0MhXiTDSWACoD08I5acQIgQqw4
         5JY3/pVCv1aAxhlYpagDhO0DDQ/OnePVrIlddai4R7xPMGi2EqnvtO6oJirzEGy+I0EY
         gly+5cEB0Rzj+VIIsWzeS5ypMQtinCE+/3wPoL2kA4xRZI5LV9XTsQcBTGxVBXYUdLHf
         8x+4JEm6dhzpp8jyGLiGWEItic9pyI6DGJmKL7Gh/uhieLXZOkozKrUbzGwh7q1YcU47
         2asQ==
X-Gm-Message-State: AOAM532MQYeYqbYsqk3lp72u2R16PvHrauNwLaFTTq7FlcUzDlEViKiX
        v8C83wOifXWv4mAM5ofaJwN7SrBDiTw=
X-Google-Smtp-Source: ABdhPJwTz9Pt+fiTqE+gn2LgXKA0CyuWJsDpMGmpNzYKnCzMmn5X/fY4zZ/iBn0+gJz7eRBfnPJvrg==
X-Received: by 2002:a17:906:1901:: with SMTP id a1mr10428425eje.129.1632876206941;
        Tue, 28 Sep 2021 17:43:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id u16sm358489ejy.14.2021.09.28.17.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:43:26 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] Remove unncessary linked list from aspm.c
Date:   Wed, 29 Sep 2021 02:43:11 +0200
Message-Id: <20210929004315.22558-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

An extra linked list is created inside aspm.c to keep track of devices
on which the link state was enabled. However, it is possible to access
them via existing device lists.

This series remove the extra linked list and other related members of
the struct pcie_link_state: `root`, `parent` and `downstream`. All
these are now either calculated or obtained directly when needed.



VERSION CHANGES:
 - v2:
»       - Avoid using BUG_ON()
»       - Create helper function pci_get_parent()
»       - Fix a bug from the previous version

MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'

Bolarinwa O. Saheed (4):
  PCI/ASPM: Remove struct pcie_link_state.parent
  PCI/ASPM: Remove struct pcie_link_state.root
  PCI/ASPM: Remove struct pcie_link_state.downstream
  PCI/ASPM: Remove unncessary linked list from aspm.c

 drivers/pci/pcie/aspm.c | 134 +++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 56 deletions(-)

-- 
2.20.1

