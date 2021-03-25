Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50589348976
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCYGzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 02:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYGzE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E96E361A1D;
        Thu, 25 Mar 2021 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616655304;
        bh=hwybfUkXNIWo6r4bPsiLbvcMETMTvuzLTW00G75yclU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5AVpjVPu/bmnR3AjASe6v9IqahdEnjGta1yQfjaIxsCfg4N+gyr+1TCNsfDGBnCA
         ZLNPYRYONuk7z2s/kNBRCGPEOCOKuA5Fun4YP8vzONTahGyghWRlaABlafugL3EFk7
         aRVDYx18xR8qP0Ysz8VbA46GU061HejSaRXRzW44=
Date:   Thu, 25 Mar 2021 07:54:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     bhelgaas@google.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <YFwzw3VK0okr+taA@kroah.com>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> configuration cycles. It assumes one initiator at a time is
> reading/writing the data registers.

That sounds like a horrible protocol for a multi-processor system.
Where is it described and who can we go complain to for creating such a
mess?

> If userspace reads from the response
> data payload it may steal data that a kernel driver was expecting to
> read. If userspace writes to the request payload it may corrupt the
> request a driver was trying to send.

Fun!  So you want to keep root in userspace from doing this?  I thought
we already do that today?

> Introduce pci_{request,release}_config_region() for a driver to exclude
> the possibility of userspace induced corruption while accessing the DOE
> mailbox. Likely there are other configuration state assumptions that a
> driver may want to assert are under its exclusive control, so this
> capability is not limited to any specific configuration range.

As you do not have a user for these functions, it's hard to see how they
would be used.  We also really can't add new apis with no in-tree users,
so do you have a patch series that requires this functionality
somewhere?

> Since writes are targeted and are already prepared for failure the
> entire request is failed. The same can not be done for reads as the
> device completely disappears from lspci output if any configuration
> register in the request is exclusive. Instead skip the actual
> configuration cycle on a per-access basis and return all f's as if the
> read had failed.

returning all ff is a huge hint to many drivers that the device is gone,
not that it just failed.  So what happens to code that thinks that and
then tears stuff down as if the device has been removed?

Trying to protect drivers from userspace here feels odd, what userspace
tools are trying to access these devices while they are under
"exclusive" control from the kernel?  lspci not running as root should
not be doing anything crazy, but if you want to run it as root,
shouldn't you be allowed to access it properly?

What hardware has this problem that we need to claim exclusive ownership
over that differs from the old hardware we used to have that would do
crazy things when reading from from userspace?  We had this problem a
long time ago and lived with it, what changed now?

thanks,

greg k-h
