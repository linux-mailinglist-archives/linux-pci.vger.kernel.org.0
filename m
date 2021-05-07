Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798D37671C
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhEGOlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 10:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhEGOlS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 10:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 322E0610F7;
        Fri,  7 May 2021 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620398418;
        bh=KToNCzZXzXdchEQsEBlcFIELZRGxK0NDfDbS3vEU1zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWBF9Sa2APLDTc4h69FihPS3COm5y/y5+453SRjoKq1z2orGhlz/IPBmosvduHEEk
         OcgtmPo/uy76a8MtMEgpYJrDm7h856eqV4kMsPYFIg54dbmV72K5v4hY4BekkZNvli
         1m0ZKnt6lDbN5TBiMQLOxKK0d+Hle7Wtnuk04qlgWa8t2qLILOQoo9ZDDMZ7k+4XEg
         00tsYPTVI58Jm6G2wbgM1kMqv61nY3CFhBnHzFPbmpjGNMpgUq3ZEv80I2GRyFjuM1
         H2wPu8csrdzJAdD2gN7TXJLkRX4aBmsNKiaNriZbOLLKrCM5QIBTiYFu4UPLJ3JfrB
         J8e/NLp77VU+g==
Received: by pali.im (Postfix)
        id 500C07E0; Fri,  7 May 2021 16:40:15 +0200 (CEST)
Date:   Fri, 7 May 2021 16:40:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/42] PCI: pci-bridge-emul: Add PCIe Root Capabilities
 Register
Message-ID: <20210507144015.bol3qeqsdoo7nmju@pali>
References: <20210506153153.30454-6-pali@kernel.org>
 <20210506231009.GA1444269@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506231009.GA1444269@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 06 May 2021 18:10:09 Bjorn Helgaas wrote:
> On Thu, May 06, 2021 at 05:31:16PM +0200, Pali Rohár wrote:
> > This is 16-bit register at offset 0x1E. Rename current 'rsvd' struct member
> > to 'rootcap'.
> 
> "The 16-bit Root Capabilities register is at offset 0x1e in the PCIe
> Capability."
> 
> Please make the commit log complete in itself.  In some contexts, the
> subject line is not visible at the same time.  It's fine to repeat the
> subject in the commit log.
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
> > Cc: stable@vger.kernel.org # e0d9d30b7354 ("PCI: pci-bridge-emul: Fix big-endian support")
> 
> I'm not sure how people would deal with *two* SHA1s.

I guess that this is fine per stable document as it mention such example:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

I have already in past sent patches with Fixes:hash1 and CC:stable/hash2
and were taken correctly.

> This patch adds functionality, so it's not really fixing a bug in
> 23a5fba4d941.

I'm not sure what is the correct meaning of Fixes tag. I included it to
easily determinate in which commit was introduced member name "rsvd"
which should have been named "rootcap".

Submitting patches document is not fully clear for me as I understood it
that Fixes and CC:stable are two different things. E.g. it mention
"Attaching a Fixes: tag does not subvert ... the requirement to Cc:
stable@vger.kernel.org on all stable patch candidates." which I
understood that patch for backporting needs to have Cc:stable:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

But I will change it as needed. Just I did not know what is "the correct
way".

> I see that e0d9d30b7354 came along later and did
> "s/u16 rsvd/__le16 rsvd/".
> 
> But it seems like a lot to expect for distros and stable kernel
> maintainers to interpret this.
> 
> Personally I think I would omit both Fixes: and the stable tag since
> these two patches (05 and 06) are just adding functionality.
> 
> > ---
> >  drivers/pci/pci-bridge-emul.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> > index b31883022a8e..49bbd37ee318 100644
> > --- a/drivers/pci/pci-bridge-emul.h
> > +++ b/drivers/pci/pci-bridge-emul.h
> > @@ -54,7 +54,7 @@ struct pci_bridge_emul_pcie_conf {
> >  	__le16 slotctl;
> >  	__le16 slotsta;
> >  	__le16 rootctl;
> > -	__le16 rsvd;
> > +	__le16 rootcap;
> >  	__le32 rootsta;
> >  	__le32 devcap2;
> >  	__le16 devctl2;
> > -- 
> > 2.20.1
> > 
