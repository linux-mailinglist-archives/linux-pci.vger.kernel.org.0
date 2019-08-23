Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C089A769
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 08:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbfHWGLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 02:11:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404124AbfHWGLM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 02:11:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so7480866wrn.10
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2019 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IQ3HdWHPan+TUjfPNMiz0fnODHLQxzhhQVeO2nH/anI=;
        b=RpPeTleYvaN17f/I6tAyfwrZ9XYW7WHuXowpXIgqrTNYVxG6RgCAfDc8sry18Ucgr3
         oABZNBTRzvHo0T47hi/VUjnodN4BAZVqzbE7R7mZHU9ypT3UPyDO2A/tfc81OTJaQDWN
         al0+hsw6uL4ozE5DLRVq7sJU9PR4k/3C7OI7SbgD7I5zvLAL48QggqbyLszIl0/Bk6GW
         kX9wo0yrnR1bVbfjPeAj0njp5YEy4q1gZygyYv4YMnl3ZNgbCnvvWhvHpLziwL/ycZSl
         O7FkGt4QfXwfKIYPalDv7XEJLzD7zvDhh0SNpz4Pm9HC7GvSo804ZI6UnjyHIaWVue9s
         KsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IQ3HdWHPan+TUjfPNMiz0fnODHLQxzhhQVeO2nH/anI=;
        b=a7bnubj30QXgE8urko6Y7cwRgw5cVo0jRQvGlnV2eZmGBn+wHJgcmF6KinEeXzuIHN
         pDql4y199p9fLJHSAOAUhRU9ZbofciIB26r/CyYTBX0oH6uC7D9dhOnxkBJi89ns5ncI
         wttLw4j68fzEDV9ulBl6XBN/4GLdgsSP/+ez2k792ICgmwKFKzYEqWTmAZLLNOPLOOyX
         pS9OGOKSpbdHy/cBElMNeORvxk9pMTdmjLpA4F9gQGcaL6QSDaNNrqK5uA+OiQY+soFl
         qUJ7z7Osbx/QKR0iCd3ZCc8qIQpGf+0QsgxCwI/UKetdhXKWHEmhtK6juYgNO9vAo2uc
         2WzA==
X-Gm-Message-State: APjAAAWYomurTi1y4FvgAewZPWFJj0lp4m95+IsMuHu8fBHwnvN5sTfF
        jr+RWQvY4ol0behPtQgn5DeFvapC
X-Google-Smtp-Source: APXvYqzHWOcxnrpBAllwnI52EY/MwFPB/l0k7AS7KqTpeI9oUjq8rbwMTJNcoUB/ekWaAwh2U5E8aA==
X-Received: by 2002:a5d:6a12:: with SMTP id m18mr2187646wru.306.1566540669790;
        Thu, 22 Aug 2019 23:11:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:34d1:4088:cd1d:73a7? (p200300EA8F047C0034D14088CD1D73A7.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:34d1:4088:cd1d:73a7])
        by smtp.googlemail.com with ESMTPSA id x13sm1678976wmj.12.2019.08.22.23.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 23:11:08 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/4] PCI/ASPM: add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Date:   Fri, 23 Aug 2019 08:11:06 +0200
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

Heiner Kallweit (4):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attributes for controlling ASPM
  PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code

 Documentation/ABI/testing/sysfs-bus-pci |  13 +
 drivers/pci/pci-sysfs.c                 |   6 +-
 drivers/pci/pci.h                       |  12 +-
 drivers/pci/pcie/Kconfig                |   7 -
 drivers/pci/pcie/aspm.c                 | 300 ++++++++++++++++++------
 include/linux/pci-aspm.h                |  10 +-
 6 files changed, 254 insertions(+), 94 deletions(-)

-- 
2.23.0

