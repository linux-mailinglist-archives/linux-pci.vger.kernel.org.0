Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7712D189C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLGSgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 13:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGSgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 13:36:21 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1CC061793;
        Mon,  7 Dec 2020 10:35:41 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d20so19472828lfe.11;
        Mon, 07 Dec 2020 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+c8FgbFyhnZsbAIXp1x4Yhx9aZ6GksQZTjiRKY8hhg=;
        b=Sbuv4FoX7hxrJeb1zerPm4TAP5KQ9wxRwwpG2ojtxqUjxaKXyx7F85InIPd8Ax9RRR
         q66cZVz6vvX5jEyyDgKhWT+9xSsipobOXWuRI1u7VR+Rr+8ALsei8R1zhWfhfMoLpMNT
         q1+u6Vc5XVA5V4fx5sPdpDrnYfotur42Z7W4UaoQZnATNc5X5Pe50kLfE4zGRgYvxlbA
         rCxRdpH3fsz4IG3A+G35Wou3D1pyUEEWamS1vrAo8iPJ/BhkpITdXym2QxgyvKD4kWeB
         8EBclvpOtLFdcVeO5Yv1ZZ34avacoI6pj7z+AOpzA/RdDMgt8zCJ8GfdNFkZ3DIzD/ov
         YJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+c8FgbFyhnZsbAIXp1x4Yhx9aZ6GksQZTjiRKY8hhg=;
        b=ikn24ie1VT18Dk37JqCK7wD0cdqgL1dnlaXwj07xKMaiCXBAQEwPV7q+SSg+np3BOC
         e3HDkPHIhU0zx0D0BZunv2BVp5ihMg7ZFAbJVB95vI4RtCIpewB7aaMlFGc3kCIqK4c4
         MkQ/XYWlnyFguhlmjiFR8Ba7SRH0pekcboXq5+oVO3yFtFbptJVJ9TYJjKEfvxsp3Pvm
         eeXDP/+D3UqJ2uiH5KuhWJzAk9SmO+5XijCMyNQ1C/OwJCRcLS/RfwXjro0avmlDDmdf
         wRVA7z9+KpoqxZYI9H76iyFx6NqdN08lPSGT7sM+YNMx953Gw1K6uvoQJGrUVpdzTYMk
         57rw==
X-Gm-Message-State: AOAM531EtLM1tYldcgO6yZ0urXUiE/azCxfsCOJKs+xVb20kXHMyh3bi
        szUyzGLd/INRbRXy9eK6huowCw35QSpryhWkCsY=
X-Google-Smtp-Source: ABdhPJyCSWf3gpN+FzIkbhfGZ+ZsEz1U1cUcioqBsQlgg4elSKCwiAC5NggOej7Gam67jbmS/dcFO8K50n/bpOBdPJM=
X-Received: by 2002:ac2:4831:: with SMTP id 17mr9198595lft.487.1607366139539;
 Mon, 07 Dec 2020 10:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20201206194300.14221-1-puranjay12@gmail.com> <20201207145258.GA16899@infradead.org>
 <CANk7y0jqS+Crf4Z3k82DXh2qxn1JO9KAO_CJGrpqH6xAJYU6Qw@mail.gmail.com> <20201207180734.GC3679937@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201207180734.GC3679937@dhcp-10-100-145-180.wdc.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 8 Dec 2020 00:05:26 +0530
Message-ID: <CANk7y0iJ+G1WxBPAGciqOvn0XvD04Ffs9py2nXP+YH2jU6UMYg@mail.gmail.com>
Subject: Re: [PATCH] drivers: block: save return value of pci_find_capability()
 in u8
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, Bjorn Helgaas <bjorn@helgaas.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 7, 2020 at 11:37 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Dec 07, 2020 at 11:23:03PM +0530, Puranjay Mohan wrote:
> > On Mon, Dec 7, 2020 at 8:23 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > Can we take a step back?  I think in general drivers should not bother
> > > with pci_find_capability.  Both mtip32xx and skd want to find out if
> > > the devices are PCIe devices, skd then just prints the link speed for
> > > which we have much better helpers, mtip32xx than messes with DEVCTL
> > > which seems actively dangerous to me.
> >
> > The skd driver uses pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
> > to check if the device is PCIe, it can use pci_is_pcie() to do that.
> > After that it uses pci_read_config_word(skdev->pdev, pcie_reg,
> > &pcie_lstat); to read the Link Status Register, I think
> > it should use pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,
> > &pcie_lstat);
> >
> > Please let me know if the above changes are correct so I may send a patch.
>
> You just want to print the current link speed, right? Does
> skdev->pdev->bus->cur_bus_speed provide what you need?

After discussing with Bjorn, we concluded that we don't need to print
the speed as it is already printed by the PCI core for every device.
PCI core calls __pcie_print_link_status() for every device, and hence
the skd_pci_info() is redundant and can be removed?


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
