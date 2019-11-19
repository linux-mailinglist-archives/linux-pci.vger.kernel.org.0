Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08907102594
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKSNib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 08:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfKSNib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 08:38:31 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CFA20409;
        Tue, 19 Nov 2019 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574170710;
        bh=Qeq3yKstyKF1OWV+FGriRX3E94irDihprjH3YTvxKmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E3AIkOQidGyiEORnZ+REDBXXWvUiuuFzQn7qWld9oTV+smSY1Asw3poo8/XRhn10X
         afByRaTX1Racvo5f6bgg5zKAeKZlnOvOx8CV5oT1YgGAuFu1Bj9xOd/3/FxQuce4j3
         eoJCxWBwB6/ei9XitlOMAr8LFliwWy7vySYLWOEo=
Date:   Tue, 19 Nov 2019 07:38:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191119133828.GA171084@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB07556573D454EB9A6D1A5140804C0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 03:17:04AM +0000, Nicholas Johnson wrote:
> I did just discover linux-next and I built it. Should I be doing this 
> more often to help find regressions?

Yes, if you build and run linux-next, that's a great service because
it helps find problems before they appear in mainline.

> I will now concentrate on fixing the problem where pci=nocrs does not 
> ignore the bus resource. One motherboard I own gives 00-7e or similar, 
> instead of 00-ff. The nocrs does not help, and I had to patch the kernel 
> myself. Only acpi=off fixes the problem, while knocking out SMT (MADT), 
> IOMMU (DMAR) and the ability to suspend without crashing.
> 
> If you disagree that nocrs should override bus resource, then let me 
> know and I will not attempt this.

I guess the problem is that with "pci=nocrs", we ignore the MMIO and
I/O port resources from _CRS, but we still pay attention to bus number
resources in _CRS?  That does sound like it would be unexpected
behavior.

I *would* like to see the complete dmesg log because these _CRS
methods are pretty reliable because Windows relies on them as well, so
problems are frequently a result of Linux defects.  If we can fix
Linux or automatically work around issues so users don't have to use
"pci=nocrs" explicitly, that's the best.

Bjorn
