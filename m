Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A950B615
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447074AbiDVLZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446980AbiDVLZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB17541AC;
        Fri, 22 Apr 2022 04:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E2361F72;
        Fri, 22 Apr 2022 11:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25151C385A0;
        Fri, 22 Apr 2022 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650626535;
        bh=SVW4zVvibn9z+IjAwyBEd5JkQQkXUtOD1zca6C1BokE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqInEFY2cO4FTnCH8Gno5qENJk/44n3MG8a3wISfMNbDgBokbaZ7vvr+qaZVsI27K
         i/VwnIIIbXQceDYv0RAf7WYyxiTpWag2UFtrdfL2mC/attGJ1kr9GGgJxyTL35FDt0
         SVEs8jdWWJveITVcdjC1Z+BBasxW4ilFyxeyNQGEWMhhl2oarOsIo5ZRE/s7n8WK29
         E8FRNSTUeDUZ+HPQ7tnDqqlvzH/oG0ZspRVjbDvuzfsktZUAxzVXzMIUzFWa9ks5+Q
         QkvKB3D94/j5v/Xc8a3s47FqgRn5wUTZWUkSJzw+PhcuThk+V5rwoy4G28IWV7jeTt
         9sm4LcyOh1m0Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nhrMW-0002mB-2D; Fri, 22 Apr 2022 13:22:08 +0200
Date:   Fri, 22 Apr 2022 13:22:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 1/5] phy: qcom-qmp: add support for pipe clock muxing
Message-ID: <YmKP4FXXm6NhQFYK@hovoldconsulting.com>
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-2-johan+linaro@kernel.org>
 <de4f9514-5132-f208-d43f-4c50afcda203@linaro.org>
 <YmKBgGHtfDcO1Mkg@hovoldconsulting.com>
 <CAA8EJpqTzcwAtxk+XtAWdZaKEx2=VduPiVBp+CWj=_C-921YJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqTzcwAtxk+XtAWdZaKEx2=VduPiVBp+CWj=_C-921YJg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Again, please trim unnecessary context from your replies. ]

On Fri, Apr 22, 2022 at 01:35:01PM +0300, Dmitry Baryshkov wrote:
> On Fri, 22 Apr 2022 at 13:20, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Apr 21, 2022 at 02:08:27PM +0300, Dmitry Baryshkov wrote:
> > > On 21/04/2022 13:20, Johan Hovold wrote:

> > > > +   /* Get optional pipe clock mux and default reference source clock. */
> > > > +   qphy->pipemux_clk = of_clk_get_by_name(np, "mux");
> > > > +   if (IS_ERR(qphy->pipemux_clk)) {
> > > > +           ret = PTR_ERR(qphy->pipemux_clk);
> > > > +           if (ret == -EPROBE_DEFER)
> > > > +                   return ret;
> > > > +
> > > > +           qphy->pipemux_clk = NULL;

> > > > +   } else {
> > > > +           qphy->piperef_clk = of_clk_get_by_name(np, "ref");
> > > > +           if (IS_ERR(qphy->piperef_clk)) {
> > > > +                   ret = PTR_ERR(qphy->piperef_clk);
> > > > +                   return dev_err_probe(dev, ret,
> > > > +                                        "failed to get lane%d piperef_clk\n",
> > > > +                                        id);
> > > > +           }
> > > > +   }
> > > > +
> > >
> > > As a second thought.
> > > This needs to be more explicit. If the chipset requires the pipe clock
> > > remuxing, we must fail if the clocks were not provided. So depending on
> > > the qmp instance/property the driver should either use devm_clk_get()
> > > (instead of _optional) or skip this block completely.
> >
> > No, the kernel is not a DT validator (and we have the YAML bindings for
> > that now).
> 
> It is not about DT validation. It is about passing a correct DT.

Heh. That's the same thing.

> The file can come up from the kernel. It can come from the older
> kernel.  OR it can come from the vendor. Or it even might be being a
> part of firmware flashed into the device.  So we can not assume that
> the DT is correct just because the in-kernel DT passes YAML
> validation.

Again, no. The kernel does not need to implement DT validation and can
assume that the DT describes the hardware accurately. If the DT says
there's a mux, the driver can use it. If there's no mux in DT, the
driver can assume it isn't there.

The only thing that complicates things here is the sc7280 dts which has
been released in 5.16. We don't care about Qualcomm's kernels and dts.

> So, as I wrote, the whole patchset needs much more care about compatibility.
> 
> > > But this will not work with earlier DTS files.
> >
> > So this is not a problem (but if we really wanted to have the driver
> > validate the DT it can be done by updating the compatible strings).
> 
> We should not update compatible strings just because the driver
> changes. Compat strings describe the hardware, not the Linux point of
> view on it.

We can, it's a documented practise in case a binding needs to be
updated in an incompatible way:

	https://www.kernel.org/doc/html/latest/devicetree/bindings/ABI.html

But I don't think it'll be needed here.

Johan
