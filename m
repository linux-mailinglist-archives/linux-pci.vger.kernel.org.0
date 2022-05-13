Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC31525F34
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiEMJ24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376600AbiEMJ2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 05:28:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D61D5266
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 02:28:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s22so699863qta.0
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHOV5J2hAwsJEAFpN6FZ5NcoOdg/JIMRAyc421SNtYU=;
        b=kdVET+G/W2ly3rh0os4eoWZK0qLS2rx1Ca5AiaLeOkJx2mQ2LKd3Nyy5Zs6Mlm5Dv+
         Hxu70S4qTWqO4g3EaKPbwK3nAWr9AB1kDe5Fj+RLVExT2kf87E3UqgtF4X9cn9b1LA7O
         KHXnHOJDhLstSHmXM0HTBMz9y0QObGQo41+G7UDvC92EiY9F4VA9gSQEFaB0Fo3Ohkqa
         THS59/5TD4pFsZ2aVCFLaihAobYzUFD5M8GkurHDecoptswS/9L9WpaqOGBUD1a3juOX
         PkJxPM/+qkjMNeIYmUHLCm4FBRfajNfwF+8ebfcBKqlfHVkxG4ESx2sCs+GW9JzLMGSR
         LlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHOV5J2hAwsJEAFpN6FZ5NcoOdg/JIMRAyc421SNtYU=;
        b=K2pCBWU3lNgVYzX+3kXo5TgeMf6B8OWqkjpJunPVbGu4aNQVrDOA5EGLrBIzaEt+53
         70DpqHtJwx28MXOFiPov1kTNNrLZ2PQ2s635QUus6sA/g7qLKWXqcjN6zUhOtW9SMx+2
         Cs/tTC2t0HnjdjoHI6eMhaLmUiQWilBRwl3nn44/+oXfAS6eAHNUcY+5/mOp7Ah08i1Y
         ZifGU58Hw+ZZ9ezXC4+3vxoFYOsbItY3hYYXclhSDYP/4/z6yvpOa/AZrSYtJ0t3pgie
         34fc61POCotZWPSs9tL9NrJxs+BjTgFYDasexGfpNZOcgDUOSB/0YRhGoIQEQPrV1EFO
         QocA==
X-Gm-Message-State: AOAM530Mq+bfHlPCtDY9ifw4y9UHxMrML7Hx3MIJh/U35BwMW2i//rv6
        6YNfZa1c97PrYLSo3pEKGZmXfGrkHeNwJMnb8TgaxQ==
X-Google-Smtp-Source: ABdhPJxZZGNHLVlCr5RmFLHoQS5lESyjxAHtSxo0peY1AalV5ydqhmXNzfvCEmGO7aGUMHPssMmn9tuUzG2RXwQTLxQ=
X-Received: by 2002:ac8:5e54:0:b0:2f3:f4ee:efbd with SMTP id
 i20-20020ac85e54000000b002f3f4eeefbdmr3545650qtx.295.1652434131397; Fri, 13
 May 2022 02:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org> <Yn4dvpgezdrKmSro@hovoldconsulting.com>
In-Reply-To: <Yn4dvpgezdrKmSro@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 May 2022 12:28:40 +0300
Message-ID: <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 May 2022 at 11:58, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 01:45:35PM +0300, Dmitry Baryshkov wrote:
> > I have replied with my Tested-by to the patch at [2], which has landed
> > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > Add support for handling MSIs from 8 endpoints"). However lately I
> > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > device was not forced to use higher MSI vectors.
> >
> > After removing this option I noticed that hight MSI vectors are not
> > delivered on tested platforms. After additional research I stumbled upon
> > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > vectors is mapped to the separate interrupt. Implement corresponding
> > mapping.
> >
> > The first patch in the series is a revert of  [2] (landed in pci-next).
> > Either both patches should be applied or both should be dropped.
> >
> > Patchseries dependecies: [3] (for the schema change).
> >
> > Changes since v7:
> >  - Move code back to the dwc core driver (as required by Rob),
> >  - Change dt schema to require either a single "msi" interrupt or an
> >    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
> >    part of the array (the DT should specify the exact amount of MSI IRQs
> >    allowing fallback to a single "msi" IRQ),
>
> Why this new constraint?
>
> I've been using your v7 with an sc8280xp which only has four IRQs (and
> hence 128 MSIs).
>
> Looks like this version of the series would not allow that anymore.

It allows it, provided that you set pp->num_vectors correctly (to 128
in your case).
The main idea was to disallow mistakes in the platform configuration.
If the platform says that it supports 256 vectors (and 8 groups),
there must be 8 groups. Or a single backwards-compatible group.


-- 
With best wishes
Dmitry
