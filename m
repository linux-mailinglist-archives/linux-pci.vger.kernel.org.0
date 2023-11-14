Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C77EAA42
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 06:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjKNFx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 00:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKNFx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 00:53:58 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E461BC
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 21:53:54 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so75431591fa.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 21:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699941232; x=1700546032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFlrR56P0Dw8EgMAlpOH7YdtXhzvKe5HaWbylkTTH64=;
        b=Udse/WvHWxIbRccIu5ESzicSWi2m2fyBzM94rY65ldeBsBlbtWfHEsdOYb8c32pb6A
         RuyrtUzXcKVk0ICkn81g0DxtoakyAxxQabrPb8SUxXHbo/d3IMpAitWEzaAmJGfeokrO
         M5ygFTSTLAZECulQ1t2W73+sXEENZIltBjxc/IVdOmxA3N4fvIlFoYA6xlIfXqDPCl3Z
         TQwE04jayacRKBgC5+vmNMp3BZKLYIDYBebgxYtmZbY47j0LwHW+XcQk4UFDrzr6X3QN
         R1e1SD5pQHHAMaANQ2GZpUHAtMuyxxwPddGKRyXEW1nDdiU3hKt1GJX4zEtw3JZrQyEO
         Jt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699941232; x=1700546032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFlrR56P0Dw8EgMAlpOH7YdtXhzvKe5HaWbylkTTH64=;
        b=UX7SbWJWHY2Lh6lbJ1pKiwTtOfFsgZMkQAsvSqVF4bQl+THDTh6Udgxib/cPC4v8Pg
         2w3QvqQP0yZ/A8kjHWNn7Rw4GSuCemXKrLi2lqUzSR3hvLzPWHil9r5DYIzwztGDjevr
         EfIC/Y8BthOD+kY3cME0OR8srZbXLyAGxvkQdhKoCqf0/MGYzaC8C39sCmUG6cVJFx9r
         R01Hr1w5dOyndOEYd/5j4TM9i5VIzfG7aXl5uYkRDcsQaQXZDvCdX6Hk9GWBtPm1UTS0
         1f0V9Xz0cnVtaIH+Acxi8P6SOAflDbR0/kExXiLHTizpioV/rhF6ubj2OGGA74wPxRNA
         g77w==
X-Gm-Message-State: AOJu0Ywg2XJMaclTXPbIbtniJDr8AV2enRChr4+aikyaI2xc3ghwEugS
        4ooqVNbvGysy5G8MpqGv4UZbyZM73MnMbnr9E/mJ6TlS
X-Google-Smtp-Source: AGHT+IG8MeLJqg4u3NdWKitk/vQw0Ud7P7PB0+K7VplKccWic8y5Nt7YPhNKimBgVRLoBSFxveNcMyo3k4u8cbPCh2Y=
X-Received: by 2002:a2e:8617:0:b0:2bf:a9b6:d254 with SMTP id
 a23-20020a2e8617000000b002bfa9b6d254mr869140lji.50.1699941232289; Mon, 13 Nov
 2023 21:53:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8U=yiC4bOrZ28Zx7-_Ho2-2kKWt4Y3O7nLdm7gNBwiL9w@mail.gmail.com>
 <20231113211556.GA641950@bhelgaas>
In-Reply-To: <20231113211556.GA641950@bhelgaas>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Tue, 14 Nov 2023 11:23:39 +0530
Message-ID: <CAHP4M8XbhNbnbZKiVibEZcPy-FHJWqEwv9-S_Dka3n=Po=hPTw@mail.gmail.com>
Subject: Re: Queries on pci address-ranges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clear, concise and comprehensive as always ! :)
Thanks a ton again Bjorn !

On Tue, Nov 14, 2023 at 2:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sun, Nov 12, 2023 at 09:36:23AM +0530, Ajay Garg wrote:
> > Hi everyone.
> >
> > I had written a (hello-world) PCI-driver couple of years back, and was
> > able to read/write from/to BARs.
> > I might have a requirement of writing more drivers, so was revisiting
> > the concepts.
> >
> > I have some queries (we can assume no IOMMU is in the picture) :
> >
> > 0.
> > Assertion : During PCI-enumeration, the physical-memory assigned to a
> > BAR is always contiguous. (Yes/No)?
>
> Yes, a BAR defines only a base address and a size, so the region is
> always contiguous in the PCI bus address space.  If there's no IOMMU,
> it is also contiguous in the CPU physical address space.
>
> If there *is* an IOMMU, it is still be contiguous in the PCI bus
> address space but could be discontiguous in CPU physical address
> space.
>
> > 1.
> > During ioremap() of BAR-physical memory, does the (mapped)
> > kernel-virtual-memory correspond to
> >
> >              * one used in vmalloc(), wherein the
> > kernel-virtual-address =3D> physical-address
> >                goes through page-tables?
> >              * one used in kmalloc(), wherein the
> > kernel-virtual-address =3D> physical-address
> >                *in all likelihood* requires only adding an offset?
>
> ioremap(), kmalloc(), and vmalloc() all return kernel virtual
> addresses, and the regions are all virtually contiguous.  Space from
> kmalloc() will be physically contiguous.  Space from vmalloc() may not
> be physically contiguous, and I don't think you can assume ioremap()
> space is physically contiguous either, although it will be contiguous
> in the *bus* address space.
>
> > 2.
> > On a related front, how does ioremap() differ from kmap()?
>
> kmap() is for highmem (see Documentation/mm/highmem.rst) and has
> nothing to do with I/O mappings like ioremap().  Very few drivers use
> it, and I doubt you should use it either.
>
> Bjorn
