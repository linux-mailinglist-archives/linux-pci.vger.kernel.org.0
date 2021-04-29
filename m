Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD32B36F0A4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhD2Thr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 15:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhD2Thm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 15:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D4B600CC;
        Thu, 29 Apr 2021 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619725015;
        bh=8qTr80J0KbuRLxil9CnVJRioIT8fB91HyxsScY2IM0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsTXJd41lFzCj1fFCS/URuvb3txwW6JaHBSYnMR1av8hx4AxBX87UNs6GU9Zwu9Hv
         5QrpjMcinSerx6yOiUd02oWNY31FJxRaBn84tfKpGQ70VE9ARH4KSWf+tUQmHZdYsG
         0q/1oUOyuJs1VyFxwTc3HhsRvYWwNpVRyoh2jc/Qp2aODWBlvaicZMRMu9/WJCynpG
         IvNF/ZTWrbhtEf+MFGgi71kAM22ZVYGIhnjhIGPYUPcifFmJTFtJLhLf/3tdu4KaO0
         YAXTNvQehz/Sfa+ML898mma27wuBdjbITNI9O4NXiUwAGA+U6XaQxQvpl885+9TxAc
         /bhrrWQDMAZuQ==
Date:   Fri, 30 Apr 2021 04:36:48 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210429193648.GA26517@redsun51.ssa.fujisawa.hgst.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 28, 2021 at 10:52:00AM +0200, Lukas Wunner wrote:
> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> link upon an error and attempts to re-enable it when instructed by the
> DPC driver.
> 
> A slot which is both DPC- and hotplug-capable is currently brought down
> by pciehp once DPC is triggered (due to the link change) and brought up
> on successful recovery.  That's undesirable, the slot should remain up
> so that the hotplugged device remains bound to its driver.  DPC notifies
> the driver of the error and of successful recovery in pcie_do_recovery()
> and the driver may then restore the device to working state.

This is a bit strange. The PCIe spec says DPC capable ports suppress
Link Down events specifically because it will confuse hot-plug
surprise ports if you don't do that. I'm specifically looking at the
"Implementation Note" in PCIe Base Spec 5.0 section 6.10.2.4.

Do these ports have out-of-band Precense Detect capabilities? If so, we
can ignore Link Down events on DPC capable ports as long as PCIe Slot
Status PDC isn't set.
