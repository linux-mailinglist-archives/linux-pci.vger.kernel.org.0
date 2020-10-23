Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69F29682D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374144AbgJWAvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 20:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369289AbgJWAvT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 20:51:19 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3C024677
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603414278;
        bh=XfPxZZsnlnwe8HX6W28fSTDlF5fPpXCjiiR0dFpqN/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06WVVUJ3KcfsK1wDUQSo94TvXxxEkpAEiT0GsulreDs57rJQswieOdha/rx316V55
         OurZmTehW60xxE3whzpbpHWnfNIoo7HnlArEjF9F2yH+d3ZMZTRUToeHJa609Ds/nl
         ShbeFgJ+MwXrf64MD+x2vHTmMxaEh2O3Bmh0JeVc=
Received: by mail-ot1-f47.google.com with SMTP id t15so3423763otk.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 17:51:18 -0700 (PDT)
X-Gm-Message-State: AOAM533VKkusCyZER1cPMj3m1OvnI73WytIVPlYVUreJJ1HNs8KngJNq
        twwOrUk0EdYm6OR3tbHlBzl8B0ZEqKOIYGLvrw==
X-Google-Smtp-Source: ABdhPJyx487CLhZhpSJBy9lYrsducrFaDu8WKfc8exzvRdK6lM3m/4hM6qip1R36Ep7l9QhVzREB2mnrBCVbHq6XqEw=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr3424039oti.107.1603414277474;
 Thu, 22 Oct 2020 17:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201022220038.1339854-1-robh@kernel.org> <20201022220507.GW1551@shell.armlinux.org.uk>
 <20201022220924.GX1551@shell.armlinux.org.uk>
In-Reply-To: <20201022220924.GX1551@shell.armlinux.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Oct 2020 19:51:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
Message-ID: <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        PCI <linux-pci@vger.kernel.org>, vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 5:09 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 11:05:07PM +0100, Russell King - ARM Linux admin wrote:
> > > @@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
> > >             pcie->realio.name = "PCI I/O";
> > >
> > >             pci_add_resource(&bridge->windows, &pcie->realio);
> > > +           ret = devm_request_resource(dev, &iomem_resource, &pcie->realio);
> >
> > I think you're trying to claim this resource against the wrong parent.
>
> Fixing this to ioport_resource results in in working PCIe.

Copy-n-paste... Thanks for testing.

Rob
