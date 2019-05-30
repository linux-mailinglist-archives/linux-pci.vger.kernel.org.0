Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F83001B
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3QW3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 12:22:29 -0400
Received: from foss.arm.com ([217.140.101.70]:39348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3QW2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 12:22:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13CAF341;
        Thu, 30 May 2019 09:22:28 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23AA43F5AF;
        Thu, 30 May 2019 09:22:26 -0700 (PDT)
Date:   Thu, 30 May 2019 17:22:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gustavo.pimentel@synopsys.com, wen.yang99@zte.com.cn, kjlu@umn.edu
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
Message-ID: <20190530162223.GG13993@redmoon>
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
 <baa68439-f703-a453-34a2-24387bb9112d@ti.com>
 <CABEDWGyJpfX=DzBgXAGwu29rEwmY3s_P9QPC0eJOJ3KBysRWtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGyJpfX=DzBgXAGwu29rEwmY3s_P9QPC0eJOJ3KBysRWtA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 11:50:41AM -0700, Alan Mikhak wrote:
> Hi Kishon,
> 
> Yes. This change is still applicable even when the platform specifies
> that it only supports 64-bit BARs by setting the bar_fixed_64bit
> member of epc_features.
> 
> The issue being fixed is this: If the 'continue' statement is executed
> within the loop, the loop index 'bar' needs to advanced by two, not
> one, when the BAR is 64-bit. Otherwise the next loop iteration will be
> on an odd BAR which doesn't exist.
> 
> The PCI_BASE_ADDRESS_MEM_TYPE_64 flag in epf_bar->flag reflects the
> value set by the platform in the bar_fixed_64bit member of
> epc_features.
> 
> This patch moves the checking of  PCI_BASE_ADDRESS_MEM_TYPE_64 in
> epf_bar->flags to before the 'continue' statement to advance the 'bar'
> loop index accordingly. The comment you see about 'pci_epc_set_bar()'
> preceding the moved code is the original comment and was also moved
> along with the code.

@Kishon, I would need your ACK to merge this patch.

Thanks,
Lorenzo

> Regards,
> Alan Mikhak
> 
> On Fri, May 24, 2019 at 1:51 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >
> > Hi,
> >
> > On 24/05/19 5:25 AM, Alan Mikhak wrote:
> > > +Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu
> > >
> > > On Thu, May 23, 2019 at 2:55 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
> > >>
> > >> Always skip odd bar when skipping 64bit BARs in pci_epf_test_set_bar()
> > >> and pci_epf_test_alloc_space().
> > >>
> > >> Otherwise, pci_epf_test_set_bar() will call pci_epc_set_bar() on odd loop
> > >> index when skipping reserved 64bit BAR. Moreover, pci_epf_test_alloc_space()
> > >> will call pci_epf_alloc_space() on bind for odd loop index when BAR is 64bit
> > >> but leaks on subsequent unbind by not calling pci_epf_free_space().
> > >>
> > >> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > >> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> > >> ---
> > >>  drivers/pci/endpoint/functions/pci-epf-test.c | 25 ++++++++++++-------------
> > >>  1 file changed, 12 insertions(+), 13 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> index 27806987e93b..96156a537922 100644
> > >> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> @@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> > >>
> > >>  static int pci_epf_test_set_bar(struct pci_epf *epf)
> > >>  {
> > >> -       int bar;
> > >> +       int bar, add;
> > >>         int ret;
> > >>         struct pci_epf_bar *epf_bar;
> > >>         struct pci_epc *epc = epf->epc;
> > >> @@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> > >>
> > >>         epc_features = epf_test->epc_features;
> > >>
> > >> -       for (bar = BAR_0; bar <= BAR_5; bar++) {
> > >> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
> > >>                 epf_bar = &epf->bar[bar];
> > >> +               /*
> > >> +                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> > >> +                * if the specific implementation required a 64-bit BAR,
> > >> +                * even if we only requested a 32-bit BAR.
> > >> +                */
> >
> > set_bar shouldn't set PCI_BASE_ADDRESS_MEM_TYPE_64. If a platform supports only
> > 64-bit BAR, that should be specified in epc_features bar_fixed_64bit member.
> >
> > Thanks
> > Kishon
