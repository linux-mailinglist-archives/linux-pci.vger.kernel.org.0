Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749D6F3F8E
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEBIsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjEBIrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 04:47:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF334C19
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 01:46:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aae46e62e9so19418675ad.2
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683017175; x=1685609175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiQalyBCKoJzAGN9ygHoJ7Nfja67Oxy2+AA4JQPS0Pk=;
        b=kOuFAu58T3IPgNuNzVp5vCYh7hR6x44qFnuyjuSRIfLqqO0MHN5vtigFl/4id/LQVq
         f9b3pEh65z3oghVjzMcjeMOe6qEEWG37i5Pr72O440jxONR6H4uGh8jkayhV+Z/DE5UG
         7zCYXfRzRRjSjfnZWXed9evFK4oZhbwOd7IuL8X8/XbpDgyKuMbE5SdZ2BJfPzxgZDED
         1QIAn3JSzPflxYubseT69TnaL1bkMyVjF2KRYfUSHJLvZopFMBligxlqzHIcFi428JeL
         GkAlUCc/E2HY481Fgi/9gZArPY3Wlcmuv7LXpgcUOLiPojkd3p4Tw7rKT/63dODvb5wZ
         Vg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017175; x=1685609175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiQalyBCKoJzAGN9ygHoJ7Nfja67Oxy2+AA4JQPS0Pk=;
        b=If0+cjlP+bDhvTAn+ZyI0aMFkbK1/FV1xz2WGCvZIE0T6MwFv8R1htZj/Y4R+OX/dE
         ZGR3XDRDwtDG4aGqNG9cwHJT7KlgAxZEQWDds4jJmJ0Jbj4uDOpL5yX2ros1FS2ZvGvw
         kQUfswIG4RXeFwLcAavwvstb15AkVd4HY57Bx30IlqkHSh7m3Nj3mjQMnq9HdtSzQZIi
         P7cImnbFkbnASD79gdB2JrdGCPdNG7vY+SthYuz84UfqXmzl8EVI8Hw4rHXo+GJLLFEd
         i6GcV5uASUloDJ3f7L9+G44jBdAJIFJ4G+L2lGg+LBuQJ6eqwByXQuGmwKlgdItMTMtl
         /gvg==
X-Gm-Message-State: AC+VfDzuTo0zGc2XzdqCfhKqDzh0m9UBV/c/ZV0pypQN96n1k0drEuRq
        G1/xmuvvtibYH2so2G0ZwiJzzQ==
X-Google-Smtp-Source: ACHHUZ6I0qdjECptknquNNgpCQjBrs60RT5yKteV6HyLqYd2VSn4QOAnmQ+6LOEt3OVBlMYpUQ4hqA==
X-Received: by 2002:a17:903:2304:b0:1a1:dd2a:fe6c with SMTP id d4-20020a170903230400b001a1dd2afe6cmr17861325plh.53.1683017175023;
        Tue, 02 May 2023 01:46:15 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902969400b001a6e9d170b8sm19031044plp.265.2023.05.02.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:46:13 -0700 (PDT)
Date:   Tue, 2 May 2023 16:45:58 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] arm64: PCI: Add quirk for Qualcomm WoA devices
Message-ID: <20230502084558.GA2103@dragon>
References: <20230423030520.9570-1-shawn.guo@linaro.org>
 <20230428213027.GA363093@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428213027.GA363093@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 28, 2023 at 04:30:27PM -0500, Bjorn Helgaas wrote:
> [+cc Andy, Bjorn A, plea for help from Qualcomm firmware folks]
> 
> On Sun, Apr 23, 2023 at 11:05:20AM +0800, Shawn Guo wrote:
> > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > host bridge windows") introduced a check to remove host bridge register
> > resources for all arm64 platforms, with the assumption that the PNP0A03
> > _CRS resources would always be host bridge registers and never as windows
> > on arm64 platforms.
> 
> That's not quite what the commit log says.  The 8fd4391ee717
> assumption is that on arm64,
> 
>   - _CRS *consumer* resources are host bridge registers
>   - _CRS *producer* resources are windows
> 
> which I think matches the intent of the ACPI spec.

Yes, I will update.

> 
> > The assumption stands true until Qualcomm WoA (Windows on ARM) devices
> > emerge.  These devices describe host bridge windows in PNP0A03 _CRS
> > resources instead.  For example, the Microsoft Surface Pro X has host
> > bridges defined as
> > 
> >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > 
> >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >     {
> >         Name (RBUF, ResourceTemplate ()
> >         {
> >             Memory32Fixed (ReadWrite,
> >                 0x60200000,         // Address Base
> >                 0x01DF0000,         // Address Length
> >                 )
> > ...
> 
> > The Memory32Fixed holds a host bridge window, but it's not properly
> > defined as a "producer" resource.
> 
> I assume you're saying the use of Memory32Fixed for a window is a
> firmware defect, right?

Yes, I will reword.

> 
> (Per ACPI r6.5, sec 19.6.83, the Memory32Fixed descriptor cannot
> specify a Producer/Consumer ResourceUsage.  I think that means the
> space is assumed to be ResourceConsumer.)
> 
> > Consequently the resource gets removed by kernel, and the BAR
> > allocation fails later on:
> > 
> >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > 
> > This eventually prevents the PCIe NVME drive from being accessible.
> > 
> > Add a quirk for these devices to avoid the resource being removed.
> 
> Since this is a Windows laptop, I assume this works with Windows and
> that Windows will in fact assign BARs in that Memory32Fixed area.
> 
> If we knew what the firmware author's intent was, we could probably
> make Linux understand it.
> 
> Maybe (probably) Windows treats these descriptors the same on arm64 as
> on x86, i.e., *everything* in PNP0A03 _CRS is assumed to be "producer"
> (at least, that's my experimental observation; I have no actual
> knowledge of Windows).

That's my bet too.

> 
> So I guess 8fd4391ee717 must have been motivated by some early arm64
> platform that put "consumer" descriptors in PNP0A03 _CRS as Lorenzo
> said [1].
> 
> In that case I guess our choices are:
> 
>   - Add quirks like this and keep adding them for every new arm64
>     platform that uses the same "everything in PNP0A03 _CRS is a
>     producer" strategy.
> 
>   - Remove 8fd4391ee717, break whatever early arm64 platforms needed
>     it, and add piecemeal quirks for them.
> 
> I hate both, but I think I hate the first more because it has no end,
> while the second is painful but limited.

Thanks for your opinion on this!  Let's try to pursue the second then.

> 
> Obviously we would need to do whatever we can to identify and fix
> things that depend on 8fd4391ee717 before reverting it.

Lorenzo,

I have zero experience on any of those early arm64 platforms.  I would
appreciate it if you can give some direction on how to identify them.

Looking at your comment below, I'm wondering if it's true that the
firmware on those early arm64 platforms has no MCFG table but provide
root->mcfg_addr via _CBA method?

"I believe it is because there were arm64 platforms (early) that added a
consumer descriptor in the host bridge CRS with MMIO registers space in
it (I am not sure I can find the bug report - it has been a while,
remember the issue with non-ECAM config space and where to add the MMIO
resource required to "extend" MCFG config space ? I will never forget
that :))."

It would be very helpful if we can find someone running any of those
early platforms, so that we can ask favor to dump ACPI tables and test
things out.

Shawn
