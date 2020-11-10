Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC72AD98D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgKJO7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 09:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730917AbgKJO72 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 09:59:28 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768D7216C4;
        Tue, 10 Nov 2020 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605020367;
        bh=qvUn9qNX1M1Qx2QeznJUHEO4kgcTe0+DelhXJxEE0dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/3QTe6UPGl4+UBnrvNNeMglzQW4NaG0atUAknJXGKmiKlQ3jFAg466x/NwQrKu8/
         gBOWhF2e4nqsUJikfZBNK85TbHjpqqfBqGUI/fPV3Q4vo0VU27Kg9mYaa1UZ+CPmR7
         m6tDvxeghc9snLMuu1GE+vc1t3kZ5zdJ+r04K2GU=
Received: by mail-ot1-f53.google.com with SMTP id f16so12745658otl.11;
        Tue, 10 Nov 2020 06:59:27 -0800 (PST)
X-Gm-Message-State: AOAM530/6H67dDL5PAJL3KAeHijbr+1XU2zLAQyWMFDyoERLp8rObvxD
        Spis/dV5AB9DWng0pGXDXiFUAN1Kt1LNhA2hImg=
X-Google-Smtp-Source: ABdhPJxoTX+rWXC9j2qbuOi17pSMpsm+frJ8yNOwZPIBGWBUEPxRNPsSN2Sgb5QTmR2TPMukZYJ0UGj/XW9Ewao913I=
X-Received: by 2002:a9d:23a6:: with SMTP id t35mr13613677otb.210.1605020366593;
 Tue, 10 Nov 2020 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20200930153519.7282-16-kishon@ti.com> <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com> <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com>
In-Reply-To: <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 15:59:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
Message-ID: <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 3:20 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 10/11/20 7:55 am, Sherry Sun wrote:

> > But for VOP, only two boards are needed(one board as host and one board as card) to realize the
> > communication between the two systems, so my question is what are the advantages of using NTB?
>
> NTB is a bridge that facilitates communication between two different
> systems. So it by itself will not be source or sink of any data unlike a
> normal EP to RP system (or the VOP) which will be source or sink of data.
>
> > Because I think the architecture of NTB seems more complicated. Many thanks!
>
> yeah, I think it enables a different use case all together. Consider you
> have two x86 HOST PCs (having RP) and they have to be communicate using
> PCIe. NTB can be used in such cases for the two x86 PCs to communicate
> with each other over PCIe, which wouldn't be possible without NTB.

I think for VOP, we should have an abstraction that can work on either NTB
or directly on the endpoint framework but provide an interface that then
lets you create logical devices the same way.

Doing VOP based on NTB plus the new NTB_EPF driver would also
work and just move the abstraction somewhere else, but I guess it
would complicate setting it up for those users that only care about the
simpler endpoint case.

      Arnd
