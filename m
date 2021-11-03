Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452DE444980
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 21:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhKCU2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCU2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 16:28:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D84C061714
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 13:26:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so5409915wrc.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdZ06WrNTWvO8pTfOQR/yXY5eszuPIqL50d8LNSENc4=;
        b=PfKl8iu1Omfr9P216DEugB9EtfwJhvRDwemVWlAaNhWyvt1Zt6BVbQL4EslGLihiiq
         y2qytpLBKB1emFFL8ajlaRiFgE8x77IT1XgoNRhwW/FrluL9UBg7ZAqawYsx1XhA89P7
         JcCqBVHYUsMZknMr8t2A9ZLLHIVyk9Dh2GAtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdZ06WrNTWvO8pTfOQR/yXY5eszuPIqL50d8LNSENc4=;
        b=lL9Y/ENeP0/vBZ61jjx3bm9jJEtoQwf1xB86oAtlHKyaPpf7ZESukIMMto2mXSiubX
         97JNZMSAIFmNerfscZ/r4LvsLazNoi74GM1TaRluAunDFBHizusTl/fK9FHaRm7hlfXr
         ERPWVQc2kHhUUYhOU0OwCKsZpovETgWJBRReehhy39vhAV0B1dJ3sR7m50tm8QwcgNdJ
         eoCj4iZB/qddrTWeCa81xCvKFbIMFVKu3dkfkjoS/CIvQ3l0MjL/DWLhytdLkjQi4yjH
         vYz3lzferLyX02t/WHX4dC7w0WjMxiBZy/PJOzG3Lxmcjr8xlrcOZUaVKL4FSfaWe1Dz
         k8BQ==
X-Gm-Message-State: AOAM533xrSaYmiPXOFHMCZG2wzgvbFZfNvhrI2+jHACXeoA+1gk72cPp
        t/xykOb5nRvzyf4wTpRFzv8Ln0sf+YrTgCmorcVhHg==
X-Google-Smtp-Source: ABdhPJz2xY1JmknziADTseDioWd5Ar+tPVGVN4X9kwFu9fL9OUxf2sdzgQDXX/Y/SaqOJ6lWuOl3quMYpB9MVubseUM=
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr14064647wrr.340.1635971162712;
 Wed, 03 Nov 2021 13:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-6-jim2101024@gmail.com>
 <YYLm3z0MAgBK24z5@sirena.org.uk>
In-Reply-To: <YYLm3z0MAgBK24z5@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 Nov 2021 16:25:51 -0400
Message-ID: <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 3, 2021 at 3:45 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 03, 2021 at 02:49:35PM -0400, Jim Quinlan wrote:
>
> > +     for_each_property_of_node(dn, pp) {
> > +             for (i = 0; i < ns; i++) {
> > +                     char prop_name[64]; /* 64 is max size of property name */
> > +
> > +                     snprintf(prop_name, 64, "%s-supply", supplies[i]);
> > +                     if (strcmp(prop_name, pp->name) == 0)
> > +                             break;
> > +             }
> > +             if (i >= ns || pcie->num_supplies >= ARRAY_SIZE(supplies))
> > +                     continue;
> > +
> > +             pcie->supplies[pcie->num_supplies++].supply = supplies[i];
> > +     }
>
> Why are we doing this?  If the DT omits the supplies the framework will
> provide dummy supplies so there is no need to open code handling for
> supplies not being present at all in client drivers.  Just
> unconditionally ask for all the supplies.

I did it to squelch the "supply xxxxx not found, using dummy
regulator" output.  I'll change it.
Regards, Jim
