Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3852515E
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355478AbiELPhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356011AbiELPhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 11:37:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC525C28B;
        Thu, 12 May 2022 08:36:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n10so5502063pjh.5;
        Thu, 12 May 2022 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krf3sQjkUcZDwoyOKRbmq1UjBHY+kqEwczeutGD/sfQ=;
        b=R4bI0lTia785dsPngPupP+1+dxEn5OhB9XPHbwzuPdwj952iQePg4hqSBN5LJf+jL0
         gojHwGIM446SgurBfKNFZhhp/TkkFnQjFKsMhdZGtf3f3rUlDr/H6pg28VnYBwatVcOu
         Orn1Bngbz5+uJQDwHOqYa0l016rrYKbZWmPq1/KiWKU8tGHmcpIFhnb9Q/+G/begBSMR
         RDb3lSk8ZDTvUYRQFJmBmKe9onPY1lVMhQnckbajVPIGrxzwMpk4nnZiGLerLGK4JqzM
         Bo2Ji89s4V3+EPM5x+QKRfAlgu6Zns8RoNx144eQ4PsXTPTMVFnlQHiBqK3MKq5X8TQY
         2i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krf3sQjkUcZDwoyOKRbmq1UjBHY+kqEwczeutGD/sfQ=;
        b=JehfvZsNsJcxQbM5P+C61UFc3rI6GKXJ4vxy9Fi7Dy10XNDUN0IH7fE8L9GGdwjTbX
         ZSe0jMfxjjahQd+uHlHeA2WlN4QFHtvxo7eYW8MAVA9hofbRprjfN19zdH8RvSrdhzbL
         emZO85bHZNzdbGy7fZ86zez1eFhdmV2TXzsLIIg2hIb8/XYhCFehM182i/UY12obLrgp
         H0LEr/cdrhJvZdG2zscWKmQybeTjlGtVq9AxNYsIpZTwuWxpjkykA3UtRKKZBD/NQ647
         3cRn8JFJQVd+OFIMllQR+5KX7sI9hb9JFJPMLSSo2SKH+OKM1Xz7rTR2+VIAXX6Cll+7
         2dbg==
X-Gm-Message-State: AOAM531BkBhnvnxjWwzO3VTCw6LAgfpjqHl4gy+zF1mN4Q/Hj/6ifDAJ
        g1kXUNK2tTqAG3QTXsBK1+dWu/tKpLmMKSkpJTc=
X-Google-Smtp-Source: ABdhPJz3qhA6ZNx2QhdgTz/UfLedOta3RZFIOSIYK7Xoz85/OLaCcsyaf8yHKUsbJvLiOc7YFOtxETJja4D5M8W6BjI=
X-Received: by 2002:a17:90b:3d0b:b0:1dc:1953:462d with SMTP id
 pt11-20020a17090b3d0b00b001dc1953462dmr185919pjb.122.1652369819247; Thu, 12
 May 2022 08:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220503005801.1714345-1-Frank.Li@nxp.com> <20220503005801.1714345-10-Frank.Li@nxp.com>
 <b2961b3e-ad0e-5b8f-8d6f-221aead9992f@ti.com>
In-Reply-To: <b2961b3e-ad0e-5b8f-8d6f-221aead9992f@ti.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 12 May 2022 10:36:47 -0500
Message-ID: <CAHrpEqT4hZ3G1YBxYdjHVDrPGZoZEpd_C==yK+CNE-ZOtk2nCA@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] PCI: endpoint: Enable DMA controller tests for
 endpoints with DMA capabilities
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 8:52 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Frank,
>
> On 03/05/22 06:28, Frank Li wrote:
> > Some Endpoints controllers have DMA capabilities.  This DMA controller has
> > more efficiency then a general external DMA controller.  And this DMA
> > controller can bypass outbound memory address translation unit.
> >
> > The whole flow use standard DMA usage module
> >
> >  1. Using dma_request_channel() and filter function to find correct
> >     RX and TX Channel. if not exist,  fallback to try allocate
> >     general DMA controller channel.
> >  2. dmaengine_slave_config() config remote side physcial address.
> >  3. using dmaengine_prep_slave_single() create transfer descriptor.
> >  4. tx_submit();
> >  5. dma_async_issue_pending();
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> The patch looks good to me (other than Lorenzo's comment on the
> description). Did you also verify DMA_MEMCPY just to make sure, the old
> path continues to work?

Not yet, our hardware platform has not memory to memory DMA.

best regards
Frank Li

>
> Regards,
> Kishon
> > ---
> > Change from v9 to v10:
> >  - rewrite commit message
> > Change from v4 to v9:
> >  - none
> > Change from v3 to v4:
> >  - reverse Xmas tree order
> >  - local -> dma_local
> >  - change error message
> >  - IS_ERR -> IS_ERR_OR_NULL
> >  - check return value of dmaengine_slave_config()
> > Change from v1 to v2:
> >  - none
> >
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
> >  1 file changed, 98 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 90d84d3bc868f..f26afd02f3a86 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -52,9 +52,11 @@ struct pci_epf_test {
> >       enum pci_barno          test_reg_bar;
> >       size_t                  msix_table_offset;
> >       struct delayed_work     cmd_handler;
> > -     struct dma_chan         *dma_chan;
> > +     struct dma_chan         *dma_chan_tx;
> > +     struct dma_chan         *dma_chan_rx;
> >       struct completion       transfer_complete;
> >       bool                    dma_supported;
> > +     bool                    dma_private;
> >       const struct pci_epc_features *epc_features;
> >  };
> >
> > @@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
> >   */
> >  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >                                     dma_addr_t dma_dst, dma_addr_t dma_src,
> > -                                   size_t len)
> > +                                   size_t len, dma_addr_t dma_remote,
> > +                                   enum dma_transfer_direction dir)
> >  {
> > +     struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
> > +     dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
> >       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > -     struct dma_chan *chan = epf_test->dma_chan;
> >       struct pci_epf *epf = epf_test->epf;
> >       struct dma_async_tx_descriptor *tx;
> > +     struct dma_slave_config sconf = {};
> >       struct device *dev = &epf->dev;
> >       dma_cookie_t cookie;
> >       int ret;
> > @@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >               return -EINVAL;
> >       }
> >
> > -     tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     if (epf_test->dma_private) {
> > +             sconf.direction = dir;
> > +             if (dir == DMA_MEM_TO_DEV)
> > +                     sconf.dst_addr = dma_remote;
> > +             else
> > +                     sconf.src_addr = dma_remote;
> > +
> > +             if (dmaengine_slave_config(chan, &sconf)) {
> > +                     dev_err(dev, "DMA slave config fail\n");
> > +                     return -EIO;
> > +             }
> > +             tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > +     } else {
> > +             tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     }
> > +
> >       if (!tx) {
> >               dev_err(dev, "Failed to prepare DMA memcpy\n");
> >               return -EIO;
> > @@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >       return 0;
> >  }
> >
> > +struct epf_dma_filter {
> > +     struct device *dev;
> > +     u32 dma_mask;
> > +};
> > +
> > +static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
> > +{
> > +     struct epf_dma_filter *filter = node;
> > +     struct dma_slave_caps caps;
> > +
> > +     memset(&caps, 0, sizeof(caps));
> > +     dma_get_slave_caps(chan, &caps);
> > +
> > +     return chan->device->dev == filter->dev
> > +             && (filter->dma_mask & caps.directions);
> > +}
> > +
> >  /**
> >   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> >   * @epf_test: the EPF test device that performs data transfer operation
> > @@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >  {
> >       struct pci_epf *epf = epf_test->epf;
> >       struct device *dev = &epf->dev;
> > +     struct epf_dma_filter filter;
> >       struct dma_chan *dma_chan;
> >       dma_cap_mask_t mask;
> >       int ret;
> >
> > +     filter.dev = epf->epc->dev.parent;
> > +     filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> > +
> > +     dma_cap_zero(mask);
> > +     dma_cap_set(DMA_SLAVE, mask);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +     if (IS_ERR_OR_NULL(dma_chan)) {
> > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > +             goto fail_back_tx;
> > +     }
> > +
> > +     epf_test->dma_chan_rx = dma_chan;
> > +
> > +     filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +
> > +     if (IS_ERR(dma_chan)) {
> > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > +             goto fail_back_rx;
> > +     }
> > +
> > +     epf_test->dma_chan_tx = dma_chan;
> > +     epf_test->dma_private = true;
> > +
> > +     init_completion(&epf_test->transfer_complete);
> > +
> > +     return 0;
> > +
> > +fail_back_rx:
> > +     dma_release_channel(epf_test->dma_chan_rx);
> > +     epf_test->dma_chan_tx = NULL;
> > +
> > +fail_back_tx:
> >       dma_cap_zero(mask);
> >       dma_cap_set(DMA_MEMCPY, mask);
> >
> > @@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >       }
> >       init_completion(&epf_test->transfer_complete);
> >
> > -     epf_test->dma_chan = dma_chan;
> > +     epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
> >
> >       return 0;
> >  }
> > @@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
> >       if (!epf_test->dma_supported)
> >               return;
> >
> > -     dma_release_channel(epf_test->dma_chan);
> > -     epf_test->dma_chan = NULL;
> > +     dma_release_channel(epf_test->dma_chan_tx);
> > +     if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> > +             epf_test->dma_chan_tx = NULL;
> > +             epf_test->dma_chan_rx = NULL;
> > +             return;
> > +     }
> > +
> > +     dma_release_channel(epf_test->dma_chan_rx);
> > +     epf_test->dma_chan_rx = NULL;
> > +
> > +     return;
> >  }
> >
> >  static void pci_epf_test_print_rate(const char *ops, u64 size,
> > @@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >                       goto err_map_addr;
> >               }
> >
> > +             if (epf_test->dma_private) {
> > +                     dev_err(dev, "Cannot transfer data using DMA\n");
> > +                     ret = -EINVAL;
> > +                     goto err_map_addr;
> > +             }
> > +
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >       } else {
> > @@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >
> >               ktime_get_ts64(&start);
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              phys_addr, reg->size);
> > +                                              phys_addr, reg->size,
> > +                                              reg->src_addr, DMA_DEV_TO_MEM);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
> > @@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >               }
> >
> >               ktime_get_ts64(&start);
> > +
> >               ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
