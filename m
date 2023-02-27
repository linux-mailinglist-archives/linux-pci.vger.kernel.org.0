Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2146A4C18
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjB0UPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 15:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjB0UPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 15:15:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39A23338
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 12:15:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so7440284pjg.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677528948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpnEvE+/SdK2xJYvrmI9miffWQyVUk2OmaUWCwQjPNM=;
        b=kXy56jY9p7bAWNqFFALBb24FnzbQGn6ZN6MQ9bLHtAa3gAZmLWxRz7gmHynTxlT7jF
         vk+LeSSfHaCfQGJyTh/frxpZNKowih6hyyLck1oeydJLhGPV4vCW+TT2/ZKTyZ09xyMe
         A66a5VyUKjs1XUG4pWFgCc2OpS2Iy3vtoxOZTBDGi6es0pvvhsTG7KiDNxTXl4sARQQy
         liP+ZebAVXXVd3hi4BhMnbDsMi1noQ92rgBhGGe9FGbAeoYboLgp512cEEtqMHDZt5q5
         LEwbCiZRloRYStzbNmIZsJba2Yqx44SkK+zRqvgitOiRhSWydvyFCpDLRYRrBy0G9cvV
         S70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677528948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpnEvE+/SdK2xJYvrmI9miffWQyVUk2OmaUWCwQjPNM=;
        b=cpsRD0hi2635Cz1oZrOxpxEC2T7ErLce8bDCrJWNwegunKrzgGFmkI9ncjRMkrNJx2
         hXnBbVwKKUTIk3dmUgE5OfbC73BsTTcHCPSuXsB/i2MdfdZ6SnseexjdItcUKjHPrLiH
         Zc2MrzoOUp5y4rR6mYldC56DbGQmgXAProNbR3E6KUVGqAUN15soMcofBzLP1hcNNjgn
         ObPMZE67r6yAefKTO7VW+tItY6jTSk2SRb0c9ggObFzEdvjkrF+pMRkbegHT07qpYbDc
         fIujpHuFmQetCsJkqtd/YQ7Q53+gDwDv5+02eNt9KvOZSIRq9tYTl2XLOXms0Kpwdz+F
         P37Q==
X-Gm-Message-State: AO0yUKUru/bn8xY2g2aZqLJ8T734YBHgMd/xtd2cCbfYgQsKYeRqtHMF
        3I40HJUfNx4yQ3IE7ZFQAU5qO/cre0xsXhQp0wUwfLj98bAscqlUy6I=
X-Google-Smtp-Source: AK7set+4+UusRDTWKUVqekIC00M9LlKWUPfOe10+UpN7ZNL7GUb5WQhWNHPeGvFb5PshqffBrr6OJiF/h70oCgv3vsM=
X-Received: by 2002:a17:90a:ce12:b0:234:925b:7d61 with SMTP id
 f18-20020a17090ace1200b00234925b7d61mr207698pju.9.1677528947405; Mon, 27 Feb
 2023 12:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20230224195749.818282-1-sdalvi@google.com> <20230224195749.818282-2-sdalvi@google.com>
 <b50ab99f-e307-3a66-9198-85a71b012e5e@linaro.org> <CAEbtx1k-7TJPcd3+cueRoKLJcoUQLfF6nfOQFVfzB0YCUrbtqg@mail.gmail.com>
 <2e4964c1-0831-c156-3372-81a56f8d623e@linaro.org> <CAEbtx1=EGC+4LfSz+HqGzjJvF2O1vsB7a42ESTqbU8p5N-yUHg@mail.gmail.com>
 <28c72c1a-df7d-db05-f32f-23b170b96db5@linaro.org> <80b17309-ec9c-8942-d901-7121bc936471@linaro.org>
In-Reply-To: <80b17309-ec9c-8942-d901-7121bc936471@linaro.org>
From:   Sajid Dalvi <sdalvi@google.com>
Date:   Mon, 27 Feb 2023 14:15:36 -0600
Message-ID: <CAEbtx1nmYwp-QJ_L-og+M=z-iQst53OtZeZOADGrQVcuhQGapQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel-team@android.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Krzysztof.
I will attempt to send a new patch to address the delay solely in the driver.

Sajid

On Sat, Feb 25, 2023 at 4:08 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/02/2023 11:00, Krzysztof Kozlowski wrote:
> > On 24/02/2023 23:09, Sajid Dalvi wrote:
> >> On Fri, Feb 24, 2023 at 3:29 PM Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 24/02/2023 22:27, Sajid Dalvi wrote:
> >>>> On Fri, Feb 24, 2023 at 2:40 PM Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 24/02/2023 20:57, Sajid Dalvi wrote:
> >>>>>> When the Root Complex is probed, the default behavior is to spin in a loop
> >>>>>> waiting for the link to come up. In some systems the link is not brought up
> >>>>>> during probe, but later in the context of an end-point turning on.
> >>>>>> This property will allow the loop to be skipped.
> >>>>>>
> >>>>>> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> >>>>>> ---
> >>>>>
> >>>>> Thank you for your patch. There is something to discuss/improve.
> >>>>>
> >>>>>>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
> >>>>>>  1 file changed, 8 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>>>>> index 1a83f0f65f19..0b8950a73b7e 100644
> >>>>>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >>>>>> @@ -197,6 +197,14 @@ properties:
> >>>>>>        - contains:
> >>>>>>            const: msi
> >>>>>>
> >>>>>> +  snps,skip-wait-link-up:
> >>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>>> +    description:
> >>>>>> +      When the Root Complex is probed, the default behavior is to spin in a
> >>>>>> +      loop waiting for the link to come up. In some systems the link is not
> >>>>>> +      brought up during probe, but later in the context of an end-point turning
> >>>>>> +      on. This property will allow the loop to be skipped.
> >>>>>
> >>>>> I fail to see how probe behavior is related to properties of hardware.
> >>>>> You describe OS behavior, not hardware. This does not look like
> >>>>> belonging to DT.
> >>>>>
> >>>>>
> >>>>> Best regards,
> >>>>> Krzysztof
> >>>>
> >>>> Thanks for your response Krzysztof.
> >>>> The hardware configuration of the system determines whether an
> >>>> endpoint device is available during host init. If it isn't available
> >>>> on a particular and dedicated pcie interface, we should skip waiting
> >>>> for the link to be up. For other interfaces, possibly even on the same
> >>>> system, where a device is present or maybe present we should wait for
> >>>> the link to come up.
> >>>
> >>> Keep discussions public.
> >>>
> >>> Your commit and property description mentions probe, which is nothing
> >>> related to hardware. Why the device would not be available during host
> >>> init (I understand we do not talk about hotplug as it is already
> >>> supported by Linux) in a way it is hardware property, not OS?
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>
> >> + everyone else I mistakenly didn't reply to earlier
> >>
> >> If I understand you correctly, the usage of probe is misleading
> >> because it doesn't have anything to do with the hardware.
> >> So your recommendation is to replace probe with device init, in the
> >> description of the property and the commit message?
> >
> > No, I asked there a question for which we need answer.
> >
> > device init is also OS task... You need to explain why this is a
> > property of hardware, not OS behavior.
>
> Actually let's be clearer - your cover letter says:
> "In some systems the link is not brought up
> during probe, but later in the context of an end-point turning on. (...)
> to skip this loop."
>
> so this is pure Linux OS stuff. You just want to control driver behavior
> from DT. Not at all DT property.
>
> Best regards,
> Krzysztof
>
