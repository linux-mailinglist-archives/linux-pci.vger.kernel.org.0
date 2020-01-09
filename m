Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671CD13601E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbgAISXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 13:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgAISXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 13:23:36 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209FD2072A;
        Thu,  9 Jan 2020 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578594215;
        bh=TYSYJuiJnxFUF6CsQMjqkB8W/GhMj9NMoeGBvL4s6lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bAjHJV+yNW8CaPIMOR3CGaOr/6NavzY8U42j0xV/hIm+5w6DR+647oWb+qAlLMg2K
         d0b+h68Ci/u/XOM8EnRUUO+KSoWo8gHWZjwomjtTXwyEUqfhjrTfI4mgPa/LixLwcz
         iA5IGoH0FsugZBbeOn3SwRiZdV8+SnSOJtS6QqSo=
Date:   Thu, 9 Jan 2020 12:23:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     David Engraf <david.engraf@sysgo.com>, thierry.reding@gmail.com,
        andrew.murray@arm.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v2] PCI: tegra: Fix return value check of
 pm_runtime_get_sync
Message-ID: <20200109182333.GA252736@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109121309.GB10919@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 12:13:09PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 17, 2019 at 08:36:32AM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 16, 2019 at 12:18:25PM +0100, David Engraf wrote:
> > > pm_runtime_get_sync() returns the device's usage counter. This might
> > > be >0 if the device is already powered up or CONFIG_PM is disabled.
> > > 
> > > Abort probe function on real error only.
> > > 
> > > Fixes: da76ba50963b ("PCI: tegra: Add power management support")
> > > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> > 
> > I added Andrew's ack and a stable tag for v4.17+.  Also cc'd
> > Manikanta, author of da76ba50963b.
> > 
> > I put this on my pci/host-tegra branch for v5.6 for now.  Lorenzo may
> > move this when he returns.
> 
> Hi Bjorn,
> 
> I could not find pci/host-tegra in your public repo, have you deleted it
> in the meanwhile ?

Welcome back, Lorenzo!  Sorry, I forgot to push the pci/host-tegra
branch.  It has been in -next for a while, though.  I pushed it now.
Happy to drop the branch if you want to add more Tegra stuff, just let
me know.

Bjorn
