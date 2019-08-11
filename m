Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0126589377
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfHKUAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 16:00:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40392 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKUAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 16:00:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so48423136pgj.7;
        Sun, 11 Aug 2019 13:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKJN9AGZxsBwvYoiulECXAcg2pL+0e5z7Of8DKP3mhU=;
        b=FQmozTjbBDYrNsKHInKVpcWnruNEXCeDQuJQmbwIHKGKc9naCNmQ+ECvxre/HYZHfc
         e+BUvL4ELn1pPdJ3+trWqq+8IL0y/BLnhltEpUMipCcZ6ijoH4+mdMI4gYTiMlYxMpQH
         G+u1AoNcOUSWAcd92zB5QC8Jgs7dpU1cGlX+78hmz8aOAvJNuA0CB8Gag1kOu70I6FRP
         CmaiBkBq58RZkHIO2kK95Ow3131OiqIJtxf8IAqiSDMsu00kHIJ7MpcT5txDXvfv6QKU
         tP4Ghp9XBKEghmg1W8u9d8dExTnxS2spLooIyjukkBkB/uBR0SuwbH/5kFc5J6lQMtJ9
         40rA==
X-Gm-Message-State: APjAAAWZUFL3YZ+OlS1hEtwe0bT3Enr3MocXh46Ck63Qful9P1XWFh1S
        5gkhI5TX6vRGpEYVnp/p1H1SAXl/CsU=
X-Google-Smtp-Source: APXvYqw0qysVjvK9CTCZffORpkHzBqrvS7xxAPNc0wGpOzASHhRUuYYl94mCYWrTFoDWf2oEE8NlWQ==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr19593873pjp.24.1565553609482;
        Sun, 11 Aug 2019 13:00:09 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id a3sm106119167pfc.70.2019.08.11.13.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:00:08 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 0/4] Simplify PCIe hotplug indicator control
Date:   Sun, 11 Aug 2019 22:59:40 +0300
Message-Id: <20190811195944.23765-1-efremov@linux.com>
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

Denis Efremov (4):
  PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
  PCI: pciehp: Switch LED indicators with a single write
  PCI: pciehp: Replace pciehp_set_attention_status()
  PCI: pciehp: Replace pciehp_green_led_{on,off,blink}()

 drivers/pci/hotplug/pciehp.h      | 30 +++++++++++--
 drivers/pci/hotplug/pciehp_ctrl.c | 14 +++---
 drivers/pci/hotplug/pciehp_hpc.c  | 74 +++++++++++--------------------
 include/uapi/linux/pci_regs.h     |  2 +
 4 files changed, 58 insertions(+), 62 deletions(-)

-- 
2.21.0

