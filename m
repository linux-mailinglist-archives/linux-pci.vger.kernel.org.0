Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75841501E1E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 00:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbiDNWPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbiDNWPI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 18:15:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E4BA327
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 15:12:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s8so5991676pfk.12
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zYUHvRKfkdjRLFK3/CH/9P1TIGF1Q+ZicVfnGSNZbtQ=;
        b=h7cJqiwetiGHvy16aJqEPAMdNWjKEKQ11taWEHXHAKIrsZnC/uWk0/kOnmc+xupHaJ
         L8Z9lHMIwClyOvcEmaljSI1xDVBSA7ia76BJNq9XMku0Odol6O5A+S7sOyntimIB74+c
         DIZMiL1FWlLPM5s8nKLrfcxzSa2GYsWTYIWLGqg8YBOgUNiTD9XNHiO5K3NeK9LDOmGb
         HnlWgSpWVRRlni/qdML9hGRk/+2Djq3ADXMmBJHYC9TOPcqQ1I758sFfRqLFD5EI8Bgj
         Vy/2KLDKz4JCfhnMr0NVyBs3hu2Ti8sYMS1sDQHB9AxwGqculm9pfc5znAWhwvT9lO1O
         lfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zYUHvRKfkdjRLFK3/CH/9P1TIGF1Q+ZicVfnGSNZbtQ=;
        b=I85ehkEwoUJ2/3Dsai+DYJr1MTpZ84ZOVBKOYa8ZWDfAL8Heziw/9eEzwkd4wlx/Y3
         saVqMiXbYMRjPkq7bljLrPduBWMaUOPy9BKSDiyXFpCYUC6Vi89+YcEZOV+lfY7d7Xa4
         XMBqr2o5z5y1eThcx1bwqzaUVOe9Fmm2rJy1taByfbtVglsnD1gNnuUA/YangILI3Utd
         hqmQTCZGhWfcAChBjKcOnFHpexGb7JbIKG6iTGVDAVW7d7zgEBezHxZ2wVuvrAJwtP1N
         +lnCrjNWnAApo7oFR47JaPO9K+A3c/rqevgZgIDdCUXQtU6PBCN13V5lTcwER6IP4pXY
         ZdLw==
X-Gm-Message-State: AOAM5316kC8IDg+i/GoMLSF38KFpFsBO0nRJdk3XhMJTkFvHIJja5/0Z
        rLbLXZHsSqnUONUNWzpbS9NXWpoTye5QBw==
X-Google-Smtp-Source: ABdhPJwGx3PPjpRY0Ldxvw6pg0jPVeQ0ys7/BEguZcCJsSwvO6Xn84gDULVCHhvdEpMhwNEMjQHltw==
X-Received: by 2002:a65:638d:0:b0:39d:74ad:ce0b with SMTP id h13-20020a65638d000000b0039d74adce0bmr3990433pgv.103.1649974360010;
        Thu, 14 Apr 2022 15:12:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00509fbf03c91sm434146pfi.171.2022.04.14.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:12:39 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:12:39 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Apr 2022 15:12:20 PDT (-0700)
Subject:     Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2204142111010.9383@angie.orcam.me.uk>
CC:     helgaas@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@orcam.me.uk
Message-ID: <mhng-f97c506a-b3e9-4a7d-9865-b78955bad4e8@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Apr 2022 13:22:42 PDT (-0700), macro@orcam.me.uk wrote:
> On Thu, 14 Apr 2022, Bjorn Helgaas wrote:
>
>> > > > Address 0 is treated specially however in many places, for example in
>> > > > `pci_iomap_range' and `pci_iomap_wc_range' we require that the start
>> > > > address is non-zero, and even if we let such an address through, then
>> > > > individual device drivers could reject a request to handle a device at
>> > > > such an address, such as in `uart_configure_port'.  Consequently given
>> > > > devices configured as shown above only one is actually usable:
>> > >
>> > > pci_iomap_range() tests the resource start, i.e., the CPU address.  I
>> > > guess the implication is that on RISC-V, the CPU-side port address is
>> > > the same as the PCI bus port address?
>> >
>> >  Umm, for all systems I came across except x86, which have native port I/O
>> > access machine instructions, a port I/O resource records PCI bus addresses
>> > of the device rather than its CPU addresses, which encode the location of
>> > an MMIO window the PCI port I/O space is accessed through.
>>
>> My point is only that it is not necessary for the PCI bus address and
>> the struct resource address, i.e., the argument to inb(), to be the
>> same.
>
>  Sure, but I have yet to see a system where it is the case.
>
>  Also in principle peer PCI buses could have their own port I/O address
> spaces each mapped via distinct MMIO windows in the CPU address space, but
> I haven't heard of such a system.  That of course doesn't mean there's no
> such system in existence.
>
>> I tried to find the RISC-V definition of inb(), but it's obfuscated
>> too much to be easily discoverable.
>
>  AFAICT the RISC-V port uses definitions from include/asm-generic/io.h.
> Palmer, did I get this right?

I'd argue that asm-generic/io.h uses the definitions from RISC-V, but 
the result is the same ;).

The general idea is that the IO itself is pretty generic for a handful 
of ports, they just need to be decorated with some fences (or whatever 
the ISA calls them) before/after the load/store.  Those are the 
__io_p{b,a}{r,w}() macros, which are in riscv's io.h.  IIRC they stand 
for something like Port{Before,After}{Read,Write}.
