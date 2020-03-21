Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5567518DF64
	for <lists+linux-pci@lfdr.de>; Sat, 21 Mar 2020 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCUKUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Mar 2020 06:20:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37936 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgCUKUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Mar 2020 06:20:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id t28so8570153ott.5;
        Sat, 21 Mar 2020 03:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fycDv9Zt435HDMHxyCS0GugKsYFKTP7ingMjjN5s0A=;
        b=tteYZ01prsngTs2dAok9M7rft/LQL2j3zZ8Zce3kcaJ+jevDM7kbbEDEJu/Hew+Oyo
         DKRziceb4FGNAvJN1hzgiFI4cSBiEMzmN7DW/cbzjyE+yyBCZ+PFit4HnoCKriWzyVJb
         t+JJgksLbuVZQbmGVl5Z19XDO7Zvv2XD6SvuTYwvRvo6SQ1IApTvL5Enw4+zBN527blm
         D2BEfhTLTh0cTHgK+2xcv8y9Kk+kpzp92U5otLMOAtyey4wtyEhrYoq9QeMh1QzN8i5G
         9KKS2O8/ejfYaXZ0yoITnN/RvEj26WA2mOQHbGgHb/orJtkmoNje6vgaWzsYBJnPPsQ/
         cAHw==
X-Gm-Message-State: ANhLgQ3BP7kWqCyniVoXHe/84XyTgRNVOIDkJ9YMyCfrA/euON3iQR1b
        ZaueKG+xwWmig/RKu5nVIzCWT4wremxOlzmNF7Ue1g==
X-Google-Smtp-Source: ADFU+vt1By31hLTK9nkP1EvcuYkl4sxt/VTnxJc/iYgPEVPmWge4nO37R/IVOW+sIjcK0Lk4wp1JhvsevBe5bzxBBQQ=
X-Received: by 2002:a9d:4505:: with SMTP id w5mr10719054ote.262.1584786018488;
 Sat, 21 Mar 2020 03:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200321045448.15192-1-saravanak@google.com>
In-Reply-To: <20200321045448.15192-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 21 Mar 2020 11:20:07 +0100
Message-ID: <CAJZ5v0ju-rOU6TF9HDScXvV9N02wuJT9d3cLkoyEdd1xL6Kfbw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Add device links from fwnode only for the
 primary device
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 21, 2020 at 5:55 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Sometimes, more than one (generally two) device can point to the same
> fwnode.  However, only one device is set as the fwnode's device
> (fwnode->dev) and can be looked up from the fwnode.
>
> Typically, only one of these devices actually have a driver and actually
> probe. If we create device links for all these devices, then the
> suppliers' of these devices (with the same fwnode) will never get a
> sync_state() call because one of their consumer devices will never probe
> (because they don't have a driver).
>
> So, create device links only for the device that is considered as the
> fwnode's device.
>
> One such example of this is the PCI bridge platform_device and the
> corresponding pci_bus device. Both these devices will have the same
> fwnode. It's the platform_device that is registered first and is set as
> the fwnode's device. Also the platform_device is the one that actually
> probes. Without this patch none of the suppliers of a PCI bridge
> platform_device would get a sync_state() callback.

For the record, I think that this is a PCI subsystem problem, but I
agree with the patch here.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index fc6a60998cd6..5e3cc1651c78 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2404,6 +2404,7 @@ int device_add(struct device *dev)
>         struct class_interface *class_intf;
>         int error = -EINVAL, fw_ret;
>         struct kobject *glue_dir = NULL;
> +       bool is_fwnode_dev = false;
>
>         dev = get_device(dev);
>         if (!dev)
> @@ -2501,8 +2502,10 @@ int device_add(struct device *dev)
>
>         kobject_uevent(&dev->kobj, KOBJ_ADD);
>
> -       if (dev->fwnode && !dev->fwnode->dev)
> +       if (dev->fwnode && !dev->fwnode->dev) {
>                 dev->fwnode->dev = dev;
> +               is_fwnode_dev = true;
> +       }
>
>         /*
>          * Check if any of the other devices (consumers) have been waiting for
> @@ -2518,7 +2521,8 @@ int device_add(struct device *dev)
>          */
>         device_link_add_missing_supplier_links();
>
> -       if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
> +       if (fw_devlink_flags && is_fwnode_dev &&
> +           fwnode_has_op(dev->fwnode, add_links)) {
>                 fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
>                 if (fw_ret == -ENODEV)
>                         device_link_wait_for_mandatory_supplier(dev);
> --
> 2.25.1.696.g5e7596f4ac-goog
>
