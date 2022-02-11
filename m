Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF74B2A27
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiBKQX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:23:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBKQXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:23:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313C738C;
        Fri, 11 Feb 2022 08:23:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F04106F;
        Fri, 11 Feb 2022 08:23:20 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647893F70D;
        Fri, 11 Feb 2022 08:23:19 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:23:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <20220211162317.GC448@lpieralisi>
References: <20220105093552.27542-1-pali@kernel.org>
 <244e74d9-1b46-2abc-6c2a-c089fa5b68b4@broadcom.com>
 <20220105181306.mkratasqg36tjf4e@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105181306.mkratasqg36tjf4e@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 07:13:06PM +0100, Pali Rohár wrote:
> Hello!
> 
> On Wednesday 05 January 2022 09:51:48 Ray Jui wrote:
> > Hi Pali,
> > 
> > On 1/5/2022 1:35 AM, Pali Rohár wrote:
> > > Register 0x43c in its low 24 bits contains PCI class code.
> > > 
> > > Update code to set all 24 bits of PCI class code and not only upper 16 bits
> > > of PCI class code.
> > > 
> > > Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bits
> > > of normal PCI bridge class.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Roman helped me with this change and confirmed that class code is stored
> > > really in bits [23:0] of custom register 0x43c (normally class code is
> > > stored in bits [31:8] of pci register 0x08).
> > > 
> > > This patch depends on patch which adds PCI_CLASS_BRIDGE_PCI_NORMAL macro:
> > > https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> > > ---
> > >  drivers/pci/controller/pcie-iproc.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > index 3df4ab209253..2519201b0e51 100644
> > > --- a/drivers/pci/controller/pcie-iproc.c
> > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > @@ -789,14 +789,13 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
> > >  		return -EFAULT;
> > >  	}
> > >  
> > > -	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
> > > +	/* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
> > >  #define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
> > > -#define PCI_CLASS_BRIDGE_MASK		0xffff00
> > > -#define PCI_CLASS_BRIDGE_SHIFT		8
> > > +#define PCI_BRIDGE_CTRL_REG_CLASS_MASK	0xffffff
> > >  	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> > >  				    4, &class);
> > > -	class &= ~PCI_CLASS_BRIDGE_MASK;
> > > -	class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
> > > +	class &= ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
> > > +	class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
> > >  	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> > >  				     4, class);
> > >  
> > 
> > I have two comments:
> > 
> > 1. You do not seem to generate the email list using the
> > get_maintainer.pl script, so the two maintainers for Broadcom ARM
> > architecture (Ray Jui and Scott Branden) are left out.
> 
> Ou, sorry for that! I have generated this patch for U-Boot and Linux
> kernel and probably mixed or forgot to include correct recipients for
> correct project.
> 
> > 2. I suppose 'PCI_CLASS_BRIDGE_PCI_NORMAL' is defined in some common PCI
> > header in a separate patch as described in the commit message. Then how
> > come these patches are not constructed with a patch series?
> 
> Yes, PCI_CLASS_BRIDGE_PCI_NORMAL is a new constant for common pci header
> file defined in patch linked in commit message.
> https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> 
> Originally I included this change in v1 of linked patch in December but
> I realized that it does not match standard PCI config space (different
> offset 0x43c vs 0x08 and also different shift 0x8 vs 0x0) and probably
> there is something either incorrect or really non-standard. So later in
> December I dropped iproc_pcie_check_link() change in v2 of the linked
> patch where is introduced PCI_CLASS_BRIDGE_PCI_NORMAL and now sent new
> change for iproc_pcie_check_link() separately.
> 
> Technically, linked patch in commit message is just extracting code into
> the common macros without any functional changed. But change in this
> iproc_pcie_check_link() has also functional change as now also lower 8
> bits of class code are changed. So in my opinion this patch should be
> really separate of linked patch.
> 
> I hope that Lorenzo and Bjorn take patches in correct order...

Can you resend the patches in a series please, I will drop this one.

Thanks,
Lorenzo

> > Other than, the change itself is exactly what I sent to Roman and looks
> > good to me. Thanks.
> > 
> > Acked-by: Ray Jui <ray.jui@broadcom.com>
> 
> Perfect!
