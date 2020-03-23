Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6819024B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCWXyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 19:54:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44207 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCWXyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 19:54:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so15364171otc.11
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2020 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ivUKPeO9SerTi1Ute2v62GeXvzFfzfq/ifSKn+sYwQ=;
        b=thfwQNJ+GUelNm8rDcQbImlNSsL38HmovsMWSUD77gnenKIZWO31Vdd6mnUTPPx08e
         45KGnfFt1/UDa9QTOY+ds3jJ3HIIgojiX2Z9bqR9ZMWiSh3olum+I6sfvYx7l0pFfhJ4
         0LpBblO07Ug/XoSo1zImEquUsFXik2gMjHlWZF9ffsp+KSgjiNM2SXfbhdel7p2bZwU7
         kWsuq38NGtewIFW9qOEhGd3ulgVVpqrH3n1ZTb/glzLXRv/+aFuwGISdYDRXALQFDINN
         8SoUWX5gEJznTIXLAhnTOaD/x9CMSpZ06ZTiwHU3fgxkiAqgSy9wRQX/34/Rnw15bPBd
         R6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ivUKPeO9SerTi1Ute2v62GeXvzFfzfq/ifSKn+sYwQ=;
        b=UeVsDQw/6rERQxjAqm1daNkeiyIatSK7Ou3KnFkTfBgzP/YMw+Qal1ILFJb/jWTbSs
         lm0gp437w04jKbPNrNSYcFtRhaWb8WptpwmzcDQVwXwvv9b1TFSz7c453N1o30VlEfeo
         enGpPqCYSyWCY+9xg4G4r5mfiV37HdZObX35YUhx02yLElabHEf6TO0fUth2EH/MulMY
         eJ+V8A68nCoGl/NfVvzcAkGq9RILtV6E0j+TExOrrkDIy0eGR8RensB81BgQBzNaCvrb
         WNc5saQV6NRyJcDyo4qvnN/Hql5XKuBIi42eMA2YELDdzJlN7hMsZdtcPDWKMnGnDZPH
         /ZvQ==
X-Gm-Message-State: ANhLgQ0rPui0eU2t21SaDlGHQ7SAfX+DLqnvssMjvIMmtVYluCL4qsaJ
        tl95iNbVecgf8/+bGNClhsGKw8hPUAOUnVydm3WXQw==
X-Google-Smtp-Source: ADFU+vsot8kt5s5rcGN6TXz0OW7n8RiiPx5Zhc+LE3dHDuKUm9vVQOF7PdjFALlTfmRme2UwsrwpkLPQ8+yM7KuiE8I=
X-Received: by 2002:a05:6830:1ac1:: with SMTP id r1mr15659040otc.139.1585007688284;
 Mon, 23 Mar 2020 16:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ju-rOU6TF9HDScXvV9N02wuJT9d3cLkoyEdd1xL6Kfbw@mail.gmail.com>
 <20200323222803.GA21243@google.com>
In-Reply-To: <20200323222803.GA21243@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 23 Mar 2020 16:54:12 -0700
Message-ID: <CAGETcx-kBHuvoJGqtdx=AORjezdOBX7-h+6Zrwpgv7UPn1UuVQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Add device links from fwnode only for the
 primary device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 23, 2020 at 3:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Mar 21, 2020 at 11:20:07AM +0100, Rafael J. Wysocki wrote:
> > On Sat, Mar 21, 2020 at 5:55 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Sometimes, more than one (generally two) device can point to the same
> > > fwnode.  However, only one device is set as the fwnode's device
> > > (fwnode->dev) and can be looked up from the fwnode.
> > >
> > > Typically, only one of these devices actually have a driver and actually
> > > probe. If we create device links for all these devices, then the
> > > suppliers' of these devices (with the same fwnode) will never get a
> > > sync_state() call because one of their consumer devices will never probe
> > > (because they don't have a driver).
> > >
> > > So, create device links only for the device that is considered as the
> > > fwnode's device.
> > >
> > > One such example of this is the PCI bridge platform_device and the
> > > corresponding pci_bus device. Both these devices will have the same
> > > fwnode. It's the platform_device that is registered first and is set as
> > > the fwnode's device. Also the platform_device is the one that actually
> > > probes. Without this patch none of the suppliers of a PCI bridge
> > > platform_device would get a sync_state() callback.
> >
> > For the record, I think that this is a PCI subsystem problem, but I
> > agree with the patch here.
>
> I don't understand the issue here.  Can somebody educate me?  I'm
> guessing this is related to pci_set_bus_of_node(), which does (for
> PCI-to-PCI bridges):
>
>   bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>   bus->dev.fwnode = &bus->dev.of_node->fwnode;

Assuming you intentionally simplified the code here, yes, it's related to that.

> where "bus" points to a struct pci_bus and "bus->self" points to the
> struct pci_dev for the bridge leading to the bus?
>
> Is this related to the fact that we have a struct device for both a
> PCI-to-PCI bridge and for its downstream bus?

This patch at least isn't talking about how many devices we have.

The patch is referring to the fact that more than one device has their
dev.fwnode point to the same fwnode. fwnode is just a generic way to
point to devicetree nodes (of_node) or ACPI nodes. So the concerns
raised for fwnode apply to of_node too, but ignore of_node for now
(I'll get to that part later).

dev.fwnode is supposed to point to the firmware node from which the
device is created or represents. Having more than one struct device
point to the same fwnode is unusual as it's unlikely one firmware node
is creating two different devices.. Maybe for MFD (multi function
devices) it *might* make sense but even then it's questionable.

In the specific case of the PCI + a device tree based system, the pcie
root controller/bridge(?) has a platform_device (bridge->dev.parent)
that points to a fwnode (that corresponds to the DT node from which
the platform device was created). Somehow (the code path is very
confusing) the pci_bus->dev.fwnode ends up pointing to the same fwnode
the platform_device is pointing to.

The pci_bus is just a run time allocated struct device used to form
some kind of device hierarchy you are trying to maintain. I think (and
maybe this is the part Rafael is referring to) the pci_bus is not
really representing the firmware node and maybe should have fwnode set
to NULL. And this fwnode issue is made more unusual because this
device doesn't even probe.

> Any suggestions for how could we fix this problem in the PCI
> subsystem?

If you set a device's of_node = something, then you really should be
setting the device's fwnode to point to the corresponding fwnode for
that of_node. So the real question is why you need to set
pci_bus->dev.of_node (instead of leaving it NULL). Sometimes devices
have their of_node set to some other device's of_node because
regulator_get()/clk_get/whatever_get() they call look at dev.of_node
to find the resource. But I don't think that's the case here.

So, if you can simply skip setting pci_bus of_node, then that's the
simplest fix. If not, not setting fwnode (while setting of_node) might
be an acceptable hack to reduce the weirdness (of setting fwnode =
some other device's fwnode). If not, then the fix would be to unwind
the need for setting pci_bus's of_node.

Hope that makes some sense.

-Saravana

-Saravana
