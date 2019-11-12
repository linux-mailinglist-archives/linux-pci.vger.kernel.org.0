Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8030AF8E8D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLLZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 06:25:17 -0500
Received: from foss.arm.com ([217.140.110.172]:60564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfKLLZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 06:25:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4518531B;
        Tue, 12 Nov 2019 03:25:16 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A073F6C4;
        Tue, 12 Nov 2019 03:25:15 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:25:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: rcar: Fix missing MACCTLR register setting
 in initialize sequence
Message-ID: <20191112112510.GA15159@e121166-lin.cambridge.arm.com>
References: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1572951089-19956-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20191111144236.GB9653@e121166-lin.cambridge.arm.com>
 <TYAPR01MB4544F0F0BCAC5116731D15A9D8770@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191112102706.GA12685@e121166-lin.cambridge.arm.com>
 <CAMuHMdXBJaL=c+9_kb70jHMqzvfxxYezLEX-Evh-FRyY-FYPyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXBJaL=c+9_kb70jHMqzvfxxYezLEX-Evh-FRyY-FYPyQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 11:46:42AM +0100, Geert Uytterhoeven wrote:
> Hi Lorenzo,
> 
> On Tue, Nov 12, 2019 at 11:27 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Tue, Nov 12, 2019 at 01:48:03AM +0000, Yoshihiro Shimoda wrote:
> > > I'm sorry. I think I should not drop a sentence "because the bit 0 is
> > > set to 1 on reset" which has the reverted patch from this version. Also,
> > > the note seems to be difficult to understand. So, I'll rewrite this log
> > > like below. Is it acceptable?
> > >
> > > ---
> > > According to the R-Car Gen2/3 manual,
> >
> > Is this a publicly available manual ? If yes we provide a link, if
> > not I will reword the sentence below.
> 
> The same hardware block is present in the RZ/G series, and documented
> in RZ/G Series User's Manual: Hardware
> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg1m.html#documents
> Chapter 39 ("PCIEC").
> Section 39.28.98 ("MAC Control Register (MACCTLR)")
> Section 39.3.1 ("Initialization"), Paragraph 3 ("Initial Setting of
> PCI Express").
> 
> Thanks, and happy digesting ;-)

Thank you, updated commit log and pushed out, pci/rcar branch.

Thanks,
Lorenzo
