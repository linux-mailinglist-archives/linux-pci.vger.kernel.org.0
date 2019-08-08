Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6349385F4B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbfHHKKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 06:10:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54224 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389793AbfHHKKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 06:10:44 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 12a2dc33bd81580e; Thu, 8 Aug 2019 12:10:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-nvme <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 0/2] nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled
Date:   Thu, 08 Aug 2019 12:03:09 +0200
Message-ID: <1921165.pTveHRX1Co@kreacher>
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com> <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain> <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM> <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain> <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM> <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com> <20190731221956.GB15795@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This series is equivalent to the following patch:

https://patchwork.kernel.org/patch/11083551/

posted earlier today.

It addresses review comments from Christoph by splitting the PCI/PCIe ASPM part
off to a separate patch (patch [1/2]) and fixing a few defects.

Thanks!



