Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58D29496C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfHSQHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:07:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40985 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSQHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:07:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so9284323wrr.8;
        Mon, 19 Aug 2019 09:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLoUlx1gsYL0OVFSMVjn2c222FNgif7/2WN9cg01ggE=;
        b=Hdcqy3XN6hh04oX2rDHc/RLpbxvUBAZ6hOwUxNxiCq+nteTqN2fKjL3MtsKltM50TZ
         59bRudQx4wUU10bsM1m4eLuKNUD89t5R0bQclwq2Y1Ai/wg9ZgAXbsKFq+yLe+1CBbVz
         lFhX7yORMWjfQe6pVgqfeTPrI9WmSPu1rsjXzxeAq12bgesEn44n5zq3C6f/f36rEbif
         l+h4HUOpqw51fTxI8QtV/7MPcxWvo/EkjjCx7Rkep/kp4V+p3sU6I3fp2KPmdlQFXk2c
         xI3STEKC0CgWuJNOUHZSinM8pNEXRnWaRnNc0NX63rtZGV9/YPMAdRor1dvgXZ3Tiqyy
         SjSw==
X-Gm-Message-State: APjAAAWiJWuwMKiS8yAMeE3qn4cmnjJf4s/O7ULu5iyt7yuXP+vxlTan
        /x5rROy3HHTaJxE11ewIsxc=
X-Google-Smtp-Source: APXvYqzuS9K5M1f90oGwEQxSqTmvmIW4FycvyX/cWqrWPuKOYeqGKO9rprB7+crHuBV0VIsTwvAvpg==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr28682362wrr.318.1566230830772;
        Mon, 19 Aug 2019 09:07:10 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b136sm32442189wme.18.2019.08.19.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:07:09 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Simplify PCIe hotplug indicator control
Date:   Mon, 19 Aug 2019 19:06:39 +0300
Message-Id: <20190819160643.27998-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe defines two optional hotplug indicators: a Power indicator and an
Attention indicator. Both are controlled by the same register, and each
can be on, off or blinking. The current interfaces
(pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
non-uniform and require two register writes in many cases where we could
do one.

This patchset introduces the new function pciehp_set_indicators(). It
allows one to set two indicators with a single register write. All
calls to previous interfaces (pciehp_green_led_* and
pciehp_set_attention_status()) are replaced with a new one. Thus,
the amount of duplicated code for setting indicators is reduced.

Changes in v3:
  - Changed pciehp_set_indicators() to work with existing
    PCI_EXP_SLTCTL_* macros
  - Reworked the inputs validation in pciehp_set_indicators()
  - Removed pciehp_set_attention_status() and pciehp_green_led_*()
    completely

Denis Efremov (4):
  PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
  PCI: pciehp: Switch LED indicators with a single write
  PCI: pciehp: Remove pciehp_set_attention_status()
  PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()

 drivers/pci/hotplug/pciehp.h      |  5 +-
 drivers/pci/hotplug/pciehp_core.c |  7 ++-
 drivers/pci/hotplug/pciehp_ctrl.c | 31 +++++++-----
 drivers/pci/hotplug/pciehp_hpc.c  | 82 ++++++++++---------------------
 include/uapi/linux/pci_regs.h     |  3 ++
 5 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.21.0

