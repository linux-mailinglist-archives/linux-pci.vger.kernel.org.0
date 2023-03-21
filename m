Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88766C2CC9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUInt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCUInr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 04:43:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC43BDB6;
        Tue, 21 Mar 2023 01:42:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w22-20020a9d77d6000000b0069d2032f98aso8019823otl.12;
        Tue, 21 Mar 2023 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679388168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIM5TNKlfNxivE5VG0d4KRJ8inW6s1usyOfvs+X4zYg=;
        b=UhCCNdHH1PEqmWjTTy62itx+pYyk+/UB50fuRUrwGS18KDu7/6NLkEvyeQVPPYUyXH
         jiKtPIEnlVzlP8N+2SDTpV3smxvUHvHRVdNFO96gpLex5OFNHxMhMYiD/MnvR9ObG71W
         E2VnFpiV/LQRYTRmlDN4odK9/ri6t7cawHZ2U8WUJkQoUowSXmC34OHl/ykT0WHz4lfw
         /5Wk8VIOyRVKYuJmvDS3NsDPJshuEfz25XG8GGIJoY864mdEMuDUJKa+7zi+ebJTKe4b
         3U/rDVApv41fOZY/fefr4b//3EIVyeUrj1X3OFggglukSgKJ2qqSV9zfkB1uGXD1g1K2
         TH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIM5TNKlfNxivE5VG0d4KRJ8inW6s1usyOfvs+X4zYg=;
        b=RBSi1D5awBv5pXjXu+Gk+99ngoXm455fkXF+hqKXomy0PJ8PnTIZ/y+veoiGucY+d2
         ARhW8pMj8rNgkom2YPRdF5/RWAzemqmIRg739N7jcHExOhojZzftm5uDbHijsvlx++PZ
         1aCDtXZ4dfPg/Pfvvku59En9jomQsKSYm0Kx8wowSrEJpN0RzK/1TDC3/CESJPCOwG2G
         zwVWEUXv19j1ZWPCsnZMt5M7x4lbj936yrsUUwnDqGacxpDvqGI94fTgy8kqe0eAogCd
         +poxDMI0HjD4F8GvOATK8Zh5UjIWhc29uT0IjvinxG9IL9mfr46XKiYMjBS6TyvguSS7
         8wPA==
X-Gm-Message-State: AO0yUKVZ5RbPOgtGNFQiauJNubBwksrnwp8wDhJXN3OPlYpFgxhOsjCw
        d+P2lTkWKMmheDuwmgKjjnjrdTgGQ07qd4/sMMg=
X-Google-Smtp-Source: AK7set9W9RD3dzU3hSbXXc5N+zgXzCtyG7/Ufz/f6/mVVEf13arFZi8yOyyf00JXd77jpHGi67JvMPmyTlGNxQiLRQs=
X-Received: by 2002:a9d:7854:0:b0:68b:cd1e:1ef1 with SMTP id
 c20-20020a9d7854000000b0068bcd1e1ef1mr535395otm.7.1679388167819; Tue, 21 Mar
 2023 01:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
 <20221013062649.303184-2-dominic.rath@ibv-augsburg.de> <20221013191249.GA38183-robh@kernel.org>
 <20221014134114.GA307620@JADEVM-DRA> <5d049f9c-f86e-990d-6e81-168606172d63@ti.com>
In-Reply-To: <5d049f9c-f86e-990d-6e81-168606172d63@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 21 Mar 2023 09:42:36 +0100
Message-ID: <CAH9NwWfLLvVG4=cxCriYjMpXHYw5OhX3rzbSXO0o5Ji3isYtXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Dominic Rath <dominic.rath@ibv-augsburg.net>,
        Rob Herring <robh@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dominic,

> >>>
> >>> Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
> >>> setting the PCIe PHY latencies.
> >>> The properties expect a list of uint32 PHY latencies in picoseconds for
> >>> every supported speed starting at PCIe Gen1, e.g.:
> >>>
> >>>   max-link-speed = <2>;
> >>>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> >>>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> >>
> >> These are a property of the PHY or PCI host? Sounds like PHY to me and
> >> that should be in the PHY node. No reason the PCI driver can't go read
> >> PHY node properties.
> >
> > I'm actually not sure if this a property of the PHY, the PCIe host, or
> > of the combination of the two.
> >
>
> Latency is mostly related to propogation latency through SERDES PCS and
> PMA layers.
>
> > We thought about adding this property to the PHY, too, but we didn't
> > know how to handle cases where a single PCIe host is linked with
> > multiple PHYs for multi-lane configurations (see TI's AM65x for
> > example). Which PHYs latency would you use to configure this PCIe RC?
>
> On AM65x, all lanes go through SERDES of same design (but just different
> instances) and thus latencies will remain same across lanes as the PCS
> and PMA logics are same. So, the delays are not lane specific
>
> >
> > Personally I don't have a very strong opinion either way - we just
> > didn't know any better than to put this into the PCIe host that needs
> > it. If you think this is better put into the PHY node we can of course
> > send a new version of this patch.
> >
>
> I don't have a preference here...  Delays are dependent on PHYs being
> used but something that host needs, will leave it to framework
> maintainers.
>
> > Is there any binding that specifies "generic" PCIe properties, similar
> > to ethernet-phy.yaml? We couldn't find any.
> >
> > I guess in the AM64x case the "PHY" is serdes0_pcie_link below serdes0:
> >
> > &serdes0 {
> >         serdes0_pcie_link: phy@0 {
> >       ...
> >
> > This seems to be described by bindings/phy/phy-cadence-torrent.yaml.
> >
> > Should we add a generic (without cdns) tx/rx-phy-latency-ps property
> > there?
> >
> >> If PTM is a standard PCIe thing, then I don't think these should be
> >> Cadence specific. IOW, drop 'cdns'.
> >
> > Yes, it is a standard PCIe thing, but we haven't seen that many
> > implementations yet, so we didn't want to pretend to know what this
> > looks like in the generic case. We can of course drop 'cdns'.
>
> PTM is definitely standard and vendor specific prefix don't make sense
> to me.
>

Is there any chance you can send a revisited patch series or is there
anything missing for
you to continue?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
