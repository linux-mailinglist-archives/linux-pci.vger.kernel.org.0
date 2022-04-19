Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A2506FE1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiDSOPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbiDSOPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 10:15:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF13969C;
        Tue, 19 Apr 2022 07:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 381B5B819C9;
        Tue, 19 Apr 2022 14:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC990C385AC;
        Tue, 19 Apr 2022 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377584;
        bh=yDWQVAT2dNyumJPz6fdK9EKnm8gIEm5qzxaXnkCoDbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BUBx5TonBG0bQ43yXOEavy812RWmAJJvRuFPL9Y/Nn4rTnL3jXcUH178WQfbhmrMu
         PLrX6yZhrGfFoFmPt6+ZEZpAD7lIb40mz5YQ8FfeNkYohpX7k91eGGJUaAGymZOuOC
         ehfDTAcuHAZWwaimkoikPbdAa9A5hULDjRIIYN8Ya1TVFKIIRqi42/rQLYvvvaZ0kO
         WMGvh8WATLJ5Ri7KnGhhlkMjMYBvGXk9UcGZj489Y0RGJeVH2XhG+zguGoUvyuMxBR
         HVZk6AHZf/iMjS8P3lmwodSU4lkj7nvYKA6gTtDcGDOP38WkldW/csbxuZEUySDiAZ
         v70317ry0/5AA==
Received: by mail-pj1-f41.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so1987676pji.4;
        Tue, 19 Apr 2022 07:13:04 -0700 (PDT)
X-Gm-Message-State: AOAM531XkEacW4OV7BX9ibszP56Frg0p04QRGk5/ASbWngx+MY1hf8kg
        PDb45km5HR5n+76Wr6lKSRE3cQW4V7oYvtuF4g==
X-Google-Smtp-Source: ABdhPJxpXMT3twN8wyuejEm0cAlv+Z/bvyWYx918m06lH56Hz4v9qLR91rKga42zYt2zKC0BUgqh/dx5Lsqo4CdAZWs=
X-Received: by 2002:a17:90a:db16:b0:1cb:9ba8:5707 with SMTP id
 g22-20020a17090adb1600b001cb9ba85707mr24787066pjv.32.1650377584301; Tue, 19
 Apr 2022 07:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <91ef84f9-4cac-c0aa-c717-7f1b3bc566fb@xilinx.com>
 <20220414164508.GA753109@bhelgaas> <CH2PR02MB6952D1D0E6FA89ED25110AFFA5F29@CH2PR02MB6952.namprd02.prod.outlook.com>
In-Reply-To: <CH2PR02MB6952D1D0E6FA89ED25110AFFA5F29@CH2PR02MB6952.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Apr 2022 09:12:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJynvpmdF2cBFDQ3og4zgrx9UFtj4NkGUV20f61yc+YtA@mail.gmail.com>
Message-ID: <CAL_JsqJynvpmdF2cBFDQ3og4zgrx9UFtj4NkGUV20f61yc+YtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 19, 2022 at 7:22 AM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
>
> > On Thu, Apr 14, 2022 at 02:46:25PM +0200, Michal Simek wrote:
> > > On 4/14/22 11:22, Bharat Kumar Gogada wrote:
> > > > Removing unnecessary version number in compatible string.
> > >
> > > I am missing reason for this in commit message.
> >
> > Agreed.  The commit log for the pcie-xilinx-cpm.c change also needs to
> > explain why removing the version is useful and safe.
>
> HI Bjorn, Michal,
>
> The CPM block is hard block, Rob pointed out that versioning has no value here.
> Will resend patch with this detail.

I did not say to remove the existing version breaking compatibility.
Just don't continue to add new version numbers.

Rob
