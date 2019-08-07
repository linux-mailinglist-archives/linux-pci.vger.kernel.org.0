Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA66849F8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfHGKn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 06:43:58 -0400
Received: from verein.lst.de ([213.95.11.211]:36478 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387433AbfHGKn6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 06:43:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 998CC68AFE; Wed,  7 Aug 2019 12:43:53 +0200 (CEST)
Date:   Wed, 7 Aug 2019 12:43:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being
 used
Message-ID: <20190807104353.GA11356@lst.de>
References: <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain> <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM> <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain> <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM> <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com> <20190731221956.GB15795@localhost.localdomain> <1893355.EP2830DdO9@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1893355.EP2830DdO9@kreacher>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	if (pm_suspend_via_firmware() || !ctrl->npss || !pcie_aspm_enabled(pdev)) {



> +	mutex_lock(&aspm_lock);
> +	aspm_enabled = bridge->link_state ? bridge->link_state->aspm_enabled : 0;

Please fix the overly long lines..
