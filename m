Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19FF4EA58
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFUOPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUOPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:15:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C822F20679;
        Fri, 21 Jun 2019 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126552;
        bh=cKl1ATkQpP+oDNaHNi2VIa2C13hcw38+hSlhNpnDBWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsgU3AMSfzeUXecKcYbTcI4sG8aRDVGY+ybbHMeTH0cdpQEpHre2neo26baNKeXcj
         YxBd+09SqWak0kpjG4tgMwUmSfVfRQvGEzhucM1m6LY+olmtxYTLMbt0IVZup5NT34
         BBEbhR+ZNvO7BxfdS7VUJgWyaMN2BPji7kKs6b2Q=
Date:   Fri, 21 Jun 2019 09:15:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI/AER sysfs files violate the rules of how sysfs works
Message-ID: <20190621141550.GG82584@google.com>
References: <20190621072911.GA21600@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621072911.GA21600@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 09:29:11AM +0200, Greg KH wrote:
> Hi,
> 
> When working on some documentation scripts to show the
> Documentation/ABI/ files in an automated way, I ran across this "gem" of
> a sysfs file: Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> 
> In it you describe how the files
> /sys/bus/pci/devices/<dev>/aer_dev_correctable and
> /sys/bus/pci/devices/<dev>/aer_dev_fatal and
> /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> all display a bunch of text on multiple lines.
> 
> This violates the "one value per sysfs file" rule, and should never have
> been merged as-is :(
> 
> Please fix it up to be a lot of individual files if your really need all
> of those different values.

Sorry about that.  Do you think we're safe in changing the sysfs ABI
by removing the original files and replacing them with new, better
ones?  This is pretty new and hopefully not widely used yet.

Bjorn
