Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E144B0966
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiBJJYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 04:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiBJJYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 04:24:44 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC5D94;
        Thu, 10 Feb 2022 01:24:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c6so13623216ybk.3;
        Thu, 10 Feb 2022 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpXloTlHsM1ntk3sqSjk73sshHjTMcoczp7h9ZRIX5M=;
        b=nG29oYDVD0/CTfWlZlBTSYZYkCvfxxAe2ytLf/1ynW7ACv4wOR+kS5nLbgNWO2cwRZ
         3Ij2aZCSYTEkTmMSPSlSfWMgEfPqIZvmyaGa8tmGFzhMUFE2+O2zqecFSoGkWwRl0jZs
         M+WaWwq+eBUHgvWShFJbAdVFJRGokJbQY8t6UP7UVfPcr02Lbaq22WgI8NPIPmEjBTk7
         nPW+6TyijgTBSh70Z30FssDYCEuTSB2J+Sdl9nphMYf1+stA3ecTIsBgceW+fzEpFaYw
         LX123oN0/7N25IN7mdCJN3L/oT5PrXZOLZbV5QLRqMBEJcX9KdyBp1GRJEuGIyDxxjwU
         NnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpXloTlHsM1ntk3sqSjk73sshHjTMcoczp7h9ZRIX5M=;
        b=vRTYu81L6g4IHulWtqq8JA4lIwvzhIsNvBOVewQxDVG1dVU+FRcTs3SUmbh75YeYf1
         55pQY/YKG8HuuafHwhP3SVHocS/A+l+khBIiI/VLQbKFE3Y0ZDHz99RPX7xl0Yt3vORk
         3FZE1OwaIwTbsu4N5XDdgTI2xZ6Z1VobveEhkmZKcyp3B7MoH+Rdo6Bm2QKAYsCRHpfB
         6MAGKnmDQA0nMug8Ds5sUNmTNR6+Wd+e7AMtExBA/jNZynU55MfzcKJnVWYq8PT2e+8s
         zBzVVImKNbrNFLKqzhpGGhtnszNbtTE34wfnSvR5CDVV/9kx6MO7SEh/DVGv+SytOEti
         rk7w==
X-Gm-Message-State: AOAM5327JW4oR6zDJTr9A9RaMBoCU9Y6CMCr67PpIIdFTFdRRxwV6nW1
        P/Ph5r6kXxF5DzXQN+8srmqc+ERjw4UCgqCZVpV0HMYGHqxcxA==
X-Google-Smtp-Source: ABdhPJz++32w1O5FkVObhtJdMj6KLqzBo+ajd9SwAzC/wnU3f93LjZv5QlOZX9jC+CIinuCj1qagS6bWtzuF3Wz/kNo=
X-Received: by 2002:a25:be50:: with SMTP id d16mr5721263ybm.41.1644485085432;
 Thu, 10 Feb 2022 01:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220210084052.GA69529@thinkpad>
In-Reply-To: <20220210084052.GA69529@thinkpad>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 10 Feb 2022 09:24:19 +0000
Message-ID: <CA+V-a8tivrjPoae69pqH1D+B=_Bd7ZzKjCA0PcfBz7Rpf022mA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Feb 10, 2022 at 8:40 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> > Hi All,
> >
> > The current PCIe EPF framework supports DMA data transfers using external
> > DMA only, this patch series aims to add support for platforms supporting
> > internal DMAC on PCIe for data transfers.
> >
> > R-Car PCIe supports internal DMAC to transfer data between Internal Bus to
> > PCI Express and vice versa. Last patch fills up the required flags and ops
> > to support internal DMAC.
> >
> > Patches 1-3 are for PCIe EPF core to support internal DMAC handling, patch
> > 4/5 is to fix test cases based on the conversation [1].
> >
>
> This looks similar to the Synopsys eDMA IP [1] that goes with the Synopsys PCIe
> endpoint IP. Why can't you represent it as a dmaengine driver and use the
> existing DMA support?
>
Let me have a look. Could you please share a link to the Synopsys PCIe
endpoint HW manual (the driver doesn't have a binding doc).

Cheers,
Prabhakar

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-edma
>
> > Patches are based on top of [1] next branch.
> >
> > [0] https://www.spinics.net/lists/linux-pci/msg92385.html
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (5):
> >   PCI: endpoint: Add ops and flag to support internal DMAC
> >   PCI: endpoint: Add support to data transfer using internal dmac
> >   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
> >   misc: pci_endpoint_test: Add support to pass flags for buffer
> >     allocation
> >   PCI: rcar-ep: Add support for DMAC
> >
> >  drivers/misc/pci_endpoint_test.c              |  56 ++++-
> >  drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.h            |  23 ++
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
> >  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
> >  include/linux/pci-epc.h                       |   8 +
> >  include/linux/pci-epf.h                       |   7 +
> >  7 files changed, 483 insertions(+), 54 deletions(-)
> >
> > --
> > 2.25.1
> >
