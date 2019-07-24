Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6E74230
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfGXXjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33906 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfGXXjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:20 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so93373749iot.1;
        Wed, 24 Jul 2019 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3iIbJ0dyzLPcLNLbe+AX/Y9B3LDQpKTXad3EmEUSck=;
        b=q8hD3OZdBlimV/ETXAcP/aPEviR6S4cRERMVGXsMPdavSeh4zFFZmLuF0YIiLAXsaA
         AbawGCKbMlr5oim0/w0vsXvvfqEBTcEsHTa5UGReuax5W/OucfY5bN734n7pyjRJZw4o
         bF7iIhctQX5mze2zzqO8Y7XqK1xShIcthDXXFY0BRStabv9C/PbFVw7BywSPbggLaDyR
         BK2P5xDJwguTF1QCWjndi7lqg2XlK8Coxo9kHo7bjs+IRoteJ9exJsv5yrEs/dR2Ux8N
         wLzS3f0wWUxdMBOn0IRf82OHiHD/Y08YZGmBP2bN2IyEWSdXKNQ5PVwQ5OThQp9hWHWo
         jyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3iIbJ0dyzLPcLNLbe+AX/Y9B3LDQpKTXad3EmEUSck=;
        b=Y6X+sjGAizywBWSx5d2+i/6b3EiNzZ8Gb432S/S7TRIPhgQ90ct9IqD37AcdvMT9ki
         Ba6mt0DRnJGAY2K0MSpsNab1FHxh6MOiEu7B9UMrA+ePEhWeuOv2ZEhiwn+yn+i0oRHz
         yLOUa44YsnXBFYrZocB0I2P2hGAbYaQdG3+9F2WB+ussBjYqxj83SGw3nHQRuu6HmuYk
         xZvVHiPbwH6r/xVL3qOYE4M6zXaeJsjYRBXkHc2bic3jHxlycijgs3WEJfxBnxvg0Ow6
         QxPDZb/Bq/ekG8Lx7OlsoZaRJjxeEAnVd8tGUgXZSYrEGhS0nFAmfzAxJZkoOHSB7Uf2
         BdJw==
X-Gm-Message-State: APjAAAUSdf71Oi2zDYuQ9YGj4nP+DA1H0xLqM95a3DR5QIPcp7klheji
        6npYkNAUyDelkUIvmW1H0pQ=
X-Google-Smtp-Source: APXvYqwruFRVqnNiWS2Tjtkr5Ytjv8WQoRsAjgH2JEMd0UmgbEOVH+gevgfw4GZdlVuw1OHFYvc3gQ==
X-Received: by 2002:a02:9a03:: with SMTP id b3mr89940454jal.0.1564011559036;
        Wed, 24 Jul 2019 16:39:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:17 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 00/11] Hide PCI symbols that don't need to be global
Date:   Wed, 24 Jul 2019 17:38:37 -0600
Message-Id: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The include/linux/pci.h header file defines several symbols that are used
only in drivers/pci/. These symbols do not need to be visible to the rest
of the kernel. Move PCI symbols that are only used in drivers/pci/ to
drivers/pci/pci.h.

Changes in v2:
        - Built patches to work with v5.3-rc1
        - Changed line lengths on commit logs to stay below 80 characters
	- Changed cover-letter log to better explain patch series


Kelsey Skunberg (11):
  PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
  PCI: Move PME declarations to drivers/pci/pci.h
  PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
  PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
  PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
  PCI: Move pci_bus_* declarations to drivers/pci/pci.h
  PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
  PCI: Move pci_ats_init() to drivers/pci/pci.h
  PCI: Move ECRC declarations to drivers/pci/pci.h
  PCI: Move PTM declaration to drivers/pci/pci.h
  PCI: Move pci_*_node() declarations to drivers/pci/pci.h

 drivers/pci/pci.h   | 48 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h | 47 --------------------------------------------
 2 files changed, 45 insertions(+), 50 deletions(-)

-- 
2.20.1

