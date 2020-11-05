Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC892A8229
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKEP1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 10:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgKEP1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 10:27:48 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3557522203;
        Thu,  5 Nov 2020 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604590067;
        bh=UK19I8OglCaJWHUkFRwd3fmiZffaNCjpPaqyNqKgbJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J5cWUrPLaQLNIbe0c5w98I8ZtT02bfs4Rol32WMQdCMT4RpEHRTMVvL8pSqs7UNOM
         Nat4d8ad9XcYqPsT7bLpl7ksJU3ZkU5HvJA8hKdN7Vtl5gy7LZ3NTMb9BbR/YxjRBK
         rZw2m8yx9gSg1kaZSFy3/WJ+bzA37pEY6XHt8NTI=
Received: by mail-ot1-f53.google.com with SMTP id i18so1786147ots.0;
        Thu, 05 Nov 2020 07:27:47 -0800 (PST)
X-Gm-Message-State: AOAM532/rZ3jDSFtRLqlmYAbO6P2AsWr3yLzLfmEqTfEtnWd2Yp8gP0G
        DLrblVFHbyLCmJvoQFZL+rH80f0ufzr+Hzz9yA==
X-Google-Smtp-Source: ABdhPJwKfqNyaCuCxyGQthoSqbrcvdbcm7lr5Y+wBARMUUWapINuOrnTTlkPS19mnYTSVopMJI/IzduZeD4wthDYe5E=
X-Received: by 2002:a9d:6e0c:: with SMTP id e12mr2049771otr.129.1604590066346;
 Thu, 05 Nov 2020 07:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47@eucas1p2.samsung.com>
 <20201029134017.27400-3-m.szyprowski@samsung.com> <20201104213539.GA4144654@bogus>
 <d89f5f0a-c45e-0bda-4db7-7b0cf9cd49fe@samsung.com>
In-Reply-To: <d89f5f0a-c45e-0bda-4db7-7b0cf9cd49fe@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Nov 2020 09:27:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQstKa7_0pjcODyyLCwMiGF9zB4_+x=GhcSUOyvuLRmw@mail.gmail.com>
Message-ID: <CAL_JsqKQstKa7_0pjcODyyLCwMiGF9zB4_+x=GhcSUOyvuLRmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie binding
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 5, 2020 at 2:33 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rob,
>
> On 04.11.2020 22:35, Rob Herring wrote:
> > On Thu, Oct 29, 2020 at 02:40:13PM +0100, Marek Szyprowski wrote:
> >> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> >> variant). Based on the text dt-binding posted by Jaehoon Chung.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> ---
> >>   .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++++++++++++++
> >>   1 file changed, 119 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>
> >> ...
>
> >> +  num-viewport:
> >> +    const: 3
> > I'm confused why you need this. This is only used with the iATU except
> > for keystone. Platforms like Exynos with their own child bus config
> > space accessors don't have an iATU.
>
> Frankly I have no idea, I don't know much about the PCI internals.

Sorry, I was confused. It's fine.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
