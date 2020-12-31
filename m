Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1F2E819E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLaS2m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 13:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLaS2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Dec 2020 13:28:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F11BE22473;
        Thu, 31 Dec 2020 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609439281;
        bh=6UolhkPVF5GeowbkR7qYVt8SbbBQkg0MBaZDTZ7XZkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EBmsXDcW5jpoarQnWGcHDO9dhpOnFjE9QJKzKdGn/5aX5M02iiGQJ7EyPorGy0U2c
         LJgfnsggWvMWRMpJIMhx9XVeZnem+IbH4LQ4bCVLx+lQDsGt9+eRsxD8eHq1/Wuu+p
         pd4JAumiNyf0fwn+7cGlqpQPgfyHKtnFJEdiAjX313brJFRbq/riIB4OEgoaveEVDY
         /1MjiB/973spChUHDAs462vdAuXoV9CkJdSmM8HZHamRbVA/vC6HkWySja196PFGi4
         yLXH4hDFZFQRl3y1eAAtEpU0SiCsnXrernUogMCK1zZ5PnkmbJ/Wg2Rg2AZsSd0apj
         Ow1I9JyZtZDCw==
Received: by mail-ej1-f48.google.com with SMTP id g20so26228475ejb.1;
        Thu, 31 Dec 2020 10:28:00 -0800 (PST)
X-Gm-Message-State: AOAM531itJTux8A+/SYa+zwtV0cR+tMxXJk9JCMD17WY3Y+JE+gEW/IH
        1BiTABji5TE5hB/8DYctLiaFnk6eTwYhLrSHNw==
X-Google-Smtp-Source: ABdhPJxZmUYiTprAcEpCfD6/J2tgK7kQBJhySuzZfjMMwXoy92HK9fDtQSZwPttUDlwnZOW0iaUAuhyIGCLYtmOb5Uo=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr54869145ejk.341.1609439279516;
 Thu, 31 Dec 2020 10:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20201229113556.5dd4610c@xhacker.debian>
In-Reply-To: <20201229113556.5dd4610c@xhacker.debian>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 31 Dec 2020 11:27:48 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+6HAB4xNzu75oVqoLQZUaEX=Y_j50GAiD4bwY_sq8Pig@mail.gmail.com>
Message-ID: <CAL_Jsq+6HAB4xNzu75oVqoLQZUaEX=Y_j50GAiD4bwY_sq8Pig@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Fix MSI not work after resume
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 28, 2020 at 8:36 PM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
> MSI stops working after resume. Because dw_pcie_host_init() is only
> called once during probe. To fix this issue, we move dw_pcie_msi_init()
> to dw_pcie_setup_rc().
>
> Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>
> Since v1:
>  - rebased on 5.11-rc1
>  - add Fixes tag
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Bjorn, please pick up for 5.11.

Rob
