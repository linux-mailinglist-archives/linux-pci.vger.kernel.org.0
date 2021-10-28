Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849B343DAAD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhJ1FTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 01:19:13 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49928
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhJ1FTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 01:19:13 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7E2A3F194
        for <linux-pci@vger.kernel.org>; Thu, 28 Oct 2021 05:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635398205;
        bh=w4w/09FZfuLDv9QiNpe09G8HG8kj8Rm/e85TyylOjKw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cq8VPEhi4dNnWSuwoD+76SyF0IyMDQq7pj1BWOAYsC1Z9+hi8ij78toj54FhEDlk6
         SH3Vjq0gYLnFtW5pp/qy44IDNpUodLaSHHDBtah2jZ1DHOxPwpElpAeNuG3V5c7s77
         9vhnVe7g5FHEbSSPTazUUuEXuHAAYk6HXrAakIyrLoejhyfjRpa3/a18f5hLJW53pY
         K4e65R3kIqJViAucrGPgjTQ9gMtW2DSQKl0OIP7CxFuuV6x/kN9Nj/cflYTPiZjFSD
         8eMUtzn6hmgzPRrmwRWIaLoPVrqTQz9d0FfLAygOV6G0pIb5BS0gBHu5vUCUd6G3WK
         64hH6/XZzd9zg==
Received: by mail-oi1-f200.google.com with SMTP id v135-20020acaac8d000000b002995845aa8cso2530106oie.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 22:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4w/09FZfuLDv9QiNpe09G8HG8kj8Rm/e85TyylOjKw=;
        b=xzMjUMHR0KL6rQ8jBJCrKxIodidrIe2Z02E1LrMAu/DhFa+yy1AnFesWo1DAy5EKPE
         VJJWpImeA8/TQmgbgowYmoe71kbemDljUsrS0C9ONgAasfgXcmJqbiRk5JT650dVKIB5
         77/aoBEAohBCfwgdWK4GxsYdAW192Ns2e4mXodF3o3t+X74A3oRxnsYSGauE8yNtp4Mu
         bDTUcMcE8KVE9Wr9MCb2yfPf/z6Hhtj4+NP04kilRHaVuZlDMD8GZsjsVnPfCiF5lNHQ
         77bUq2Pouhoev3zeTNHfm/K77Z2I4xC+vcdE6sSu5H0H1uozu6Q43yq6YYkPRggSZ2WE
         2cwg==
X-Gm-Message-State: AOAM533hj7Yzy/aG70HzKZdQ6yfiI0JtZ3Xdpw3WgwwhAsMLywYkoWPl
        vWgXJ2pcmeB9NmUeUQxgSSyqHxeO6SBaNWuH10TO+OMrwscUsaDyi9sWg1a0KsG8RneQU1ZAQfC
        LvVXoSoNMF/zCvwrM2WcEPuMubjcwb5/XhPzpvH9ixoLW2zvkVDLozw==
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr1681192oth.233.1635398204591;
        Wed, 27 Oct 2021 22:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfyZgo2HvulEezaAHjWw86S1CWV6EW+zSNzZA3tyky5FFoj5l6UxkMTZtrDl5aLiXaNLUtCGTf+F91fY0Vkik=
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr1681178oth.233.1635398204356;
 Wed, 27 Oct 2021 22:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p7cqnGmySsxSz1xTmUp=_O_vApMuvcg-cBFUHButpva7Q@mail.gmail.com>
 <20211026165348.GA146058@bhelgaas>
In-Reply-To: <20211026165348.GA146058@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 28 Oct 2021 13:16:31 +0800
Message-ID: <CAAd53p5g++fHfOi9WUVm2aHo+4C9AssFcA1dB0AMt9rBwsKTnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 27, 2021 at 12:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Oct 26, 2021 at 10:28:38AM +0800, Kai-Heng Feng wrote:
>
> > What if we fallback to the original approach and use the VMD driver
> > to enable ASPM and LTR values?  At least I think Intel should be
> > able to provide correct values for their SoC.
>
> Can you post the patches for that?  I'm not sure exactly what the
> original approach was.  Are these the same as the downstream support
> you mention below?

This is the previous attempt to enable VMD ASPM:
https://lore.kernel.org/linux-pci/20200930082455.25613-1-kai.heng.feng@canonical.com/

It didn't enable LTR though.

Right now the downstream kernel use PCI quirk to enable VMD ASPM and LTR:
https://kernel.ubuntu.com/git/ubuntu/unstable.git/commit/?id=069ab00c2613d27cb7cdeb2a4c751de89dab81b4
https://kernel.ubuntu.com/git/ubuntu/unstable.git/commit/?id=1e4dec5fe846f8dd8954b173434670f8ae30b5ff

The patches don't touch VMD driver to minimize merge conflict on VMD driver.
I really hope we can put these changes to upstream VMD driver.

Kai-Heng

>
> > So what other options do we have if we want to enable VMD ASPM while
> > keeping CONFIG_PCIEASPM_DEFAULT=y?  Right now we enabled the VMD
> > ASPM/LTR bits in downstream kernel, but other distro users may want
> > to have upstream support for this.
