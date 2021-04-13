Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CFE35E6D8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbhDMTFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 15:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhDMTFb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 15:05:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F37F9613CA;
        Tue, 13 Apr 2021 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618340711;
        bh=4Ni2D0JUJ42Est7AJ0WpTT8dYYJFoHWL2Gb1omodwC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E5tOj1ht7JAZoA45fjn5AJPCOcYkUxA6HJR0noeyrwa0ogD1ofa+bAfI/4gy9GRAt
         zcSV7bWTOSQ64roa6Bfwe4x48tAuqG3Tx5zO3fbr8NhZB3J86SFA109BXiXhKxDyl4
         MDSN+61Bf0p8Rq1jurlKFVNLiRTdBHMdW5ccdYQ7FhuS+1bOL4Je3dbCueP5CjFQ2S
         bWueyMhZRODLv8geYEgzBuBBhjm/08so5aJf6uefuYyiDOulL4UHysVJcgzdrYpzsy
         0jDiXfEh80Hl0sZbCn7iM4VVeGwZR2UvInbWe+BvGPMVzOnMcal0S/eVcQ4gpnLcKV
         Ez3CDMD1OBJ3A==
Date:   Tue, 13 Apr 2021 14:05:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        robh@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: Device driver location for the PCIe root port's DMA engine
Message-ID: <20210413190509.GA2256814@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe57865-41f8-67c5-e6a6-9abe7252591c@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 11:42:15PM +0530, Vidya Sagar wrote:
> On 4/13/2021 3:23 AM, Bjorn Helgaas wrote:

> > The existing port services (AER, DPC, hotplug, etc) are things the
> > device advertises via the PCI Capabilities defined by the generic PCIe
> > spec, and in my opinion the support for them should be directly part
> > of the PCI core and activated when the relevant Capability is present.
> Is there an on-going activity to remove port service drivers are move
> AER/DPC/Hotplug etc.. handling within PCI core?

No, not that I'm aware of.  I'd just like to avoid extending that
model.

Bjorn
