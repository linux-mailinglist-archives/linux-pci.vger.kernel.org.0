Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D777718A079
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRQa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 12:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgCRQa5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 12:30:57 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD45F205ED;
        Wed, 18 Mar 2020 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584549056;
        bh=SWq3vQe10D+2Ta/Vt6aPrSduBD94fsmRComoCIhY6Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aoVFrCcbyKg/L2zC6V1v1sQ8sKRRgS9GVy3OMCZrxYvdaIQlSh/0i2mLSqfgVYVv6
         GKDqQi6yJeObQJnr0eDR7LIeFoSmGvSl3AJE8VtkRi8M9+G0yaDeSqtjuFSiUCZm33
         oEgF/g00lXvtlojVskzFd2+h8ohjB7GKj3ZxaaM8=
Date:   Wed, 18 Mar 2020 11:30:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, amurray@thegoodpenguin.co.uk,
        rdunlap@infradead.org
Subject: Re: [PATCH] PCI: mobiveil: Fix unmet dependency warning for
 PCIE_MOBIVEIL_PLAT
Message-ID: <20200318163053.GA182914@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318103504.GA13361@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 10:35:16AM +0000, Lorenzo Pieralisi wrote:
> On Wed, Mar 18, 2020 at 05:33:12PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Fix the follow warning by adding the dependency PCI_MSI_IRQ_DOMAIN
> > into PCIE_MOBIVEIL_PLAT.
> > 
> > WARNING: unmet direct dependencies detected for PCIE_MOBIVEIL_HOST
> >   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
> >   Selected by [y]:
> >   - PCIE_MOBIVEIL_PLAT [=y] && PCI [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && OF [=y]
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  drivers/pci/controller/mobiveil/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I have applied it to pci/mobiveil for v5.7.

Thanks, I updated my "next" branch with this.
