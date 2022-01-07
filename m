Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F67487CDF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiAGTPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 14:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiAGTPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 14:15:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A8C061574;
        Fri,  7 Jan 2022 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=grgsnELUEXZnuUjrVS4f5sHoasCVsBVCh9f+iJP67pA=; b=dHj0fodlh3VfjeW9VmH2pxwZSR
        7Tn/gYIelKp6SQ/rG6Giu0IP4YvsNoWg3wXG+/OV//NQ+/8OBMcBCBiD8cCs3YUJ/WQgUvH2bNhXE
        ISsP1V9AYlmg8ibVTX6h93pCfKoaIfqrDtkTrkV3ghkwC4T4vHkJay8QF06RtEmzuQh6IIWzkL29w
        sa+gDnOytbBfSnQd+4cSBrFnu+wSAKuBXXzWGqCpONLnRf0tJ0zJFcPxWposgxZ+6LCIaumSme3XA
        9JfR3pC4JGLCdRgY1yhJANs6P9hd3blMI1kE8agwZP1hllfTLaVsCRiG98MljmV8B/8ouTHW0pWde
        aATHLDZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56622)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1n5ui0-0001k1-TT; Fri, 07 Jan 2022 19:15:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1n5uhy-00029p-BZ; Fri, 07 Jan 2022 19:15:26 +0000
Date:   Fri, 7 Jan 2022 19:15:26 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] PCI: mvebu: Handle invalid size of read config
 request
Message-ID: <YdiRTjGGWelHZ9rA@shell.armlinux.org.uk>
References: <20211125124605.25915-5-pali@kernel.org>
 <20220107184548.GA390934@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107184548.GA390934@bhelgaas>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 12:45:48PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 25, 2021 at 01:45:54PM +0100, Pali Rohár wrote:
> > Function mvebu_pcie_hw_rd_conf() does not handle invalid size. So correctly
> > set read value to all-ones and return appropriate error return value
> > PCIBIOS_BAD_REGISTER_NUMBER like in mvebu_pcie_hw_wr_conf() function.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> Is there a bug that this fixes?  If not, I would drop the stable tag
> (as I see Lorenzo already did, thanks!).
> 
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 08274132cdfb..19c6ee298442 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -261,6 +261,9 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> >  	case 4:
> >  		*val = readl_relaxed(conf_data);
> >  		break;
> > +	default:
> > +		*val = 0xffffffff;
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> 
> Might be the right thing to do, but there are many config accessors
> that do not set *val to ~0 before returning
> PCIBIOS_BAD_REGISTER_NUMBER:

I think a better question would be - how can this function be called
with a size that isn't 1, 2 or 4? I suppose if someone were to add
another PCI_OP_READ/PCI_OP_WRITE. However... they really need to audit
every implementation if they do that.

The generic implementation does this:

        if (size == 1)
                *val = readb(addr);
        else if (size == 2)
                *val = readw(addr);
        else
                *val = readl(addr);

and therefore completely ignores the size if it isn't 1 or 2. So I
don't think this is something that needs fixing.

If we're going to fix this in drivers, shouldn't we fix the generic
implementation too?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
