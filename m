Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D214391C4
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 10:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJYIzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 04:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhJYIzX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 04:55:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D1260F46;
        Mon, 25 Oct 2021 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635151981;
        bh=S//sndJIRJ7TL4mbvU/yccDnaRnmlc5/5cc+I5c0MXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=raCBK/M2+SblpxtdVIheFkaG0BSV3qVKGZWUMuvecYHYOXxUqYomOC3TSmBSU0DqE
         2IlNlYCt936+vdPI5C8KfkzGBzkjsWi05UVrkTANQYGaWPeKR0IVetDlL50QRtVUjI
         0mzrRHDYn45TWvtAtHLBYxc69TCAz2sTpO+PEbaiosFDu8/EI8uS9cm/h7mDxdv5T9
         wEMZaDOqFAYlam7M7N1l0ucvwqj98lSq9eH9z6/gsv+dMhasRhAWIP+kup/gt6A8ID
         93MVxODMjcFY9E8g3Swh0riPPKZ0ugIsYByh7mmpGwAwJIn3FvZt8A1tIbbv+sr09k
         TJo7vgWs3KkWQ==
Date:   Mon, 25 Oct 2021 09:52:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v15 02/13] PCI: kirin: Add support for a PHY layer
Message-ID: <20211025095254.522c1da6@sal.lan>
In-Reply-To: <3919b668-cf6a-ffda-0115-c2a94750e56a@ti.com>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
        <f38361df2e9d0dc5a38ff942b631f7fef64cdc12.1634812676.git.mchehab+huawei@kernel.org>
        <3919b668-cf6a-ffda-0115-c2a94750e56a@ti.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Em Mon, 25 Oct 2021 13:44:57 +0530
Kishon Vijay Abraham I <kishon@ti.com> escreveu:

> Hi Mauro,

> > +
> > +static const struct of_device_id kirin_pcie_match[] = {
> > +	{
> > +		.compatible = "hisilicon,kirin960-pcie",
> > +		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
> > +	},  
> 
> Where is PCIE_KIRIN_EXTERNAL_PHY used?

See:
	[PATCH v15 06/13] PCI: kirin: Add Kirin 970 compatible

	https://lore.kernel.org/all/ac8c730c0300b90d96bdaaf387d458d8949241a9.1634812676.git.mchehab+huawei@kernel.org/

Basically, Kirin 970 (and any other devices that would use the same
driver) should also use PCIE_KIRIN_EXTERNAL_PHY and place the PHY 
driver inside drivers/phy, instead of hardcoding it at the driver.

The Kirin 970 PHY driver was already merged at linux-next:

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/phy/hisilicon/phy-hi3670-pcie.c

Regards,
Mauro
