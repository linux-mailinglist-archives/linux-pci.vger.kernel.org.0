Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1162C4EAF2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFUOpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFUOpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:45:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002172089E;
        Fri, 21 Jun 2019 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561128302;
        bh=q70MibmwnCTMbTaHdEAX5LqZY9jUKGiJgTvCSHm190c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThrUwR3Ecvs/hHhP6WaYD3l1QmgyOaHiKD9NhXU3miNk1Wa9VO/fvZRyeE7m/us0r
         xkJBbtBjl0q+VlydHOG1VGEPTWGO1W6VMPBSWskl6G7J01wHOl/OdJmGYvl6qt4q4V
         nl+36skBpAqHKt9LNPqBxRn+39A3p5HRVlfGAADA=
Date:   Fri, 21 Jun 2019 16:44:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI/AER sysfs files violate the rules of how sysfs works
Message-ID: <20190621144459.GA6493@kroah.com>
References: <20190621072911.GA21600@kroah.com>
 <20190621141550.GG82584@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621141550.GG82584@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 09:15:50AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2019 at 09:29:11AM +0200, Greg KH wrote:
> > Hi,
> > 
> > When working on some documentation scripts to show the
> > Documentation/ABI/ files in an automated way, I ran across this "gem" of
> > a sysfs file: Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> > 
> > In it you describe how the files
> > /sys/bus/pci/devices/<dev>/aer_dev_correctable and
> > /sys/bus/pci/devices/<dev>/aer_dev_fatal and
> > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > all display a bunch of text on multiple lines.
> > 
> > This violates the "one value per sysfs file" rule, and should never have
> > been merged as-is :(
> > 
> > Please fix it up to be a lot of individual files if your really need all
> > of those different values.
> 
> Sorry about that.  Do you think we're safe in changing the sysfs ABI
> by removing the original files and replacing them with new, better
> ones?

I doubt any tool is parsing that monstrosity, so you should be fine :)

> This is pretty new and hopefully not widely used yet.

Only one way to find out...

thanks,

greg k-h
