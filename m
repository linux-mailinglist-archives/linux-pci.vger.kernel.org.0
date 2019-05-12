Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26571AC85
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 15:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfELNw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 09:52:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53679 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfELNw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 09:52:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so11362040wme.3
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=owLq9vRyOANZjQW/jCCgD8Kccc7qYubdtQ51osS/44k=;
        b=rXwTMWi3gs+WHjyU1DrtFjTuFEELv2jXFAjUOdiplIKqhrXq5iouZxunlppmaBhS7v
         ZTk8fIdzdkxZTP7mhs7oJvvKvfuruRKsWC9JGLa3WMYNh86NgN7TXjEwf3Y2OzoUaD6h
         rrZl5o81/G1iBzktZq+Au/w3dhiD1iJAaKpS7tS6r/RbEMBNWH6MQuC8foosF0yxo+X2
         W6+v80/8F/7GC0XQYMedbNDWdYgprVxNQeV+/osVYTl0GiivvbE0CFtWjUyxh7gxtEqv
         NS2DJePpq1C7EUeeN/YxZCLtyXvGL3BzsDyGvTHserH2QplBDobjmiy03+rK+PihaB1R
         LE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=owLq9vRyOANZjQW/jCCgD8Kccc7qYubdtQ51osS/44k=;
        b=DnyrYi/XBUFmRV9QkWfyLBusb4HJP08t5ve9SuZwYX//+iAWWFHbx5qE/Amza1vdB4
         SCW6jv7iVOCcwk4AmDIkUGj+RUuw7dEjOZ5aiO+TyO4ayw7XWU6X8LkU32199yLJcpqr
         BsS/FldXVoxHGy0Z8nmuhCqE8rXryzVtONjd+kaKExA0qsciQ69Dbkj74IJ5rQDMZGS6
         kqmAN0+3EHDDiLn+OUwrzeK2Lfq2Q9iG8qHFkARS8YOXy2lKKIEi5NwvAJPAD1g5UxFA
         XW2MeXlAGPm2cLLpYzAOg/64AbEaAyv5TWvpqhhUJ6ipBIUECYVK6lb3vWLO9ylrKebn
         EHEg==
X-Gm-Message-State: APjAAAUHQd6aHh3fwsogLxK+l/VsdHqIuQPzGw3aX+e6OZjmfu2Y+Ds9
        KmQ6gK0MNMc4kJDR62VyQ6Z/ZQsDaMA=
X-Google-Smtp-Source: APXvYqzCqDGeiWn72/K+WBf3XL3rEPsB1I/NEpxm1g/OwceSBkB6eunpOZgFSPWEWXQxWYqD7faAXQ==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr13093962wme.128.1557669175598;
        Sun, 12 May 2019 06:52:55 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id z74sm17856437wmc.2.2019.05.12.06.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:52:54 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC v3 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Date:   Sun, 12 May 2019 15:52:46 +0200
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

This is a RFC version, therefore documentation of attribute is
still missing. The attribute handling was inspired by the protocol
attribute handling in drivers/media/rc/rc-main.c.
Attribute syntax in a few words:
none: allow all supported ASPM states
all: disable all ASPM states
+<state>: add state to list of disabled ASPM states
-<state>: re-enable ASPM state if supported

v2:
- bind attribute to the endpoint
v3:
- reverse semantics of attribute
- change attribute name to aspm_link_states to reflect changed semantics

Heiner Kallweit (3):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attribute for controlling ASPM

 drivers/pci/pci.h        |   8 +-
 drivers/pci/pcie/aspm.c  | 204 ++++++++++++++++++++++++++++++++++++---
 include/linux/pci-aspm.h |   8 +-
 3 files changed, 199 insertions(+), 21 deletions(-)

-- 
2.21.0

