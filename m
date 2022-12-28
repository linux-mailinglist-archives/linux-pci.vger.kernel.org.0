Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F076575A7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiL1LKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 06:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiL1LKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 06:10:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C821F;
        Wed, 28 Dec 2022 03:10:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id fy4so15955586pjb.0;
        Wed, 28 Dec 2022 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9naIqkNaMLLvBoGYLzFhWmmFiWmpVPHULOvj3Di9g6k=;
        b=eGH05jcojq8zeolUJcWkGi13CoWSOuiL6roVFk71k5HBNaFEMs0LV2JrvAy/InsyIw
         Dqe7pp5Pnv319wrjp/4mjTmxT6RsHaD//5XzUuSjnpbXky3m424p2xrkTuxfJ7OmVRP+
         2SM9uqz18R6sC4azPQJAIHacJxxzjJa967YYXhDHgY4swyLsvzi1/YuTtPIgzw++wyA1
         KH/PWLGM3T9Q4naPyj6v+jydtZCCDAjmUdCJWWbbxVnXM4YuemoqfKgc5PL5BJ/eaXDl
         MjcJ5OWzNjMhzeJMzg0RjYC+W8cfOM32RfZ1VRIqfrOgPs4ZJXgedd5nQ5yKTAl+db3e
         gOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9naIqkNaMLLvBoGYLzFhWmmFiWmpVPHULOvj3Di9g6k=;
        b=2U7vwRQ8O6yLb00IWXtfXDmdk7+WcYz8Untmi63eqBJX4R6jnWjW696+D3701Psst8
         iZMkWq92roeoWPqCD9CXHmkaQVSDGeEboRjkLuhQHlommNQjwJTQF89mo3giLOiK9N7i
         TupZrmJkVCZGWCHrATFK64NJP8utWLu+Nte33BofCXyhP/ebBbz3XB6+q6qjwrKDutWK
         An0LeSadaT96Nh7Mj39oukUIlympC+xIieWHOdpMyO/CXHVTYTtFkP2ITcKnwfoFB2WN
         fauZsqpcuwZjTu3o5CFudoZzAiymxnkRO4ODEcEfzTo5R3SVjADerZdl3EMPdP2iO4tk
         zy8g==
X-Gm-Message-State: AFqh2kq8fXrzRcvBEhNJOSQS6lK+jdrWL0mq/pnA2D6xMNaNlHVMEnBR
        v8mkUKOX/ZseNYDA5nc5Met5LSGSNQ2W9bpX6jg=
X-Google-Smtp-Source: AMrXdXsR2yBJjTWXi9Mcq9RAHhoH5ym7DSPJZ4GBvFZ7UCjdbK9Z7RqQU3pfsUC8aO/1M1t4cyIPFu1YXwSA9Hpx6RM=
X-Received: by 2002:a17:903:2301:b0:192:55ab:890c with SMTP id
 d1-20020a170903230100b0019255ab890cmr1494771plh.57.1672225828681; Wed, 28 Dec
 2022 03:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20221116214841.1116735-1-robimarko@gmail.com> <20221116214841.1116735-2-robimarko@gmail.com>
 <20221205215253.itobukkyiecn7xi7@builder.lan> <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
 <20221227192049.zk5gqhpnq2m7baqa@builder.lan>
In-Reply-To: <20221227192049.zk5gqhpnq2m7baqa@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 28 Dec 2022 12:10:17 +0100
Message-ID: <CAOX2RU4SGmmZT6e0V5YCsCYU82wAJH736PhEz4Tx+Q0XTFU_9A@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Dec 2022 at 20:20, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Tue, Dec 06, 2022 at 10:51:40AM +0100, Robert Marko wrote:
> > On Mon, 5 Dec 2022 at 22:52, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> > > > IPQ8074 comes in 2 silicon versions:
> > > > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > > > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> > > >
> > > > v2 is the final and production version that is actually supported by the
> > > > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> > > >
> > > > Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> > > > by fixing the Gen3 QMP PHY node first.
> > > >
> > > > Change the compatible to the Gen3 QMP PHY, correct the register space start
> > > > and size, add the missing misc PCS register space.
> > > >
> > >
> > > Does this imply that the current node doesn't actually work?
> >
> > Hi Bjorn,
> > Yes, the node is for a completely different PHY generation, basically
> > PCIe on IPQ8074
> > is completely broken, hence this patch series.
> >
> > >
> > > If that's the case, could we perhaps adopt Johan Hovolds' new binding
> > > and drop the subnode in favor of just a flat reg covering the whole
> > > QMP region?
> >
> > I have not seen that so far, any examples?
> >
>
> See
> Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml in
> v6.2-rc1.
>
> The idea is to, at least, use this for all new platforms introduced.
>
> And if the current definition doesn't actually work I suggest that we
> replace it with the new one.

I understand the intention, but these bindings dont match the QMP generation
found in IPQ8074 at all, and Gen3 has already been documented in bindings.

This would require updating the driver to carry the offsets and rework
of bindings to
not require power domains, etc for IPQ8074 as I have not found any
code downstream
to indicate it has GSDC-s for PCIe though I dont have any docs at all
for the SoC.

Regards,
Robert
>
> Regards,
> Bjorn
