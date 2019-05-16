Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE120844
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPNe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 09:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPNe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 May 2019 09:34:28 -0400
Received: from localhost (50-82-73-190.client.mchsi.com [50.82.73.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6EB2082E;
        Thu, 16 May 2019 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558013667;
        bh=PBPZzcKd0Z8uWoCgQKHE0hud8HInbi5Qz300gJ1ZCa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev7849NFKxRx5zGJKMpGlDGI4a4fgEQWXOAnjyB15r1743IVrj/AqKQhSAOJzrRdv
         TRKLOZKNE2WUkVzKU9wboToh/XPA1fFvCSt6qaEpn64neel1l9y4eff4ImEzwN61N0
         vEEPb0jY5bWsnzmxfKOLHMdHuyTgYlJYHjflOvts=
Date:   Thu, 16 May 2019 08:34:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190516133426.GC101793@google.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 14, 2019 at 09:00:19AM +0530, Vidya Sagar wrote:
> On 5/13/2019 12:55 PM, Christoph Hellwig wrote:
> > On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
> > > Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
> > > using these APIs be able to build as loadable modules.
> > 
> > But this is a global setting.  If you root port is broken you need
> > a per-rootport quirk instead.
> > 
> There is nothing broken in Tegra194 root port as such, rather, this
> is more of software configuration choice and we are going with
> legacy interrupts than MSI interrupts (as Tegra194 doesn't support
> raising PME interrupts through MSI and please note that this doesn't
> mean root port is broken).

I think the port *is* broken.  PCIe r4.0, sec 6.1.6, says

  If the Root Port is enabled for edge-triggered interrupt signaling
  using MSI or MSI-X, an interrupt message must be sent every time the
  logical AND of the following conditions transitions from FALSE to
  TRUE:

    * The associated vector is unmasked (not applicable if MSI does
      not support PVM).

    * The PME Interrupt Enable bit in the Root Control register is set
      to 1b.

    * The PME Status bit in the Root Status register is set.

The Tegra194 root port advertises MSI support, so the above should
apply.

> Since Tegra194 has only Synopsys DesignWare core based host
> controllers and not any other hosts, I think it is fine to call this
> API in driver.

It's fine to add a per-device quirk to set pdev->no_msi or something
similar.

Bjorn
