Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921222B706
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGWT5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 15:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGWT5q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 15:57:46 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFF32086A;
        Thu, 23 Jul 2020 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595534265;
        bh=dRVWMy39tT6wAPfPtn0iZAUMp/DpcR3/2Kj29ElInIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L/QfwoU4oC9NCaDNrwHinZeKXeR9zsJSkX6zYFw5RRMbQZXDnUIGf1yV+B8lS1+Ki
         XjbrFTzYbkCA2/Alu+Ip6PtccBJRk65NnYKP1Jx5Y6TVLywojlIGBO94LhPJMLjsZP
         k5VchAgtlSvB1CTg3X2ZM1c/6mNemM+n1Y75OsQY=
Date:   Thu, 23 Jul 2020 14:57:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        Armen Baloyan <abaloyan@gigaio.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
Message-ID: <20200723195742.GA1447143@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Nqziz6TKfk7U6QvBjZtV7ibBfwwym1kTb1Q4t-cz04JQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andrew, Armen, hpa]

On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >
> > The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> > transactions between root ports and found to work. Therefore add it
> > to the list.
> >
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>
> 
> Starting with Zen, all AMD platforms support P2P for reads and writes.

What's the plan for getting out of the cycle of "update this list for
every new chip"?  Any new _DSMs planned, for instance?

A continuous trickle of updates like this is not really appealing.  So
far we have:

  7d5b10fcb81e ("PCI/P2PDMA: Add AMD Zen Raven and Renoir Root Ports to whitelist")
  7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
  bc123a515cb7 ("PCI/P2PDMA: Add Intel SkyLake-E to the whitelist")
  494d63b0d5d0 ("PCI/P2PDMA: Whitelist some Intel host bridges")
  0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex")

And that's just from the last year, not including this patch.

> > ---
> >  drivers/pci/p2pdma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index e8e444eeb1cd..3d67a1ee083e 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -284,6 +284,8 @@ static const struct pci_p2pdma_whitelist_entry {
> >         {PCI_VENDOR_ID_AMD,     0x1450, 0},
> >         {PCI_VENDOR_ID_AMD,     0x15d0, 0},
> >         {PCI_VENDOR_ID_AMD,     0x1630, 0},
> > +       /* AMD ZEN 2 */
> > +       {PCI_VENDOR_ID_AMD,     0x1480, 0},
> >
> >         /* Intel Xeon E5/Core i7 */
> >         {PCI_VENDOR_ID_INTEL,   0x3c00, REQ_SAME_HOST_BRIDGE},
> >
> > base-commit: ba47d845d715a010f7b51f6f89bae32845e6acb7
> > --
> > 2.20.1
> >
