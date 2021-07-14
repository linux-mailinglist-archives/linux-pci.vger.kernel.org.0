Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E233C83CA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGNLZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 07:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238984AbhGNLZo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 07:25:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A35E613B2;
        Wed, 14 Jul 2021 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626261773;
        bh=FC/9D6uaBW1b3824J5hBP6nN+CqfeDP2fvPFq9DaeZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQGnjDpCTB7wsjfVmd8BzXw8199D9LfSiVbEVCMbb9ZLYBxbOzux0NDHfabpvA9og
         21Y6dwPEkTjZMsDYjP/c0JgujoPTXpMekB/mYUJAALEETwiyTijQLZ6Ve7UNxxfLSU
         6YV2Km6kQfSmI69+mF2UluychIw7OhEWT2EaerG6rtv4PPehLyn58ETJ/egoHmzDxF
         /j+yicTAqvNFrKKVIutKeTBOx4aPhzrqWPDTEpZo5msAeikA0ybfQOKUG5tkwEkH5+
         TujfaEM4PQQ0moXqsPYlI1EGCSTXVHIVhyKyULs0sKm+DnRTex100WYbHl+RSB1J26
         j87ZzVkWKStJw==
Date:   Wed, 14 Jul 2021 13:22:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/8] dt-bindings: PCI: kirin: Drop PHY properties
Message-ID: <20210714132246.0bb44667@coco.lan>
In-Reply-To: <20210714022849.GA1330659@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022849.GA1330659@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 13 Jul 2021 20:28:49 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Jul 13, 2021 at 08:28:37AM +0200, Mauro Carvalho Chehab wrote:
> > There are several properties there that belong to the PHY
> > interface. Drop them, as a new binding file will describe
> > the PHY properties for Kirin 960.  
> 
> Folks are okay with an incompatible change on hikey960?

I hope so ;-)

I mean, it should be easy to add a backward-compatible code that
would make the PHY driver to use the pci-bus old schema if there's
no PHY entry at DT.

However, this is not enough, as the PHY driver won't be loaded/probed
without at least this at hi3660.dtsi:

	pcie_phy: pcie-phy@f3f2000 {
		compatible = "hisilicon,hi960-pcie-phy";
	};


So, some (probably ugly) hack would be needed at pcie-kirin, in order
to make it to manually load and probe the PHY driver, if it
founds (for instance) "phy" reg-name as a pcie-kirin property.

Thanks,
Mauro
