Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE626CF3C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 01:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIPXG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 19:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgIPXG5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 19:06:57 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287F722205;
        Wed, 16 Sep 2020 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600297616;
        bh=mVtA+yZ5H+wUI0uplWeAykbiC3OpBkIU+KtUDYfIycQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y6e7CCllPoIo507T4PvUGnaTmzSWrsDg7ZtNc8Q5fYNND7fAjAM8OQY6RwvuQUT6u
         v13ri8BWmMkQDzfXXZnh45z4Rxfn+sRvrPBm7vW7WaM6XDaEtZC4B9qRRqzEAT/Gww
         EUb5XIzReTmxlf+8X3WLFTwtBJQLyioA/Cd9USvk=
Date:   Wed, 16 Sep 2020 18:06:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Message-ID: <20200916230654.GA1595243@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BC1F7E6-64B8-4564-97A3-49C914CA926D@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 09:09:20AM -0700, Sean V Kelley wrote:

> Walking the bus with an RCEC as it is probed in the portdrv_pci.c can be
> done with both its own bus (bitmap) and with supported associated bus
> ranges.  In that walk I’m able to find all the associated endpoints via both
> bitmap on own bus and the bus ranges. No pci_get_slot() is needed as per
> your original suggestion.

OK.  That seems OK for now.

> The suggsted approach to the rcec_helper() seems to imply that we either
> walk it again or have cached all the associated RCiEP.  When we do the walk
> above, we are merely, finding the RCiEPs and linking them to the RCEC’s
> structure. There is no caching done of a list of RCiEPs per RCEC.

pcie_portdrv_init() is a device_initcall, so it should be called after
we enumerate all the PCI devices (at least those present at boot).  So
you don't have to worry about finding an RCiEP before its associated
RCEC -- we should have found them *all* by the time we get to
pcie_portdrv_probe().

Bjorn
