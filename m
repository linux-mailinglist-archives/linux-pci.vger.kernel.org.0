Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9909BE9C
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2019 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHXPjr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Aug 2019 11:39:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37073 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfHXPjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Aug 2019 11:39:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so11299625wrt.4
        for <linux-pci@vger.kernel.org>; Sat, 24 Aug 2019 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kIYK1ac8ue565+NeN3t8Pa2Eq+WWkCA+ZFYhNPul5eM=;
        b=bZ3NyB4gM81YbJKsBisFWxn00IMp8VB62mrpUuCYHslNCnjQgCleXxG+4aDroQFYXr
         MdF/513G2M9Et5RB4Arn6LWSSWeP/oTyu1GCJGtPT85DAKAAMQNOo6XBXyyBkwGzahG+
         gICUONkqWpEDEK+8v3FD6pjirTjQ/sdAURPT56x6T/e7vGpxmb37ZpckF4Fd4iAYYTRA
         PMwFYjyO6cipP2dgCwq3MgKsnr0xsYNz1JrI8yN647uXMlQ3HCKiSVYyCB0GMUCpdVGS
         CqzqPBYFrMuOObZMdJ4bppKAYIfSECQMdMHpzGd8pPwQe52CCv03sNpPWJUplGkCWoXv
         xbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kIYK1ac8ue565+NeN3t8Pa2Eq+WWkCA+ZFYhNPul5eM=;
        b=a4QMBB6Z7ASzzjSY2KpKqAtXq7/5BORfpSecGclCI790epMPLLm3LJyo9vO/l9jnzY
         Pwqv5vyg4Bws5M6HbUPXo9tjEQCS5jKCapnoIOareVqL6dvPWiosErLMTAKEwG+huzDj
         Z7GT4XQJgXpo/ZqW+eBfvKdygRyL2UTLxacUWwtJYHAGY7E7z0lEFitJl0AZHNyZalS7
         2Z+OhNWqtZ2WmkyDxbB02zz+QhlV1iFFAh/P6c9P1gNLthcM8MTIOt2us/PBe7WUu/Nd
         ZMv37JvDp+teLnfITSMqCBGnfHxO9ecBfsWhVqjJ/KRmTMMPbXqcqfd+n80yv54rSQOC
         gAmg==
X-Gm-Message-State: APjAAAUD36lGy7r+ILNwgUO7q4hx6OsD/grOVppfqkTLUuvcGWovqm0A
        c/1sA0Fitb5HBz3riYBPTqMGDB4f
X-Google-Smtp-Source: APXvYqy5UqL/Q3TvrJDJYqG7S6TtwEtKiYDuJwhlWAA2HtRvBWXTDExmJ+PX8h6ZL3ff4T2Q+hMX4g==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr11471068wrl.62.1566661184956;
        Sat, 24 Aug 2019 08:39:44 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:2069:2121:113c:4840? (p200300EA8F047C0020692121113C4840.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:2069:2121:113c:4840])
        by smtp.googlemail.com with ESMTPSA id 4sm10497237wro.78.2019.08.24.08.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 08:39:44 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/4] PCI/ASPM: add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
Date:   Sat, 24 Aug 2019 17:39:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per
default. However especially on notebooks ASPM can provide significant
power-saving, therefore we want to give users the option to enable
ASPM. With the new sysfs attributes users can control which ASPM
link-states are disabled.

v2:
- use a dedicated sysfs attribute per link state
- allow separate control of ASPM and PCI PM L1 sub-states

v3:
- patch 3: statically allocate the attribute group
- patch 3: replace snprintf with printf
- add patch 4

v4:
- patch 3: add call to sysfs_update_group because is_visible callback
           returns false always at file creation time
- patch 3: simplify code a little

Heiner Kallweit (4):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attributes for controlling ASPM link states
  PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code

 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci-sysfs.c                 |  10 +-
 drivers/pci/pci.h                       |  12 +-
 drivers/pci/pcie/Kconfig                |   7 -
 drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
 include/linux/pci-aspm.h                |  10 +-
 6 files changed, 195 insertions(+), 93 deletions(-)

-- 
2.23.0

