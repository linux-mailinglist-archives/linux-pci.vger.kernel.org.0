Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9720143535F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJTTEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 15:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230290AbhJTTEb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 15:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0C3660EB1;
        Wed, 20 Oct 2021 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634756536;
        bh=LTS6MAYewrWPxmu6wu7tCAK1yc55sLMAEpDF0ug4y6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UwFUHl8PY/SmaU1BtR97o607/9KUmYn1Sx5CbM60V8xVBJov7Pjg8XWeeHNVaLCxc
         hoKGlhshvXPYq9ecbbgRExre2T+oY0SZfVplM/pvpGW37IESWqHCXAlx261fESd+zN
         +KDN9pR/jlFwu1gg22KbrLN29S0PGA+qWamcN/Zoo2gm+VTH8IbONOXYiQprBLMylm
         pU5djHjgVF/Sh5gOc+6IHVaQYRuofSvzjQfBphtkjKd/02dxPM6AYRk6iOt9XTaTDd
         PIsJKXUFjAPW1dOpbtp59oXXBe0eDNggzeMsbHI6sSFWhXu/NOJG7mYRjCiMFNyfV+
         AF0kPrkylLYqA==
Date:   Wed, 20 Oct 2021 14:02:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>, Simon Xue <xxm@rock-chips.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211020190214.GA2630871@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020064142.0807ae70@sal.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 20, 2021 at 06:41:42AM +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 19 Oct 2021 14:27:58 -0500
> Bjorn Helgaas <helgaas@kernel.org> escreveu:
> 
> > On Tue, Oct 19, 2021 at 07:06:37AM +0100, Mauro Carvalho Chehab wrote:
> > 
> > > Mauro Carvalho Chehab (11):
> > >   PCI: kirin: Reorganize the PHY logic inside the driver
> > >   PCI: kirin: Add support for a PHY layer
> > >   PCI: kirin: Use regmap for APB registers
> > >   PCI: kirin: Add support for bridge slot DT schema
> > >   PCI: kirin: give more time for PERST# reset to finish
> > >   PCI: kirin: Add Kirin 970 compatible
> > >   PCI: kirin: Add MODULE_* macros
> > >   PCI: kirin: Allow building it as a module
> > >   PCI: kirin: Add power_off support for Kirin 960 PHY
> > >   PCI: kirin: fix poweroff sequence
> > >   PCI: kirin: Allow removing the driver  
> > 
> > Don't repost for this, but if you have occasion to repost for other
> > reasons, two of these are not capitalized like the others:
> > 
> > >   PCI: kirin: give more time for PERST# reset to finish
> > >   PCI: kirin: fix poweroff sequence  
> > 
> > These are write-once for you, but I'll be reading them many times in
> > the future and they're minor distractions.
> 
> Ok, changed on my working repository. On media and on other subsystems
> I contribute regularly, the practice is just the opposite: to use
> lowercase after colons.

Thanks.  I wouldn't mind a kernel-wide convention, but there isn't
one.  I just try to pay attention to whatever convention there is for
a given file or subsystem.

Bjorn
