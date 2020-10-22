Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B52963CB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 19:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900422AbgJVRa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899736AbgJVRa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 13:30:56 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A5D24182;
        Thu, 22 Oct 2020 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603387856;
        bh=e1OOWqlK+6yiPgodm4SQjI0ssftJYqWaV/GuAXEtKic=;
        h=Date:From:To:Cc:Subject:From;
        b=Du3sro8N/tjfYugZK+ABSKOcHVkMqIWaY2uN0FTQXvjhUzpN5fvb/7b481GLWTEj6
         y6hu2vMYRn1/U5926JMzs8ZDYzMU0puqaH21BM7c7AMtbxSbyfKOwZXS/PmGOeuFXX
         qGNVly0sHvnoehJS8pxkua3XW9zQp2QcBzPDwuoM=
Date:   Thu, 22 Oct 2020 12:30:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, vtolkm@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Subject: [Bug 209729] mvebu-pcie soc:pcie: resource collision
Message-ID: <20201022173054.GA511367@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209729

From the bugzilla:

  device: Turris Omnia (armv7l)

  kernel log:

  mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
  mvebu-pcie soc:pcie: Parsing ranges property...
  mvebu-pcie soc:pcie: MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
  mvebu-pcie soc:pcie: MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
  mvebu-pcie soc:pcie: MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
  mvebu-pcie soc:pcie: MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
  mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
  mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
  mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
  mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
  mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
  mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
  mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
  mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
  mvebu-pcie soc:pcie: resource collision: [mem 0xf1080000-0xf1081fff] conflicts with pcie [mem 0xf1080000-0xf1081fff]
  mvebu-pcie: probe of soc:pcie failed with error -16

  As a result PCIe devices, e.g. WLan cards, are not working.
