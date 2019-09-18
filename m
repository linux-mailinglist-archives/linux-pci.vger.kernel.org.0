Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B890BB62CE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfIRMJV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 08:09:21 -0400
Received: from foss.arm.com ([217.140.110.172]:40342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfIRMJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 08:09:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DE7C337;
        Wed, 18 Sep 2019 05:09:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B92363F575;
        Wed, 18 Sep 2019 05:09:19 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:09:18 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: quirks: Fix register location for UPDCR
Message-ID: <20190918120917.GF9720@e119886-lin.cambridge.arm.com>
References: <054ef65b-07de-7625-ebcb-f5ce64bc2726@kernkonzept.com>
 <20190918104213.GD9720@e119886-lin.cambridge.arm.com>
 <8da75cab-d3d4-14aa-1113-087d4a868072@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8da75cab-d3d4-14aa-1113-087d4a868072@kernkonzept.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 18, 2019 at 02:02:59PM +0200, Steffen Liebergeld wrote:
> On 18/09/2019 12:42, Andrew Murray wrote:
> > On Tue, Sep 17, 2019 at 08:07:13PM +0200, Steffen Liebergeld wrote:
> >> According to documentation [0] the correct offset for the
> >> Upstream Peer Decode Configuration Register (UPDCR) is 0x1014.
> >> It was previously defined as 0x1114. This patch fixes it.
> >>
> >> [0]
> >> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-mobile-i-o-datasheet.pdf
> >> (page 325)
> >>
> >> Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
> > 
> > You may also like to add:
> > 
> > Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > 
> > As well as CC'ing stable.
> 
> Ok. Thank you.
> 
> > I guess the side effect of this bug is that we claim to have peer
> > isolation when we do not. This fix ensures that we get the advertised
> > isolation.
> Yes, that is also my understanding. Should I explain that in the commit
> message?

I think something similar to that would be helpful.

Thanks,

Andrew Murray

> 
> Best,
> Steffen
> -- 
> Steffen Liebergeld +49-351-41 888 613
> 
> Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
> Geschäftsführer: Dr.-Ing. Michael Hohmuth
