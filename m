Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD83A1AEE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhFIQcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 12:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232165AbhFIQcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 12:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CD2613BF;
        Wed,  9 Jun 2021 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623256212;
        bh=sZcOJ7luK3oY+8m3Y2hGIPBy4OR8/aFohpS3cOiI7r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gxL1yNangmPnHNjqXpKb+Z9MNI3Y4p+u/4dT2OZOL3JUFq5gdyPNiK8GlC6Jrk7Lt
         TquacCBxxRCce3k2w8kNmSWuIxCqHAfZDNwJbCp4cxVZqijtkvjycxLc54s7SSTAE6
         pVwXVdKhN3vGWIBPOlIdLNz7pqERK8JnLmWo3XmPtH3ve8Vyl3+Ru8GLEK7fPXcCol
         +OlBhAMJ3qRO9YELLn7JK6mRzoGeZI1jYKZWmlR1xkQMRZJ5YEiiZ1+SF8B66Kt5Cp
         qY+EtIcNwi/D8hGj5D/x1cvjHdkgg/0mPVyAs/c04mkkZGlCDNzbkE9VojW9etrcB/
         kb8+OmskXw6Kw==
Date:   Wed, 9 Jun 2021 11:30:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        amurray@thegoodpenguin.co.uk, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query regarding the use of pcie-designware-plat.c file
Message-ID: <20210609163010.GA2643779@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
> Hi,
> I would like to know what is the use of pcie-designware-plat.c file. This
> looks like a skeleton file and can't really work with any specific hardware
> as such.
> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
> present and its configuration is enabled (Ex:- Tegra194 system with
> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
> pcie-designware-plat.c called first (because all DWC based PCIe controller
> nodes have "snps,dw-pcie" compatibility string) and can crash the system.

What's the crash?  If a device claims to be compatible with
"snps,dw-pcie" and pcie-designware-plat.c claims to know how to
operate "snps,dw-pcie" devices, it seems like something is wrong.

"snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
might not know how to operate device-specific details of some of those
devices, but basic functionality should work and it certainly
shouldn't crash.

Bjorn
