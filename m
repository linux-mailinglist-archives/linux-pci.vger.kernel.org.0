Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8637D491E6F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 05:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiARESM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 23:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiARESL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 23:18:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8354C061574;
        Mon, 17 Jan 2022 20:18:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v7so21113897qtw.13;
        Mon, 17 Jan 2022 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9o9DpK13MatKC2a2XKRD5830ZC7rW/olB0VrnJU85A=;
        b=Yfcp6UdyiQWlnGIZvrqrskMM2MxT3MtTXZ7YrMs8/vcaauMXMFMSlCqI4/rHHi1Rlm
         jl6ms4hUrZjIFlGvhKKD5JjbCaeTo9mv0UG5ePgLp/+w8k55BC9mYSIRa60fufVNX1Q4
         m4cklVv6Zqy2CYI25DDnCdAl//gf85kkA3Pj7ORq9AY1EEvTuySED48yKVINDhnU5qGL
         Nla0gIwte27T6CEPOyHIpSFVv2hY4BwJfbpyGiw/lwjpBtougtP5j42LNrI10S5TotK2
         DJ1rj9f31cFrJBuJmOBRAZReK8Sjts5d6zXLoOLRnrrmUM4N7vEWHCH0FLlwjJFEDAqo
         3PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9o9DpK13MatKC2a2XKRD5830ZC7rW/olB0VrnJU85A=;
        b=Py4xZHBN+fYJ4WEULqSdsD47JORtTjnz+lpJ4qaq9XaJMbqe/8cF0RnOXcJc+xesbu
         4UlhzEXJtAd/6w82tC9EZCJ5faaR66QQ4zhpyT6IDzBxK8F4XruBL8U/Gn/jxZk+X+cg
         tHL0kbBI6b7UFfiYhp5N4vxgzubGN7VxA4pozDmuFMSMkb0KeArzC1G62FoNeQTWDIGG
         WV/iGwEhl1OFMxOHhGQ3C7u7a8E4tvS48eLxQNCy6Rq2DFSz9TPcSk7bzXq+l1CwBwEw
         nPLXZ3w35IKNjC+u/r65W0rLNC2JrVPy9EQ3K7+Nxl0m3dLu+zoG4nGOY4bfpcY6SiMe
         Nnmw==
X-Gm-Message-State: AOAM532knhq7LWt16B8HM6ZUlqhUvDR4HXoZNlgsGAMVxOBNzBhdU3xE
        y+MzxV5HVQllTv7RV9zbp6uQ32YSxoBVVg==
X-Google-Smtp-Source: ABdhPJw1CklW48mnzCnPszfAakqZ3eGyOKxF4NWI6hgU9iyEZSO8YE+3Y+zbso61QfOgkeTZyFlU5w==
X-Received: by 2002:ac8:5ccd:: with SMTP id s13mr9582452qta.606.1642479490132;
        Mon, 17 Jan 2022 20:18:10 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d11sm10225479qkn.96.2022.01.17.20.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 20:18:09 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH 0/3] Add PCIe enclosure management support
Date:   Mon, 17 Jan 2022 22:17:55 -0600
Message-Id: <cover.1642460765.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set adds support for two PCIe enclosure management methods,
"Native PCIe Enclosure Management" (defined in the PCI Express Base Spec)
and "_DSM Definitions for PCIe SSD Status LED" (defined in the PCI
Firmware Spec). The latter is very similar to the former, but uses a _DSM
interface (which can be provided by firmware) rather than a PCIe
extended capability.  Each provides a way to control up to ten indicator
states (such as locate, fault, etc.)

There are three patches in the set:

(1) Expands the existing enclosure driver to support more
indicators.

(2) Adds an auxiliary driver "pcie_em" that can attach to auxiliary
devices created by the drivers of any devices that can support PCIe
enclosure management (nvme, pcieport, and cxl).  It will register an
enclosure device with one component for each device with an enclosure
management interface.

(3) Modifies the nvme driver to create an auxiliary device to which the
pcie_em driver can attach.

These patches do not modify the cxl or pcieport drivers to add support,
though the driver was designed to make it easy to do so.
---
Sorry for the long delay in getting this out!
---

Stuart Hayes (3):
  Add support for seven more indicators in enclosure driver
  Add PCIe enclosure management auxiliary driver
  Register auxiliary device for PCIe enclosure management

 drivers/misc/enclosure.c      | 189 ++++++++------
 drivers/nvme/host/pci.c       |  11 +
 drivers/pci/pcie/Kconfig      |   8 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/pcie_em.c    | 473 ++++++++++++++++++++++++++++++++++
 include/linux/enclosure.h     |  22 ++
 include/linux/pcie_em.h       |  97 +++++++
 include/uapi/linux/pci_regs.h |  11 +-
 8 files changed, 733 insertions(+), 79 deletions(-)
 create mode 100644 drivers/pci/pcie/pcie_em.c
 create mode 100644 include/linux/pcie_em.h

-- 
2.31.1

