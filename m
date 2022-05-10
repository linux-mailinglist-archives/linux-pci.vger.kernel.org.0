Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34085220A3
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347029AbiEJQJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348247AbiEJQH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 12:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A0253AA7;
        Tue, 10 May 2022 09:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE6FB81D0D;
        Tue, 10 May 2022 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3664DC385CF;
        Tue, 10 May 2022 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652198421;
        bh=S+Udw4q/qdeK0LraOCKyvGdFYNsj8SeCKPMsyHplKUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bd/5Hc46ICRKZ/GRK1EzPDUZpvVdDbXat6kSJM4E5TbQlKZubKU7Q0xYWQAGdu49P
         HzrGtdGnXl7Ca5y0DtQJdXCMKx6FueohFADw/9181wwaVI4S5Qt5nSnpYilSLaIi/b
         /R8po7N8djAYCS/VSa4xuDPVwkgCAAVM9hZOHYWY5bOCUAbUPiqgtdv0PV3B/sO/D/
         e9ejuEz8LB/uYkrWG7m2mOmXbty/4t5ISUi96kkS7KWpiLfTBd+tgWItLFwDWNfjAj
         IKlTEACESiQJVWDhVhB051LOYkqRKnL5M5SamfcufcCq7nq7Si95YKFgrL61CzouBQ
         xZl5mvOuI08cA==
Received: by mail-pj1-f53.google.com with SMTP id x88so4708997pjj.1;
        Tue, 10 May 2022 09:00:21 -0700 (PDT)
X-Gm-Message-State: AOAM531maTNDYfcD60HSsyvkCF6kkMFkpHUyFd3VWFLEGe4GTicibsnz
        GuppxMrVNNNFVLg+qrucH3KkKkGL+pQ/I5RgFQ==
X-Google-Smtp-Source: ABdhPJzy+9cnxPvWe4uU9hmRJqDkSAV91tz5hBrNkP8hlvvVGgf2Y9lpkxy3Vb1bAK9ICTtcwsPKl9+plSF77BUdAmE=
X-Received: by 2002:a17:902:7884:b0:15e:e6a8:346 with SMTP id
 q4-20020a170902788400b0015ee6a80346mr21417641pll.151.1652198420610; Tue, 10
 May 2022 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com> <eea7db0b-b483-e61c-8f2d-174f2032fd51@xilinx.com>
In-Reply-To: <eea7db0b-b483-e61c-8f2d-174f2032fd51@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 May 2022 11:00:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJj_CPPn9+by3rSpSXW9ufUcbsUbNbE3wE5qFRrJ-PjKg@mail.gmail.com>
Message-ID: <CAL_JsqJj_CPPn9+by3rSpSXW9ufUcbsUbNbE3wE5qFRrJ-PjKg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 10, 2022 at 2:29 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
>
> On 5/4/22 17:43, Rob Herring wrote:
> > On Fri, Apr 29, 2022 at 8:02 AM Bharat Kumar Gogada
> > <bharat.kumar.gogada@xilinx.com> wrote:
> >>
> >> Describe cpm reg property before cfg reg property to align with
> >> node name.
> >
> > The order is an ABI. If breaking it is okay, explain why here.
>
> I didn't push any description for versal to upstream u-boot or linux yet but
> xilinx is using this order for years. DT binding order wasn't aligned to it.
>
> For example: (Xilinx Linux is in sync with this).
> https://github.com/Xilinx/u-boot-xlnx/blob/master/arch/arm/dts/versal.dtsi

Good to know, but if there are upstream dts files, what do they use?

> Driver itself is working with reg-names and order of regs doesn't matter. It
> means changed order doesn't break any functionality.

While in general I consider the order part of the ABI, if that's
enough to avoid breakage on anything you care about, then just state
that.

> Right now reg order really matter in binding doc but would be good in these
> examples to record that both ways are fine.
> Would it be better to describe that both ways are fine?

Only if that's what you need. If you are fine with the order changing,
then make the change and fix all the dts files.

>
>    reg-names:
>      oneOf:
>      - items:
>        - const: cfg
>        - const: cpm_slcr
>      - items:
>        - const: cpm_slcr
>        - const: cfg
>
>
> Another small reason is that all hard IPs in Versal are normally placed below
> 4GB address range. And there are some others which also have mapping above. This
> is one of that example and we normally aligned with 32bit address.
>
> And the biggest reason is that current node name is pcie@fca10000 which should
> be aligned with the first register base which is before this patch 0x600000000
> but name suggest that the first reg should be cpm_slcr instead of cfg. That's
> why I consider this patch as a fix and the patch should contain fixed tag.

I don't disagree. I'm only asking for a better commit message.

Rob
