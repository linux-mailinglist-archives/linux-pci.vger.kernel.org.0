Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E044FF02
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhKOHLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhKOHLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:08 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56140C061746;
        Sun, 14 Nov 2021 23:08:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso11606716wmf.0;
        Sun, 14 Nov 2021 23:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afFh3SKUeYtZRP0CVCrCYVNZyeQAFDjB1h7oTumFy/g=;
        b=McvZK6EC5nWpWRM0l3oUEDtogX2QSLYoitz/TLvFd51R0vnKGJMoI1DErw4zScPGeM
         Iuo9frAGmGKBZCBTu5ZCRgCF5jjp+/nXmKJ4AsvHXwwfwNutNSQuO5pUZxBA3udWQojW
         Ct7voWUcs05TzxNcT3sdIIzejJFcy4rfk8D9YbPtx5/ctSIJeSM3+rlAvH9NzmZIDR42
         J5iE5nQR0VLCYDFvAWqVVyzxzB0Se/yRyQACjNXj5uVdrJCyxVGIM2/KKlymJ6hDy8MA
         5WNLE6NUuDNvAVFXYIazyRtgTzly7WXmulbGK6cb7qFxS7reIhS+64a1F+nvuEvrWAmh
         nxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afFh3SKUeYtZRP0CVCrCYVNZyeQAFDjB1h7oTumFy/g=;
        b=5T/AxtV2r9Q8gGs+m6F+t1cRv+SqGsczgeAHHiHwejYtNPYjFDgjMVpFp3LYXyTMh0
         7p+vFhmuIMt5D8jgHMsJjlYXyhVo8UoFB1QKE62BHJbrrvZeLDOVo96RdzpeUDq2yBhm
         xXBQoyqwIFv+I3lJrjyNgkMVRNwnRW2HLUDWCODunf9WGpZD9vAUankp2tVowbde5xp1
         5eLUDB6wq7uHuLtA1ZugXVS7nucXxE3ZG++NnV4ogXvVMC8is5kWs5Z5kyP95E16mq8o
         htSgUlofz0bQiMCVYOpHueUmS+CDkPJ1ZAmsq3DMTyg2DswXsIbo7V/uK9RkvrU5wtJf
         vW/g==
X-Gm-Message-State: AOAM530SlQbJFyIZQGhyHYwqk3MC5o8TWJV2zNsH9piEANJQy1XzWzeM
        GUvZyLe+/2OQuK9itEsuR3PT4OC8JB8=
X-Google-Smtp-Source: ABdhPJyO7akrjktvgzkJeYv7xxy2c59tKscS/Vy76SI4p3+7+EPm47hWSjOFLg3plQVhGl5NmjjLCQ==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr40687401wmq.95.1636960091712;
        Sun, 14 Nov 2021 23:08:11 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:11 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] PCI: mt7621: remove specific MIPS code from driver
Date:   Mon, 15 Nov 2021 08:08:04 +0100
Message-Id: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

MIPS specific code can be removed from driver and put into ralink mt7621
instead which is a more accurate place to do this. To make this possible
we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
which has been implemented for ralink mt7621 platform (there is no real 
need to implement this for any other platforms since those ones haven't got
I/O coherency units). This also allow us to properly enable this driver to
completely be enabled for COMPILE_TEST. This patchset appoarch:
- Move windows list splice in 'pci_register_host_bridge()' after function 
  'pcibios_root_bridge_prepare()' is called.
- Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
- Avoid custom MIPs code in pcie-mt7621 driver.
- Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test 
  module compilation to complain (already sent patch from Yanteng Si that
  I have rewrite commit message and long description a bit.
- Remove MIPS conditional code from Kconfig.

This patchset also fix some errors reported by Kernel Test Robot about
implicit mips functions used in driver code and fix errors in driver when
is compiled as a module [1] (mips:allmodconfig).

There was an ongoing discussion about this here [0] but I preferred to send
my proposal for better review and understanding:

[0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
[1]: https://lkml.org/lkml/2021/11/14/436

Thanks in advance for your time.

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (5):
  PCI: let 'pcibios_root_bridge_prepare()' access to 'bridge->windows'
  MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
  PCI: mt7621: avoid custom MIPS code in driver code
  PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
  PCI: mt7621: Kconfig: completely enable driver for 'COMPILE_TEST'

 arch/mips/ralink/mt7621.c            | 30 +++++++++++++++++++++
 drivers/pci/controller/Kconfig       |  2 +-
 drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
 drivers/pci/probe.c                  |  4 +--
 4 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.33.0

