Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A915038CEA7
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhEUULm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 16:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhEUULl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 16:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC936101B;
        Fri, 21 May 2021 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621627818;
        bh=XA1ABq8YonEMJwPvBO1DQSpN/DaawZg01skDnn4XKy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nk8p/uRVoQkyXFgDNR3qCjnQE3Bc3RDtc44yobAR7eEX26P3DvPkcprq7rX6f9sSz
         9dmXDru2OE3+EFy8xhMU8Q4q6SPqn+CpFGE7RuBE9tjbDg53+shoN/sNU7g/n5T7j/
         tpUiBSQV6ZZwXOerVMQULr9rIlbBmwl685ScmC90=
Date:   Fri, 21 May 2021 22:10:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v4 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <YKgTp00l1pRI4DTd@kroah.com>
References: <20210513232701.411773-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513232701.411773-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 04:27:00PM -0700, Rajat Jain wrote:
> Move the "removable" attribute from USB to core in order to allow it to be
> supported by other subsystem / buses. Individual buses that want to support
> this attribute can populate the removable property of the device while
> enumerating it with the 3 possible values -
>  - "unknown"
>  - "fixed"
>  - "removable"
> Leaving the field unchanged (i.e. "not supported") would mean that the
> attribute would not show up in sysfs for that device. The UAPI (location,
> symantics etc) for the attribute remains unchanged.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v4: - instead of devicce_type->supports_removable, add 1 more value in
>       device_removable_enum
>     - documentation update.
>     - Remove "Acked-by" and "Reviewed-by" tags from previous versions.
> v3: - Minor commit log / comments updated.
>     - use sysfs_emit()
>     - Rename local variable name (state -> loc)
>     - change supports_removable flag from bool to bitfield.
> v2: Add documentation

This looks good to me, I have no further objection to it at all, nice
cleanups.

I can take this in my driver-core tree, so that other busses can use it
(and can create a tag to pull from if needed), or I can also take the
PCI patch (patch 2/2 here), if Bjorn gives his reviewed-by: for it.

Are there other busses besides PCI that you want to enable this soon
(i.e. before 5.14-rc1)?

thanks,

greg k-h
