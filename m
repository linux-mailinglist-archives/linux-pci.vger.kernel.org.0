Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422B91358F4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 13:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgAIMNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 07:13:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbgAIMNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 07:13:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963BA31B;
        Thu,  9 Jan 2020 04:13:12 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E843F534;
        Thu,  9 Jan 2020 04:13:11 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:13:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Engraf <david.engraf@sysgo.com>, thierry.reding@gmail.com,
        andrew.murray@arm.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v2] PCI: tegra: Fix return value check of
 pm_runtime_get_sync
Message-ID: <20200109121309.GB10919@e121166-lin.cambridge.arm.com>
References: <20191216111825.28136-1-david.engraf@sysgo.com>
 <20191217143632.GA160591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217143632.GA160591@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 08:36:32AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 16, 2019 at 12:18:25PM +0100, David Engraf wrote:
> > pm_runtime_get_sync() returns the device's usage counter. This might
> > be >0 if the device is already powered up or CONFIG_PM is disabled.
> > 
> > Abort probe function on real error only.
> > 
> > Fixes: da76ba50963b ("PCI: tegra: Add power management support")
> > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
> I added Andrew's ack and a stable tag for v4.17+.  Also cc'd
> Manikanta, author of da76ba50963b.
> 
> I put this on my pci/host-tegra branch for v5.6 for now.  Lorenzo may
> move this when he returns.

Hi Bjorn,

I could not find pci/host-tegra in your public repo, have you deleted it
in the meanwhile ?

I am happy to merge it myself, asking to check if there is anything
I am missing.

Thanks,
Lorenzo
