Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAC6A6047
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjB1UV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 15:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjB1UV4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 15:21:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F334C22
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 12:21:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so1402931wms.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 12:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47lTjHx+oRbLgh0ixd2904/xBmki05B5JimnvDPdC1s=;
        b=iaR2tdEAJMqpeBCdU0JxELeCFr6kEm9ptId5w9RgZJ8MRysc1q//nuDZy3xXl6NW1f
         6VrG8LEcbVf/TuEGgXXwxvwLqrmXnZCTeT5KgsMkzyyScHLhI+JrMXu+DjSS6r3jUTLF
         EyQqEJ5DiTB+5gsuGHNTXU8naKNo2g5Vlv/DwSxAIFa+P1HCFkFFNse5L1IrLyFeOL9w
         HAHWoRK46XqlkwfR2PmCzppOlSe9m8/OyrosoIQdLpijyfxPuGY008R8PNGejKx0nciR
         CfMaQOXL+k4BNJDqDKjmR2X7h1cKGm5Y6Tx/WDq9GkZvFRSa1nsLCDQHa12gCcS/BZhM
         MZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47lTjHx+oRbLgh0ixd2904/xBmki05B5JimnvDPdC1s=;
        b=wNdt9nXCGLZjSG9wUpr740+KqZINWDnImMvk7cF9VaTA/TqrBg8Y+pxgJTedR+mD1i
         Fx5StOU2ps4t6HSvfskLF9BtyVwTuYcx6ekWuddRhuWYKmxNXX0M96X8Uh8f/6wLCjBM
         B7TWj8KOVONWtmuOEX0iFi/+9qebPpmQgD4zvDlYdSvDlgNdAVGn0H+wEtOrT3OSHi2R
         xSwRuIlWYP9YqSExfODbSHb5jHy4+YXvklcqEGd2RkJ2bjhT+TrDclxJ220VUNgkY60f
         KnKnFTKGU6kmZzoZILbjgoNyAI5t2HS6Wo9mtCO9KnE+ddUMj2Vkd8T5pSSJCIgN4aaA
         jjUQ==
X-Gm-Message-State: AO0yUKX/a1JPFbt/5epujWSm2HzAk7ZoYMaoLX/LicLLd+oJIx1XF2aJ
        pOAZgJ90Uzf+SUFQlwA/sjMQYm/etKbAU2c7BTF5Wqqr
X-Google-Smtp-Source: AK7set/wvZwLy7JJyhSnWARVSLvcHqeTlaf0US3t/Dbkmt8lLKvVcRV/v9+5Th9J2uehNmNYNRbbI/7pYTkeowOFy9M=
X-Received: by 2002:a7b:c2a1:0:b0:3e1:787:d706 with SMTP id
 c1-20020a7bc2a1000000b003e10787d706mr1141316wmk.2.1677615710838; Tue, 28 Feb
 2023 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <bug-217100-41252@https.bugzilla.kernel.org/> <20230228124427.GA114786@bhelgaas>
In-Reply-To: <20230228124427.GA114786@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 28 Feb 2023 15:21:38 -0500
Message-ID: <CAMdYzYrSiBD3gKxKjufo=LM6d6Si9QmcZdfBn1MT3tdU3yFW8w@mail.gmail.com>
Subject: Re: [Bug 217100] New: Bifurcation between pcie3x1 & pcie3x2 doesn't
 work in RK3568J.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, smalltalk@swismail.com,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Kever Yang <kever.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
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

On Tue, Feb 28, 2023 at 7:44 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Feb 28, 2023 at 08:53:50AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217100
> >
> >            Summary: Bifurcation between pcie3x1 & pcie3x2 doesn't work in
> >                     RK3568J.
> > ...
>
> > Hello.
> >
> > First, I want to say that pcie3x1 crashes if started before pcie3x2 . Driver
> > > pcie-designware.c
> >
> > in function
> >
> > > void dw_pcie_version_detect(struct dw_pcie *pci)
> >
> > tries to read parameter from dbi register (PCIE_VERSION_NUMBER) and fails on
> > it.
> > So I changed sequence of declaration PCIE in rk3568.dtsi: first - pcie3x2 next
> > pcie3x1. Now Linux first starts pcie3x2, then successfully starts pcie3x1.
> >
> > But main problem is that bifurcation in phy driver
> > > phy-rockchip-snps-pcie3.c
> >
> > doesn't work. I tried add next lines in function
> >
> > > static int rockchip_p3phy_probe(struct platform_device *pdev)
> >
> > right after block check
> >
> > > if (priv->num_lanes == -EINVAL) {
> > > }
> >
> > > priv->num_lanes = 2;
> > > priv->lanes[0] = 1;
> > > priv->lanes[1] = 2
> >
> > And driver writes during Linux boot process that bifurcation is enabled, but
> >
> > lspci
> >
> > does't show second device.
> >
> > Best regards,
> > Anton.
>
> Thanks much for your report, Anton.  People don't really pay attention
> to the bugzilla, so I'm forwarding this to the mailing list and to
> some folks who've worked on that driver in the past.
>
> MAINTAINERS doesn't list an entry for pcie-dw-rockchip.c; I'm not sure
> if that's an oversight or if nobody cares enough to actually maintain
> it.

Good Afternoon,

That bug report leaves a lot to be desired. Configuration of the phy
must be completed correctly in the dts or the pci controller will hang
and / or crash depending on kernel configuration parameters.
Bifurcation is not automatic.

At a minimum we need to know what device they are attempting this on
as well as the full dts they attempted to use. A full kernel log would
also be helpful.

Very Respectfully,
Peter Geis

>
> Bjorn
