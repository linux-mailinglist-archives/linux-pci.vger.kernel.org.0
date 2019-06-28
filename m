Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF765964A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfF1IoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 04:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1IoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 04:44:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA8D2070D;
        Fri, 28 Jun 2019 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561711445;
        bh=o6V86oek2kjSAYllqdbRs9diWyYXGQbO50xPH7OpvSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykGpmU6sP2eEgs8/lrb6HffixI0ak35r4b72eAIqMwJZJOc2Batv1QLFrvWcFA20k
         vIn+SxScmErc5TuHgzKadINK17LTRa+KL8Z+sw4PElRPhx/L8I3R/YcOETnnWp3EyR
         AzDVn+te4PTN2POdKWghJYgV/+4uWiiGlME9CeSM=
Date:   Fri, 28 Jun 2019 10:44:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: PCI/AER sysfs files violate the rules of how sysfs works
Message-ID: <20190628084402.GA28386@kroah.com>
References: <20190621072911.GA21600@kroah.com>
 <20190621141550.GG82584@google.com>
 <CACK8Z6FXS3VoaqxmwXCR2vnp-TSE5zGMi6Zt1w_LxskTguMw=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6FXS3VoaqxmwXCR2vnp-TSE5zGMi6Zt1w_LxskTguMw=Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 05:56:59PM -0700, Rajat Jain wrote:
> On Fri, Jun 21, 2019 at 7:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jun 21, 2019 at 09:29:11AM +0200, Greg KH wrote:
> > > Hi,
> > >
> > > When working on some documentation scripts to show the
> > > Documentation/ABI/ files in an automated way, I ran across this "gem" of
> > > a sysfs file: Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> > >
> > > In it you describe how the files
> > > /sys/bus/pci/devices/<dev>/aer_dev_correctable and
> > > /sys/bus/pci/devices/<dev>/aer_dev_fatal and
> > > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > > all display a bunch of text on multiple lines.
> > >
> > > This violates the "one value per sysfs file" rule, and should never have
> > > been merged as-is :(
> > >
> > > Please fix it up to be a lot of individual files if your really need all
> > > of those different values.
> >
> > Sorry about that.  Do you think we're safe in changing the sysfs ABI
> > by removing the original files and replacing them with new, better
> > ones?  This is pretty new and hopefully not widely used yet.
> 
> Hi Bjorn / Greg,
> 
> I'm thinking of having a named group  for AER stats so that all the
> individual counter attributes are put under a subdirectory (called
> "aer_stats") in the sysfs, instead of cluttering the PCI device
> directory. I expect to have the following counters in there:
> 
> dev_err_corr_<correctible_error_name>  (Total 8 such files)
> dev_err_fatal_<fatal_error_name> (Total 17 Such files)
> dev_err_nonfatal_<fatal_error_name> (Total 17 Such files)
> 
> dev_total_err_corr (1file)
> dev_total_err_fatal (1file)
> dev_total_err_nonfatal (1file)
> 
> rootport_total_err_corr (1file - only for rootports)
> rootport_total_err_fatal (1file - only for rootports)
> rootport_total_err_nonfatal (1file - only for rootports)
> 
> Please let me know if this sounds ok.

Sounds good to me.

thanks,

greg k-h
