Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB59155F8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFWPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 18:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEFWPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 18:15:12 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38DFC2054F;
        Mon,  6 May 2019 22:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557180911;
        bh=yuPWiAOPAeQgK77uMgxcqRZ+hzITam4zxTNrLmBr2rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OurK6XfDgrjObW/fEeTV1l7G5JppX674nAJ7WXtNeCvXW7mb+IoqxPTyh/1wL8RHK
         VHpBZjVnflpMkXXARBL9ECX2qK5WkQaOo/EcBtP+7HlA1PXDXLzC/x9zTLX+4wcu+o
         hzB3bI0v3qDoXoWtHHPihtDIXF6qXUkerhHV3tGI=
Date:   Mon, 6 May 2019 17:15:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
Message-ID: <20190506221509.GB156478@google.com>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
 <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
 <20190430175304.GC145057@google.com>
 <1cdf51f0-653a-f0e8-83dc-88b9d023a269@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdf51f0-653a-f0e8-83dc-88b9d023a269@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 04, 2019 at 05:31:04PM +0200, Heiner Kallweit wrote:
> On 30.04.2019 19:53, Bjorn Helgaas wrote:
> > On Sat, Apr 13, 2019 at 11:12:41AM +0200, Heiner Kallweit wrote:

> > I like the idea of exposing these sysfs control files all the time,
> > instead of only when CONFIG_PCIEASPM_DEBUG=y, but I think when we do
> > that, we should put the files at the downstream end of the link (e.g.,
> > an endpoint) instead of at the upstream end (e.g., a root port or
> > switch downstream port).  We had some conversation about this here:
> > 
> > https://lore.kernel.org/lkml/20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com
> > 
> > Doing it at the downstream end would require more changes, of course,
> > and probably raises some locking issues, but I think we have a small
> 
> This isn't obvious to me as I'm not that familiar with the PCIe subsystem.
> - Why do we need more changes on the downstream end?

I just meant that it might be a little more complicated because the
existing PCIEASPM_DEBUG code works at the upstream end so you can't
use it directly.

> - Which locking is affected?

Normally if we operate on device X, we only touch registers in device
X.  Here we need to also touch things in the bridge upstream from X,
so it's outside the usual model.  We've had locking issues in the
device enable path where we sometimes have to enable the upstream
bridge before enabling the device itself.  I don't know if there are
similar issues here or not, so I mentioned it as a possibility.

> > window of opportunity here where we can tweak the sysfs structure
> > before we're committed to supporting something forever.
> > 
> > Bjorn
> > 
> Heiner
