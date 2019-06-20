Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF164CF57
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFTNrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 09:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfFTNrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 09:47:15 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0B4206E0;
        Thu, 20 Jun 2019 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561038434;
        bh=d5ofdz+9QjwZAj1YbfVJI70wV21UwnW5CSJhDjRuEXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMcdIzXtTql+jmwRd9fsBmgATm1jxJS4XlsVljsVlhic8uNE6y2bzFIFUx6gVOFfO
         ynOCsn0X/MLyEZLUuHFX+AgI7mgipWHJXODK0CEQtFL4C+A5+MOo08518R8HwXH0XP
         uSM34PN5Bcjis2vD482kqy/Uz+ZobWlibEwEW9n0=
Date:   Thu, 20 Jun 2019 08:47:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
Message-ID: <20190620134712.GI143205@google.com>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 07:35:21PM -0600, Logan Gunthorpe wrote:
> On 2019-06-19 6:56 p.m., Nicholas Johnson wrote:
> > On Wed, Jun 19, 2019 at 10:45:38AM -0600, Logan Gunthorpe wrote:
> >> On 2019-06-19 8:01 a.m., Nicholas Johnson wrote:
> >>> ----- Forwarded message from Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> -----
> >>>
> >>> Date: Thu, 23 May 2019 06:29:28 +0800
> >>> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> >>> To: linux-kernel@vger.kernel.org
> >>> Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> >>> Subject: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size independently
> >>> X-Mailer: git-send-email 2.19.1
> >>>
> >>> Add kernel parameter pci=hpmemprefsize=nn[KMG] to control
> >>> MMIO_PREF size for PCI hotplug bridges.
> >>
> >> Makes sense.
> >>
> >>> Change behaviour of pci=hpmemsize=nn[KMG] to not set MMIO_PREF
> >>> size if hpmempref has been specified, rather than controlling
> >>> both MMIO and MMIO_PREF sizes unconditionally.
> >>
> >> I don't think I like that fact that hpmemsize behaves differently
> >> if hpmempref size is specfied before it. I'd probably suggest
> >> having three parameters: hpmemsize which sets both as it always
> >> has, a pref one and a regular one which each set one of
> >> parameters.
> > 
> > It does not matter if hpmempref is specified before or after
> > hpmemsize.  I made sure of that.
> 
> > Originally, I proposed to depreciate hpiosize, hpmemsize, and
> > introduce: hp_io_size, hp_mmio_size, hp_mmio_pref_size, each
> > controlling its own window exclusively.
> > 
> > The patch had the old parameters work with a warning, and if the
> > new ones were specified, they would override the old ones. Then,
> > after a few kernel releases, the old ones could be removed.
> 
> Well I don't like that either. No need to depreciate hpmemsize.
> 
> > Bjorn insisted that there be nil changes which break the existing
> > parameters, and the solution he requested was to leave hpmemsize
> > to work exactly the same (controlling both MMIO and MMIO_PREF),
> > unless hpmemprefsize is given, which will take control of
> > MMIO_PREF from hpmemsize.
> 
> I agree with Bjorn here too but my suggestion is to leave hpmemsize
> alone and have it set both values as it has always done. And add two
> new parameters to set one or the other. Then there's none of this
> "sets one if the other one wasn't set". Also, if I only want to
> change the non-preftechable version then your method leaves no way
> to do so without setting the preftechable version.

Adding two new parameters sounds like a good idea to me.
