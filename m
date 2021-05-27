Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604F73928B6
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhE0HmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234318AbhE0HmR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:42:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36A27610A6;
        Thu, 27 May 2021 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622101243;
        bh=Irlo7mGbJ+1ThfdROf+4QLN6ktaoyaBx/mf73kvLs4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jV1mzuY7JTsHFcNoKiKjyj1zAbzNaoUurjWnPVFZ9QxzBTKgbsAkxYfAPq/F3ggwr
         cpPprcqhwkwTxtlGARNEMfh0T1U9hzr6Wy6RKQOdGYqnNWJjqA9t128hbhvoBUpPX3
         SGnCohFgM117oI9CmIe/4hWNs9Nlg1oaTOhnp+98=
Date:   Thu, 27 May 2021 09:40:40 +0200
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
Subject: Re: [PATCH v5 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <YK9M+OQ33+A5PFVB@kroah.com>
References: <20210524171812.18095-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524171812.18095-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 10:18:11AM -0700, Rajat Jain wrote:
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
> Move the "removable" attribute from USB to the device core so it can be
> used by other subsystems / buses.
> 
> By default, devices do not have a "removable" attribute in sysfs.
> 
> If a subsystem or bus driver wants to support a "removable" attribute, it
> should call device_set_removable() before calling device_register() or
> device_add(), e.g.:
> 
>     device_set_removable(dev, DEVICE_REMOVABLE);
>     device_register(dev);
> 
> The possible values and the resulting sysfs attribute contents are:
> 
>     DEVICE_REMOVABLE_UNKNOWN  ->  "unknown"
>     DEVICE_REMOVABLE          ->  "removable"
>     DEVICE_FIXED              ->  "fixed"
> 
> Convert the USB "removable" attribute to use this new device core
> functionality.  There should be no user-visible change in the location or
> semantics of attribute for USB devices.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> v5: - Update commit log per Bjorn's suggestion, and add "Reviewed by".
>     - don't check for dev!=NULL    

I've applied this series to my USB tree now, thanks for reworking it so
many times.

greg k-h
