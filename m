Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1910937
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEAOkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 10:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfEAOkh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 10:40:37 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759BB21743;
        Wed,  1 May 2019 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556721636;
        bh=u/Mw+fWUEc/keOY00CbYB4GGaE1NsH7Iz/SacOTrmu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F7oM7ztQcFOIiPuXKfJ1EcCi/n1iNrrmqRFjtEtw9XTElgEUNQlR9iDiFZpc2fBV5
         dPJ6afxmUSOfsYesgZIq5YWSanIDuec0xGb4XS8DSAQHwhC695wPcx3vOHoBe6TxhW
         ugZJv8xufT3ixjf0W+E9RioFUaaDz5xqbf41YDyE=
Received: by mail-qt1-f169.google.com with SMTP id e5so13249883qtq.2;
        Wed, 01 May 2019 07:40:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVFnxP1ATi/Z+ZMDqPjY/X3+Qo4a8ovUWxEG2yLY4cFNbov9uRU
        DbsMQ/yThMjKG4m9f0m291LKZmYKaMldurHzsA==
X-Google-Smtp-Source: APXvYqytLK1Pq61l7Qct4WHvSayk3d/X1r8PSrqTB8epWaZOFI7gczb2hse2g9sw9rEdqH94e1h3AhLCMTwrfTg02ic=
X-Received: by 2002:aed:306c:: with SMTP id 99mr4346058qte.38.1556721635726;
 Wed, 01 May 2019 07:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190426124620.28881-1-kishon@ti.com>
In-Reply-To: <20190426124620.28881-1-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 1 May 2019 09:40:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fR3-9c2pgDAL4EJebbiUntW46C_HAD5zoNaXRvojbHA@mail.gmail.com>
Message-ID: <CAL_Jsq+fR3-9c2pgDAL4EJebbiUntW46C_HAD5zoNaXRvojbHA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Add PCI EP DT binding documentation for AM654
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 26, 2019 at 7:47 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Add devicetree binding documentation for PCIe in EP mode present in
> AM654 SoC.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/pci-keystone.txt  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
