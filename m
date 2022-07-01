Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2884156393D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiGASiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGASiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 14:38:22 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E71C125;
        Fri,  1 Jul 2022 11:38:21 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id y18so3085223iof.2;
        Fri, 01 Jul 2022 11:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JFCuwZEGgnwKogwS2rb4M4/WgT3C/xL2jGrRo19barQ=;
        b=gzt0HLkU/EnzSnKZIT8PPc4BWed/E8j3NJx2GVpB6Ju2wxgi2RStfzrQ+oAzM8Wmpf
         JXZ9HhGFIZoDFE2D+Zw2QIO/VoSw088uMTnl/11kTyL43NCY5ObipLQwP1GQYA7t0yF4
         b2wYRuEcP40JvKL0yeEqH6dnHr1CNjUMZ0OhAYPsS4GF2qw+zKaoTNM2DOBaT3f3f6CK
         zmCkTUK9LaW4d1C3caBJYKZkzRGD9zWSDyUICRX8vLmngyAGPaii3LHSIvZV5Y0XX6ju
         CD3aj/DloTi3prnoKIRJ13VT8wUOqao/5RhM4LDcsooxPQqnc5rHn78Hd4yX5ksz/E3v
         LuQQ==
X-Gm-Message-State: AJIora8v1ALGnopIWLvjRTJ0kM7Q1x6DZVgBKTs3sEkaGQ3J3UZyvpoh
        GumDHD0/ypWdh43/c3zddy3fPBqEQw==
X-Google-Smtp-Source: AGRyM1tFLVvxZZTJZOKCOqsLHuzfA/xaz+jEPQd5u+nxRGC5u+1Ag3I61t1MmqHlM07u2fPMmqZFPg==
X-Received: by 2002:a6b:7012:0:b0:675:43e5:58a1 with SMTP id l18-20020a6b7012000000b0067543e558a1mr8337072ioc.4.1656700700922;
        Fri, 01 Jul 2022 11:38:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b002d955fab9dbsm9352343ilt.23.2022.07.01.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:38:20 -0700 (PDT)
Received: (nullmailer pid 1288873 invoked by uid 1000);
        Fri, 01 Jul 2022 18:38:19 -0000
Date:   Fri, 1 Jul 2022 12:38:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: PCI: qcom: Enumerate platforms with
 single msi interrupt
Message-ID: <20220701183819.GB1284915-robh@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-4-johan+linaro@kernel.org>
 <c20ba06c-b37a-e91c-84c6-6d2147bb2478@linaro.org>
 <Yr6ykvru52aDZhFm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr6ykvru52aDZhFm@hovoldconsulting.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 10:38:42AM +0200, Johan Hovold wrote:
> On Fri, Jul 01, 2022 at 10:33:35AM +0200, Krzysztof Kozlowski wrote:
> > On 29/06/2022 16:09, Johan Hovold wrote:
> > > Explicitly enumerate the older platforms that have a single msi host
> > > interrupt. This allows for adding further platforms without resorting
> > > to nested conditionals.
> > > 
> > > Drop the redundant comment about older chipsets instead of moving it.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > This does not exist in linux-next, so it should be squashed it with the
> > previous series.
> 
> As mentioned in the cover letter this depends on the MSI series that has
> unfortunately not yet been merged.
> 
> That series is self-contained and ready to be merged, so this follow-up
> does not need to be squashed in.

I suspect that Bjorn would rather squash these in.

Rob
