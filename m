Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190A32FE98
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfE3Oyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 10:54:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfE3Oyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 10:54:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E37341;
        Thu, 30 May 2019 07:54:37 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51E43F59C;
        Thu, 30 May 2019 07:54:36 -0700 (PDT)
Date:   Thu, 30 May 2019 15:54:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ley Foon Tan <lftan.linux@gmail.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: altera: Fix no return warning for
 altera_pcie_irq_teardown()
Message-ID: <20190530145411.GA13993@redmoon>
References: <1558664151-2584-1-git-send-email-ley.foon.tan@intel.com>
 <CAFiDJ5_HCeY0hf8W-HiEMLFWgjYNspXuH9dBV1kKY-YEvMLAeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFiDJ5_HCeY0hf8W-HiEMLFWgjYNspXuH9dBV1kKY-YEvMLAeA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 10:17:28AM +0800, Ley Foon Tan wrote:
> On Fri, May 24, 2019 at 10:15 AM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
> >
> > Fix compilation warning caused by patch "PCI: altera: Allow building as module".
> >
> > drivers/pci/controller/pcie-altera.c: In function ‘altera_pcie_irq_teardown’:
> > drivers/pci/controller/pcie-altera.c:723:1: warning: no return statement in function returning non-void [-Wreturn-type]
> >  }
> >
> > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > ---
> >  drivers/pci/controller/pcie-altera.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> > index 6c86bc69ace8..27222071ace7 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -706,7 +706,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
> >         return 0;
> >  }
> >
> > -static int altera_pcie_irq_teardown(struct altera_pcie *pcie)
> > +static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
> >  {
> >         irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> >         irq_domain_remove(pcie->irq_domain);
> > --
> > 2.19.0
> >
> Hi
> 
> You can squash this patch to this https://lkml.org/lkml/2019/4/24/18
> "PCI: altera: Allow building as module" if want.

Done, thanks.

Lorenzo
