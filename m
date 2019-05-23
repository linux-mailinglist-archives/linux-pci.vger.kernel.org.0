Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6036028B39
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfEWUDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:03:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfEWUDV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:03:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id e15so7609187wrs.4
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NKz0b8B4MODduZKitm8Apz87Ur79qI+/8NwQeigp/Rk=;
        b=Y+aqVBbgNeyVMZlLyQTTVz48BLxmkrkVC2GI6W7V2pxaqSA2V0HmH6g2PQXAvhqjJp
         fcPr3XZH3RW9UK3HKSBwq4VOWOqT5bj+XzPJFFKlNIP2fzhYa2+2yjbvUleAqdybCRvI
         Op5Y+D/PrWHUdM+krxYIQaHc7KIxPiEB+zqT3kIV1leagsnqeRpOWKVInNUECvrGcU6o
         3FwaXFVs/CGyc9C+ZuilY/tnGBMCuHdyVsbCXGi5plNFygMe2UkYhlBpvW9VMUcxlp8i
         kwduVSSjXVp5PegDCIxpeEyW5k0GCInYbiqAVxcGPTLqPWLFe/YqqxWDrwyfqmmUSUuV
         zNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NKz0b8B4MODduZKitm8Apz87Ur79qI+/8NwQeigp/Rk=;
        b=ZQw5pDzoTZXmb/ELODVh16140ctjUOVzITwzo/DMKSbryDaTp9jGd4BnFOW0Q48Um6
         +AxQggY3Ly/9+JgT0fcVN736OVHSM3O5iYzAbUkPXzZWxIUxJV50EzzZJOvqBMRFFM9S
         o40QMmuMH1my+g66x+OFWudVCgUrbQ27u1GGDueub28d+QgwJRXCLBxihOw5JrKnEW5w
         7q27GpxgXIIkW4O+ZTycBK8G5AysJvRjpMZDBA3ky+lmkH6vQNS4t278U8zcYJnnzfjs
         j0gD3281+7k3vRsSLnVT+eslm4LK8qDjYaZfaQaD2k40x48weuEHYGh/EGMpgBFcgheV
         yVPg==
X-Gm-Message-State: APjAAAVapDlu+bU9W4GS1olNOQl9h6vADdCiPI8+ODH0TycA9gOXPkru
        tqrWH2NwsSTplNkFjsBF0jJUd0AL
X-Google-Smtp-Source: APXvYqwpjq+b1AC0UG0GJPOjXa9Hc216nF7tESaFLFywCTuHQ6KfugshNkBBpyh4stOsY7UqFj0d+g==
X-Received: by 2002:adf:d4c4:: with SMTP id w4mr7687781wrk.254.1558641799411;
        Thu, 23 May 2019 13:03:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0? (p200300EA8BE97A003CD1E8FED810B3F0.dip0.t-ipconnect.de. [2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0])
        by smtp.googlemail.com with ESMTPSA id j206sm813710wma.47.2019.05.23.13.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:03:18 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Date:   Thu, 23 May 2019 22:03:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
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
ASPM. With the new sysfs attribute users can control which ASPM
link-states are disabled.

After few RFC's this is the submission-ready version. Added to the RFC
version has been documentation of the new sysfs attribute.

Heiner Kallweit (3):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attribute for controlling ASPM

 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci.h                       |   8 +-
 drivers/pci/pcie/aspm.c                 | 211 ++++++++++++++++++++++--
 include/linux/pci-aspm.h                |   8 +-
 4 files changed, 219 insertions(+), 21 deletions(-)

-- 
2.21.0

