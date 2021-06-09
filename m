Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B93A0AB1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 05:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhFIDjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhFIDjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 23:39:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB54C061574
        for <linux-pci@vger.kernel.org>; Tue,  8 Jun 2021 20:36:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n12so18240868pgs.13
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oubMStFNGrtV4LE+3WOGbMFsCnKASljsoNpfRmbbGlw=;
        b=I9gQ9HCmiAJcqC1oTV6XW+qgj+jecrM9jYzZbj0yvo2ONVzPHopjLXH02JeTChRr9+
         QRQm/NaAfdEr42swK1wGhwrFiMnMLDIRlLp5vRe23stYEUf/USxsiF/GnkbjG2mg+3z2
         aFtKXxR+nOzPD+K6YZe73dvECSex8wpSwf7Gt+/wqj13cQXdqff8Pay9+df3oYMlnI4x
         Dhdsr6eazTZBMPk5wgYhWxw4OODLXnh4oZV3C+kc1CMCM4nztJOA0jq+hXpwhI8uRvc0
         QUx+zRRIOnSi5UD6ys6HjCoVXy97tz/pt1RF+jIbY1VOLic51sqhUeK27WARM1PvYEv5
         MHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oubMStFNGrtV4LE+3WOGbMFsCnKASljsoNpfRmbbGlw=;
        b=teKtXnEGjqnUcGW5P3aTHAxj1Ejnd8ntHvH3AGIxTNWqmVGiQopE48j5vyft6+4+Z2
         g2jQgI/rRmnEeGkz2+WjU+9yN4KXepOIgLX0BSNlSiKXF4DFxu9l2UOQaeZ+F6oDsdDS
         6cx3ZOojn/OYBTTEGmfFyGeumqe+AdLnc3OoxE0wWqvwE3l18hahdsiwbZ2fotLqoJCS
         qihHgC1BYACWKGUj4etRZ6UYC8B6tz98qDeLrVfZpRosswwucRc+ewOuQbcwt7bwPsc1
         hKzFCWZFxSHrQgGSMQcAdW8jcEdzv8YPlESsRGSLBE6ALnmznqxwIREWG8uFOcEb0V0P
         i/6g==
X-Gm-Message-State: AOAM531y2R4jViy3rwcavGOqvKWTcU583Cy87AEh68ORPkanzeU7fHHJ
        jXim0X42pv5c0oUfsnngCoy/wA==
X-Google-Smtp-Source: ABdhPJwR+7W6O5QClSyBgLz+We60zX4lg8j0nOjpURIHwLZDB0g3ckTMsGLQDoy7ABIUIsXTnp6uUg==
X-Received: by 2002:a63:b043:: with SMTP id z3mr1636587pgo.89.1623209817652;
        Tue, 08 Jun 2021 20:36:57 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:36:56 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 0/3] PCI: Add a quirk to enable SVA for HiSilicon chip
Date:   Wed,  9 Jun 2021 11:36:38 +0800
Message-Id: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices have PASID capability
though not supporting TLP.

Add a quirk to set pasid_no_tlp and dma-can-stall for these devices.

Jean's dma-can-stall patchset has been accepted
https://lore.kernel.org/linux-iommu/162314710744.3707892.6632600736379822229.b4-ty@kernel.org/

v4: 
Applied to Linux 5.13-rc2, and build successfully with only these three patches.

v3:
https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
Rebase to Linux 5.12-rc1
Change commit msg adding:
Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/20210302092644.2553014-1-jean-philippe@linaro.org/

By the way the patchset can directly applied on 5.12-rc1 and build successfully though
without the dependent patchset.

v2:
Add a new pci_dev bit: pasid_no_tlp, suggested by Bjorn 
"Apparently these devices have a PASID capability.  I think you should
add a new pci_dev bit that is specific to this idea of "PASID works
without TLP prefixes" and then change pci_enable_pasid() to look at
that bit as well as eetlp_prefix_path."
https://lore.kernel.org/linux-pci/20210112170230.GA1838341@bjorn-Precision-5520/

Zhangfei Gao (3):
  PCI: PASID can be enabled without TLP prefix
  PCI: Add a quirk to set pasid_no_tlp for HiSilicon chips
  PCI: Set dma-can-stall for HiSilicon chips

 drivers/pci/ats.c    |  2 +-
 drivers/pci/quirks.c | 27 +++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.7.4

