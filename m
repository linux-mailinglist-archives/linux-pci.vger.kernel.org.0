Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB63433F3D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJSTaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 15:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhJSTaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 15:30:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87E966008E;
        Tue, 19 Oct 2021 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634671679;
        bh=hDzqaJoeHzbx0uIYbgizcCY/h41j5RA+wDzwnl4NrXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JabQc6wMmOLWsJsa6mMw8DsGqyAmNm2LtTnsDKBjDK3vL0UGGzRq13feS32AzKOS7
         NMaBc4PIBWrwKZJDtBpxpbQOkxROZPy9wTY0pzd1UETLXWbGzQUZkJF6vhQWXTIJt7
         iP9kf/0oNKvA9jstP1xAq/qv6zMFs84hs+7AFoPKYxMeKlFcVKqZGw4KVzX49gCQLO
         BAezIn1hyURyqFSj7U7sDpckwLRdGRaV2a4bwBOI6X15Yf9Ql0lbnCK4LhI7KGVOVH
         pOoRoH/gP5JTHuGu+KO25/SiQokPoLFRu0sV9DDMPb85U2r+UN38e6oFyq+39eTDH3
         ChZ2NHkJa/grQ==
Date:   Tue, 19 Oct 2021 14:27:58 -0500
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
Message-ID: <20211019192758.GA2393049@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 07:06:37AM +0100, Mauro Carvalho Chehab wrote:

> Mauro Carvalho Chehab (11):
>   PCI: kirin: Reorganize the PHY logic inside the driver
>   PCI: kirin: Add support for a PHY layer
>   PCI: kirin: Use regmap for APB registers
>   PCI: kirin: Add support for bridge slot DT schema
>   PCI: kirin: give more time for PERST# reset to finish
>   PCI: kirin: Add Kirin 970 compatible
>   PCI: kirin: Add MODULE_* macros
>   PCI: kirin: Allow building it as a module
>   PCI: kirin: Add power_off support for Kirin 960 PHY
>   PCI: kirin: fix poweroff sequence
>   PCI: kirin: Allow removing the driver

Don't repost for this, but if you have occasion to repost for other
reasons, two of these are not capitalized like the others:

>   PCI: kirin: give more time for PERST# reset to finish
>   PCI: kirin: fix poweroff sequence

These are write-once for you, but I'll be reading them many times in
the future and they're minor distractions.
