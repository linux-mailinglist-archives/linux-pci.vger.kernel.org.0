Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4257434DC43
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhC2W7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 18:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhC2W6i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 18:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3E6761987;
        Mon, 29 Mar 2021 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617058718;
        bh=jhysSetweRUJdS8VenXWdDpmgxH3meIzQdLA2n+rNm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NX3jpCkg50kc51Psd4U6zDewVQFQWSR2kXksn3BxHwIudf8SBsko8ehoG3HOi7ujV
         1slDQ533ySqgv5YqvAXuO11FrXhiX/iv+8p9oGHz0GvXy5Uz5DrB+c7W8mNRaBqYok
         5rY8oD3x8lYdsWu1EWHhKnk9cMTMQFDZRB/Cc56SH3eofsTWzNIA08RdWG1iAwwMbG
         sb5+OlZREYqIz19u8KIwGYX2lkDefSMoiTK33xlN84ZFTXcz5aapzHdjSxhVj3EyPC
         NA/XOqYB9xIMoLA5y+9MyJj1dDgdUoIkLq0F7f58WhJzmMP5BNjy2ixirK0Yxb+Qss
         VKMeJCgQHDZWA==
Received: by pali.im (Postfix)
        id 515CBA79; Tue, 30 Mar 2021 00:58:35 +0200 (CEST)
Date:   Tue, 30 Mar 2021 00:58:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <20210329225835.cv2ev5ou5szvrws2@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
 <20210311123844.qzl264ungtk7b6xz@pali>
 <1615621394.25662.70.camel@mhfsdcap03>
 <20210318000211.ykjsfavfc7suu2sb@pali>
 <1616046487.31760.16.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616046487.31760.16.camel@mhfsdcap03>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 March 2021 13:48:07 Jianjun Wang wrote:
> On Thu, 2021-03-18 at 01:02 +0100, Pali Rohár wrote:
> > On Saturday 13 March 2021 15:43:14 Jianjun Wang wrote:
> > > On Thu, 2021-03-11 at 13:38 +0100, Pali Rohár wrote:
> > > > On Wednesday 24 February 2021 14:11:28 Jianjun Wang wrote:
> > > > > +
> > > > > +	/* Check if the link is up or not */
> > > > > +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> > > > > +				 !!(val & PCIE_PORT_LINKUP), 20,
> > > > > +				 50 * USEC_PER_MSEC);
> > > > 
> > > > IIRC, you need to wait at least 100ms after de-asserting PERST# signal
> > > > as it is required by PCIe specs and also because experiments proved that
> > > > some Compex wifi cards (e.g. WLE900VX) are not detected if you do not
> > > > wait this minimal time.
> > > 
> > > Yes, this should be 100ms, I will fix it at next version, thanks for
> > > your review.
> > 
> > In past Bjorn suggested to use msleep(PCI_PM_D3COLD_WAIT); macro for
> > this step during reviewing aardvark driver.
> > 
> > https://lore.kernel.org/linux-pci/20190426161050.GA189964@google.com/
> > 
> > And next iteration used this PCI_PM_D3COLD_WAIT macro instead of 100:
> > 
> > https://lore.kernel.org/linux-pci/20190522213351.21366-2-repk@triplefau.lt/
> 
> Sure, I will use PCI_PM_D3COLD_WAIT macro instead in the next version.
> 
> Thanks.

Anyway, now I found out that kernel has functions for this waiting:
pcie_wait_for_link_delay() and pcie_wait_for_link()

Function is called from pci_bridge_wait_for_secondary_bus().

But in current form it is not usable for native controller drivers.

This looks like another candidate for code de-duplication or providing
"framework".


Lorenzo, as maintainer of native controller drivers, do you have some
ideas about providing "framework", common functions or something for
avoiding to implement same code patterns in every native controller
driver, which is de-facto standard PCIe codepath? Including a way how to
export PERST# reset gpio?
