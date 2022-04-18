Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C19505C54
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbiDRQUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbiDRQUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 12:20:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457582CE2B;
        Mon, 18 Apr 2022 09:17:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f19fdba41fso18692317b3.3;
        Mon, 18 Apr 2022 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGWxv/qota/JshJiLK9mcfcLcUXUwT9NkI4w3aXnwsE=;
        b=BRLJRAM6c4CTKa9943BLdzY274Da7Gk76ZH+uFpSX6pUtz6TPcxsEk/jNKjVOuMN+a
         HcEP9XqzUKeT06kLFtfKlWdNwbU+wkAWwhFub0lyjCq9Opij8cKGZfczmS0M4uzEGLJF
         +59kT9/fyltIEL1RVB9BW8W81FABIUsmVd9couP7iIcapJoY5P5Gh9jgvqIvOtr//bPk
         7zvJfX4X7uyKiTRopzYzY4n/uwrjXG+DDsYNVvf7hnBs4br/ON6llX48ghv2JqmRtWpT
         kOq71eBViGMD6nnTUISoAsAqmbCBxV/pbZriCXqo79zTuKs02sNMuKZYqENpYYCIAOML
         zEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGWxv/qota/JshJiLK9mcfcLcUXUwT9NkI4w3aXnwsE=;
        b=Rbdbsj5X3FOpEi/oLaFPAkNjTTRWBcICfDFkOdfNRxlq/qhbZ14ZUaV48Cj3j8rroV
         I9LrYAX9+DhyRrXRKJFjn5aByM0oC1rmPeu1hEi/QollpsTSB6Rhd4hGj047E+aVz8OO
         qbBJqP1B83hU7BYBMStT5WGoGwmuq0LdAdTmpGmd1r9TqubCdIWinXe8ot3zsg/EhEz4
         uBGfaCC+is7CA8mLChpewKWMQu072Xc0fA/x5qOV9OKj6ZA2LyGjWVTq5+aiM5k8FBBO
         kQuQx5xLURCxe98YdB769x7G27bpU7mYiTdzY0Pv9rTqd1hddUBT1W3/2XqUSEwyK1lF
         XpBg==
X-Gm-Message-State: AOAM530pe/RmrAA6j7vE+SvRVx0IDqKYNs64/FfW+9Ucw4bD6ouzd6lp
        5Kky45+KmgL+Zvzn5bcoeHDkKp0/kvGzUJ7L9rU=
X-Google-Smtp-Source: ABdhPJx2IFxxyKsz/E+/vX5yjPGTf8jxveTP2m6H/pqXXpMrMGVz4/s/MMOE1+sNXpE6i7CO0eSsyT8JQa0WRfWGhSc=
X-Received: by 2002:a81:5904:0:b0:2eb:f900:882e with SMTP id
 n4-20020a815904000000b002ebf900882emr10602126ywb.281.1650298662641; Mon, 18
 Apr 2022 09:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-a220fd81-2ee9-474d-bd65-505b9ed904b2-1650186482865@3c-app-gmx-bs58>
 <20220418155313.GA1101563@bhelgaas>
In-Reply-To: <20220418155313.GA1101563@bhelgaas>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 12:17:31 -0400
Message-ID: <CAMdYzYpydGyQZT2n9Tf+ccQMLHzfhOgoyamMgspQDcjzm3Umdg@mail.gmail.com>
Subject: Re: Re: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 11:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Apr 17, 2022 at 11:08:02AM +0200, Frank Wunderlich wrote:
> > > On Sat, Apr 16, 2022 at 03:54:56PM +0200, Frank Wunderlich wrote:
> > > > From: Frank Wunderlich <frank-w@public-files.de>
> > > >
> > > > PCIe Lanes can be split to 2 slots with bifurcation.
> > > > Add support for this in existing pcie driver.
>
> > > Is the "rockchip,bifurcation" DT property something that should be
> > > generalized so it's not rockchip-specific?  Other controllers are
> > > likely to support similar functionality.
> >
> > I do not know if other controllers support similar functionality,
> > but i ack a property without vendor prefix is better. Should i use
> > "bifurcation" as name or do you think about a different name which
> > is more generic?
>
> Really a question for Rob about what name would be good and where it
> should go.

It might be good to define this as a lane map.
In the Rockchip implementation it's only 2+0 or 1+1, but that isn't
guaranteed if this is made into a standard definition.
So perhaps:
pcie-bifurcation-map = <0>, <1>;
pcie-bifurcation-map = <1>;
pcie-bifurcation-map = <4>, <5>, <6>, <7>;
