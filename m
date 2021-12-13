Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B2473875
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 00:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbhLMX2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 18:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhLMX2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 18:28:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74665C061574;
        Mon, 13 Dec 2021 15:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F662B81701;
        Mon, 13 Dec 2021 23:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E67C34600;
        Mon, 13 Dec 2021 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438092;
        bh=XFwpAZy57oX2vfbJplvczXx5BJ6qNzz2z9ThuM9vfB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FaM2HiGJmeQ0t6PuWPtYoqorcQkF7wPJ1EDcEpOWBflT8aNPw8q0agYiNSnJLeaty
         l3xVFaPY/q1n9cRTKHshlVUHX+h0MC8nLFZdcG24QpB31+qILJrWyfO+Y4b0YpEN0x
         IuJXuisvBhkGLLfZrsLExZ7IzWFuNKu188AwefAoT14aeawQ0N8o2eXBn1qDhKuTzo
         2hg7gWc3/8CYSyYw1eSi1yAG6XlxdJS/aqKzwC2XhBMDP8bYBcb9iKzQDDzSYOtgDY
         81SwWlmrHJ6iPTChMsP+JPeezox6yuuLubQXhfVO1SPW8HVjfKzYyzTnE7ylmnCTWc
         fW63spioyyyHQ==
Received: by mail-ed1-f54.google.com with SMTP id w1so57158650edc.6;
        Mon, 13 Dec 2021 15:28:12 -0800 (PST)
X-Gm-Message-State: AOAM532L+NKG/TvTdadzd/eMAVIQ5VGQAD2AhOTKmqg4aa319sigwjH/
        EXp0VXqer0b2oTCAs/yfPhp7VQQWJT1TFFUlUA==
X-Google-Smtp-Source: ABdhPJz03X1uEeikTlQG3AyHAQW9tVt9gbf5JYaizN++Ch1mwmPaWCRWRF0WQcWEuKyvwATGDJgq1R0HWpO3QdEIu3Y=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr2557411edt.201.1639438091217;
 Mon, 13 Dec 2021 15:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20211213190221.355678-1-f.fainelli@gmail.com> <20211213190221.355678-7-f.fainelli@gmail.com>
 <1639437829.333710.1773610.nullmailer@robh.at.kernel.org> <91c2ad0d-491c-902a-4b12-d96f9cdbbab2@gmail.com>
In-Reply-To: <91c2ad0d-491c-902a-4b12-d96f9cdbbab2@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Dec 2021 17:27:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLj3jcjHVZVtpnZvWUVmBMqJ-ngwXbhg50aVp6r0HR9Mg@mail.gmail.com>
Message-ID: <CAL_JsqLj3jcjHVZVtpnZvWUVmBMqJ-ngwXbhg50aVp6r0HR9Mg@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 13, 2021 at 5:25 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 12/13/21 3:23 PM, Rob Herring wrote:
> > On Mon, 13 Dec 2021 11:02:21 -0800, Florian Fainelli wrote:
> >> Conver the iProc PCIe controller Device Tree binding to YAML now that
> >> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
> >>  .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
> >>  2 files changed, 184 insertions(+), 133 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml:97:34: [warning] too few spaces after comma (commas)
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'brcm' is a dependency of 'brcm,pcie-ob-axi-offset'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'pcie-ob' is a dependency of 'brcm,pcie-ob-axi-offset'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
>
> OK, so the dependencies must be quoted, but not the properties
> declaration. Thanks!

Not quite. Strings with a comma must be quoted when using the json
style [] list form. The one per line '-' style doesn't need quoting
(for commas).

Rob
