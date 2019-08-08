Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1418686CD3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 23:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfHHV7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 17:59:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43806 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfHHV64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 17:58:56 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 4f32714b9266bc6e; Thu, 8 Aug 2019 23:58:54 +0200
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
Subject: [PATCH v3 0/2] nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled
Date:   Thu, 08 Aug 2019 23:51:36 +0200
Message-ID: <2184247.yL3mcj2FRQ@kreacher>
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com> <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain> <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM> <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain> <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM> <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com> <20190731221956.GB15795@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxsLAoKPiBUaGlzIHNlcmllcyBpcyBlcXVpdmFsZW50IHRvIHRoZSBmb2xsb3dpbmcgcGF0
Y2g6Cj4gCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTA4MzU1MS8KPiAK
PiBwb3N0ZWQgZWFybGllciB0b2RheS4KPiAKPiBJdCBhZGRyZXNzZXMgcmV2aWV3IGNvbW1lbnRz
IGZyb20gQ2hyaXN0b3BoIGJ5IHNwbGl0dGluZyB0aGUgUENJL1BDSWUgQVNQTQo+IHBhcnQgb2Zm
IHRvIGEgc2VwYXJhdGUgcGF0Y2ggKHBhdGNoIFsxLzJdKSBhbmQgZml4aW5nIGEgZmV3IGRlZmVj
dHMuAAoKU2VuZGluZyB2MyB0byBhZGRyZXNzIHJldmlldyBjb21tZW50cyBmcm9tIEJqb3JuLgoK
VGhhbmtzIQoKCgo=




