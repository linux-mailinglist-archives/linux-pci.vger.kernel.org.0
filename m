Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55C567E75
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiGFG2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiGFG23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 02:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D185BD4;
        Tue,  5 Jul 2022 23:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F31B361D5E;
        Wed,  6 Jul 2022 06:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581B6C341CB;
        Wed,  6 Jul 2022 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657088903;
        bh=uf62HvexVvB/Jx636o0MTt6E8hWMJQJNNvtBTXI9zxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=inhfUNQ4eoL/s3BvkLPhTfpTXUyY3Um/ynU4oJD6fAmIxr2da4mvIonLnOhuSE4S2
         xtZP1F+/IckpFSk/VgPIzcAqZkbDucMs7Mwt269DQmrASyWxH1jz5dlJhigA9w4IS3
         sIVpag65QuzZlPt16iddFyqWtX2jf1iUgUY3Dj13lPQHv77T4rI3PEGveVNYrQDSys
         7j1SF3T2ZYRiqhQYlPwUl9Df1AiJ5HwwbFJyc3spw8U7bgRzuwET2oMjNC3Xwscppg
         Sx+T7CWGyUyzWAwoglJNoQsumuM/CoylPF49jeuhM40LsjboVZKd2HrG4IVq/xw/y7
         8Xxe+2nH7yCPg==
Received: by mail-ot1-f42.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so11262885otk.0;
        Tue, 05 Jul 2022 23:28:23 -0700 (PDT)
X-Gm-Message-State: AJIora8VKfocbtKsyAx8IKw1nJKLqsh43ZHb8pTC4omXWPfSYyyGIagQ
        1CyGeT7BVTT+d6rP+iZWZsCFCWfH8UxK5IEX7QI=
X-Google-Smtp-Source: AGRyM1utRDa88CHhHTp5mP603IgAR57zrfhTLhegc113/GcO7yyNAJfXIpPN9E4szsM0k5P00ekmC12Kbd2fKlOgQfk=
X-Received: by 2002:a05:6830:d0d:b0:616:99da:1fb0 with SMTP id
 bu13-20020a0568300d0d00b0061699da1fb0mr16396323otb.109.1657088902445; Tue, 05
 Jul 2022 23:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p4>
 <20220706052217epcms2p444cc8608b21d483a66a43ecf4f2140d4@epcms2p4>
In-Reply-To: <20220706052217epcms2p444cc8608b21d483a66a43ecf4f2140d4@epcms2p4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 6 Jul 2022 08:28:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfA_5a9bfx5=p=2qj1GxLRxt-1WsHwPfT3iho48mxiANw@mail.gmail.com>
Message-ID: <CAJKOXPfA_5a9bfx5=p=2qj1GxLRxt-1WsHwPfT3iho48mxiANw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
To:     wangseok.lee@samsung.com
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Jul 2022 at 07:22, Wangseok Lee <wangseok.lee@samsung.com> wrote:
>
> On 05/07/2022 19:59, Krzysztof Kozlowski wrote:
> > On 29/06/2022 09:18, Wangseok Lee wrote:
> >> Just a gentle ping for this patch, if any concern on this patch please let me know.
> >>
> >
> > You received comments to fix in this patch. Exactly four. Four important
> > points to fix. Therefore what is this ping about?
> >
> > Without fixing these items, your patch cannot be accepted. What is more
> > to ping here?
> >
> > Best regards,
> > Krzysztof
>
> I tried to receive your opinion about the fix point .
> I will request a review again after modifying it in the next patch.

But there was no quote about any fix point in your message. You
replied on top of it so there was no reference to any previous topic.

Best regards,
Krzysztof
