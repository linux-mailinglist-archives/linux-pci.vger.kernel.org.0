Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F15DABEC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406119AbfJQMZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 08:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfJQMZD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 08:25:03 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A864021D7D;
        Thu, 17 Oct 2019 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571315102;
        bh=LrQnz98uOVhoyL8C9jQ/wywj8PjyWmRHMV/7DS2tY4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zu+0INm1hJy9vc9v5kn3GgXSkcVIG6uOYhfSj3digX3umNQnSVVQnmVmEG3zhPLa+
         m/6i4tKlKnjpgFq/AXCMtLY1+Rpq1Viq52FfvW0UObUiT28jIhvn7/lKGECBJKcEn+
         dABuMoopMqlt5uUyA0LtKMpMXmpu8chzMOcmfhJE=
Received: by mail-qk1-f173.google.com with SMTP id h126so1619912qke.10;
        Thu, 17 Oct 2019 05:25:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXmHGyio2hBvZsVhJqm8Ca5PwIAE+ZboMMwGeWX1hZSQ1ZLCzFF
        xUck95nEHmNCRZqPV3Hun65Q+87jR/B1nc1TiA==
X-Google-Smtp-Source: APXvYqykgRdraUNdbziBpUQsRMBhKGPDacKw+vE+jl7H1/l6Fb7fZ4vekhfagyfuSNF6yc1qHpHfVqZsnpUaNiSiAoQ=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr3039133qkl.152.1571315101761;
 Thu, 17 Oct 2019 05:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-12-robh@kernel.org>
 <20191017072625.GB19517@infradead.org>
In-Reply-To: <20191017072625.GB19517@infradead.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Oct 2019 07:24:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Hmwy04-XtTCp+H=H5BeaFVeHXgq1R0xVvBdgPEsDbPw@mail.gmail.com>
Message-ID: <CAL_Jsq+Hmwy04-XtTCp+H=H5BeaFVeHXgq1R0xVvBdgPEsDbPw@mail.gmail.com>
Subject: Re: [PATCH v2 11/25] PCI: rockchip: Drop storing driver private
 outbound resource data
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 2:26 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 16, 2019 at 03:06:33PM -0500, Rob Herring wrote:
> > +     entry = resource_list_get_entry_of_type(&bridge->windows, IORESOURCE_MEM);
>
> This add another too long line.  Please audit the whole series for that.

82 characters didn't seem worth a line break...

Rob
