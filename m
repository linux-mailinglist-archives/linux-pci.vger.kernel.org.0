Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54343799B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhJVPIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhJVPIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 11:08:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5427C061243
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 08:06:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d3so1370375wrh.8
        for <linux-pci@vger.kernel.org>; Fri, 22 Oct 2021 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIvrqPUuxcoH0q6+3l1CYyqJkwrcb2T7uuS0LcS4Xjo=;
        b=ASrm3smHMtCHvAbDwIx8QoXfpW74ObcmTPPb+utN5FzQ5kW1ihXXzfhKVHeNJ8+gI2
         1gH3kRpgA0llpjIU3Tp0vwehNBplj9bkpj9KC5qzrdZSvojG+f6sa8TASpec6F7jJSE5
         y8xNYfDZygiSc6A9jE6+hF+ELkCr96vS/taqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIvrqPUuxcoH0q6+3l1CYyqJkwrcb2T7uuS0LcS4Xjo=;
        b=rAvZvCAXvwErcpcUfwloQsNEo5qqJasdL1f6vyplQZ+VpNX9LqM6KGXWERpdL4DTYQ
         ArlEUTIGrc2SJxMN9fjDuFv709h4EYkK5cWqsqyvW7/X5d8Cp6tvwOjXvrfvvU5jgGjl
         pY7t3D+SQ+5Fa10Jlb/gOuMi6dbKoIM7IJxHdbwjte+zETPrXoXKM6QDvKIdHX+R+oFE
         MbA0hgJmTgQX7KjPQcyyLyWi0jMXYhdk6QKSnoppUTV1R3tRHrnqr8x69VuAWeFDzbAf
         RWE1KGoq6pDafyM6AJaNpNS3c8EtZ51JS0wpkA2kH2X9ZA1geoeskBZlipLU3aSMwllG
         +4Xg==
X-Gm-Message-State: AOAM531lgDG1i5wkVr4bS673n7Q0uVz68Oo1+VV9gXuKhVLWkfWoIKdR
        vsOLk5H8Q2ZY2HJomVo2IDxXNCAoyt6K/yHrvS2kiA==
X-Google-Smtp-Source: ABdhPJw/+cohLedLGM0slfaQoKoLKSxgcj8S/9byAKQDcpXFqlLlOVLMJXyo+pno1NqRHLZA/3niJVNkuExhdjL7Gp4=
X-Received: by 2002:adf:ba87:: with SMTP id p7mr518137wrg.282.1634915193241;
 Fri, 22 Oct 2021 08:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-6-jim2101024@gmail.com>
 <YXLNLWNKkcYodqCG@sirena.org.uk>
In-Reply-To: <YXLNLWNKkcYodqCG@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 22 Oct 2021 11:06:21 -0400
Message-ID: <CA+-6iNyT5-X63bdioNQaY=htyev2KPEhELQAFcvH06sLMVo-qQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] PCI: brcmstb: Do not turn off regulators if EP can
 wake up
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
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

On Fri, Oct 22, 2021 at 10:39 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 10:06:58AM -0400, Jim Quinlan wrote:
>
> > +enum {
> > +     TURN_OFF,               /* Turn regulators off, unless an EP is wakeup-capable */
> > +     TURN_OFF_ALWAYS,        /* Turn regulators off, no exceptions */
> > +     TURN_ON,                /* Turn regulators on, unless pcie->ep_wakeup_capable */
> > +};
> > +
> > +static int brcm_set_regulators(struct brcm_pcie *pcie, int how)
> > +{
> > +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
>
> I can't help but think this would be easier to follow as multiple
> functions, there is very little code sharing between the different
> paths especially the on and off paths.
Agree; I just wanted to make less changes to struct pci_host_bridge.  Will fix.

>
> >       if (pcie->num_supplies) {
> > -             (void)brcm_set_regulators(pcie, false);
> > +             (void)brcm_set_regulators(pcie, TURN_OFF_ALWAYS);
>
> I should've mentioned this on the earlier path but it's not normal Linux
> style to cast return values to void and looks worrying.
Got it.

Thanks,
JimQ
