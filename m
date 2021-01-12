Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED02F26DA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 05:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhALECw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 23:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbhALECw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 23:02:52 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C881AC061786
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 20:02:11 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 22so760076qty.14
        for <linux-pci@vger.kernel.org>; Mon, 11 Jan 2021 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=srYruzwMD9dqHYu9mhQyqr32NqB25nzIPSQzatQ9efg=;
        b=GlT7QDl0qRuEu0YpYsnP6Nit1RQ2PSu6oMQRj9edkRqFpIMNHxHS0D4KjkAwVNGt2a
         wT4By/XUh61m9wv3WMvFTHjGmLhk9/iUTr8M9NjgPaiBGNjf6E64E3Tbjw9Uk2Umrtcy
         OOkEXhcC3QXl27gCjn9gdmkYcK7eY0E4sXmn/ekW6A7N3h7ZzlAwYoGF8mxmy5EJaANt
         K7ht9E0NdAON+/tZOeJuUMJUFDPakq0rlpKJJU3r1v65FBaUWODTG++dCUqjrvsRfYW6
         IQlgtxKKk+3s9maM1s8dXFNyhQ9jviJ5meYp2OTwVb+xKXDO93FNCaxjGDzGeBmChp9g
         W4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=srYruzwMD9dqHYu9mhQyqr32NqB25nzIPSQzatQ9efg=;
        b=howFp1YAD/bPO6WFpNgxWjfX31zky3spxR3BXxOwln4tn76vGQOhVn3TNlAhD7qIZD
         3/5IqMkNu07CdRl1UzaN1SrVqMrx7Pu3Z+3LAZVrdzn5xqrYMRFNOOY3tpNVqLzU8A5y
         nJP/mz+hJlhPpONg8R101Tupa2eZyCGQV40lKBvZr9wbe805juADfVqc6sTvpRZ6nK0Y
         gHXB/HDDyW/Ep+DlOjbCXiBDSKrIogjGnAvGMFcLdvF0zMyy46DkfRgnh0R8aPTlMKHt
         0WMOD3oWSIuKVkx/+27XG8PmmnurV/olcGIXvXVNfGaMXpquTjviWqzLrL/HVF0lAm8k
         olNQ==
X-Gm-Message-State: AOAM530YT1wxPra5tiQF/fDBuVojh+BqhPVuknDe/tNMZcu6SkBtEYdY
        9vcAx9ixtgejAjCMGAbxW57pMWqj3v17soe4
X-Google-Smtp-Source: ABdhPJzHaNQxh2u4Sn42cu3kPnjGaK0PQ9XvFceP0AiQPVTLUwD5y/p2yNAsPlnVhA/zG55IqN1PfQ4LrRNEPniv
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a05:6214:184a:: with SMTP id
 d10mr2505402qvy.41.1610424130356; Mon, 11 Jan 2021 20:02:10 -0800 (PST)
Date:   Tue, 12 Jan 2021 04:02:03 +0000
Message-Id: <20210112040205.4117303-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/2] Disable ASPM on GL9750 during a suspension
From:   Victor Ding <victording@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Victor Ding <victording@google.com>,
        Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


GL9750 SD Host Controller has a 3100us PortTPowerOnTime; however, it
enters L1.2 after only ~4us inactivity per PCIe trace. During a
suspend/resume process, PCI access operations are frequently longer than
4us apart. Therefore, the device frequently enters and leaves L1.2 during
this process, causing longer than desirable suspend/resume time. The total
time cost due to this L1.2 exit latency could add up to ~200ms.

Considering that PCI access operations are fairly close to each other
(though sometimes > 4us), the actual time the device could stay in L1.2 is
negligible. Therefore, the little power-saving benefit from ASPM during
suspend/resume does not overweight the performance degradation caused by
long L1.2 exit latency.

Therefore, I am proposing to disable ASPM during a suspend/resume process.


Victor Ding (2):
  PCI/ASPM: Disable ASPM until its LTR and L1ss state is restored
  mmc: sdhci-pci-gli: Disable ASPM during a suspension

 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci.h      |  1 +
 drivers/pci/pci.c                 | 11 ++++++++
 drivers/pci/pci.h                 |  2 ++
 drivers/pci/pcie/aspm.c           |  2 +-
 6 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

