Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92F9C40D0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfJATQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 15:16:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51786 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJATQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 15:16:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4604190wme.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GIO7GJfJxKMwKP+/m88jvKHnSu/jI3oDBt/ADTnsBaY=;
        b=aiBbUiCGuicmMJkbzyKknGydd4RsfO9wSwSnRPcIxv1FzFDspoyUsQ3nhiBbvQn1JU
         SlnsPw/ElbGmpOP/76QPO7bP1XIhWi43rSkj7fy1LNO3G+/ofEp4GVER0NLEX/r4N5p5
         xxtkCOFbWDVNegFlPHxI36tTEqxlV5KCEibY2+XdvKews/pOmIXrbWac+Bth5gTpQy7Z
         pKFteO+V59ngFTwL2Bp/U9iQrlcHJFHnlSINA5QaAs1JnOvzmQCbGRAv/ntRpWJ4TLMw
         ayyes1yKRNCK3YkwJWGk5ZsaEO9Sp5I2qMDo5z0v7jnO8DyC5TXrXED0pUKBclN6SIQQ
         NXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GIO7GJfJxKMwKP+/m88jvKHnSu/jI3oDBt/ADTnsBaY=;
        b=Y6Z5urO7TD4POmPBtsceZFIOgwnO7+Inm7k4aJUxBA/LPDCOkvkUT4Hf4LhyuzrWjd
         RhMEq/XT01hlHwL63+CQ2Ts2vv05pB7qivUfq25s3qbUhlQPGACfqFuPxJWC/iSHOxGz
         6nFGMuxjMW+wAQwcBiZyxzRX1MltoyOzGQdigF3U5qNFLwIQAhK38lJTcQKjPnm+pi8D
         st18fCUST8SA1Ar39vNPvPHYJ7wNCoFaN0bD969l7y3ozSCKr4NBIW5NTE+dI902UxCT
         lItsLsMLWURR7RnbC5CrMfX80DE+qG2Yv3lfoxBFMQy2rnjXzerYpTAe3ifs+P4ZLZHx
         JOAQ==
X-Gm-Message-State: APjAAAW5Acae985MjkBoeWWTbi/MAT9th1vNT7gUxWXj0XP63TQBO4IN
        Uk5sCjvA7qHHMaAYiTUzhdDdXNYT
X-Google-Smtp-Source: APXvYqxQazMqr2phNTQiVKp5hdSNLVYBA/q8Z+ifLZD1nbxsyzYXA3OjSOtq7SQpeHMAoXRmoDXanQ==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr4706849wmj.173.1569957361070;
        Tue, 01 Oct 2019 12:16:01 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:ad11:16fb:d8da:de15? (p200300EA8F266400AD1116FBD8DADE15.dip0.t-ipconnect.de. [2003:ea:8f26:6400:ad11:16fb:d8da:de15])
        by smtp.googlemail.com with ESMTPSA id j1sm36726150wrg.24.2019.10.01.12.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:16:00 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v6 0/4] PCI/ASPM: Add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <0577b966-6290-0685-123d-c675baf97caa@gmail.com>
Date:   Tue, 1 Oct 2019 21:15:53 +0200
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

v6:
- patch 3: consider several review comments from Bjorn
- patch 4: add discussion link to commit message

Heiner Kallweit (4):
  PCI/ASPM: Add L1 PM Substate support to pci_disable_link_state
  PCI/ASPM: Allow to re-enable Clock PM
  PCI/ASPM: Add sysfs attributes for controlling ASPM link states
  PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and related code

 Documentation/ABI/testing/sysfs-bus-pci |  14 ++
 drivers/pci/pci-sysfs.c                 |  10 +-
 drivers/pci/pci.h                       |  12 +-
 drivers/pci/pcie/Kconfig                |   7 -
 drivers/pci/pcie/aspm.c                 | 246 +++++++++++++++++-------
 include/linux/pci.h                     |  10 +-
 6 files changed, 206 insertions(+), 93 deletions(-)

-- 
2.23.0

