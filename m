Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7372F65C819
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 21:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjACUcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjACUcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 15:32:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6713F26;
        Tue,  3 Jan 2023 12:32:07 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y19so14824049plb.2;
        Tue, 03 Jan 2023 12:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWS6045Sqj+UNo6j97/cMXasJ422pH4cxGvxpkvbD2Q=;
        b=mTfDrY8Vkw8ftCHsbxPDOIKOHXhXVPbsrMgCZLjEDLTUlwBUtkm6ckQ/kC0P7MynIw
         pBUxILNQ/E4AnBrdlZhh2XetSK06ppKvYzYyYblTDcXgHQfNFzGZfSjXl04X1JOMoBt9
         3cE0cRvuvIDykOsEdSryS7O3P2TuZTNF1hSpKd25Nh5eEbBau+i0Zv9iJGYGEjy2WP6j
         ItJggYwCABrW5EhbGAx4KQu/jFp7gKMzi4NntBv4qQYoVoI5Ma2t9zUDqLwTo89RdLlF
         whoAeJr7yi7D4RgS+aAlNpjXAmw1fw8fXlkqmL/8hUPjpvC9UTnurR9h5vNPvfiBGags
         hxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWS6045Sqj+UNo6j97/cMXasJ422pH4cxGvxpkvbD2Q=;
        b=pTYj3k/WCSu1YcJreJxi4w3ODDiO/82mfCXmOY6o3JUDEMTCuWfsJcmIACjUOTowtL
         EXv+X6cSSXx/ovKC+ByBijH78tOUovw3VIOr6hEeSeQ6J3D8/T+U8S6x6H/19VDhVEP2
         cdrVsCwV+dh+4fgtAOOvPjx+xmzcQVq3g9et/CoCfIy7ksgGC1Mgkutt/+QD0QtYu3dz
         gUbCWq40BfuDiBYqYghmB7dccCKLUsxdNJMebnOlmWiOXLCuLVY+bLq+ANTGYGGz14rg
         iesun4EepmlqY6F9TbZW7/znkNTkoWPexrtCf44iSeZgpVMT099ZoMho1/do+7Ud3tUl
         Puvg==
X-Gm-Message-State: AFqh2kp9PwKr5kizy4smGFSqcgM7FUXwCVt1NKy06ZaLvUAKNC8ZDTqV
        VxNY2PnLb6D1+G+seGLEYGlSQNtG2dkMALJGg2w=
X-Google-Smtp-Source: AMrXdXsDo+pE0O4bLVZdjG42s7+bK+VCkeLLmW7EahsTQD3uNpYDHDdjWvuLtLBvvm3flW3ehrg656L2uj18hqp7wbw=
X-Received: by 2002:a17:90a:3187:b0:226:abeb:d073 with SMTP id
 j7-20020a17090a318700b00226abebd073mr34968pjb.142.1672777926573; Tue, 03 Jan
 2023 12:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20221116214841.1116735-1-robimarko@gmail.com> <20221116214841.1116735-2-robimarko@gmail.com>
 <20221205215253.itobukkyiecn7xi7@builder.lan> <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
 <20221227192049.zk5gqhpnq2m7baqa@builder.lan> <CAOX2RU4SGmmZT6e0V5YCsCYU82wAJH736PhEz4Tx+Q0XTFU_9A@mail.gmail.com>
 <20221229172944.6lg6mb53uqj2hps6@builder.lan>
In-Reply-To: <20221229172944.6lg6mb53uqj2hps6@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 3 Jan 2023 21:31:55 +0100
Message-ID: <CAOX2RU7uWDuw0_8wxcmM07tpWpXZ_m2WRz-GGcRu9Ny8zoctNA@mail.gmail.com>
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

On Thu, 29 Dec 2022 at 18:29, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Dec 28, 2022 at 12:10:17PM +0100, Robert Marko wrote:
> > On Tue, 27 Dec 2022 at 20:20, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Tue, Dec 06, 2022 at 10:51:40AM +0100, Robert Marko wrote:
> > > > On Mon, 5 Dec 2022 at 22:52, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > >
> > > > > On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> > > > > > IPQ8074 comes in 2 silicon versions:
> > > > > > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > > > > > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> > > > > >
> > > > > > v2 is the final and production version that is actually supported by the
> > > > > > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> > > > > >
> > > > > > Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> > > > > > by fixing the Gen3 QMP PHY node first.
> > > > > >
> > > > > > Change the compatible to the Gen3 QMP PHY, correct the register space start
> > > > > > and size, add the missing misc PCS register space.
> > > > > >
> > > > >
> > > > > Does this imply that the current node doesn't actually work?
> > > >
> > > > Hi Bjorn,
> > > > Yes, the node is for a completely different PHY generation, basically
> > > > PCIe on IPQ8074
> > > > is completely broken, hence this patch series.
> > > >
> > > > >
> > > > > If that's the case, could we perhaps adopt Johan Hovolds' new binding
> > > > > and drop the subnode in favor of just a flat reg covering the whole
> > > > > QMP region?
> > > >
> > > > I have not seen that so far, any examples?
> > > >
> > >
> > > See
> > > Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml in
> > > v6.2-rc1.
> > >
> > > The idea is to, at least, use this for all new platforms introduced.
> > >
> > > And if the current definition doesn't actually work I suggest that we
> > > replace it with the new one.
> >
> > I understand the intention, but these bindings dont match the QMP generation
> > found in IPQ8074 at all, and Gen3 has already been documented in bindings.
> >
> > This would require updating the driver to carry the offsets and rework
> > of bindings to
> > not require power domains, etc for IPQ8074 as I have not found any
> > code downstream
> > to indicate it has GSDC-s for PCIe though I dont have any docs at all
> > for the SoC.
> >
>
> I was only thinking of the structural difference, not the power-domains
> etc. But yes you're right that it means updating the driver and the
> binding.
>
> The end result would be much nicer though...

I agree that it would be nicer, though it's asking for many changes, especially
bindings since it's already described there.

The current patchset has been thoroughly tested for months at this point.

How would you like to proceed here, as I would really like to get PCI working
upstream?

Regards,
Robert
>
> Regards,
> Bjorn
