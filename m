Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED827F5CB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbgI3XPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 19:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbgI3XP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 19:15:29 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2010C2076A;
        Wed, 30 Sep 2020 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601507729;
        bh=id6jYAcbj7ZDrxFxqLcRs6IFIMcf4bKjBStxpZA2N+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Um83YSRn19ZPpvkuiuawCz4za9l/koOnvdBkAMvR9fA1Pszm26T6ciJ/ASIYYDPO+
         hCAWgBLuXHHbVB1BOVAKCrq5nTwSWMzrNtpx/MQd6qLx1FaqyePqol3TAXRwtk4ARX
         G2a0G1DO4+pAxtJTKC9cOWS8scHSXIR8wgR8K9qw=
Date:   Wed, 30 Sep 2020 18:15:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/PM: Fix D2 transition delay
Message-ID: <20200930231527.GA2645760@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929194748.2566828-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 02:47:46PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Remove an unused #define.
> 
> Fix the D2 transition delay.  I changed this a year ago to conform to the
> PCIe r5.0 spec, but I think the number I relied on is a typo in the spec.
> I asked the PCI-SIG to fix the typo.  Hopefully I'll get a response before
> the merge window.
> 
> Bjorn Helgaas (2):
>   PCI/PM: Remove unused PCI_PM_BUS_WAIT
>   PCI/PM: Revert "PCI/PM: Apply D2 delay as milliseconds, not
>     microseconds"
> 
>  drivers/pci/pci.c | 2 +-
>  drivers/pci/pci.h | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)

Applied with Rafael's reviewed-by to pci/pm for v5.10.  Subject to
revision based on feedback from the PCI-SIG, of course.
