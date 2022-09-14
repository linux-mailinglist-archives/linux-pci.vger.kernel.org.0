Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B05B8766
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiINLnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiINLnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 07:43:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712267C32A
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 04:43:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l10so14851028plb.10
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=33idBYFCA209mbgtuNpDyXjAqmtZgCVjerVNq6pkJTs=;
        b=ZuHmndqGGf6u5UtuBXdG6ItHcfgAjQeE6DIp43ODmI7EjWPliHSd+pyB0lWdTcyatm
         1sPPBaOTGgfHnQ0+ROLpnTXemAKr5LKup53Y3WrCkCR1eejjCMMzbBBDA0c1iHehULe8
         km5w/Zh5A1bqcUqsEZ6CR6IvMLhRCrMz38DFT/r3HyChrlIWfDf7QxtBG3pxsUGBflhb
         j83caFqoD+02TvHlt3OUd9A22oWU4/vOcxiQGUDLVHvO5yvaoV4VeT4Ch2xKt3xfHsfo
         vIQH/+r+VitUurUsjV8D2JRNDbSfGbnLtD33CCRA7BrgXABYqzC0Ko9a/qNNap3rxumq
         aBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=33idBYFCA209mbgtuNpDyXjAqmtZgCVjerVNq6pkJTs=;
        b=Ob5mOT7EkAVfgyi/7CfHHezFq46ohk7dW3CvzGLNn/sPEgoLjdrK7quxHt5zi/Lo1y
         wkP3hmRt3iBe3Zu5OQ0Pc/7G+qtULuWVtGuqz/9rDthwbFJn4Fof1xi2sMn1c0oplUx/
         gj8aCXiPwsW75V2S6GPdWxRnkcm/FpkuuNoqBeUS55PcKuLBBXDpxPnjEZo7NiFJwHy7
         szge/vh+qQiugRC7wIUoUQ6nM0Z7+NLO5juqAWF50FF+fxP6FlBjWJkVosDHEtIFPENW
         ZUTZXi+eYK8c3F/2sDlAS++nELu30LLtCezk9zWcSh0CIeH4Ej4gGd6BHdC7M97i7W4S
         yV8w==
X-Gm-Message-State: ACgBeo2DRBBnLY5amGhvkTgMlJa6Nr20rojdV25yTvkQ0egFFlsUUOdo
        SjYgOYLive/WPBG1x5sPBLnT
X-Google-Smtp-Source: AA6agR5ag1zkX0H9iLQGM/1UA7/eYstPU3VbIihZ8yKHixMVvDVXrwladTODkw+IQ+rn+xFxZNnjcQ==
X-Received: by 2002:a17:902:f395:b0:178:2f95:4d0b with SMTP id f21-20020a170902f39500b001782f954d0bmr14953759ple.106.1663155792863;
        Wed, 14 Sep 2022 04:43:12 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id k29-20020aa7973d000000b00537ff911a89sm9844460pfg.105.2022.09.14.04.43.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 04:43:11 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:13:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220914114306.GG16459@workstation>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 12:25:51PM +0100, Jon Hunter wrote:
> 
> On 14/09/2022 12:18, Manivannan Sadhasivam wrote:
> > On Wed, Sep 14, 2022 at 04:32:10PM +0530, Vidya Sagar wrote:
> > > Agree with Mani.
> > > Not all form factors support PRSNT pin (Ex:- M.2 Key-M form factor) and even
> > > if the slot form factor supports PRSNT, it is not mandatory to have a GPIO
> > > routed to the PRSNT pin of the slot.
> > 
> > Right.
> > 
> > > Also, since these are development platforms, we wouldn't want to keep
> > > changing a controller's status in the DT, instead want to know the device's
> > > presence/absence (by way of link up) looking at the log.
> > > In my honest opinion, I don't think the absence of a device in the slot
> > > should be treated as an error.
> > > 
> > 
> > As I mentioned earlier, timeout can happen due to an issue with PHY layer
> > also. In those cases, "dev_err()" is relevant.
> > 
> > And I also agree that absence of the device should not be treated as an
> > error. But my question is, if you know that the slot is going to be
> > empty always, why cannot you just disable it in dts?
> 
> I really don't think that makes sense from a usability perspective. You want
> to allow users to connect PCI cards and for them to work without having to
> update the DTB. I have plenty of open PCI slots on my PC and I would be a
> bit upset if someone told me I need to update the PC firmware each time I
> wanted to use a new slot.
> 

My question was, "do you think the slot is going to be empty always".
This can happen with slots exposed through a connector (not a PCIe one) and
users would plug in add-on cards for accessing the slots. In those
cases, the add-on specific devicetree can enable the PCIe instance and
use it.

But from your reply, I can infer that the slot is exposed on a standard
PCIe connector and users would connect a PCIe device any time.

Anyway, I don't strongly object the change and leave it to the
maintainers to decide.

Thanks,
Mani

> Jon
> 
> -- 
> nvpublic
