Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF5891D0
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfHKN3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 09:29:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52415 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKN3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 09:29:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so9944122wms.2;
        Sun, 11 Aug 2019 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcN0R64ay0subyuaTqrli2YWqqqppdT258U9pgi7TrY=;
        b=esS+8BAnViIMBUVZU0YqRYUiYQnyjdtPOecbxwlEczHqVoY9tzP3HvUGvSMoVG4YNK
         EGJ44Qu/7hFquhNDYAsj7XZC0yTisoKXe6/7w/LUwx+Xc7m0+BEEG9qYVssAa4W0w2Fz
         CKKTTPHM50d8m8WP2KL61VRzljMZq/UVYwL04ODA0VS0UzHjzZ6T8/2UlFuGzmYCebBh
         Lg1ELk8JOub8j2BieFrLkUcdhXWCywk2jtL4TzXShlasGlwTBmmXH9sx68XtfkWUmz2v
         W2wnVpVp6pDBQSYYcSvwnFUPknJ3g6h0DsexnKE8/eSNGq9zMs6QfzUNumqfcqSQXFK6
         /nMA==
X-Gm-Message-State: APjAAAW9xixYVDRRth1rSDCylO32fIokwd7zfDXucj2dbmvoQybxoCiW
        mkGyqk1YXtVdDgpAc8Eltqw=
X-Google-Smtp-Source: APXvYqwCHOfmOGdzFrumv7Gx+2E2zqlnNdkKPC1B+IQP+pCnHdSJuej0hMJqIt+cao7MT0NJA/Dxcg==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr22459656wmk.101.1565530191629;
        Sun, 11 Aug 2019 06:29:51 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o16sm13781463wrp.23.2019.08.11.06.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:29:51 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 0/4] Simplify PCIe hotplug indicator control
Date:   Sun, 11 Aug 2019 16:29:41 +0300
Message-Id: <20190811132945.12426-1-efremov@linux.com>
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
pciehp_set_attention_status()) are replaced with a new one.

Denis Efremov (4):
  PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
  PCI: pciehp: Switch LED indicators with a single write
  PCI: pciehp: Replace pciehp_set_attention_status()
  PCI: pciehp: Replace pciehp_green_led_{on,off,blink}()

 drivers/pci/hotplug/pciehp.h      | 31 +++++++++--
 drivers/pci/hotplug/pciehp_ctrl.c | 14 ++---
 drivers/pci/hotplug/pciehp_hpc.c  | 87 +++++++++++++------------------
 3 files changed, 69 insertions(+), 63 deletions(-)

-- 
2.21.0

