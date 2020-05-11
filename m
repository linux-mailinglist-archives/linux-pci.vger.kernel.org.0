Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88F1CE1A9
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgEKR0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 13:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgEKR0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2020 13:26:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D89C061A0E
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 10:26:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so10433187ljg.5
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2020 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2syOPhIUuk5+IIGwPWtaFvYhD+RO13CJnl5VVYLO2dc=;
        b=KJnTxBodECfNSWC+eXV6D9gkJ/P9LWcTJrXC4Ghx2Vn9hyQwnoY7rP9e/Qnv64vGu+
         ShEE2LP25xfnfLorU/NMyCqQarLGS419o5kBE3SwFxQs98FNZzckVPVqSSnApRO5k/YO
         F7kuYSn8gjSSEiC7F9lvthwHeRQoIqLWSslcr9J1OVKxajVJmhOYy0MgcdAyIxT96kFY
         O00pFB6HFyU8tmRMpmL7HTwei/rqW0eocZTDHnXeyZwi/ifgD1HA7UQCk7hJr8yrZ+d7
         kQvhk7wrn6lfmCpUvmtB1JJsBA6vb9O0R+mz/B2OpP8dHg8rLhiWx2YfvdG1CaBBsptw
         cFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2syOPhIUuk5+IIGwPWtaFvYhD+RO13CJnl5VVYLO2dc=;
        b=FEIJ7eDKHr97U/Mzl77Pj7SYQJTGdNfmsmMNYiI+cxe7ehqKW8H3bbw7h8KZ/YQecv
         0xBdc/HwRI5t4JulpEPDEEGXaG1USHn0TM8yV8LXklicoRURBDMUKhW0IodbFf/QFaSg
         b1zV/7TIjdx6TxDERBnqGQLIDPAGzrsMeNc7Bb2tLPLM9tfFx+NF5NTz+Vbn1JqdVoKt
         XTsfkY0iDmf8RFLDi21dC0cSgYOMrPpHYPhEh08LAw+vMYNMLmelkVCfkNdutd+j6n/K
         QuzC0ue5flNnVc5fxOR/uX7i1CKs8zntwjx6nQQxQhXLloF5KQTUvpN9KVtmo9WlEBJP
         zS/Q==
X-Gm-Message-State: AOAM5300CTK7soh8ROwFmsVzGB9IOFaxvsEAdKE6kFFxSghj90xT9BV0
        iNGQ6/Ot/S9FILxqOUiaMd12yT26Xk52ZMqeTNIyJg==
X-Google-Smtp-Source: ABdhPJzLWh2c6HKanzjF35gvufPT/AenACZyvySv0aUIe5AQ4TxUG2/GcC/bY0xcWzmTE/GXX51eHW/7Q84P+RgSIZY=
X-Received: by 2002:a2e:b52a:: with SMTP id z10mr237472ljm.200.1589218005149;
 Mon, 11 May 2020 10:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <1588350008-8143-1-git-send-email-alan.mikhak@sifive.com> <20200507214234.GA5449@bogus>
In-Reply-To: <20200507214234.GA5449@bogus>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 11 May 2020 10:26:33 -0700
Message-ID: <CABEDWGygtfK0-dd7VUKH2K1FWy8KweG8o7bRjNFQAXfWHkT8fA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Enable picking DMA
 channel by name
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, sebott@linux.ibm.com,
        efremov@linux.com, vidyas@nvidia.com,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 2:42 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, May 01, 2020 at 09:20:08AM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify pci_epf_test_init_dma_chan() to call dma_request_channel() with a
> > filter function to pick DMA channel by name, if desired.
> >
> > Add a new filter function pci_epf_test_pick_dma_chan() which takes a name
> > string as an optional parameter. If desired name is specified, the filter
> > function checks the name of each DMA channel candidate against the desired
> > name. If no match, the filter function rejects the candidate channel.
> > Otherwise, the candidate channel is accepted. If optional name parameter
> > is null or an empty string, filter function picks the first DMA channel
> > candidate, thereby preserving the existing behavior of pci-epf-test.
> >
> > Currently, pci-epf-test picks the first suitable DMA channel. Adding a
> > filter function enables a developer to modify the optional parameter
> > during debugging by providing the name of a desired DMA channel. This is
> > useful during debugging because it allows different DMA channels to be
> > exercised.
> >
> > Adding a filter function also takes one step toward modifying pcitest to
> > allow the user to choose a DMA channel by providing a name string at the
> > command line when issuing the -d parameter for DMA transfers.
>
> This mostly looks fine, but needs to be part of a series giving it a
> user.

Thanks Rob for your comments.

I do have other changes in mind that build on this patch to give this
filter function a user other than its current caller that is passing a
NULL pointer as the filter parameter. I can hold it back until then.
However, those changes are more involved and may take longer to implement
and review. In the meantime, maybe this can be accepted independently as
an interim measure to aid debugging during development. If this patch were
to be applied to the codebase, it becomes much simpler to manually edit
the code during development and replace the NULL with a string such as
"dma0chan1" until a command line option becomes available.

This patch is also not necessarily related to my other patch about
supporting slave dma transfers. Even when working on machines that just
have platform dma channels and no slave dma channels, I experience the
same limitation where I cannot exercise any channel other than the one
picked by default.

>
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 60330f3e3751..043916d3ab5f 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -149,10 +149,26 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >  }
> >
> >  /**
> > - * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> > - * @epf_test: the EPF test device that performs data transfer operation
> > + * pci_epf_test_pick_dma_chan() - Filter DMA channel based on desired criteria
> > + * @chan: the DMA channel to examine
> >   *
> > - * Function to initialize EPF test DMA channel.
> > + * Filter DMA channel candidates by matching against an optional desired name.
> > + * Pick first candidate channel if desired name is not specified.
> > + * Reject candidate channel if its name does not match the desired name.
> > + */
> > +static bool pci_epf_test_pick_dma_chan(struct dma_chan *chan, void *name)
> > +{
> > +     if (name && strlen(name) && strcmp(dma_chan_name(chan), name))
>
> Doesn't this cause warning with 'name' being void*?

I compiled this patch for riscv and x86_64 but didn't see any warning. I will
address your concern by posting a v2 patch.

>
>
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +/**
> > + * pci_epf_test_init_dma_chan() - Helper to initialize EPF DMA channel
> > + * @epf: the EPF device that has to perform the data transfer operation
> > + *
> > + * Helper to initialize EPF DMA channel.
> >   */
> >  static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >  {
> > @@ -165,7 +181,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >       dma_cap_zero(mask);
> >       dma_cap_set(DMA_MEMCPY, mask);
> >
> > -     dma_chan = dma_request_chan_by_mask(&mask);
> > +     dma_chan = dma_request_channel(mask, pci_epf_test_pick_dma_chan, NULL);
> >       if (IS_ERR(dma_chan)) {
> >               ret = PTR_ERR(dma_chan);
> >               if (ret != -EPROBE_DEFER)
> > --
> > 2.7.4
> >
