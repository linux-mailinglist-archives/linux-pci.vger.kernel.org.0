Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB841E81E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbhJAHQh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 03:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238668AbhJAHQg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 03:16:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00CFF61246;
        Fri,  1 Oct 2021 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633072492;
        bh=mgLxvzAF2BEBs36gds66YnmgyvIQqLoaFwwtvzBniZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5wlhm4z79VFWQ5ej5mHjG0+DUsThXYtYnKy9cj54IUWqsAjVmwskUZfLHqHqopSS
         AEn5wGc42ZuNylUp60LIZqs9o5p4pBxIs6HYBwYm6dFXIIZ9pUI0dN/qIjTTT1aTSj
         CYhS3zGN8/aF7qQPeQzLxeSp3kp6vGDKnTgLckCg=
Date:   Fri, 1 Oct 2021 09:14:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVa1aiTqS6Ik5cO1@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001012815.1999501-6-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> +static int sdsi_device_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *miscdev = file->private_data;
> +
> +	get_device(miscdev->this_device);

Why do you think this is needed?  Shouldn't the misc core handle all of
this for you already?

> +
> +	return 0;
> +}
> +
> +static int sdsi_device_release(struct inode *inode, struct file *file)
> +{
> +
> +	struct miscdevice *miscdev = file->private_data;
> +	struct sdsi_priv *priv = to_sdsi_priv(miscdev);
> +
> +	if (priv->akc_owner == file)
> +		priv->akc_owner = NULL;

Why is this needed?

> +
> +	put_device(miscdev->this_device);

I see this matches the open call, but if you do not have this in the
open call, is it needed here as well?

> +	ret = devm_add_action_or_reset(priv->miscdev.this_device, sdsi_miscdev_remove, priv);
> +	if (ret)
> +		goto deregister_misc;

I think this is all you need to clean up your device memory, not the
get/put device in open/release, right?

thanks,

greg k-h
