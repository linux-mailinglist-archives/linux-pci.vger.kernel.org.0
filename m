Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889EC513984
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349844AbiD1QSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349842AbiD1QSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 12:18:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C327B3F;
        Thu, 28 Apr 2022 09:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1095CE2C22;
        Thu, 28 Apr 2022 16:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA33C385A9;
        Thu, 28 Apr 2022 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651162514;
        bh=ITjlQ9g4B0gG723l683GuIOlpyn+saWXawbyT3upTSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gydywKUF2PJ/Z+XCGdoURVO8Xu7MmunrcWN9ck3aC2UWj3xv/rAFHrMc4EA/Rb3/g
         dpRe75K6y46Jm5gEMux0dZl+qGHCu6SgDVHxR+6OeoY/VH6vWGB61e3ooREjaRPoDF
         b6eNMdhrK8W0V27HcoUtdk7zEVgndcfj+zezhqU9zGS1ZJY/ORJ0RvQcYBjATn2U/0
         IWLRejijOuO0bm5NVM0tvkj8USH6xGeqbiCQvpIz66SCo4YhlchLlGs/fWJ1TyITAE
         YFBhzjpF20pQe0PViDJD6TjSha4laT9JglwvI1kJJTrUH2Pm2c2KBmtmc5YE+n5U8L
         X2GQCoMzYH5vg==
Received: by mail-pf1-f171.google.com with SMTP id i24so4653790pfa.7;
        Thu, 28 Apr 2022 09:15:14 -0700 (PDT)
X-Gm-Message-State: AOAM532HxKbiX8wR6Znr2RE2zqlankTqkY+dFV3AnTHHAe/wcJ+vhNDu
        9hcEZr2hygWada0EXvOSAEnZ3Kq5LgakA2x+uw==
X-Google-Smtp-Source: ABdhPJxWGKldChLEEW78VL6JusmO+ABexzsxV/SQewmd+Y9FRmG85Z5pK95W6eSIzbOvdvdIEpSvnklBPlyKXQUKU8s=
X-Received: by 2002:a63:ff4b:0:b0:3aa:3083:5131 with SMTP id
 s11-20020a63ff4b000000b003aa30835131mr29087326pgk.148.1651162513664; Thu, 28
 Apr 2022 09:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-2-johan+linaro@kernel.org> <de4f9514-5132-f208-d43f-4c50afcda203@linaro.org>
 <YmKBgGHtfDcO1Mkg@hovoldconsulting.com> <CAA8EJpqTzcwAtxk+XtAWdZaKEx2=VduPiVBp+CWj=_C-921YJg@mail.gmail.com>
In-Reply-To: <CAA8EJpqTzcwAtxk+XtAWdZaKEx2=VduPiVBp+CWj=_C-921YJg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Apr 2022 11:15:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmy1-=5=NpWuVo9RYBXAvLisREJoMp1cWEychGmfFN=w@mail.gmail.com>
Message-ID: <CAL_JsqLmy1-=5=NpWuVo9RYBXAvLisREJoMp1cWEychGmfFN=w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] phy: qcom-qmp: add support for pipe clock muxing
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 5:35 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 22 Apr 2022 at 13:20, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Apr 21, 2022 at 02:08:27PM +0300, Dmitry Baryshkov wrote:
> > > On 21/04/2022 13:20, Johan Hovold wrote:
> > > > Some QMP PHYs need to remux to their pipe clock input to the pipe clock
> > > > output generated by the PHY before powering on the PHY and restore the
> > > > default source during power down.
> > > >
> > > > Add support for an optional pipe clock mux which will be reparented to
> > > > the generated pipe clock before powering on the PHY and restored to the
> > > > default reference source on power off.
> > > >
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

[...]

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
> It is not about DT validation. It is about passing a correct DT. The
> file can come up from the kernel. It can come from the older kernel.
> OR it can come from the vendor. Or it even might be being a part of
> firmware flashed into the device.

As of dtschema 2022.03, validation of dtb's from firmware (or anywhere
else) is supported. Of course, as the old saying goes, if it's not
upstream, it doesn't exist. We can't control what vendors do in their
DTs.

> So we can not assume that the DT is correct just because the in-kernel
> DT passes YAML validation.

I agree with Johan on this. In terms of ensuring correctness, the
kernel does a horrible job. It never will be as long as it is done in
ad hoc code.

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

Yes and no. It is the OS/client view of the h/w. If a binding is
deemed horribly broken we could do a new compatible string and
binding. That's not something we want to be doing frequently though.

Rob
