Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1625349B2D2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381380AbiAYLSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 06:18:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59802 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354601AbiAYLQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 06:16:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB0C61675;
        Tue, 25 Jan 2022 11:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1410AC340E0;
        Tue, 25 Jan 2022 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643109304;
        bh=jiWy23PF8gjrQaHK3eXhaNjTOKYRVwwmMnm35rIo+0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5ZJASWZdjsDgI5Yj4x6P4PF3mQyrPW5hfOpwJj0EUvkkHU7PFA7HaYhNMVo0X5kL
         7Xho5IbY3Lx1FIvE3PVsDbYUhyUh/LyyaZ3lOxZsj00LHO0Jrg09vMder2WgMLXxpr
         cLfp4O2NryuU+nwRIwVvU7aMQ6EDGOHijPh1OCdE=
Date:   Tue, 25 Jan 2022 12:15:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <Ye/btvA1rLB2rp02@kroah.com>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/X7E2dKb+zem34@lahna>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > by the firmware to mark any device as untrusted.
> > 
> > I think this new property should be documented somewhere too (also
> > explain when to use it instead of ExternalFacingPort). If not in the
> > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > under Documentation/devicetree/bindings.
> 
> Actually Microsoft has similar already:
> 
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> 
> I think we should use that too here.

But we do not have "dma protection" for Linux, so how will that value
make sense?

And shouldn't this be an ACPI standard?

thanks,

greg k-h
