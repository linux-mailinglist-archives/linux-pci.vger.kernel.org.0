Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6243DB686E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfIRQqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 12:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387733AbfIRQqw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 12:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53ECFEC524;
        Wed, 18 Sep 2019 16:46:52 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3041100197A;
        Wed, 18 Sep 2019 16:46:51 +0000 (UTC)
Date:   Wed, 18 Sep 2019 10:46:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI: quirks: Fix register location for UPDCR
Message-ID: <20190918104651.66535375@x1.home>
In-Reply-To: <20190918120917.GF9720@e119886-lin.cambridge.arm.com>
References: <054ef65b-07de-7625-ebcb-f5ce64bc2726@kernkonzept.com>
        <20190918104213.GD9720@e119886-lin.cambridge.arm.com>
        <8da75cab-d3d4-14aa-1113-087d4a868072@kernkonzept.com>
        <20190918120917.GF9720@e119886-lin.cambridge.arm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 18 Sep 2019 16:46:52 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Sep 2019 13:09:18 +0100
Andrew Murray <andrew.murray@arm.com> wrote:

> On Wed, Sep 18, 2019 at 02:02:59PM +0200, Steffen Liebergeld wrote:
> > On 18/09/2019 12:42, Andrew Murray wrote:  
> > > On Tue, Sep 17, 2019 at 08:07:13PM +0200, Steffen Liebergeld wrote:  
> > >> According to documentation [0] the correct offset for the
> > >> Upstream Peer Decode Configuration Register (UPDCR) is 0x1014.
> > >> It was previously defined as 0x1114. This patch fixes it.
> > >>
> > >> [0]
> > >> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-mobile-i-o-datasheet.pdf
> > >> (page 325)
> > >>
> > >> Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>  
> > > 
> > > You may also like to add:
> > > 
> > > Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
> > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > 
> > > As well as CC'ing stable.  
> > 
> > Ok. Thank you.
> >   
> > > I guess the side effect of this bug is that we claim to have peer
> > > isolation when we do not. This fix ensures that we get the advertised
> > > isolation.  
> > Yes, that is also my understanding. Should I explain that in the commit
> > message?  
> 
> I think something similar to that would be helpful.

This is unfortunate, but my initial impression is that this may have
just been a typo that slipped by everyone.  It's difficult to actually
test for isolation.  Maybe someone from Intel could review this.  Also,
Steffen discussed this with me prior to posting and I believe this is
untested, so while trivial from inspection, it would be preferable to
know that some sample of hardware doesn't fall over as a result.
Thanks,

Alex
