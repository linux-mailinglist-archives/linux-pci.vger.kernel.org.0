Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0890DCC9CA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJEMCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 08:02:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJEMCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 08:02:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so10031742wrm.12
        for <linux-pci@vger.kernel.org>; Sat, 05 Oct 2019 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Wer2YeuJa19/ZyfOFM8efrGkhDksrLhnOgkiZnPHW/A=;
        b=YxYMnetYD0q5wS2nZD4Bo9GWccjZ4iWjF/DjBzXoD9jyDiXafmkBESEe+TUfwrlfRV
         2izs/dRzE72ec5K4at2XmjkGX6el0o3dl0H8cyWHNzJr2nXJDgrWJuExav7SlhPyX0X1
         EeQHqzXut+tfPnDP71dHstfeFPdYhshE27AHla5SNDW98knf/V4rKWOLf8weI0O7X8LG
         PHU+w8bq6fnDEWccwsOF1wOlv+N2B70bosPExzB2+NfIAmJodVjG/GNp/qot1tQsSzwr
         iBkvzXY2vSgAmMZlHl8WYRXmNExbXC2P/8kzZX/wH+JPF3djz46vdVyb+e8E+0zMTNkN
         aecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Wer2YeuJa19/ZyfOFM8efrGkhDksrLhnOgkiZnPHW/A=;
        b=rhwFU2YoE2xMlbOOVM3yQ0lQpgoIyNdil51wRxagVhsfw37MmCfEVWE06qT5TWoNO3
         GXlpfFmjHCboX72EzUJkGCPg0Ef5UkoU/6ZlkqQLrgPx+RBgn5hejLpCD2axHd91H1Oc
         GuOarBEQ7nnKxOH/II2KJj+I9mV7IV5P1AA3w5y4rcGUpzSeJJEzLUIT94Vs5qa5B/aX
         /DlXDctBOjaB9O+AMdnUf8EejMPwvMAqtgNE5gi1OKExo2rIh2MeJ3GOhE8toLqC8ifp
         XsmaIkzO0/rVVuCrE2y3+6gJVfgXg5siI11RA61m3I+Ab+RlfUShej8X5ktG4bJWmvWa
         Whmw==
X-Gm-Message-State: APjAAAXkCrPLrHz95pGm4pLDQAVrKL6LYRbLSLsAz0r1vK6JkG91CBkQ
        yBw2b/GGlLuGSkqpMWY2zLhbILa3
X-Google-Smtp-Source: APXvYqypnrX+pMcPBrWKdv5ULe6zbMpJHiLmCgrVL0g8SmcaQnbu6HEu4ZfWcCZUBXpsW/5pVLOVPQ==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr15199947wrn.307.1570276957298;
        Sat, 05 Oct 2019 05:02:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:78ef:16af:4ef6:6109? (p200300EA8F26640078EF16AF4EF66109.dip0.t-ipconnect.de. [2003:ea:8f26:6400:78ef:16af:4ef6:6109])
        by smtp.googlemail.com with ESMTPSA id q15sm20063431wrg.65.2019.10.05.05.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 05:02:36 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v7 0/5] PCI/ASPM: Add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <e1c28e25-df18-16e1-3e9f-933f613ea858@gmail.com>
Date:   Sat, 5 Oct 2019 14:02:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
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

v5:
- rebased to latest pci/next

v6:
- patch 3: consider several review comments from Bjorn
- patch 4: add discussion link to commit message

v7:
- Move adding pcie_aspm_get_link() to separate patch 3
- patch 4: change group name from aspm to link_pm
- patch 4: control visibility of attributes individually

Heiner Kallweit (5):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: Add and use helper pcie_aspm_get_link
  PCI/ASPM: Add sysfs attributes for controlling ASPM link states
  PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and related code

 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/pci-sysfs.c                 |   6 +-
 drivers/pci/pci.h                       |  12 +-
 drivers/pci/pcie/Kconfig                |   7 -
 drivers/pci/pcie/aspm.c                 | 252 ++++++++++++++++--------
 include/linux/pci.h                     |  10 +-
 6 files changed, 199 insertions(+), 102 deletions(-)

-- 
2.23.0


