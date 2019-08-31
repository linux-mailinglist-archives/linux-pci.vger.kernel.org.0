Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381B6A4613
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2019 22:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfHaUKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Aug 2019 16:10:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46787 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaUKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Aug 2019 16:10:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so8809269wrt.13
        for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2019 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Aev97Pa+qYFh+cUwY9FmnFvad0TOkV/gvIGhNIY3Gp4=;
        b=bh6JMDFRu0X2XUGZ3rqBC+191o/+92BQMlQS+tY49MkihKV5WiZFG8Z9PLtR46WBK8
         dy40N2oCoJY6zq5ZdTNNLkU7HNB44xC0dx2KcUF8O86/EW1dwZ/aGkPapWrcdtucYo45
         pdoxKYspOt8bd6rzQ8JUP/HZ2BNtq5m0itnlR1396a+9NHWSrMtns3KeDD7TlEo0kOL9
         JFEQQMMx/GGulKxU/2rceYeSJm+iDzai7LQu6ODvhbSI4pWfFdJuV8A+/yxPB03qPsJB
         gMF0mmnw9dwPDnla2L38sNqZouJFQ4RMGGV+/5YkbFfF09wSJIqBky16AUYfIRTmgMwD
         V7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Aev97Pa+qYFh+cUwY9FmnFvad0TOkV/gvIGhNIY3Gp4=;
        b=qHNEV8RObHXDVmufeeDU1oI5MgqzEiQLWq425yrCGzalzT4RO8GL/jSUPCwzfUbKh2
         V4Mh+80uxA3H5BUNwB1DzdXPlRDsPJlq364RVSpN5wiO2mUBkjV3Et7mHdVimcTlGLeh
         dyQYeoH/JCzHJa97KmJZ2xFeBUmvPo8WU03J6z5fwhvnpuZ2MQDXMc1WWn8CTkT5Q8mF
         Xe1oDaGh8mOUEXNEDvm/sbUrHWdqRWWgq06VI360kRpHBkiA4RjsTYSwdrvPmPCDSBFz
         qMiB+JrMzGzFCALDs2xm75GhyS4wSJZR0GKp/YDSMyFBb4pUEYXQwHiRA+o3NwEFXQkf
         5xRg==
X-Gm-Message-State: APjAAAXPc9iSulTQKRLrQYcvwrsyJTQmfndEeDv+ZaSsBnlY9SRflIo1
        G7Og+3iGGyxcQuJMF/m7QpeI+RPU
X-Google-Smtp-Source: APXvYqwLCvXU3ASBDMxPgqUkeQfPEEyqZE+GFubzOZM4VLTbewCFZdqxHr6Wu0Va9p6o0UygZ/cbJg==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr4365043wru.249.1567282208719;
        Sat, 31 Aug 2019 13:10:08 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:9586:e556:3a4d:c04? (p200300EA8F047C009586E5563A4D0C04.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:9586:e556:3a4d:c04])
        by smtp.googlemail.com with ESMTPSA id f23sm6570522wmf.1.2019.08.31.13.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 13:10:07 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 0/4] PCI/ASPM: add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <c63f507f-7f52-7164-dbc5-07fc18e433b8@gmail.com>
Date:   Sat, 31 Aug 2019 22:10:00 +0200
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

Note: Series depends on series "PCI: Make pcie_downstream_port()
available outside of access.c" from Mika Westerberg that is still
sitting in the PCI inbox. 
Alternatively I could prepare a version w/o this dependency, but
then Mika's series would need to be changed.

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

v5:
- rebased to latest pci/next

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
 include/linux/pci.h                     |  10 +-
 6 files changed, 195 insertions(+), 93 deletions(-)

-- 
2.23.0

