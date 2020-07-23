Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7722B74B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGWUOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 16:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 16:14:05 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EC220792;
        Thu, 23 Jul 2020 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535245;
        bh=38Ha0i2OURRFTebqAjdv1F43niWTps8Plj2Z/f94/uE=;
        h=Date:From:To:Cc:Subject:From;
        b=F00goI8F1fGtZvCqfTa0VzK236bTBjwKdmIXfKZ1JRYun3qN4X2Bxzvt2hvptNREZ
         D8WBWgm2A71LaTEnU8K156EUB1pFc8ur24D513w5E4PXO29Vs9+GNgCmLJUYBprqqP
         ARTgnc114As0emsj6Qui3NY3wsfAeZvxwVt4b+hQ=
Date:   Thu, 23 Jul 2020 15:14:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: touchpad doesn't work at all on ACER Spin 5
Message-ID: <20200723201403.GA1450503@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Anybody interested in looking at this issue?
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1884232

It looks like something wrong in the way we handle "reserved" regions
in the e820 map with respect to PCI address assignment.

BIOS programmed BAR 0 to [mem 0xfe010000-0xfe010fff], but according to
the PCI0 _CRS method, that area is not routed to the PCI bus:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x3f800000-0xbfffffff window]
  pci 0000:00:1f.5: [8086:34a4] type 00 class 0x0c8000
  pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
  pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
  pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
  pci 0000:00:1f.5: BAR 0: trying firmware assignment [mem 0xfe010000-0xfe010fff]
  pci 0000:00:1f.5: BAR 0: [mem 0xfe010000-0xfe010fff] conflicts with Reserved [mem 0xfc800000-0xfe7fffff]
  pci 0000:00:1f.5: BAR 0: failed to assign [mem size 0x00001000]
