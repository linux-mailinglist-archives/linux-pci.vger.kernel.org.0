Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAD4B4F56
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352361AbiBNLub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 06:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352648AbiBNLuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 06:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF794;
        Mon, 14 Feb 2022 03:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AB461286;
        Mon, 14 Feb 2022 11:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC8C340E9;
        Mon, 14 Feb 2022 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644839353;
        bh=ofMA+waGTo/pG7F7s4Rwg0xTEsFwMBbjf3Abpr2J8pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E889Q//CBY6NBKWMSby39FcMy9/J65+2X2/SzPwe/ZFHUScNLXZyzxG2yYp6lnkS/
         A722jm33WcI/TL3pH56kWVcHagKXfvpmqXmU0VDJPA8kZRPVD/moiXf1UsbCiFxHb0
         2gT5kmjEcI3bBYlIqy/WmSb/5z4U4NPMpr59hShV2NIw51eiBjFupapA6hMrJJei6X
         hAwsNVurVLrb6KRFzYLIguPcBjltw1YAjtVoJz5+PvPfb0qrwXuYhstt7ZDWd6mWoD
         iJVSwydrsNUdzbzsbV7yr4tMq03kjy2tfaguGZhWR9yX3QEJ8lOtACcMCXhcPEbhhN
         MImPupZ5mrNLg==
Received: by pali.im (Postfix)
        id 890D9CAA; Mon, 14 Feb 2022 12:49:10 +0100 (CET)
Date:   Mon, 14 Feb 2022 12:49:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <20220214114910.vaez3coyyfztabni@pali>
References: <20220105093552.27542-1-pali@kernel.org>
 <244e74d9-1b46-2abc-6c2a-c089fa5b68b4@broadcom.com>
 <20220105181306.mkratasqg36tjf4e@pali>
 <20220211162317.GC448@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211162317.GC448@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 February 2022 16:23:17 Lorenzo Pieralisi wrote:
> On Wed, Jan 05, 2022 at 07:13:06PM +0100, Pali Rohár wrote:
> > Hello!
> > 
> > On Wednesday 05 January 2022 09:51:48 Ray Jui wrote:
> > > Hi Pali,
> > > 
> > > On 1/5/2022 1:35 AM, Pali Rohár wrote:
> > > > Register 0x43c in its low 24 bits contains PCI class code.
> > > > 
> > > > Update code to set all 24 bits of PCI class code and not only upper 16 bits
> > > > of PCI class code.
> > > > 
> > > > Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bits
> > > > of normal PCI bridge class.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > 
> > > > ---
> > > > Roman helped me with this change and confirmed that class code is stored
> > > > really in bits [23:0] of custom register 0x43c (normally class code is
> > > > stored in bits [31:8] of pci register 0x08).
> > > > 
> > > > This patch depends on patch which adds PCI_CLASS_BRIDGE_PCI_NORMAL macro:
> > > > https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> > > > ---
> > > >  drivers/pci/controller/pcie-iproc.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > > index 3df4ab209253..2519201b0e51 100644
> > > > --- a/drivers/pci/controller/pcie-iproc.c
> > > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > > @@ -789,14 +789,13 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
> > > >  		return -EFAULT;
> > > >  	}
> > > >  
> > > > -	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
> > > > +	/* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
> > > >  #define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
> > > > -#define PCI_CLASS_BRIDGE_MASK		0xffff00
> > > > -#define PCI_CLASS_BRIDGE_SHIFT		8
> > > > +#define PCI_BRIDGE_CTRL_REG_CLASS_MASK	0xffffff
> > > >  	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> > > >  				    4, &class);
> > > > -	class &= ~PCI_CLASS_BRIDGE_MASK;
> > > > -	class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
> > > > +	class &= ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
> > > > +	class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
> > > >  	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> > > >  				     4, class);
> > > >  
> > > 
> > > I have two comments:
> > > 
> > > 1. You do not seem to generate the email list using the
> > > get_maintainer.pl script, so the two maintainers for Broadcom ARM
> > > architecture (Ray Jui and Scott Branden) are left out.
> > 
> > Ou, sorry for that! I have generated this patch for U-Boot and Linux
> > kernel and probably mixed or forgot to include correct recipients for
> > correct project.
> > 
> > > 2. I suppose 'PCI_CLASS_BRIDGE_PCI_NORMAL' is defined in some common PCI
> > > header in a separate patch as described in the commit message. Then how
> > > come these patches are not constructed with a patch series?
> > 
> > Yes, PCI_CLASS_BRIDGE_PCI_NORMAL is a new constant for common pci header
> > file defined in patch linked in commit message.
> > https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> > 
> > Originally I included this change in v1 of linked patch in December but
> > I realized that it does not match standard PCI config space (different
> > offset 0x43c vs 0x08 and also different shift 0x8 vs 0x0) and probably
> > there is something either incorrect or really non-standard. So later in
> > December I dropped iproc_pcie_check_link() change in v2 of the linked
> > patch where is introduced PCI_CLASS_BRIDGE_PCI_NORMAL and now sent new
> > change for iproc_pcie_check_link() separately.
> > 
> > Technically, linked patch in commit message is just extracting code into
> > the common macros without any functional changed. But change in this
> > iproc_pcie_check_link() has also functional change as now also lower 8
> > bits of class code are changed. So in my opinion this patch should be
> > really separate of linked patch.
> > 
> > I hope that Lorenzo and Bjorn take patches in correct order...
> 
> Can you resend the patches in a series please, I will drop this one.

Done!
https://lore.kernel.org/linux-pci/20220214114109.26809-2-pali@kernel.org/T/#u

> Thanks,
> Lorenzo
> 
> > > Other than, the change itself is exactly what I sent to Roman and looks
> > > good to me. Thanks.
> > > 
> > > Acked-by: Ray Jui <ray.jui@broadcom.com>
> > 
> > Perfect!
