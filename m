Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC772C0E5C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbgKWPCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 10:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbgKWPCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2020 10:02:05 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94413C0613CF;
        Mon, 23 Nov 2020 07:02:05 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so16178985ilb.0;
        Mon, 23 Nov 2020 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qh6qjS2zm/X4PF4RHg4Jo9s/UIxaspmiraVkw8cJCxY=;
        b=GGsIDsuT/GcH6k7VbgAzUv5xHGQ9/ygxAjZxx6fiPbzBaqiKHls7/sg4aHjBN7/AYe
         9LDZNo8f4XatEV0dTgFJlCx7ziSIupxkwmyhXv+ANA4Gus/mNtfm70k0AtMyF23jYLTG
         nOcJM44YR1gy2QYWYAZu031NOTLGKLa7OINLTk5/r2lM0WBJB9cjndkfmLtSQ3yvnyWr
         Az66EPfRYKgBkzzKi9NcnmTHAQI74S4/f+BsGoEq6S0BPtRkItiYpG/j58kjFIkPVOIm
         QtQYyRW3NDdfWXokmsu2pPeo5jByJoxBsvPbBxxsUK1+Jf8koqzB/+WGieZfY1jd67wR
         hvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qh6qjS2zm/X4PF4RHg4Jo9s/UIxaspmiraVkw8cJCxY=;
        b=YrtA0FZsOKlsoWuxAoiVUgvJv3v1wxByNF+fwor4PHuubAW8TmYS46b22gLhwoCaj3
         kDxW7wbuhWOh5/PdzTvEVrP0nOoZS1QPrYzvQpUR369a+jFu8Ylw1SqW32PeuR9/SKV7
         Y1j9T1VEyfJeNjlgW5SWmUaU+kyN7enTLN0ItaM/EtQ5y9FiCAcRnh9pZ9mtvIdJvzKI
         4nfNorP7LMKIPJdpMMxc6arbmCOFp4esB+da7MCOd8INBtT2CVlC+7zMysnM8d++fq2o
         d+Fr5pSmb869+SEx++lUu5ZSSdv84wPZ3InFAQ0cEXGevklTmL80Ptx5BGEFiCPTeZLf
         41Xg==
X-Gm-Message-State: AOAM533Vrzpef93KiPKMK0zhLAHXPIE8mwzqNr0ZI2t/XlCAjLGI5QS0
        ihlz0qQi6W3kinBof5djFRiVRH2B3C0SipU1dm8=
X-Google-Smtp-Source: ABdhPJyPlSCcrkWuxpLElr435EbIzERKEmMpp/aPZIQlmUhmPcx7tNXoMxCzH+ew026RrC1J8NRQmtwcu022+ZhfdMs=
X-Received: by 2002:a92:35d7:: with SMTP id c84mr95549ilf.251.1606143724717;
 Mon, 23 Nov 2020 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116165407.8050-1-sudipm.mukherjee@gmail.com>
 <20201116170137.GA2587640@ulmo> <0ef6fc37-4e91-68a1-0744-90b4093ce5ba@codethink.co.uk>
In-Reply-To: <0ef6fc37-4e91-68a1-0744-90b4093ce5ba@codethink.co.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 23 Nov 2020 16:01:59 +0100
Message-ID: <CAKXUXMxzEBoVwuVFYnKCi004a7ytQfK+B-wjjE8i1J1Fzce6qw@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
To:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 23, 2020 at 3:51 PM Sudip Mukherjee
<sudip.mukherjee@codethink.co.uk> wrote:
>
>
> On 16/11/2020 17:01, Thierry Reding wrote:
> > On Mon, Nov 16, 2020 at 04:54:07PM +0000, Sudip Mukherjee wrote:
> >> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
> >> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
> >> doing 'return 0'.
> >>
> >> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> >> ---
> >>  drivers/pci/controller/pci-tegra.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > This has been proposed multiple times in the past and Bjorn and I have
> > agreed every time that this is not an improvement, so sorry, but NAK.
>
> Thanks Thierry and Neil. I have now added a blacklist script in our CI
> so "PTR_ERR_OR_ZERO" will not be flagged for anything in drivers/pci/*
> anymore in our testing.
>
>

Thanks, Sudip. I think that is a good idea to minimize churn on
subsystem maintainers from janitors.

We can continue to discuss how to share these settings on
ignore-rule-X-on-subsystem-Y with other "analysis tool CI
maintainers".

Lukas
