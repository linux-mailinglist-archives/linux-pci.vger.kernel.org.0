Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8AF584B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfKHUNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 15:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387659AbfKHUNS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 15:13:18 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FB52085B;
        Fri,  8 Nov 2019 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573243997;
        bh=/isY0+4PS4J2/y6GStOz4vrmZ1nhrHLrMIQl8lELC4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BW6rFPu2QrXQDwaMXUsKAZpHYA4ZvwCvy5C6D3XFR7XUQydDc2lJu3MHBfJ4PeRKh
         c07iZ375C53PUb2a6QaTyITQ6rXDrYX0o0vCNwuDcZppvWO34//biFE1IEZsDnSWWc
         OokvA6IrOynO2xPs2IaZhD7CyOonXIUff9JesM3s=
Date:   Fri, 8 Nov 2019 14:13:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Message-ID: <20191108201315.GA130030@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10030157.3aYrIYsZTJ@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 12:49:59PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 6, 2019 8:02:50 PM CET Bjorn Helgaas wrote:
> > On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > This series rearranges some PCI power management code to make it somewhat
> > > easier to follow and explicitly consolidate the power-up (transitions to
> > > D0) code path.
> > > 
> > > It is not intended to change the functionality of the code.
> > 
> > Applied with Mika's reviewed-by to pci/pm for v5.5, thanks!
> 
> Any chance to push this out, though?  That would help with integration/testing
> a bit ...

Done, thanks for the reminder.
