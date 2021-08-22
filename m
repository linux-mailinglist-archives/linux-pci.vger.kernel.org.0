Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA13F3F8B
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhHVNrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhHVNrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 09:47:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41865C061575;
        Sun, 22 Aug 2021 06:46:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k29so21912132wrd.7;
        Sun, 22 Aug 2021 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sfDQQYQpgFy68AcFLsr9ziLQ/Z630LuIi0eJC2Q61rg=;
        b=ol1hhBSCOLm1OXXs+wpHwP/5J1TLCHXoZIAEz4Lz0yPB/15ffEChwX68xAVyeEWLc2
         uOe/G5lKUf3djGrWamWXxSfvO9aDrsNy3UIQHmaDNHqiFl9xHVtvBLNlK2gQ+08RbrAw
         kRP24L2lYxAha+LnduMwHGkdiZUpN1Z9buXreS2C0y53nG338O8m8Q1xBKIyrBao+lsB
         HmBKFf+ft0XC55yWtyv6x7BU+Zj6uAp3caxvj7mI2Oww7LrxnXLjOt3rHtHFGfGv5vBC
         VhCCW3d7exesWZkNHvkM4/p59IEawK26J8QIJ9jrL2wfr1wuzGUrrEPZQIj4IWvgpzGM
         8tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sfDQQYQpgFy68AcFLsr9ziLQ/Z630LuIi0eJC2Q61rg=;
        b=HftJXYjtgQDqRu49L2ZfOUWCdCX5TPEjiRGVgYgFJyCkJmfOZHAkI7U5fHodyDWD/F
         0rheYmBIdIgUrWpwzu9UqYBUa8ISIrhR5w5sVqd6EqHfAZyJVywhlGq0bBLe9CQ2wfwM
         okEbbttetLU4yLa8qI26E7b84vGfriZnkmjSZsAWIpUuea6JxsSxQ761jgO+YYvrvI+f
         A+ssUbWgAoxl0GrYBEL8jz+jImAPIlmnhvMhCNBszmiscBeqyjKhZT2LS4onfdyVuV5X
         luHy01ZHvw+mg0Sy9Jo2GLhq3O4gc3Pu++FBSg5VYIg1y58z0CR4YLM4cFMWwNtildpz
         7QnQ==
X-Gm-Message-State: AOAM532HCtzCzngfHXj0vrcKj6otb8XRL4fq7yLSFrfSZKbU5AIMXeMS
        Np5bjaALxeTTZyEn34Wf6G9JqeIfsh3LBw==
X-Google-Smtp-Source: ABdhPJzgqRtwHg2pg1YzwfBr1t3hyB6Lne7rMSR3vFixs/x8UdUHZ3vtk/F96taTuBwxbhNPXnQSBg==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr8888551wru.24.1629639986567;
        Sun, 22 Aug 2021 06:46:26 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:fc53:5e22:f926:c43b? (p200300ea8f084500fc535e22f926c43b.dip0.t-ipconnect.de. [2003:ea:8f08:4500:fc53:5e22:f926:c43b])
        by smtp.googlemail.com with ESMTPSA id o17sm4896551wrm.8.2021.08.22.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 06:46:26 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        Michael Chan <michael.chan@broadcom.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 00/12] PCI/VPD: Convert more users to the new VPD API
 functions
Message-ID: <1ca29408-7bc7-4da5-59c7-87893c9e0442@gmail.com>
Date:   Sun, 22 Aug 2021 15:46:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series converts more users to the new VPD API functions.

bnx2 patches have been tested with a BCM5709 card.
The other patches are compile-tested, except cxlflash.

Heiner Kallweit (12):
  sfc: falcon: Read VPD with pci_vpd_alloc()
  sfc: falcon: Search VPD with pci_vpd_find_ro_info_keyword()
  bnx2: Search VPD with pci_vpd_find_ro_info_keyword()
  bnx2: Replace open-coded version with swab32s()
  bnx2x: Read VPD with pci_vpd_alloc()
  bnx2x: Search VPD with pci_vpd_find_ro_info_keyword()
  bnxt: Read VPD with pci_vpd_alloc()
  bnxt: Search VPD with pci_vpd_find_ro_info_keyword()
  cxgb4: Validate VPD checksum with pci_vpd_check_csum()
  cxgb4: Remove unused vpd_param member ec
  cxgb4: Search VPD with pci_vpd_find_ro_info_keyword()
  scsi: cxlflash: Search VPD with pci_vpd_find_ro_info_keyword()

 drivers/net/ethernet/broadcom/bnx2.c          | 46 +++-------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  1 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 91 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 49 +++-------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  2 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 76 ++++++----------
 drivers/net/ethernet/sfc/falcon/efx.c         | 79 ++++------------
 drivers/scsi/cxlflash/main.c                  | 34 ++-----
 8 files changed, 98 insertions(+), 280 deletions(-)

-- 
2.33.0

