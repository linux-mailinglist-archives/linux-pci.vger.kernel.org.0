Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2146A3483C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfFDNSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfFDNSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 09:18:50 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3242199C;
        Tue,  4 Jun 2019 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559654329;
        bh=kstaWkEOjz4sGnvduRYtac82iKRZqlwD3wYOfYdZAJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne0yes6lGitXgq3FdEvA/6cW2YR77DufQi52Gox4dH+56J4CFagViIAsuRlw+SY1h
         GeQJt2hA7XSzmQP1p1M+2CIZZKq/BL7Y+B9v74X6DxRsjFb3vBQaL3elhp51Wu0q/L
         /lWNsSEXnx/Kduvzcs5X43uAwHfOAN0pyqHu50Vo=
Date:   Tue, 4 Jun 2019 08:18:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com
Subject: Re: [PATCH] PCI: altera: Allow building as module
Message-ID: <20190604131848.GA40122@google.com>
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 12:57:14PM +0800, Ley Foon Tan wrote:
> Altera PCIe Rootport IP is a soft IP and is only available after
> FPGA image is programmed.
> 
> Make driver modulable to support use case FPGA image is programmed
> after kernel is booted. User proram FPGA image in kernel then only load
> PCIe driver module.

I'm not objecting to these patches, but help me understand how this
works.  The "usual" scenario is that if a driver is loaded before a
matching device is available, i.e., either the driver is built
statically or it is loaded before a device is hot-added, the event of
the device being available causes the driver's probe method to be
called.

This seems to be a more manual process of programming the FPGA which
results in a new "altera-pcie" platform device.  And then apparently
you need to load the appropriate module by hand?  Is there no
"hot-add" type of event for this platform device that automatically
looks for the driver?

Bjorn
