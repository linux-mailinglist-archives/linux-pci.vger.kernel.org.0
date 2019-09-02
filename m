Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82709A5972
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfIBOeD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 10:34:03 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53611 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfIBOeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 10:34:03 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E5B0B1BF20E;
        Mon,  2 Sep 2019 14:34:00 +0000 (UTC)
Date:   Mon, 2 Sep 2019 16:43:07 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
Message-ID: <20190902144306.GA1011@voidbox.localdomain>
References: <20190901133915.12899-1-repk@triplefau.lt>
 <20190902105536.GG9720@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902105536.GG9720@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 02, 2019 at 11:55:36AM +0100, Andrew Murray wrote:
> On Sun, Sep 01, 2019 at 03:39:15PM +0200, Remi Pommarel wrote:
> > Normally asserting reset signal on gpio would be achieved with:
> > 	gpiod_set_value_cansleep(reset_gpio, 1);
> > 
> > Meson PCI driver set reset value to '0' instead of '1' as it takes into
> > account the PERST# signal polarity. The polarity should be taken care
> > in the device tree instead.
> > 
> > This fixes the reset assertion meaning and moves out the polarity
> > configuration in DT (please note that there is no DT currently using
> > this driver).
> 
> The device tree bindings for this give an example configuration:
> 
>         pcie: pcie@f9800000 {
>                         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>                         reg = <0x0 0xf9800000 0x0 0x400000
>                                         0x0 0xff646000 0x0 0x2000
>                                         0x0 0xff644000 0x0 0x2000
>                                         0x0 0xf9f00000 0x0 0x100000>;
>                         reg-names = "elbi", "cfg", "phy", "config";
>                         reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
> 
> Is the 'reset-gpios' line still consistent with this change, or does
> this need to be updated as well?

Good catch, the polarity of the reset gpio will more likely be
GPIO_ACTIVE_LOW.

Do you want a separate patch for that or can I just include it in v2 ?

Thanks.

-- 
Remi
