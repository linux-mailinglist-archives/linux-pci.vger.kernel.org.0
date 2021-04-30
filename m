Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC83703E1
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 01:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhD3XCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 19:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3XCN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 19:02:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F319C06138B
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 16:01:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f21so33088126ioh.8
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fatalsyntax-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aG5r9GGtzNqH4QN+nje0dhFSUCRYfN/rfoUAdz2/jM=;
        b=u7L7uKSOO1EP7Mq/01LrpEj7n76gU6Nr+kvqaTDBioVMDTzySKnz904cHtRxVa+agU
         num9gQZTrziQKPzl5WCjpmYvp2QOsZi3TsUSCoz6stIi8h1ossOW0Rk0eT8hPsAd62SN
         u5o+D+RSlfkNqFgWTM1tXkiMJPCHq5IIFv7JfmVrjKmvCskx5DXj1xbK9a/EEol78IHz
         +WethyiQPeNNyhBZxAbkxwhGhUMRWoJ1ZYsLuEYgXs2eTDpOEoE+kSGgv8vX7pgHoOuS
         ho8wTg+abFB3oi53ea6aCdVYiEBwvr0Fv18a58xnvWtXNz0O8vA3MvsUGWib8sNvDRBZ
         8hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aG5r9GGtzNqH4QN+nje0dhFSUCRYfN/rfoUAdz2/jM=;
        b=dJXG997eREcNI1p6FfXENjOafHwKO9s49ubXlJy0xRKYk+IWexn4db8yk9NnoHfUyK
         c9C1ariqkwpcx7bUe0Llahf0LTgabhGKRSO2rqK6HwfkosvQC12FWnVE7GcoaNx82HPQ
         77+qeA30Ty56drfa/TXMM7Ar3zV35Bz6Auki6rMj3CYBcDvo5Gx+UzUFrNK+rBydUzxW
         RuaMOwXXSweFMbXRpPYQ+ps+8xPWkFbnf86hhC1mvbRn/wmNtjjDjs9Bb8ZhPX/GSDcy
         c2O7SzsPuAbbQqFtNG3x2qW3OpVs49HS1xqFm6sOGT75KisfQ9m2jiG/vNKniLzhuKFR
         9yJA==
X-Gm-Message-State: AOAM530ncMFap4LSoEL3LuTBWavY/4kjm2fJNSsZ1GAQJkGCcBIiH2ts
        rZAwSnPzEGgcblkTXceZt9IN4g==
X-Google-Smtp-Source: ABdhPJxVa/6wRsnNzmM3U1Le6pid1K6ENmzh3s0m9llxHrWshhkWUO/H7ZuRpdqyuVjp6OICYPyTUA==
X-Received: by 2002:a5e:dc0c:: with SMTP id b12mr5676504iok.109.1619823683403;
        Fri, 30 Apr 2021 16:01:23 -0700 (PDT)
Received: from nagato.condo.fsyn.dev (2603-6000-ca08-f320-6401-a7ff-fe72-256d.res6.spectrum.com. [2603:6000:ca08:f320:6401:a7ff:fe72:256d])
        by smtp.gmail.com with ESMTPSA id w10sm1483420ilm.38.2021.04.30.16.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 16:01:22 -0700 (PDT)
From:   Robert Straw <drbawb@fatalsyntax.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, Robert Straw <drbawb@fatalsyntax.com>
Subject: [PATCH v2] PCI: Disable Samsung SM951/PM951 NVMe before FLR
Date:   Fri, 30 Apr 2021 18:01:19 -0500
Message-Id: <20210430230119.2432760-1-drbawb@fatalsyntax.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SM951/PM951, when used in conjunction with the vfio-pci driver and
passed to a KVM guest, can exhibit the fatal state addressed by the
existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
the SSD, and vfio-pci attempts an FLR to the device while it is in this
state, the nvme driver will fail when it attempts to bind to the device
after the FLR due to the frozen config area, e.g:

  nvme nvme2: frozen state error detected, reset controller
  nvme nvme2: Removing after probe failure status: -12

By including this older model (Samsung 950 PRO) of the controller in the
existing quirk: the device is able to be cleanly reset after being used
by a KVM guest.

Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>
---
changes in v2:
  - update subject to match style of ffb0863426eb 

 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3b..e339ca238 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3920,6 +3920,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
+	{ PCI_VENDOR_ID_SAMSUNG, 0xa802, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-- 
2.31.1

