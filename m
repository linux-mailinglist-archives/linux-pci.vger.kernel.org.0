Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292A413B86E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAOD5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43354 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgAOD5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:02 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001ij-30; Tue, 14 Jan 2020 20:56:59 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnW-0000gQ-KY; Tue, 14 Jan 2020 20:56:50 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:41 -0700
Message-Id: <20200115035648.2578-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 0/7]  Switchtec Gen4 Support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Here are the cleaned up version of the patches for Gen4 support in
switchtec. The end result is mostly the same, save some very minor
changes, but the organization into commits has been reworked per
Bjorn's feedback. This set is also rebased onto pci/switchtec.

A git branch is available here:

https://github.com/sbates130272/linux-p2pmem switchtec-next-v2

Thanks,

Logan

--

Kelvin Cao (2):
  PCI/switchtec: Add gen4 support for the flash information interface
  PCI/switchtec: Introduce gen4 variant IDS in the device ID table

Logan Gunthorpe (5):
  PCI/switchtec: Rename generation specific constants
  PCI/switchtec: Introduce Generation Variable
  PCI/switchtec: Refactor ioctl_flash_part_info()
  PCI/switchtec: Separate out gen3 register structures into unionse
  PCI/switchtec: Add gen4 support for the system info registers

 drivers/pci/quirks.c                 |  18 ++
 drivers/pci/switch/switchtec.c       | 334 +++++++++++++++++++++------
 include/linux/switchtec.h            | 148 ++++++++++--
 include/uapi/linux/switchtec_ioctl.h |  13 +-
 4 files changed, 424 insertions(+), 89 deletions(-)

--
2.20.1
