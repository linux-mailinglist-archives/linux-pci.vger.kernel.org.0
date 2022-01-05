Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2A485800
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiAESNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 13:13:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39022 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 13:13:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B3861803;
        Wed,  5 Jan 2022 18:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43054C36AE0;
        Wed,  5 Jan 2022 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641406389;
        bh=XFXjmqXYuibwyK92ypw+JHMrcOAcsGTLlMLcfXAm7/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRDmFBL13tN6aEFFUwG14hsTkcsWsb3or9njILqk98ZaK6fwcemv3aDdQ/d4rn5vv
         OI3nqTeKZk+csF7hvZ9irjsoXlkJntNnqikhP6hXr/HnG+q9VTb0Hxhb9jFyAeTRP/
         rdjmjlXYiTqB0Plwh4gtxN7RhcU96vhAzKjvne/LSCvQH2vvn6incXxjzGLPfRt36t
         iUY3dZZdgdQktg4EbZdOjwx8z+kfh8vOsB5Lf3yEzExBhtutbjoMREKhRjLvXvMJRn
         r3yV6wb2L7rOPmZXIn6OvZ7m0Pby19QOiap+wUhXJRWxkrcy4cE/E4eljFz9dZQ4EL
         l0OY3UopQrN6Q==
Received: by pali.im (Postfix)
        id 7629A82A; Wed,  5 Jan 2022 19:13:06 +0100 (CET)
Date:   Wed, 5 Jan 2022 19:13:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Roman Bacik <roman.bacik@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <20220105181306.mkratasqg36tjf4e@pali>
References: <20220105093552.27542-1-pali@kernel.org>
 <244e74d9-1b46-2abc-6c2a-c089fa5b68b4@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <244e74d9-1b46-2abc-6c2a-c089fa5b68b4@broadcom.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Wednesday 05 January 2022 09:51:48 Ray Jui wrote:
> Hi Pali,
> 
> On 1/5/2022 1:35 AM, Pali Rohár wrote:
> > Register 0x43c in its low 24 bits contains PCI class code.
> > 
> > Update code to set all 24 bits of PCI class code and not only upper 16 bits
> > of PCI class code.
> > 
> > Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bits
> > of normal PCI bridge class.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Roman helped me with this change and confirmed that class code is stored
> > really in bits [23:0] of custom register 0x43c (normally class code is
> > stored in bits [31:8] of pci register 0x08).
> > 
> > This patch depends on patch which adds PCI_CLASS_BRIDGE_PCI_NORMAL macro:
> > https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 3df4ab209253..2519201b0e51 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -789,14 +789,13 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
> >  		return -EFAULT;
> >  	}
> >  
> > -	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
> > +	/* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
> >  #define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
> > -#define PCI_CLASS_BRIDGE_MASK		0xffff00
> > -#define PCI_CLASS_BRIDGE_SHIFT		8
> > +#define PCI_BRIDGE_CTRL_REG_CLASS_MASK	0xffffff
> >  	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> >  				    4, &class);
> > -	class &= ~PCI_CLASS_BRIDGE_MASK;
> > -	class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
> > +	class &= ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
> > +	class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
> >  	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
> >  				     4, class);
> >  
> 
> I have two comments:
> 
> 1. You do not seem to generate the email list using the
> get_maintainer.pl script, so the two maintainers for Broadcom ARM
> architecture (Ray Jui and Scott Branden) are left out.

Ou, sorry for that! I have generated this patch for U-Boot and Linux
kernel and probably mixed or forgot to include correct recipients for
correct project.

> 2. I suppose 'PCI_CLASS_BRIDGE_PCI_NORMAL' is defined in some common PCI
> header in a separate patch as described in the commit message. Then how
> come these patches are not constructed with a patch series?

Yes, PCI_CLASS_BRIDGE_PCI_NORMAL is a new constant for common pci header
file defined in patch linked in commit message.
https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/

Originally I included this change in v1 of linked patch in December but
I realized that it does not match standard PCI config space (different
offset 0x43c vs 0x08 and also different shift 0x8 vs 0x0) and probably
there is something either incorrect or really non-standard. So later in
December I dropped iproc_pcie_check_link() change in v2 of the linked
patch where is introduced PCI_CLASS_BRIDGE_PCI_NORMAL and now sent new
change for iproc_pcie_check_link() separately.

Technically, linked patch in commit message is just extracting code into
the common macros without any functional changed. But change in this
iproc_pcie_check_link() has also functional change as now also lower 8
bits of class code are changed. So in my opinion this patch should be
really separate of linked patch.

I hope that Lorenzo and Bjorn take patches in correct order...

> Other than, the change itself is exactly what I sent to Roman and looks
> good to me. Thanks.
> 
> Acked-by: Ray Jui <ray.jui@broadcom.com>

Perfect!
