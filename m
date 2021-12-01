Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7644659EE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353836AbhLAXuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 18:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353824AbhLAXuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 18:50:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759FC061574;
        Wed,  1 Dec 2021 15:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52463CE2135;
        Wed,  1 Dec 2021 23:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE57C53FCD;
        Wed,  1 Dec 2021 23:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638402397;
        bh=/68xd18Co11QfmVypZO2/D4sRtZrh0SGI3U3HFs+5qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DfrFHeVWwRBLggy/MOUDPL+ISR+Olbd2DxRG+9WvSD/l0tOUa6XN4hKvN/TuL6EsK
         VDnzj/mPeyuhDi80gG+wQCQaQKkHLUKpv/gky8NiHZKvwC03ceJD3ZD1SDsarhNxz1
         3JCUW1yl94eMRKaScYPvaRKhEQa9qeHH5YEyN+JPqgr2DDCdbtAF9yQAGtCKC6OtUg
         LIHJtjWue4EGeDyIj656kU+HuL8GNYZuh/LLhsMpfRl56IcE8LYqPP0mm32sHvegGq
         9yWTt62Jlmn+4cydvDBJTzZqvOwQUH/gfauTF1duEKY3TBYjpDNfJfdEHcyxaF+RGI
         N+GJ3P7bwa1Aw==
Received: by mail-ed1-f47.google.com with SMTP id w1so108851433edc.6;
        Wed, 01 Dec 2021 15:46:37 -0800 (PST)
X-Gm-Message-State: AOAM530rhU5KUt6eDaPY91Xu9egQ2boNiy2qDmV6Hmh/9auhfBVWN7z/
        IRX0jrA0VddT9PIYCnZnYqk0un/aL9xnQnDsEw==
X-Google-Smtp-Source: ABdhPJwH8vC1+yopFdWmDlNaVi6P5l4oebYOJsnF/jPuWJG9o5yrO05W9yRto7M0QiXayPPOx25tmr10rvMmhSAFlKg=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr12390931edu.327.1638402395645;
 Wed, 01 Dec 2021 15:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20211101180243.23761-1-tharvey@gateworks.com>
In-Reply-To: <20211101180243.23761-1-tharvey@gateworks.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 17:46:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+n9B7k3tLsgsNg=cLykQk-6ZDH3znsKeUEabvKwUiUQQ@mail.gmail.com>
Message-ID: <CAL_Jsq+n9B7k3tLsgsNg=cLykQk-6ZDH3znsKeUEabvKwUiUQQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx: do not remap invalid res
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 1, 2021 at 1:37 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On imx6 and perhaps others when pcie probes you get a:
> imx6q-pcie 33800000.pcie: invalid resource
>
> This occurs because the atu is not specified in the DT and as such it
> should not be remapped.
>

Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
Reviewed-by: Rob Herring <robh@kernel.org>

> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
