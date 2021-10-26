Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC343B7A2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhJZQ4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 12:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237590AbhJZQ4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 12:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B37B601FF;
        Tue, 26 Oct 2021 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635267230;
        bh=8ZHAjFaWjzftQ0tMBWTtPlq3XYzflHXIiSKtmYcBIWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MPfsdWbMcP3/Ka30zCA25xKnFSe6bR4Q2r20k6zcNycONHZ1Eizlg4nIk/ML/a4nx
         pck8w2FgTDE95ucyuZ0AAvJL4f45jTGNPdZcl8AIuOm3a0odY53jdx5ah9zj1/Syzt
         kHRllOHX3mc+lumN/0rpr1AELGHik0isjAx4IMsdSWLW0z10QnNpkbz8fiQ8MqL1on
         /L63n20nJdRUYV64wx/dlPVcVqZ49svDIQuYDo7tyCfIryttln9ZEwb3yILEfaAU/0
         UjiCi/D8lSXJFVQa5ZJT47L3ftgsCJgWWHy44DtH+hfZj6hCyAuKnXazoGfi2X1KwL
         WDZaPg58hqheg==
Date:   Tue, 26 Oct 2021 11:53:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
Message-ID: <20211026165348.GA146058@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7cqnGmySsxSz1xTmUp=_O_vApMuvcg-cBFUHButpva7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 10:28:38AM +0800, Kai-Heng Feng wrote:

> What if we fallback to the original approach and use the VMD driver
> to enable ASPM and LTR values?  At least I think Intel should be
> able to provide correct values for their SoC.

Can you post the patches for that?  I'm not sure exactly what the
original approach was.  Are these the same as the downstream support
you mention below?

> So what other options do we have if we want to enable VMD ASPM while
> keeping CONFIG_PCIEASPM_DEFAULT=y?  Right now we enabled the VMD
> ASPM/LTR bits in downstream kernel, but other distro users may want
> to have upstream support for this.
