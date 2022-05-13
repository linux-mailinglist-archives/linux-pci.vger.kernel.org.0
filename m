Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F44526001
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379284AbiEMKK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350059AbiEMKK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 06:10:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C4140C5
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 03:10:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fu47so6444493qtb.5
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6a24hmutHKBGPmKdmfzo+GbqGc2VGX64fsVUBoQOak=;
        b=ZJ2qfJ31vR6PlkYcXNCuvVB0LtzyBMrsX39x7zgy56oWu2NbHtdhnoTyNB8YvPOhdN
         FK4B91mKUm+XHUNlEhbILynY9HJ0PNWsjhBHGSZ+NVY2IDa9AsBhGhy+xVHWkV5QaWT1
         FL3oiJZrjcjas7G7EHOJk74E5UNCEKOPuV6nyXWCOVc2HeauNkBBJRqEnkLZDUPtuerW
         PCXTUk6z8PzlF6d1sZg2f7HjzElZhW6twJjLW0Gol/Ula5tDl09rfYNaN4cRpk86FwMM
         H7wFub9pyV/v5BqxQbFYQZ/S8ZfXTw1grLI3LqZ8rwL72MixXrBJSE2Gsj6QM/cKrsJT
         13zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6a24hmutHKBGPmKdmfzo+GbqGc2VGX64fsVUBoQOak=;
        b=F4Jvt56WDRy4E4LPLVaBUGluPTd26g+QCXQN58K8hm/jah1oGd4Z99VY37KenEnY5v
         pDvbuDN/W0/FSXlrl5+bHF4T3BhIUnP3TdcN2s1fT5p3NDSLWydBbl0x91T/P5o6RePJ
         K3bLXBCQj3A086YYNM7SNvNOv/+ArsU8n4mE4O6lQZkQp2NRvBbeDFybLbV+6u2QPLMe
         ZN8xFGBEflB7IdNDqGTakJM5wLpoeJpIDXUMA2SGPDrcPPeKvZnEs2MZ1pBJaFI91Ouf
         v46NvqHoir9QwnaApxJImCxfONvjE9LV9ys8M7tERJ4uTMYX2dJ4MqUxh5MZk9ObhmsE
         Tjxg==
X-Gm-Message-State: AOAM530JD8NM+5xezraGIpM6GWztrkbbfJpi2pAN0XQI+wPpMxSjGG9w
        mtYAQd0fod0IDEkIz1/MuqwvdmNSoBuxlAGR6G3IAQ==
X-Google-Smtp-Source: ABdhPJzAi/elIkBWOFcWmkdVB2d0z/x9dKi584KPCw1vkuUCARdqrVdlFvWzZG61xwKYSxSJZ6Anb6jvV8IDKkg/xGY=
X-Received: by 2002:a05:622a:188e:b0:2f3:dc9f:946 with SMTP id
 v14-20020a05622a188e00b002f3dc9f0946mr3736913qtc.682.1652436655475; Fri, 13
 May 2022 03:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <Yn4dvpgezdrKmSro@hovoldconsulting.com> <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
 <Yn4ms7dKIzeAqt7A@hovoldconsulting.com>
In-Reply-To: <Yn4ms7dKIzeAqt7A@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 May 2022 13:10:44 +0300
Message-ID: <CAA8EJppt4kiG45j62W-Z7Ech8WLNnkPYiVv7T0AK-+Dxtc_KDQ@mail.gmail.com>
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

On Fri, 13 May 2022 at 12:36, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, May 13, 2022 at 12:28:40PM +0300, Dmitry Baryshkov wrote:
> > On Fri, 13 May 2022 at 11:58, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, May 12, 2022 at 01:45:35PM +0300, Dmitry Baryshkov wrote:
> > > > I have replied with my Tested-by to the patch at [2], which has landed
> > > > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > > > Add support for handling MSIs from 8 endpoints"). However lately I
> > > > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > > > device was not forced to use higher MSI vectors.
> > > >
> > > > After removing this option I noticed that hight MSI vectors are not
> > > > delivered on tested platforms. After additional research I stumbled upon
> > > > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > > > vectors is mapped to the separate interrupt. Implement corresponding
> > > > mapping.
> > > >
> > > > The first patch in the series is a revert of  [2] (landed in pci-next).
> > > > Either both patches should be applied or both should be dropped.
> > > >
> > > > Patchseries dependecies: [3] (for the schema change).
> > > >
> > > > Changes since v7:
> > > >  - Move code back to the dwc core driver (as required by Rob),
> > > >  - Change dt schema to require either a single "msi" interrupt or an
> > > >    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
> > > >    part of the array (the DT should specify the exact amount of MSI IRQs
> > > >    allowing fallback to a single "msi" IRQ),
> > >
> > > Why this new constraint?
> > >
> > > I've been using your v7 with an sc8280xp which only has four IRQs (and
> > > hence 128 MSIs).
> > >
> > > Looks like this version of the series would not allow that anymore.
> >
> > It allows it, provided that you set pp->num_vectors correctly (to 128
> > in your case).
> > The main idea was to disallow mistakes in the platform configuration.
> > If the platform says that it supports 256 vectors (and 8 groups),
> > there must be 8 groups. Or a single backwards-compatible group.
>
> But you also added
>
> +        - properties:
> +            interrupts:
> +              minItems: 8
> +            interrupt-names:
> +              minItems: 8
> +              items:
> +                - const: msi0
> +                - const: msi1
> +                - const: msi2
> +                - const: msi3
> +                - const: msi4
> +                - const: msi5
> +                - const: msi6
> +                - const: msi7
>
> which means that I can no longer describe the four interrupts in DT.
>
> I didn't check the implementation, but it seems you should derive the
> number of MSIs based on the devicetree as I guess you did in v7.

It is a conditional, so you can add another conditional for the
sc8280xp platform describing just 4 interrupts. And as you don't have
legacy DTS, you can completely omit the backwards compatible clause in
your case.
So, something like:
 - if:
   properties:
      contains:
         enum:
            - qcom,pcie-sc8280xp
  then:
    properties:
       interrupts:
          minItems: 4
          maxItems: 4
       interrupt-names:
           items:
              - const: msi0
              - const: msi1
              - const: msi2
              - const: msi3

-- 
With best wishes
Dmitry
