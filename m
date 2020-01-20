Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89338142EA0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATPS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 10:18:57 -0500
Received: from foss.arm.com ([217.140.110.172]:33568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgATPS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 10:18:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D2D30E;
        Mon, 20 Jan 2020 07:18:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661003F52E;
        Mon, 20 Jan 2020 07:18:54 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:18:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200120151849.GA24402@e121166-lin.cambridge.arm.com>
References: <20200103174935.5612-1-vidyas@nvidia.com>
 <CABhMZUUHGEEhsJ-+foSsodqtKXyX5ZNPkGgv_VzXz=Qv+NVcUA@mail.gmail.com>
 <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
 <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
 <20200120111042.GA203160@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120111042.GA203160@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 20, 2020 at 12:10:42PM +0100, Thierry Reding wrote:

[...]

> > > Currently the BSP has the kernel booting through Device Tree mechanism
> > > and there is a plan to support UEFI based boot as well in the future software
> > > releases for which we need this quirky way of handling ECAM.
> > > Tegra194 is going to be the only and last chip with this issue and next chip
> > > in line in Tegra SoC series will be fully compliant with ECAM.
> > 
> > ACPI on ARM64 works on a standard subset of systems, defined by the
> > ARM SBSA:
> > 
> > http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf
> 
> I don't understand what you're saying here. Are you saying that you want
> to prevent vendors from upstreaming code that they need to support their
> ACPI based platforms? I understand that the lack of support for proper
> ECAM means that a platform will not be SBSA compatible, but I wasn't
> aware that lack of SBSA compatibility meant that a platform would be
> prohibited from implementing ACPI support in an upstream kernel.

ACPI on ARM64 requires a set of HW components described in the SBSA.

If those HW requirements are not fulfilled you can't bootstrap an ARM64
system with ACPI - it is as simple as that. It is not even appropriate
to discuss this on a Linux mailing list anymore since it is HW
requirements and it has been public information since ACPI on ARM64 was
first enabled.

> > These patches will have to be carried out of tree, the MCFG quirk
> > mechanism (merged as Bjorn said more than three years ago) was supposed
> > to be a temporary plaster to bootstrap server platforms with teething
> > issues, the aim is to remove it eventually not to add more code to it
> > indefinitely.
> 
> Now, I fully agree that quirks are suboptimal and we'd all prefer if we
> didn't have to deal with them. Unfortunately the reality is that
> mistakes happen and hardware doesn't always work the way we want it to.
> There's plenty of other quirk mechanisms in the kernel, and frankly this
> one isn't really that bad in comparison.

Because you don't have to maintain it ;) - I think I said what I had to
say about the MCFG mechanism in the past - it has been three years
and counting - it is time to remove it rather that adding to it.

> > So I am afraid but this quirk (and any other coming our way) will not be
> > merged in an upstream kernel anymore - for any queries please put Nvidia
> > in touch.
> 
> Again, I don't understand what you're trying to achieve here. You seem
> to be saying that we categorically can't support this hardware because
> it isn't fully SBSA compatible.

I am not trying to achieve anything - I am just stating public
information - let me repeat it again for interested readers: to
bootstrap an ARM64 system with ACPI the platform HW design must follow
the SBSA guidelines.

> Do you have any alternative suggestions on how we can support this in an
> upstream kernel?

Booting with a device tree ?

> We realized a while ago that we cannot achieve proper ECAM on Tegra194
> because of some issues with the hardware and we've provided this as
> feedback to the hardware engineers. As a result, the next generation of
> Tegra should no longer suffer from these issues.

We will bootstrap next generation Tegra with ACPI then, there are
SBSA tests available for compliancy - again, that's a matter for
Nvidia and Arm to settle, not a mailing list discussion.

> As for Tegra194, that chip taped out two years ago and it isn't possible
> to make it fully ECAM compliant other than by revising the chip, which,
> frankly, isn't going to happen.
> 
> So I see two options here: either we find a way of dealing with this, by
> either merging this quirk or finding an alternative solution, or we make
> the decision that some hardware just can't be supported.
> 
> The former is fairly common, whereas I've never heard of the latter.

What does this mean ? Should I wreck the upstream kernel to make it boot
with ACPI on *any* ARM64 platform out there then ?

My stance is clear above and the ACPI PCI programming model - inclusive
of firmware - has been there since ACPI was deployed, if ACPI support
is required HW must comply, either that or it is out of tree patches
and I can't be blamed for that.

Thanks,
Lorenzo
