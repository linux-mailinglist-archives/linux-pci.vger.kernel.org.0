Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0D103719
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfKTJ5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 04:57:40 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37820 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfKTJ5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 04:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=el6438nih4sfwVUUpa3K7cGTYMkZUt0pCE/MflmMSiA=; b=bcV3glNLOjIUujMfUEw4s7kT6
        Z6OGWKZbmD0U635MtVAIlSU1ixudFfoksF22a7LTl1W20n/1fJdNsXuujM3+C1ZTKUoUumNB9aNOs
        RYd13CFvhF4cDxk/34GB9IhDX+rdOqDeoiGBGD0nrEfxwip7rS0pNaRknuUJkcgFvqxExxT41yxpW
        8PEtujQ51/SZdZW8JriCE6ikn3f7nsbUxydGpzA2n35/RP5oFpUtcrXMbFBO6AibcBqU+4KuUgB3a
        35iKgzeq3jZ6/tOsoixKQz1oeB1QCsv6pvCEo3bwd+4bSE4EBX/WpAuLpJTlt+0kXqiV8Vxb8mAU5
        yKENSjU9w==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58700)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXMju-0007YX-7j; Wed, 20 Nov 2019 09:57:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXMjp-0001cr-EL; Wed, 20 Nov 2019 09:57:29 +0000
Date:   Wed, 20 Nov 2019 09:57:29 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20191120095729.GJ25745@shell.armlinux.org.uk>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:45:17AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is to recode the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated
> Mobiveil's PCIe Gen4 controller.

How many PCIe cards have been tested to work/don't work with this?

I need:

PCI: mobiveil: ls_pcie_g4: fix SError when accessing config space
PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451
PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577

to successfully boot with a Mellanox card plugged in with a previous
revision of these patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
