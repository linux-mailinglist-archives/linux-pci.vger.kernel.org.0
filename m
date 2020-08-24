Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5877C250C74
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgHXXjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 19:39:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35343 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXXjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 19:39:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id i10so11667098ljn.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 16:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPcUh17X29eC3oL3t9ThNk4PiBbxnGl1SnHYNtZdA5E=;
        b=c+d+ytoX7pwBwYrK+mflsKeWRMX6BwLHu84I0phpjLMZHNf3ldNuxwq0v1CzW3A1Vz
         maLtfcboidBLumRpX+p0FHwh7Ca36dvoAcO41c2nHfqWFVnLkLcCLTXyX8gjWJsz5a4/
         s69PIuxYnkwCl8xlZ+++XW4Ris0lBEdYHFmUI+qB46PWX0DiAoEOSxH5/T3ZkTpwKBWZ
         0+3+/18HWru/SoqBlBRFoFLwTkaKbe2JJIdt4pSJn9wfHw4dSb462AaAkCpB8IKYWiP0
         RcZ2D+clyX1IvDRcsxgYiPTuPdGAKAY5dwbqghnSAjZsbpVrfimdnDPfC4aRaXS6cZ+w
         czYg==
X-Gm-Message-State: AOAM5337kFgoApNAkuTtlcyMZkLtPivx/nmil+XGaP6W/eICtoLHHja6
        G5NRCQ6CvSe+pzVvxHeUuuA=
X-Google-Smtp-Source: ABdhPJxE4UWa9bi3EHteV4L0s3sM5qTJcOYLTe8jqlb3xWN26BW2VbrBFu1/WXi4EnHj0LG/lZHd7w==
X-Received: by 2002:a2e:a489:: with SMTP id h9mr3742482lji.121.1598312360657;
        Mon, 24 Aug 2020 16:39:20 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r6sm2492682lji.117.2020.08.24.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:39:19 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: Replace use of snprintf() with scnprintf() in show() functions
Date:   Mon, 24 Aug 2020 23:39:15 +0000
Message-Id: <20200824233918.26306-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace use of snprintf() with scnprintf() in order to adhere to the
rules in Documentation/filesystems/sysfs.txt, as per:

  show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

Also resolve the following Coccinelle warnings, for example:

  drivers/pci/p2pdma.c:69:8-16: WARNING: use scnprintf or sprintf
  drivers/pci/p2pdma.c:78:8-16: WARNING: use scnprintf or sprintf
  drivers/pci/p2pdma.c:56:8-16: WARNING: use scnprintf or sprintf

The Coccinelle warning was added in commit abfc19ff202d ("coccinelle:
api: add device_attr_show script").

There is no change to the functionality.

Related:
  https://patchwork.kernel.org/patch/9946759/#20969333
  https://lwn.net/Articles/69419

Krzysztof Wilczyński (3):
  PCI: Replace use of snprintf() with scnprintf() in
    resource_alignment_show()
  PCI: sysfs: Replace use of snprintf() with scnprintf() in
    driver_override_show()
  PCI/P2PDMA: Replace use of snprintf() with scnprintf() in show()
    functions

 drivers/pci/p2pdma.c    | 8 ++++----
 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.28.0

