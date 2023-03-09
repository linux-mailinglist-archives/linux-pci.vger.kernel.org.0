Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7586B199C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 03:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCICws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 21:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCICwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 21:52:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128297FF8
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 18:52:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so784639pja.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 18:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678330343;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5Th4ezi2JLIwi7eXgKdUNLkPeZJxmBPYFrzOKORyYI=;
        b=zshNKuLrllaWY+2TQVkDsSi6bkHt2ZAnqw5shYeTatNjWSWHQFxu/6ctZJ/P1BDPNE
         8OdvScnv9ovgnQpjMxPfHN7bGd86ZU/XTVlBM2bDJCJogsXWYnzC54rfGZrTidh1Zjwd
         SBPp0MpO+G9BbchFcJfcU/zb7MNWQWbB7EHOlMUVijztPdTeRGj2EZNckhtEuLx+mC6W
         z/OCfK24jblkBtS5kRjYzhqpQEzTUskI/1toc1RoXg89GvC0CQaSVV9AQoIrmujIzi02
         JLhl1bOW8Bj64YA4RJMHvsqJaRF0wSxD8hHH+EWHGaDc3UmvtzEJ5L5FJOOt+F4XxtVe
         baAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678330343;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5Th4ezi2JLIwi7eXgKdUNLkPeZJxmBPYFrzOKORyYI=;
        b=FIvFqpC6kRuTSlKKpT3CcbzT1oI9tzyV0jx5llTUty0g7bvv6OBb/RcmftanYOcQci
         Hd8R/O7fUMh2VEkVWrLiU37PePLEvdlflzj0YEgXe6omFkxM8zqCiaHR+LQ9dgmFb7bv
         oIeZKVZParmhxAGA2m3Gsc/NTAxJatXSMqyeKleg8pAj/7AlWZvjoWkJYzDxQ1Msya2l
         unMLOovSmAHAqpDWLg9u/I6akX3fZKHXLjeGyadd9kTQlrrKULF3+ZV6Zmi+mDwnG6Y3
         l9+6D2kbVhV3DKwqnde+EH4lwCuiqFKKNZFqeo8uFYCMVNcCpn3WPuT9dJU/OSGwgzB2
         MtKQ==
X-Gm-Message-State: AO0yUKW0/LoTEerC0KAsP5H20t0sQyiOjVnBi/0Pocsb1+rkoeDoEZB+
        nUox/PIBsNndlmz67tcaGwBRYg==
X-Google-Smtp-Source: AK7set/506rAh498pfYZpAHNlgO/8W9KnvcLLm96NcVxAazQSKNg9B8FzpR+Y9lB+gbmoIWJZCqb6Q==
X-Received: by 2002:a17:903:441:b0:19e:7d51:3a41 with SMTP id iw1-20020a170903044100b0019e7d513a41mr18047647plb.69.1678330343429;
        Wed, 08 Mar 2023 18:52:23 -0800 (PST)
Received: from T480 (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ab8200b0019e60c645b1sm10395624plr.305.2023.03.08.18.52.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Mar 2023 18:52:22 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:52:13 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Message-ID: <20230309025212.GB18319@T480>
References: <20230227021221.17980-1-shawn.guo@linaro.org>
 <20230308185310.GA1030878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308185310.GA1030878@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-arm-msm and MSM maintainer Bjorn

On Wed, Mar 08, 2023 at 12:53:10PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2023 at 10:12:21AM +0800, Shawn Guo wrote:
> > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > host bridge windows") introduced a check to remove host bridge register
> > resources for all arm64 platforms, with the assumption that the PNP0A03
> > _CRS resources would always be host bridge registers and never as windows
> > on arm64.
> > 
> > The assumption stands true until Qualcomm Snapdragon Windows laptops
> > emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
> > resources instead.  For example, the Microsoft Surface Pro X has host
> > bridges defined as
> > 
> >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
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
> >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> >                 0x0000,             // Granularity
> >                 0x0000,             // Range Minimum
> >                 0x0001,             // Range Maximum
> >                 0x0000,             // Translation Offset
> >                 0x0002,             // Length
> >                 ,, )
> >         })
> >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> >     }
> > 
> > The Memory32Fixed holds a host bridge window, but it's not properly
> > defined as a "producer" resource.  Consequently the resource gets
> > removed by kernel, and the BAR allocation fails later on:
> > 
> >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > 
> > This eventually prevents the PCIe NVME drive from being accessible.
> > 
> > Add a quirk for these platforms to avoid the resource being removed.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > We are running into the issue on more devices than just Surface Pro X
> > now, so trying to sort it out with a quirk as suggested by Lorenzo [1].
> 
> One thing I don't like about this application of quirks is that the
> list of affected platforms is likely to grow, which is an ongoing
> burden for users and developers.

It's a very reasonable concern.  I really hope that Qualcomm will start
thinking about Linux support on these machines in the future not too far
away, so that the list will not grow too long.

> Can we have a conversation with Qualcomm about how they *intend* this
> to work?  Linux is probably doing something wrong (interpreting
> something differently than Windows does), and if we could fix that, we
> have a better chance of future platforms working without quirks.

Today Qualcomm only ships and cares about Windows on these machines, but
I believe it will change sooner or later.

Shawn
