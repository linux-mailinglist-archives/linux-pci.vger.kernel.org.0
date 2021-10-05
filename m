Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E92422FE4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhJESZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhJESZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:25:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C869613AC;
        Tue,  5 Oct 2021 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633458202;
        bh=YzSecprsSRN1kCi/iRg3G0GZDxm9Y4cQm5i3sYHtNxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K38nQKpVghWY4FF4wjcI3yw/a40A/S+z8WAbRwYv0rp+Kaolq9NrppgddxUEVDeZY
         DVAll8M7jqb2hW40DPrM7QsRRFVc8a9FC8qMheG46uv6kcXI5JdnNqK69PFijLC+FF
         /tnKj1y0xk+EfYVtJ8p7mkOab/zUufAvNPFG2fEW8Z2uSpFSHdq0klx/zcsl5kvd8K
         4jV4vIXiMKcPMHvnK/o+/a43kCGx9gzmekRaMe0KVZmRzmotGdROi1l6rOG1ezTfhy
         1NPckI92tiLajJEnFXLRKtLtm1kx9CTbJFir3ZZklqAMsm5QnI++MG8tg28Ka43w+q
         LrhsbG9kenzVw==
Date:   Tue, 5 Oct 2021 13:23:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Message-ID: <20211005182321.GA1106986@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005112448.2c40dc10@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo]

On Tue, Oct 05, 2021 at 11:24:48AM +0200, Mauro Carvalho Chehab wrote:
> Hi Bjorn,
> 
> Em Tue, 28 Sep 2021 09:34:10 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> >   PCI: kirin: Reorganize the PHY logic inside the driver
> >   PCI: kirin: Add support for a PHY layer
> >   PCI: kirin: Use regmap for APB registers
> >   PCI: kirin: Add support for bridge slot DT schema
> >   PCI: kirin: Add Kirin 970 compatible
> >   PCI: kirin: Add MODULE_* macros
> >   PCI: kirin: Allow building it as a module
> >   PCI: kirin: Add power_off support for Kirin 960 PHY
> >   PCI: kirin: fix poweroff sequence
> >   PCI: kirin: Allow removing the driver
> 
> I guess everything is already satisfying the review feedbacks.
> If so, could you please merge the PCI ones?

Lorenzo takes care of the native host bridge drivers, so I'm sure this
is on his list.  I added him to cc: in case not.
