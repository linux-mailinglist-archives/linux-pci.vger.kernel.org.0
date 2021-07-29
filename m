Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683893DAB1F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2Smo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhG2Smn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D7A60F4B;
        Thu, 29 Jul 2021 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584159;
        bh=giqfi5RjpNKGDI8AfANrtGogs1pVhcNtZoy1PqvKgjM=;
        h=From:To:Cc:Subject:Date:From;
        b=Fr9FCbK5m5Va72ZW++cWDIFuzm7ob4RGVfkRmjQluoaRKs9bEBlafza6ZW97qw/UB
         wb/k5ak+YpspMmn26WKfqMpAW7EIJrNvy5bkjBR486Mszj0D2ir56R1kD+2GokYp0Y
         i+VdSpeT/MgGbTW244Ei3Sk/k6Edm0ROF+3xATkrHOndnxZlHGcMwgYPhjNvu6TEng
         cv7ciBNWUBLC4detFmrgT8oEC4hZZDvdXd8qNkolMOS9URBYupU8sbL2TFnJd3jPmr
         2OyaiEIPaKeZuSYloPpWGd+rBHsrm6hie8Bgyh4hM2gY3wM+0uR5MAwARjEZcMOZDA
         vE3jzuXf1FDSA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/6] PCI/VPD: pci_vpd_size() cleanups
Date:   Thu, 29 Jul 2021 13:42:28 -0500
Message-Id: <20210729184234.976924-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The basic idea is to validate VPD resource *size* without validating the
actual content, since the kernel really doesn't care about the content.

Thanks very much for the feedback on v1, and I'd be glad for any additional
feedback.

Follow-up to:
https://lore.kernel.org/r/20210715215959.2014576-1-helgaas@kernel.org

Changes since v1:
  - Incorporate Heiner's patch to reject VPD if first byte is 0x00 or 0xff
    (https://lore.kernel.org/r/8de8c906-9284-93b9-bb44-4ffdc3470740@gmail.com/)
  - Update size checks to reject resources that would extend past the
    maximum VPD size

Bjorn Helgaas (5):
  PCI/VPD: Correct diagnostic for VPD read failure
  PCI/VPD: Check Resource Item Names against those valid for type
  PCI/VPD: Reject resource tags with invalid size
  PCI/VPD: Don't check Large Resource Item Names for validity
  PCI/VPD: Allow access to valid parts of VPD if some is invalid

Heiner Kallweit (1):
  PCI/VPD: Treat initial 0xff as missing EEPROM

 drivers/pci/vpd.c | 55 +++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

-- 
2.25.1

