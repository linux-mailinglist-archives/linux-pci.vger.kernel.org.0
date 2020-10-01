Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5427FF75
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgJAMsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 08:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbgJAMsg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 08:48:36 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A148020B1F
        for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2020 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601556515;
        bh=ki+j6gliLWrwViiWs/JuC97LNKbkywYwv2LcI2EcjxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g3Nt7tqMfp36xmM1eQ0AgSMTvop9zoreAoquklYBwmpwQ2OCDR9km/77gP+Q/Isom
         d5ogLHQnjeUWLgVmgnWCoarG8o7taAqjZRtCIaA1VmaAVGkuI4l/syDeK0g14yUaQf
         GxTE9QELoeEtBYhweFqtq7AlOeEh+ft8OD0x2A9k=
Received: by mail-ot1-f48.google.com with SMTP id a2so5187101otr.11
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 05:48:35 -0700 (PDT)
X-Gm-Message-State: AOAM532ACsHGD7VGALahN4KHbwZFgFbr35w9z0/wdFWYYIKPNtEzXk1t
        JgNql0qNsrBDhe+NOU/W2AHWpZs03epotUfQ3Q==
X-Google-Smtp-Source: ABdhPJzVr2YsGYlrTWOv5J7zhRJO4+YB9KJfys1n5W2PCLpXbbts9kVfMGQyBE//kSJp5SlWgYsEv5rs29bjDyXn4Sc=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr4847905otp.129.1601556514960;
 Thu, 01 Oct 2020 05:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200930223707.GA2640592@bjorn-Precision-5520>
In-Reply-To: <20200930223707.GA2640592@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Oct 2020 07:48:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKhP+o_Y6t8HRRp20F3isAtqdNLPzhg7VxDyY7j-UYOSA@mail.gmail.com>
Message-ID: <CAL_JsqKhP+o_Y6t8HRRp20F3isAtqdNLPzhg7VxDyY7j-UYOSA@mail.gmail.com>
Subject: Re: of_match[] warnings
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> These warnings are sort of annoying.  I guess most of the other
> drivers avoid this by depending on OF as well as COMPILE_TEST.

Using the of_match_ptr() macro should prevent this.

>   $ grep -E "CONFIG_(OF|PCIE_(SPEAR13XX|ARMADA_8K))" .config
>   CONFIG_PCIE_SPEAR13XX=3Dy
>   CONFIG_PCIE_ARMADA_8K=3Dy
>   # CONFIG_OF is not set
>
>   $ make W=3D1 drivers/pci/
>   ...
>     CC      drivers/pci/controller/dwc/pcie-spear13xx.o
>   drivers/pci/controller/dwc/pcie-spear13xx.c:270:34: warning: =E2=80=98s=
pear13xx_pcie_of_match=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>     270 | static const struct of_device_id spear13xx_pcie_of_match[] =3D =
{
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
>   ...
>     CC      drivers/pci/controller/dwc/pcie-armada8k.o
>   drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: =E2=80=98ar=
mada8k_pcie_of_match=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>     344 | static const struct of_device_id armada8k_pcie_of_match[] =3D {
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~
>
