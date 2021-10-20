Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9F4344C0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJTFoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 01:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhJTFoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 01:44:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4956B610FF;
        Wed, 20 Oct 2021 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634708511;
        bh=W/zndsrIO03CCVWRiW3h89JjE5e2vGwXoypJkY4Fy40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mqX/5eUckZ+hGL7rMu5XaCNgADjckqv3UJNSpmXc9VSsZz7vmV0DXKu+CkYY0w6DZ
         WakHDvNlIO2xH+/yoiP47n3ZaZg0QuQDF3r5PgetfUY0A7KJd3pjYzjaM5PZQ6FQye
         Kv78ilP6eRKJbUSjktsbvuvyAgCzo6rMaAAWdFP/pwpk2aKhQfJAVaNyK0Zt+bqjUl
         uwsaIKPuVJU5FiPSUSrRoXzq3IUcTTiVXhNp+gDTUsdAFdn/ofOCrzae60x72ErtYb
         7y0yOvNDViI2d3imlCMpncufEHSJgtvY4SKQy1IoquHH7MTs8mh/L1ZF/NZJdlUEEV
         GYGT/l7tVsr3w==
Date:   Wed, 20 Oct 2021 06:41:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
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
Message-ID: <20211020064142.0807ae70@sal.lan>
In-Reply-To: <20211019192758.GA2393049@bhelgaas>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
        <20211019192758.GA2393049@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 19 Oct 2021 14:27:58 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> On Tue, Oct 19, 2021 at 07:06:37AM +0100, Mauro Carvalho Chehab wrote:
> 
> > Mauro Carvalho Chehab (11):
> >   PCI: kirin: Reorganize the PHY logic inside the driver
> >   PCI: kirin: Add support for a PHY layer
> >   PCI: kirin: Use regmap for APB registers
> >   PCI: kirin: Add support for bridge slot DT schema
> >   PCI: kirin: give more time for PERST# reset to finish
> >   PCI: kirin: Add Kirin 970 compatible
> >   PCI: kirin: Add MODULE_* macros
> >   PCI: kirin: Allow building it as a module
> >   PCI: kirin: Add power_off support for Kirin 960 PHY
> >   PCI: kirin: fix poweroff sequence
> >   PCI: kirin: Allow removing the driver  
> 
> Don't repost for this, but if you have occasion to repost for other
> reasons, two of these are not capitalized like the others:
> 
> >   PCI: kirin: give more time for PERST# reset to finish
> >   PCI: kirin: fix poweroff sequence  
> 
> These are write-once for you, but I'll be reading them many times in
> the future and they're minor distractions.

Ok, changed on my working repository. On media and on other subsystems
I contribute regularly, the practice is just the opposite: to use
lowercase after colons.

Regards,
Mauro
