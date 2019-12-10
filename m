Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBFC118B44
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLJOlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 09:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 09:41:17 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A3920637;
        Tue, 10 Dec 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988876;
        bh=SltthD4NbtaeRWyxi1D4XcXo4egcyCVIbinwy09m8FU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KuNTqMFNMWoBMSOEUtzr0uQGn5HUyh+PTR+nBmoJYbnPeswReouo7wj+EBSeabn6B
         z+b20KTF1Yt2p/87POEocxWE8VyW5eA3FIz/JPFwkLC9NUoFr5Zrnt/MjgBHlDBtNL
         j7bCqkCIS4MnuaXxrPbcVI8dHwaOBJK6VvU0N6i0=
Date:   Tue, 10 Dec 2019 08:41:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191210144115.GA94877@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209160638.141431-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
> From: Deepak Pandey <Deepak.Pandey@arm.com>
> 
> The Arm N1SDP SoC suffers from some PCIe integration issues, most
> prominently config space accesses to not existing BDFs being answered
> with a bus abort, resulting in an SError.

Can we tease this apart a little more?  Linux doesn't program all the
bits that control error signaling, so even on hardware that works
perfectly, much of this behavior is determined by what firmware did.
I wonder if Linux could be more careful about this.

"Bus abort" is not a term used in PCIe.  IIUC, a config read to a
device that doesn't exist should terminate with an Unsupported Request
completion, e.g., see the implementation note in PCIe r5.0 sec 2.3.1.

The UR should be an uncorrectable non-fatal error (Table 6-5), and
Figures 6-2 and 6-3 show how it should be handled and when it should
be signaled as a system error.  In case you don't have a copy of the
spec, I extracted those two figures and put them at [1].

Can you collect "lspci -vvxxx" output to see if we can correlate it
with those figures and the behavior you see?

[1] https://drive.google.com/file/d/1ihhdQvr0a7ZEJG-3gPddw1Tq7cTFAsah/view?usp=sharing

> To mitigate this, the firmware scans the bus before boot (catching the
> SErrors) and creates a table with valid BDFs, which acts as a filter for
> Linux' config space accesses.
> 
> Add code consulting the table as an ACPI PCIe quirk, also register the
> corresponding device tree based description of the host controller.
> Also fix the other two minor issues on the way, namely not being fully
> ECAM compliant and config space accesses being restricted to 32-bit
> accesses only.

As I'm sure you've noticed, controllers that support only 32-bit
config writes are not spec compliant and devices may not work
correctly.  The comment in pci_generic_config_write32() explains why.

You may not trip over this problem frequently, but I wouldn't call it
a "minor" issue because when you *do* trip over it, you have no
indication that a register was corrupted.

Even ECAM compliance is not really minor -- if this controller were
fully compliant with the spec, you would need ZERO Linux changes to
support it.  Every quirk like this means additional maintenance
burden, and it's not just a one-time thing.  It means old kernels that
*should* "just work" on your system will not work unless somebody
backports the quirk.

> This allows the Arm Neoverse N1SDP board to boot Linux without crashing
> and to access *any* devices (there are no platform devices except UART).
