Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB040AC62
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhINL1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 07:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhINL1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 07:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 181086108B;
        Tue, 14 Sep 2021 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631618790;
        bh=z17rkFjIwbMfar/Gaqd/jjuffYq/yJJhF9L7K2YXTPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=htNEbtOR8qIlDyRjbMOB9WHAN23xw30njyo4Z42xUf66tdcFROqF99j61kAILuWku
         EEi7WY+kqZM0x4c9s0vRVj+qvX97IYAP7YCguzD7doP/d0i3WtzTNwiMZWCM1g1HFQ
         h1C1FGtxXJolrKsVRIi2uMdxG/ItX9HWzsVhsYGZhe5Mc0D3rOH11ZlDjfE2jyvlV9
         AylWfFbbnWCwxI4ElWshfq4Rjx8Bs7GgtCsGMgg/uefYgQ8V8gC7v0Fp34a4O/2ZTP
         OO9l5SwILc7PDBXMizpfqhfgpbSUvUiuL6azvn9pqzh3X9Mxv9vg9mh1mCUO+tV5oS
         7bowPvbgqGsBw==
Date:   Tue, 14 Sep 2021 06:26:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210914112628.GA1412445@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870c3332-db60-9cf5-0439-247f91ce7808@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 14, 2021 at 08:21:46AM +0200, Heiner Kallweit wrote:
> On 14.09.2021 01:46, Bjorn Helgaas wrote:

> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> >  /*
> 
> Leaving the quirks in FIXUP_HEADER stage would have the advantage that for
> blacklisted devices the vpd sysfs attribute isn't visibale. The needed
> changes to the patch are minimal.

What do you have in mind?  The only thing I can think of would be to
add a "pci_dev.no_vpd" bit.  "vpd.cap == 0" means the device has no
VPD, and "vpd.len == 0" means we haven't determined the size yet.  All
devices start off with vpd.cap == 0 and vpd.len == 0, so a
FIXUP_HEADER quirk would have to set a sentinel value or some other
bit.

Bjorn
