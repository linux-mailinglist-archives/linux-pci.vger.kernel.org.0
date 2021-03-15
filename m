Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1955B33BF6B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCOPIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 11:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhCOPHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 11:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4420664DDF;
        Mon, 15 Mar 2021 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615820838;
        bh=XWtY5TrlDj205yMxswmssJtQpzPjqYZvnSFgDjHYf3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsiINWnEUVxh+ebkcsJHKfr1UHle02AB79BC4Ecuj470m0d1FrlR0Vv1w73TFnarl
         vPhjPAeRL7y06AhpBr7n0E1amh+ULFyWc4vlsXPzK+Dr4v0iFhtRZLYcnUYMMgAnqD
         Zp77IH5tUNHqJ3uYI+VmBHv2uNWz/WMeW/56H304AmsmmDQTZu5RySaZSN7ZxGSfrH
         yd0NYnprVK1eex+/tnL2NaITJjOn+kLbe1DFodiG26/TXdi+gXeX864uw2HKaA1ESP
         6Nof9zsC7bg9chj+/B3GZe93PzmWOFa9GvbDCReGcvTQ4hBM+QGp7eTbtMLrqi6MpE
         6ABtBg/T1S6wA==
Date:   Mon, 15 Mar 2021 17:07:14 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YE94InPHLWmOaH/b@unreal>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315083409.08b1359b@x1.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> On Mon, 15 Mar 2021 14:52:26 +0100
> Pali Rohár <pali@kernel.org> wrote:
>
> > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > warm reset respectively.
> >
> > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > type of reset, which is currently implemented only for PCIe hot plug
> > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > bus reset with some other hook. PCIe Warm Reset does not have API in
> > kernel and therefore drivers do not export this type of reset via any
> > kernel function (yet).
>
> Warm reset is beyond the scope of this series, but could be implemented
> in a compatible way to fit within the pci_reset_fn_methods[] array
> defined here.  Note that with this series the resets available through
> pci_reset_function() and the per device reset attribute is sysfs remain
> exactly the same as they are currently.  The bus and slot reset
> methods used here are limited to devices where only a single function is
> affected by the reset, therefore it is not like the patch you proposed
> which performed a reset irrespective of the downstream devices.  This
> series only enables selection of the existing methods.  Thanks,

Alex,

I asked the patch author here [1], but didn't get any response, maybe
you can answer me. What is the use case scenario for this functionality?

Thanks

[1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal

>
> Alex
>
