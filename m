Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A35194986
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 21:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZUsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 16:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgCZUsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 16:48:09 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60FF2070A;
        Thu, 26 Mar 2020 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585255689;
        bh=6RKen0ioTy65oeuJuXAtJ6M2BJxU8YbCxuM+rKEX6NY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vkbsDVHff3CZYPxtxcc0HH1/CZg3CSmvig9OJyTv8xuiWi01uIYoBe5p1UK/juO07
         W2cirk8UdPTFG/Fx2mEs/VvE9am3rbh8UJYQ7Dufa7Y1+2lSDW8ps9HN3qv87cQc1I
         XwxIrq10sk/x+sVNQpLiRH+unIfFfgKFXSCP8zwc=
Date:   Thu, 26 Mar 2020 15:48:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: Re: [PATCH 1/3] PCI: iproc: fix out of bound array access
Message-ID: <20200326204807.GA87784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a836faf-645d-a1ab-d525-738a318758a0@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 01:27:36PM -0700, Ray Jui wrote:
> On 3/26/2020 12:48 PM, Bjorn Helgaas wrote:
> > ...
> > It's outside the scope of this patch, but I'm not really a fan of the
> > pcie->reg_offsets[] scheme this driver uses to deal with these
> > differences.  There usually seems to be *something* that keeps the
> > driver from referencing registers that don't exist, but it doesn't
> > seem like the mechanism is very consistent or robust:
> > 
> >   - IPROC_PCIE_LINK_STATUS is implemented by PAXB but not PAXC.
> >     iproc_pcie_check_link() avoids using it if "ep_is_internal", which
> >     is set for PAXC and PAXC_V2.  Not an obvious connection.
> > 
> >   - IPROC_PCIE_CLK_CTRL is implemented for PAXB and PAXC_V1, but not
> >     PAXC_V2.  iproc_pcie_perst_ctrl() avoids using it ep_is_internal",
> >     so it *doesn't* use it for PAXC_V1, which does implement it.
> >     Maybe a bug, maybe intentional; I can't tell.
> > 
> >   - IPROC_PCIE_INTX_EN is only implemented by PAXB (not PAXC), but
> >     AFAICT, we always call iproc_pcie_enable() and rely on
> >     iproc_pcie_write_reg() silently drop the write to it on PAXC.
> > 
> >   - IPROC_PCIE_OARR0 is implemented by PAXB and PAXB_V2 and used by
> >     iproc_pcie_map_ranges(), which is called if "need_ob_cfg", which
> >     is set if there's a "brcm,pcie-ob" DT property.  No clear
> >     connection to PAXB.
> > 
> > I think it would be more readable if we used a single variant
> > identifier consistently, e.g., the "pcie->type" already used in
> > iproc_pcie_msi_steer(), or maybe a set of variant-specific function
> > pointers as pcie-qcom.c does.
> 
> It is not possible to use a single variant identifier consistently,
> i.e., 'pcie->type'. Many of these features are controller revision
> specific, and certain revisions of the controllers may all have a
> certain feature, while other revisions of the controllers do not. In
> addition, there are overlap in features across different controllers.
> 
> IMO, it makes sense to have feature specific flags or booleans, and have
> those features enabled or disabled based on 'pcie->type', which is what
> the current driver does, but like you pointed out, what the driver
> failed is to do this consistently.

There are several drivers that have the same problem of dealing with
different revisions of hardware.  It would be nice to do it in a
consistent style, whatever that is.

> The IPROC_PCIE_INTX_EN example you pointed out is a good example. I
> agree with you that we shouldn't rely on iproc_pcie_write_reg to
> silently drop the operation for PAXC. We should add code to make it
> explictly obvious that legacy interrupt is not supported in all PAXC
> controllers.
> 
> pcie->pcie->reg_offsets[] scheme was not intended to be used to silently
> drop register access that are activated based on features. It's a
> mistake that should be fixed if some code in the driver is done that
> way, as you pointed out.

That's actually why I dug into this a bit -- the
iproc_pcie_reg_is_invalid() case is really a design-time error, so it
seemed like there should be a WARN() there instead of silently
returning 0 or ignoring a write.

Bjorn
