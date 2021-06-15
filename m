Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6138B3A8AB6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFOVLT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhFOVLT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:11:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0BB613C7;
        Tue, 15 Jun 2021 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623791354;
        bh=XPZFATeT6O1TSS3iPQi0I85I8kVNARs+UfjO8U3dfVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pPA+xbPwkHvD/bRBsqIYaropPUgzP0KRUX71yffRfdKMlT/fWysCvoLdreNOuzDYZ
         jfryhOoN7kI5G/puKCbf+W21R7hEc5ohnGEOBEuHS5m0k4EWdQdBWyR/c8cTtAdXv1
         +QIONcpJ82r85IRnqVzeKg5EHZ6ljaYX/IFxIh6qSjxJCLQRo/o2Dzw08SJFQtmKqI
         KB0+U7a+IBrTIdk/Kq03p0Zv0ClsMDjRKsS/1R/Dtugzc2TY4I++m8dO+LU1yqhCZd
         SE9pE+W8tWpE0tbYrdr1SzcOp++7jpcL4G2avlE8mXfwYFJjq+mJ0JChjaqnfpNxF/
         ij9pYyK4nHG1w==
Received: by mail-ed1-f41.google.com with SMTP id t7so7751550edd.5;
        Tue, 15 Jun 2021 14:09:14 -0700 (PDT)
X-Gm-Message-State: AOAM533mEukABkC/Efgr+n8RUc8Vs/YiVvLX0Iw1AD7RA0ygOSrfPEQQ
        5OKnZ+VYIczWhceRzkAuRC9tTAdcUEAdI9OqkA==
X-Google-Smtp-Source: ABdhPJw414bzNY20+um3YrNRtQXFNYn5br7a3HAvmXNIDiJkSz+f0qWYMHTTl029XmRnYhAh7UpWGbc/GfiHf7emSTc=
X-Received: by 2002:aa7:dc4c:: with SMTP id g12mr161778edu.258.1623791352761;
 Tue, 15 Jun 2021 14:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210607154044.26074-1-srikanth.thokala@intel.com> <20210607154044.26074-3-srikanth.thokala@intel.com>
In-Reply-To: <20210607154044.26074-3-srikanth.thokala@intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 15:09:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmLz2TChWYGtEGtHpd5aO4hp+zvx8cExb760PDsx-nRg@mail.gmail.com>
Message-ID: <CAL_JsqJmLz2TChWYGtEGtHpd5aO4hp+zvx8cExb760PDsx-nRg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
To:     srikanth.thokala@intel.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        mallikarjunappa.sangannavar@intel.com,
        Krzysztof Wilczynski <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 7, 2021 at 1:47 AM <srikanth.thokala@intel.com> wrote:
>
> From: Srikanth Thokala <srikanth.thokala@intel.com>
>
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
>
> In Root Complex mode, only internal reference clock is possible for
> Keem Bay A0. For Keem Bay B0, external reference clock can be used
> and will be the default configuration. Currently, keembay_pcie_of_data
> structure has one member. It will be expanded later to handle this
> difference.
>
> Endpoint mode link initialization is handled by the boot firmware.
>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> ---
>  MAINTAINERS                               |   7 +
>  drivers/pci/controller/dwc/Kconfig        |  28 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-keembay.c | 451 ++++++++++++++++++++++
>  4 files changed, 487 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c

Reviewed-by: Rob Herring <robh@kernel.org>
