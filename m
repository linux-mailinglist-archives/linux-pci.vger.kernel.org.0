Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9C98279
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHUSOX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 14:14:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39284 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUSOW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 14:14:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so2932835wra.6
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2019 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KPEd3xKNdQ7XpPaQERMC0lbJMBtjmYGl6YTcFqi/auY=;
        b=NaDLTAf2+ywWMjZpS0O54SolNJckVQJg9PS9IOTzGrHCaZ+0LfhartEc7KVZZJo3F/
         mIwUzycSMftIiirX3WNyCfDacNV5HdST/9kjQ+eKbjAvhlUZbJRTgVYfec8+OjUFXsH/
         TZMexRbpdkOFvjo+FcTwf+8sXAG+NrS8TkV3YwkoMb7Dhef64K89Nlt3Lq91+2FELCc8
         KU5o3HKgcxZ2yDwMut/egUM4/mNL5ACuF/k+9URwcFMTFBq3WYBzf1OlTarRTor9NfVK
         itQ0QmeeD+sD1xwxPLrigu21fTj0hjSbyE8qi7jOud5j1KikUgKVnX2Js2RvYxi/3jzH
         KXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KPEd3xKNdQ7XpPaQERMC0lbJMBtjmYGl6YTcFqi/auY=;
        b=RQr6S7XGuppLoFmfr/H3XNUfoMzRcyGtUZ8ULtc8skkCyb5/moMLGeIhH5u66ktIB2
         xB/QPcbvYZtPMTGhDY4lQ4SAQewdQyY3yhogURD/InF8LWlw0dixmTNqzjuQ0Cc2mEoY
         IYRG9HFxtLTNRALNXP4TggwMjAH2J5GY0KAYhnJTRQ1IfN4RImI8li/VSlMMyrsR1IPO
         Hrx4KJTO6RaO7QqPFFwp41USmSQO5rXmDUEr+sQ7t2eCPC4u3ObZd1r3+FZtINrtFukN
         cgmI6ZxZf1K/OSgkVyw7buzFGS5ryjEoGo+cTEWArMFFHLupClfX4G2Kc3yFt8g+EApY
         mM2A==
X-Gm-Message-State: APjAAAXj5N44zz5aMnVe3Ut7UHOM7fUVUa+urb5jkMZD8erLUqN2/iJS
        mgitrZwQnmQIFdI7G6Ck5iQuePL/
X-Google-Smtp-Source: APXvYqxG3jcUX6Z82beM70sqKZC+ktJbc7xTTEHqprr/YunBud5HcbqJQilonFd0WeGrJ79SS5s8Ug==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr40053050wrr.5.1566411260632;
        Wed, 21 Aug 2019 11:14:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:3d5d:5315:9e29:1daf? (p200300EA8F047C003D5D53159E291DAF.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:3d5d:5315:9e29:1daf])
        by smtp.googlemail.com with ESMTPSA id f17sm1305062wmj.27.2019.08.21.11.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 11:14:19 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/3] PCI/ASPM: add sysfs attributes for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <b4b1518a-d0e8-9534-5211-115107e770e1@gmail.com>
Date:   Wed, 21 Aug 2019 20:14:13 +0200
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

Heiner Kallweit (3):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attributes for controlling ASPM

 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci.h                       |   8 +-
 drivers/pci/pcie/aspm.c                 | 292 +++++++++++++++++++++++-
 include/linux/pci-aspm.h                |  10 +-
 4 files changed, 304 insertions(+), 19 deletions(-)

-- 
2.23.0

