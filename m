Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B533BF0A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhCOOxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 10:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240806AbhCOOwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 10:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEEB264E4D;
        Mon, 15 Mar 2021 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615819961;
        bh=G3ozJXmGXxAqgrO+D3whXaRr9LYu3Iu2YW+g7hNfPuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVrJ2ZTABExkLOf3T9pFk2hY164N3cDdTbU4yBvVpG2Ue5m1HjAjXktQ4GhdZcxTO
         y2ufICjjv42ebbx3yl5/2eRtgGJj0Z7QEXFD9fW2HClpFzkvuXG5jLVSEXjz+8PQAg
         uen2Y/yZaPmK/4SD+zERgnidBLItHlVSnkpSQT1sY6AuWcV5uvSDeEPQAB91Zkj8ES
         4rWtL82GfDZDDd50I3rXsBa4AXMlz0ThGU1ku0NpmbfI0r6if0Qtx5brsvZeN1qzYq
         +XqhVs+zdwXe4GhJ0TpEzBLqTcMDt/vYBbCrAaeQw8vd4J8cRi9wvcVPX9giO2GSqu
         2NiMtcbp7KROA==
Received: by pali.im (Postfix)
        id 6538182E; Mon, 15 Mar 2021 15:52:38 +0100 (CET)
Date:   Mon, 15 Mar 2021 15:52:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315145238.6sg5deblr2z2pupu@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315083409.08b1359b@x1.home.shazbot.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 15 March 2021 08:34:09 Alex Williamson wrote:
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
> defined here.

Ok!

> Note that with this series the resets available through
> pci_reset_function() and the per device reset attribute is sysfs remain
> exactly the same as they are currently.  The bus and slot reset
> methods used here are limited to devices where only a single function is
> affected by the reset, therefore it is not like the patch you proposed
> which performed a reset irrespective of the downstream devices.  This
> series only enables selection of the existing methods.  Thanks,
> 
> Alex
> 

But with this patch series, there is still an issue with PCI secondary
bus reset mechanism as exported sysfs attribute does not do that
remove-reset-rescan procedure. As discussed in other thread, this reset
let device in unconfigured / broken state.
