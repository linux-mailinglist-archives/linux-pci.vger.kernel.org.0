Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1AB45B5FC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhKXH5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 02:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhKXH5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 02:57:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3ACC061714
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 23:54:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np3so1820052pjb.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 23:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6GvgMO3bDV1Gv9RaQtAnaYISkA1nQVTEfzgtEITUG8=;
        b=UZS7PhUUjfRt8wcMdv3RZNHnBXhEtw8IJrbI5ebpS2k7XYM9CeRmI93G9PIvJMrNhH
         PFpEI+dWT12WQHau2OEFRpXYCPWzo1Pbsy9vInMe2Vf4pnp901bAjEsQids4ea3v6OW2
         3dKhBYOKAAbFJ5DpKPM5t7UyCrUvcr5TuAZsQFixDY4HLPQRXzkLL3WgSJoMVFJOLwtF
         M8jUEb0QW+EXRK782MJ9VK9Y3Jb4qHNdyrg9i56lYHPHxVTZLhrrESj1LyVK+6ZU1ZCw
         BXDc7o93AKBWjOEs2yS1/5zPhUOz7SMtZkTpkmCab0b8YRQP9lhYBadpYMnP7U9Bg9za
         vTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6GvgMO3bDV1Gv9RaQtAnaYISkA1nQVTEfzgtEITUG8=;
        b=C2efAL1IWTGB6GmBRJzjivnPWHyLJ5CB00lLL2IoJggiIAhG1ToPu3k9m5AkZ0TqpH
         imuWo3ySrA3V9ZXv0oErgm11RZ8x8gJLTrAce80F4bYkn4UsEmt32n9dKt7ak7HptF0l
         YuwbTTvLOaXgLnnvEDjgK6fYTl3P5GOs30vLJdlP/W0ijmxGqRCM4TOcLb6ui4t6EVUo
         lUi/8DrpsJg2+gGd9dcg2OQgBuCpptWS7nCv7YXJ6T7TFRj4Gw5ZxUUNJ4Lj/aQaHe1M
         TS/hdUUDpqj3GQshhtNoWRYe6309E+d4tRtshrMkBJ+aPWIidcI7wgN5b0aJnnJ//Mmi
         swWg==
X-Gm-Message-State: AOAM533YeEF1eO5Zxm5kCLAOKX/hbMC0fU4JvdRnyMEOsMa88o3O4h5D
        LaBXZrHSxngT8fyjKYgaB8zSFxOp49r9/HqvmY44Ng==
X-Google-Smtp-Source: ABdhPJwx5vxubnaQUhsFqNh+AUbdwrIOygehiI/0X/MoXrj2GP35tdedYUei/q+OXo5lEHg2D3Fy+SN4/bfItOng0VE=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr15690393plt.89.1637740453619; Tue, 23
 Nov 2021 23:54:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas> <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
 <20211124063316.GA6792@lst.de> <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
 <20211124072824.GA7738@lst.de> <YZ3qvtHlMkRnC74f@kroah.com>
In-Reply-To: <YZ3qvtHlMkRnC74f@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 23:54:03 -0800
Message-ID: <CAPcyv4iYcBFDhDtcxc37EWfX1Wpuh8Zsm4-whTL0vNyY4zW3AQ@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 11:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 24, 2021 at 08:28:24AM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > > I am missing the counter proposal in both Bjorn's and your distaste
> > > for aux bus and PCIe portdrv?
> >
> > Given that I've only brought in in the last mail I have no idea what
> > the original proposal even is.
>
> Neither do I :(

To be clear I am also trying to get to the root of Bjorn's concern.

The proposal in $SUBJECT is to build on / treat a CXL topology as a
Linux device topology on /sys/bus/cxl that references devices on
/sys/bus/platform (CXL ACPI topology root and Host Bridges) and
/sys/bus/pci (CXL Switches and Endpoints). This CXL port device
topology has already been shipping for a few kernel cycles. What is on
the table now is a driver for CXL port devices (a logical Linux
construct). The driver handles discovery of "component registers"
either by ACPI table or PCI DVSEC and offers services to proxision CXL
regions. CXL 'regions' are also proposed as Linux devices that
represent an active CXL memory range which can interleave multiple
endpoints across multiple switches and host bridges.
