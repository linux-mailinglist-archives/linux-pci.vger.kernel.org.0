Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811473C654F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhGLVOL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 17:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhGLVOK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 17:14:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7830C61249;
        Mon, 12 Jul 2021 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626124282;
        bh=0Wx45sxU13fCIWUUT3TdPFMKGJcb4SVUd3EIYciwlcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G41PBVPkyZdnCydhZfTwOuR2nfNMe+dxVrD7UEwpNapFldoVHSuTK1DF/zkyS2CZm
         mpPb76owEUJfdGn4O3TJkc+WQibupaiXbKotpybH14gwp8hm+6ugsisGwcSPqPq3JO
         fD4MtdfXCfSVkS6zCPXv/vROxesjG2iWRaz1SHr9wx8sAyDuX/8/eu+PrERmLw7Zks
         f40VjN2WVxzrDpkacYbtSrb4Tdcsni8LCvnPiF3TuXJ/W+lKw3STkMsmMhoYiZxHNd
         Zjez30+zvUf14kjWO9lrLQUxzjpBb32wDGWnL54k35BWSmxS9cyDT01JA2ljS52H9+
         QES2F3rBDRP+A==
Date:   Mon, 12 Jul 2021 23:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Add support for Hikey 970 PCIe
Message-ID: <20210712231115.638b0697@coco.lan>
In-Reply-To: <20210712165221.GA1654345@bjorn-Precision-5520>
References: <cover.1625826353.git.mchehab+huawei@kernel.org>
        <20210712165221.GA1654345@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Em Mon, 12 Jul 2021 11:52:21 -0500
Bjorn Helgaas <helgaas@kernel.org> escreveu:

> On Fri, Jul 09, 2021 at 12:41:36PM +0200, Mauro Carvalho Chehab wrote:
> > ...
> > Manivannan Sadhasivam (1):
> >   arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller
> >     hardware  
> 
> FWIW, this didn't apply cleanly for me to v5.14-rc1.

True. The last patch of this series:

	dts: HiSilicon: Add support for HiKey 970 PCIe controller hardware

Depends on a patch that should be merged via another tree:

	https://lore.kernel.org/lkml/db5b33e4d0b239a7377e123b46f63b5640329021.1625477735.git.mchehab+huawei@kernel.org/

Such patch adds the DTS data required for the PMIC.

I guess I'll submit the series without this one. Once both series
get merged, I'll submit it in separate.

> 
> > Mauro Carvalho Chehab (8):
> >   dt-bindings: phy: add bindings for Hikey 960 PCIe PHY
> >   dt-bindings: phy: add bindings for Hikey 970 PCIe PHY
> >   dt-bindings: PCI: kirin: fix compatible string
> >   dt-bindings: PCI: kirin: drop PHY properties
> >   phy: hisilicon: add a PHY driver for Kirin 960  
> 
> >   PCI: kirin: drop the PHY logic from the driver
> >   PCI: kirin: use regmap for APB registers  
> 
> If/when you repost this, please update these subject lines to match the
> historical style:
> 
>   PCI: kirin: Drop PHY logic from the driver
>   PCI: kirin: Use regmap for APB registers
> 
> Also, please update subject lines, commit logs, Kconfig menu and help
> text, comments, etc throughout to capitalize "HiKey" and "HiSilicon"
> as the vendor does.

Ok.

> 
> >   phy: hisilicon: add driver for Kirin 970 PCIe PHY  



Thanks,
Mauro
