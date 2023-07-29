Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D28767B71
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jul 2023 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjG2CDA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 22:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjG2CC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 22:02:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2A100;
        Fri, 28 Jul 2023 19:02:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so41035181fa.2;
        Fri, 28 Jul 2023 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690596176; x=1691200976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNeYYEAYiaR9Cb0tSj/jbWg7rilIA/g/CnHkEspzBrQ=;
        b=QVSTGwUbeNcVofqaMfPuUO1DHfMHY90hgV9NX7/olHRG8VCtqwB+WcG87k2ceZU8Nw
         Vy/BCKBJDDuj2fcR8O9prxPfcPCpcm/jGxd6+77uCaxRQvvFsQK/azZ6DmsSC16hbfrp
         lpyccGSqlZ0dgTHB6BRDdSrWvQreFOe6S1lnovHCK9YY/FqMPJlTJY2ogX0kEu7/3r7V
         dW6dih6D30ZmlyEbJ6zn69X+3X9/ZYwdSGuhLOQoTyL9mOB4tG6Nvid8D1CjWZ/5fCdC
         EZRIhnrk0ethUH+QCU8Lg8C4sT5z9wASpIRjNxhxyY62k2TlVmm+TZgh/bUgwxzwiCHp
         4RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690596176; x=1691200976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNeYYEAYiaR9Cb0tSj/jbWg7rilIA/g/CnHkEspzBrQ=;
        b=IOxSrS/xeDBztokafILMwEcEAaL2zooo1Vgm8Aifr9p4+X9vW3DHYGVwGtpCw8VnAv
         551APwIu+nBfTgVJAnphXWXdVPSPtONqADZlGTXmNZrS1wyXEImzmh3Cfbcad9+bQfIM
         Z+BQllu2AUNd/Qe0GCJMT993iundx/M56O/kEBHWJbWu8MVcptvp+s5OSspAnFdd3YJT
         9RpSLbX1kWoUQ0hLV2WuTEkKnPIp/dGG5LHT5v0ZdHIc689Jxpn3bCX4bofOrtYhIUkh
         /FATt09HzB2tWc9JUpJfbVeLcuQeuIi2AMiuPZ17P6whedeAlyY6bM3svLr3ErTK7WCz
         HCZQ==
X-Gm-Message-State: ABy/qLYzuAdkMiLI+YaCfjja+/wOb3DNcFPs7S3VXYocqQkREibvVxfD
        Q+Hn5R8omDqlH4rJDZWFzOePCEtIL2O4mQ==
X-Google-Smtp-Source: APBJJlFgRJI+GGSZp4VuAIyU95dnYy3YhUfEAaFG400mSJIZ52Nov/Ie106QzmtE9/yxeykIfHBcGw==
X-Received: by 2002:a05:6512:2520:b0:4fb:9d61:db4d with SMTP id be32-20020a056512252000b004fb9d61db4dmr3806309lfb.18.1690596176174;
        Fri, 28 Jul 2023 19:02:56 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id i28-20020a056512007c00b004fcdd81355csm1036230lfo.269.2023.07.28.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 19:02:55 -0700 (PDT)
Date:   Sat, 29 Jul 2023 05:02:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v18 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Message-ID: <xza3xtnlfznjqmjjms3gee5rqbyubtuu4yu6glowmir3z25umr@dss3i2lbfbgc>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-3-yoshihiro.shimoda.uh@renesas.com>
 <6e88938f-5cb7-96c8-681e-0e929ace4517@kernel.org>
 <20230724073211.GB6291@thinkpad>
 <guakfqdncogablbr6e72xx65ssbqoz536fykegnnea7zel4bho@qyreizjysvoy>
 <ef9026be-4b46-a267-704c-8ea29cd534f0@kernel.org>
 <dea62385-7f3a-9396-dcec-4a743bda0fca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea62385-7f3a-9396-dcec-4a743bda0fca@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 29, 2023 at 10:58:46AM +0900, Damien Le Moal wrote:
> On 7/29/23 10:55, Damien Le Moal wrote:
> > On 7/29/23 10:35, Serge Semin wrote:
> >> On Mon, Jul 24, 2023 at 01:02:11PM +0530, Manivannan Sadhasivam wrote:
> >>> On Fri, Jul 21, 2023 at 05:10:27PM +0900, Damien Le Moal wrote:
> >>>> On 7/21/23 16:44, Yoshihiro Shimoda wrote:
> >>>>> Using "INTx" instead of "legacy" is more specific. So, rename
> >>>>> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> >>>>>
> >>>>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> >>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >>>>> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> >>>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> >>>>
> >>
> >>>> I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
> >>>> PCI_IRQ_XXX macros used everywhere. Less definitions :)
> >>>>
> >>>> See attached patch that I have in my queue (about to send that).
> >>>>
> >>>
> >>> It looks better! This patch should be dropped.
> >>
> >> Back then Bjorn specifically asked to change the names suffix in a
> >> preparation patch before adding the INTx support to the DW PCIe core
> >> driver (see the Sb tag in the patch log). Damien, seeing you cleanup
> >> the names anyway what about fixing the macro suffix too: INTx instead
> >> of LEGACY)?
> > 
> > Sure, I can do that. That is going to be a gigantic patch though given that
> > PCI_IRQ_LEGACY is used well beyond the ep/pcie controller drivers.
> > While I agree it would be nice to do, not sure it is worth such code churn.
> > 
> >> Mani, Damien, what do you suggest to Yoshihiro to do with the
> >> LEGACY/INTx names in the following up patches of this series?
> > 
> > If everyone is OK with the patch I proposed (the PCI_IRQ_LEGACY -> PCI_IRQ_INTx
> > change can go on top), then I can rebase it and send it next week (the remaining
> > of my EP cleanup series needs some more testing & rebasing). Yoshihiro can
> > either include it in his series or rebase on it if the patch is added to
> > pci-next quickly.
> 
> Note that we could start by simply defining an alias:
> 
> #define PCI_IRQ_INTx	PCI_IRQ_LEGACY
> 
> and gradually convert all drivers using it until we can get rid of PCI_IRQ_LEGACY.
> 
> That probably would be simpler than a treewide patch that would likely create
> lots of conflicts.

Sounds good to me. Though it's better to wait for the Bjorn opinion
about that before moving forward with the implementation.

-Serge(y)

> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
