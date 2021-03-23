Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92D93465CF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhCWQ7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhCWQ6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 12:58:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439DC061574;
        Tue, 23 Mar 2021 09:58:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l3so14938600pfc.7;
        Tue, 23 Mar 2021 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q6HLBdpORj52B/QlxfKOriW3XwZYRHdxIv9lX/34Xow=;
        b=DC1l5KdJxmXpfR6SVLRhu8CVDSEPw6lc4Z/Hndn7FKXYmJ5Onzds3ErTQCbRQZ14+5
         qjFY8dudrNJk/AjtLFl1EcJau02+ZX7CLSeVqmJs2T/DcTWHJ/dQ3T0AVC51eoF2dcLU
         74KtM5gB7lrbVg14MMyRFb8QaxxxUNPM0r+WnzCDo6CqTIDxP3pJV0+8piz0XrnkPknp
         12JFpIlEJ7jKnbLXFk0t1xAEoyFg7kvwiY4xfw4vAAJWCXg8+MSvJW1aaomQ9yW5Ye1g
         Itdu4kVmwtaL/FjZxxEwW+Mzl5ok4B1xTXkvQCl98b/Atu7yj7D3+v5w/A9FlnuhD+GR
         Gddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q6HLBdpORj52B/QlxfKOriW3XwZYRHdxIv9lX/34Xow=;
        b=AgonEKaR2XwfXMQCi5JiqKWlQE77zMp8T5Gq6rBK9y5ysjiHEmIOwp8p2cJoHLWdjl
         FHfaXIyEFkjHSmSSvkIERm92MpqwZ7Xf8p1NFOx3mxKM79FqmvkOmRrXz00kbVTeX/zy
         SHMfhOwJQ3T1Ic7JO60+pR34nnUwtFBcRdJX8HQ0iCnAcj6UiuwbqxJ89Bp6YUlS7GZP
         uFqms8ix1eFu2NW0ATkmKTJK+Fg6N5/AclT9kiZDnyud5uugHAyWmIWDLLvz33Ciq6oP
         f57MnANpxOUyzvjt6ZHnnRE6+bAVUyAlsVb0nVcXlJqxpGQxOgadLkWUntDgWfo2Uznt
         XMJg==
X-Gm-Message-State: AOAM531Nd/VrRhQfXcoxEL2tV1hBF0N55flUn7gc+8mu6ObYNpO21EFl
        CYqnhQrPaquQAvezifFdBG4=
X-Google-Smtp-Source: ABdhPJw9KiqlaeOJI2rlUyzZOufuqJd/B5r/EWkgsH3sUfJoLdASbIs1eBjfLkKF2FJFS04oRnWmhA==
X-Received: by 2002:a17:902:cecf:b029:e6:ac65:4680 with SMTP id d15-20020a170902cecfb02900e6ac654680mr6858615plg.64.1616518717093;
        Tue, 23 Mar 2021 09:58:37 -0700 (PDT)
Received: from localhost ([2401:4900:5298:bb2f:6d40:6041:a658:f52a])
        by smtp.gmail.com with ESMTPSA id b3sm3171129pjg.41.2021.03.23.09.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:58:36 -0700 (PDT)
Date:   Tue, 23 Mar 2021 22:27:49 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     alex.williamson@redhat.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, kabel@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: How long should be PCIe card in Warm Reset state?
Message-ID: <20210323165749.retjprjgdj7seoan@archlinux>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
 <20210323161941.gim6msj3ruu3flnf@archlinux>
 <20210323162747.tscfovntsy7uk5bk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323162747.tscfovntsy7uk5bk@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/23 05:27PM, Pali Rohár wrote:
> On Tuesday 23 March 2021 21:49:41 Amey Narkhede wrote:
> > On 21/03/10 12:05PM, Pali Rohár wrote:
> > > Hello!
> > >
> > > I would like to open a question about PCIe Warm Reset. Warm Reset of
> > > PCIe card is triggered by asserting PERST# signal and in most cases
> > > PERST# signal is controlled by GPIO.
> > >
> > > Basically every native Linux PCIe controller driver is doing this Warm
> > > Reset of connected PCIe card during native driver initialization
> > > procedure.
> > >
> > > And now the important question is: How long should be PCIe card in Warm
> > > Reset state? After which timeout can be PERST# signal de-asserted by
> > > Linux controller driver?
> > >
> > > Lorenzo and Rob already expressed concerns [1] [2] that this Warm Reset
> > > timeout should not be driver specific and I agree with them.
> > >
> > > I have done investigation which timeout is using which native PCIe
> > > driver [3] and basically every driver is using different timeout.
> > >
> > > I have tried to find timeouts in PCIe specifications, I was not able to
> > > understand and deduce correct timeout value for Warm Reset from PCIe
> > > specifications. What I have found is written in my email [4].
> > >
> > > Alex (as a "reset expert"), could you look at this issue?
> > >
> > > Or is there somebody else who understand PCIe specifications and PCIe
> > > diagrams to figure out what is the minimal timeout for de-asserting
> > > PERST# signal?
> > >
> > > There are still some issues with WiFi cards (e.g. Compex one) which
> > > sometimes do not appear on PCIe bus. And based on these "reset timeout
> > > differences" in Linux PCIe controller drivers, I suspect that it is not
> > > (only) the problems in WiFi cards but also in Linux PCIe controller
> > > drivers. In my email [3] I have written that I figured out that WLE1216
> > > card needs to be in Warm Reset state for at least 10ms, otherwise card
> > > is not detected.
> > >
> > > [1] - https://lore.kernel.org/linux-pci/20200513115940.fiemtnxfqcyqo6ik@pali/
> > > [2] - https://lore.kernel.org/linux-pci/20200507212002.GA32182@bogus/
> > > [3] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
> > > [4] - https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/
> >
> > I somehow got my hands on PCIe Gen4 spec. It says on page no 555-
> > "When PERST# is provided to a component or adapter, this signal must be
> > used by the component or adapter as Fundamental Reset.
> > When PERST# is not provided to a component or adapter, Fundamental Reset is
> > generated autonomously by the component or adapter, and the details of how
> > this is done are outside the scope of this document."
> > Not sure what component/adapter means in this context.
> >
> > Then below it says-
> > "In some cases, it may be possible for the Fundamental Reset mechanism
> > to be triggered  by hardware without the removal and re-application of
> > power to the component.  This is called a warm reset. This document does
> > not specify a means for generating a warm reset."
> >
> > Thanks,
> > Amey
>
> Hello Amey, PCIe Base document does not specify how to control PERST#
> signal and how to issue Warm Reset. But it is documented in PCIe CEM,
> Mini PCIe CEM and M.2 CEM documents (maybe in some other PCIe docs too).
>
> It is needed look into more documents, "merge them in head" and then
> deduce final meaning...
Okay so PCIe CEM revision 2.0(from 2007) on page no 22 says-
"On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL)
from the power rails achieving specified operating limits.  Also, within
this time, the reference clocks  (REFCLK+, REFCLK-) also become stable,
at least TPERST-CLK before PERST# is deasserted."

Then below it says-
"After there has been time (TPVPERL) for the power and clock to become
stable, PERST# is deasserted high and the PCI Express functions can start
up."

And then there is table of timing on page no 33-
Symbol 		Parameter 				Min
TPVPERL 	Power Stable to PERST# inactive 	100ms
TPERST-CLK 	REFCLK stable before PERST# inactive 	100μs
TPERST 		PERST# active time 			100μs
TFAIL 		Power level invalid to PERST# active 	500ns
...

I agree this is confusing.

Thanks,
Amey
