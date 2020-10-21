Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B74294C4B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442223AbgJUMMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 08:12:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442217AbgJUMMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 08:12:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id t9so2756214wrq.11;
        Wed, 21 Oct 2020 05:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Geiy1luQDgrfk0QA0gnO6sNJwWrWgtM6sqCvbinnx6Q=;
        b=Cn49ODJJldqRnkq/1Gr8s+PMe84Ug8R9/b6V2ql4RdVlvDfEVAeTrj+Ys/a71J5RIi
         PCK2y8EZJuXslfMN7q03nkmzIM6bA61C4QbxLcwE7Zmq4dw165S+mtBa8lzNQuWXB3a6
         CtRZyyiVpG9sviG6xl7GiP136/kg0cZKHmcd9ja/wSt6XFL+nBqzQTMYjztiEW8592QF
         w9buINHtHK8Oh9HqKRppejMEnsL//ZPgql5a9UCJu+FqOh/yL86W4UZuuHu0fw262LI0
         6FHKggSQq/vzEygRPBl8Niw2SEG9ho+AjwaiiDp90g/4NNnAIdkoF9YATTQiR4vLuEa7
         ThGw==
X-Gm-Message-State: AOAM532D/Cdjv3H8XAhs5ZK+NjGcj1XHgn4C8nTtWiXpm66QeFclF/XR
        ye1mu0l8s9dDo/gg5W/Zrho=
X-Google-Smtp-Source: ABdhPJwvRquWAPFs7VrnzvZyJL7W79RWO7ff1FG6dMYkQ4h8LuMyEN2mtueYmm6OIT7J/ADjIi9dkw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr4140251wrq.327.1603282327552;
        Wed, 21 Oct 2020 05:12:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id h4sm3765965wrv.11.2020.10.21.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:12:05 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:12:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
Message-ID: <20201021121203.GA27418@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
 <20201019094715.15343-3-m.szyprowski@samsung.com>
 <20201019101233.GB51073@kozik-lap>
 <CAJKOXPcyruYQxcioPxGE8J8jS0Yey+09HpXxFgQm4f2w98s5cg@mail.gmail.com>
 <50b13de0-168b-3fad-1e84-cc86f1a376d8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50b13de0-168b-3fad-1e84-cc86f1a376d8@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 21, 2020 at 01:59:25PM +0200, Marek Szyprowski wrote:
 >>> +required:
> >>> +  - reg
> >>> +  - reg-names
> >>> +  - interrupts
> >>> +  - interrupt-names
> >>> +  - clocks
> >>> +  - clock-names
> >>> +  - phys
> >>> +  - phy-names
> >>> +  - vdd10-supply
> >> additionalProperties: false
> > This can be unevaluatedProperties, since you include pci-bus schema.
> > However still you should either include designware schema or include
> > it's properties here.
> 
> Frankly, I would like to include designware-pci bindling/schema, but it 
> has not been converted to yaml yet. I don't feel that I know PCI enough 
> to do that conversion...

I think you need then include all properties in your dtschema. Otherwise
DTS will not pass (neither the example here) the checks.

Best regards,
Krzysztof

