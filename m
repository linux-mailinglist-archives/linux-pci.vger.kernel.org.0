Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3FA10843E
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2019 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKXRCL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Nov 2019 12:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfKXRCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Nov 2019 12:02:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43805207DD;
        Sun, 24 Nov 2019 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574614930;
        bh=yTmvBBSki+sWQIcHxtO0uYKyI8aK9o6H9e3lZIwE6xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCE0iDORjQv/+lPjRQbS6uDIPTuDFpx1N5KlSCY4Vhh9g06dwcW0gVshWusxqRx4s
         G1ybicyh9H3ERmLK/cMWy7V4NEjeNyJXpT4jtAIV1wN2JARU1ThGhsjWZvkmiHBeW1
         RYW7rs5BfL2Swo+cSCkHM+q0YcERhXh9yR/iD0Q8=
Date:   Sun, 24 Nov 2019 18:02:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191124170207.GA2267252@kroah.com>
References: <20191121211017.GA854512@kroah.com>
 <20191121230411.GA92983@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121230411.GA92983@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 05:04:11PM -0600, Bjorn Helgaas wrote:
> What sort of tools would this break?  There are no AER tools since the
> AER stats sysfs files don't exist yet, so I assume there are some
> generic sysfs tools or libraries.

Any normal tool that looks at sysfs attributes, like udev and friends.
They will "miss" the uevent for the subdirs and not know how to
associate anything with the "parent" struct device.

> Incidentally,
> https://www.kernel.org/doc/html/latest/admin-guide/sysfs-rules.html
> suggests that maybe we should be documenting these files with
> /sys/devices paths instead of the symlinks in /sys/bus/pci/devices/,
> e.g.,
> 
>   diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>   -What:		/sys/bus/pci/devices/.../msi_bus
>   -What:		/sys/bus/pci/devices/.../msi_irqs/
>   -What:		/sys/bus/pci/devices/.../msi_irqs/<N>
>   +What:		/sys/devices/pci*/.../msi_bus
>   +What:		/sys/devices/pci*/.../msi_irqs/
>   +What:		/sys/devices/pci*/.../msi_irqs/<N>

Either is fine, but yes, the second one is nicer.

thanks,

greg k-h
