Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C129B16F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759373AbgJ0O3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 10:29:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39282 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759344AbgJ0O3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 10:29:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id e15so1010388pfh.6
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=NEHb3IRzceYWmIJb3EUhbJwoIvwSXkYOALZu5psCZDc=;
        b=NNEfyoJXWhYru1f6876EtwCmW1CLhAY3Ex8MmM36kBeFFEbB6PFODOtFZzxIoT4u15
         qnQEZRIHGOOTNh8RM3O3r4cwAE7BDvvKsq7smp7n56k1tFvNENEDjJa74L33+zPu55Ug
         wVgUTOT9D3beUq9REJ6r3PhJ4hOfoWH/WaeZAysoM/XxTDs8ALunBjQqUVUyNwE5gnYL
         mAFALAvF8UGVjy/KJ7Zu7mn8z+8xjhwJFKriVY036KRWA0ghHaDY2c96Xj7zlrJfKOLB
         HGvGNB8Mf5sLouJVRpb+m7mE08pYQtQNHBVJU4sptYZDmXw93qyZw2zHzJCljHS+v7C4
         PsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=NEHb3IRzceYWmIJb3EUhbJwoIvwSXkYOALZu5psCZDc=;
        b=jkXhVgkvUJLr7x01nBBRsYGDrb2WKdVU2oq71/veMwv+pksknMjOeIMsOwyL3EU8S6
         M3bsigiprr/Pmb+dXFu6MXgJF02cF25xZTROQLrUwmRp5b7AZTZD686gMmv2FuSnoXeB
         lTe4bCWRMWKPGTkT6yEXAdZE6xa99dicYCWECOT0KfS1bFRaDldRixdQuvnGSljYVB9p
         AaHVp20yX6sk623gV04nHJqT2YXppF7cXhjC8TaUQ6S0jkeDGgMcBKiThKDGTnl4fm2N
         AH6hzud7QUFi65VsNjl+8JklsKiS1GPHFnPDoNy3HX+O+CG8hhEr+9ygA+/Q5NWBlg8S
         VAAA==
X-Gm-Message-State: AOAM5331oEeBf5iZP2GR8t58BQjIr507X2q7+iTQV8scSa6VFht0csJK
        oeZyTcP3fJ8k2zbb71MTOlg=
X-Google-Smtp-Source: ABdhPJz88wx2ICJV8A9R+tvpyIGYRCUnZbycg9vENs2t/VZNXLRlqTaK6BKutaCqCVMOAbx7FRzupg==
X-Received: by 2002:a63:5d61:: with SMTP id o33mr2096083pgm.295.1603808976662;
        Tue, 27 Oct 2020 07:29:36 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id ei4sm2275986pjb.4.2020.10.27.07.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:29:35 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: dwc: Support multiple ATU memory regions
Thread-Topic: [PATCH] PCI: dwc: Support multiple ATU memory regions
Thread-Index: AWgxODU28nZmEZFs54opsFnCSARtqdz2ar3X
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 27 Oct 2020 14:29:30 +0000
Message-ID: <SLXP216MB04773B7B0AE4A8B480FD1C0AAA160@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201026181652.418729-1-robh@kernel.org>
In-Reply-To: <20201026181652.418729-1-robh@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/20, 2:16 PM, Rob Herring wrote:
>=20
> The current ATU setup only supports a single memory resource which
> isn't sufficient if there are also prefetchable memory regions. In order
> to support multiple memory regions, we need to move away from fixed ATU
> slots and rework the assignment. As there's always an ATU entry for
> config space, let's assign index 0 to config space. Then we assign
> memory resources to index 1 and up. Finally, if we have an I/O region
> and slots remaining, we assign the I/O region last. If there aren't
> remaining slots, we keep the same config and I/O space sharing.
>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> For 5.11. This is based on the regression fix for 5.10 I sent[1].
>
> Rob
>
> [1] https://lore.kernel.org/linux-pci/20201026154852.221483-1-robh@kernel=
.org/
>
> .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +--
>  2 files changed, 34 insertions(+), 26 deletions(-)
>

[...]
