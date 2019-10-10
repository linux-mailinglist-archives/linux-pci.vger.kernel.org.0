Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9221ED2BF3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJJOB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 10:01:27 -0400
Received: from verein.lst.de ([213.95.11.211]:58372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJOB1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 10:01:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1F5468C65; Thu, 10 Oct 2019 16:01:21 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:01:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary
 locking
Message-ID: <20191010140121.GA31701@lst.de>
References: <20191010124746.2882-1-helgaas@kernel.org> <20191010124746.2882-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010124746.2882-2-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 07:47:46AM -0500, Bjorn Helgaas wrote:
> +	return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;

Can we unobsfucated this while we're at it?

	if (!bridge->link_state)
		return false;
	return bridge->link_state->aspm_enabled;
