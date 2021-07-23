Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69D3D41FA
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhGWU3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 16:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWU3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 16:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E84F060F23;
        Fri, 23 Jul 2021 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627074594;
        bh=S1RyrhXdrAJLHGDiVIMsUz+rt8tFgWcQL/m10hYrsUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oYQHD/nzWUvyhydsxnXQU6BFh3kD8PGkXNyavmuRPi31TBZLvUmkxWSjBfELnIRMX
         AqAUdSwdfEIdwfrk3p37KlC3U/mseazwl5+g3Q1XLxwZtJg9ZdMCRLkd4Y5q9JnajD
         jc+R/ClrGGr5oHBytuXHPUtmz31LHrZOe96m7gX7jjB/n+KVfwe53jNIS2t/VQlmvc
         ck8IHtxoU8dXvLhSOYSiRcunLSCjfYlpbDN0RfQDaVAM4LjPUh7Ls8UlzalS3STzvZ
         6obQNdffUGNFa3P8DBda7jlZ1YXfP0LHE+iQ3NpRcmbcTy7eZZseVlzoll8DpDB2AE
         t83/7tVTFy8TA==
Date:   Fri, 23 Jul 2021 16:09:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rahul Tanwar <rtanwar@maxlinear.com>, bhelgaas@google.com,
        robh@kernel.org, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ckim@maxlinear.com,
        qwu@maxlinear.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH] PCI: dwc/intel-gw: Update MAINTAINERS file
Message-ID: <20210723210952.GA440386@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723152805.GA4103@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 04:28:05PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 06, 2021 at 04:20:59PM +0800, Rahul Tanwar wrote:
> > Add maintainer for PCIe RC controller driver for Intel LGM gateway SoC.
> > 
> > Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3298f4592ce7..61c1cfcc453b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14392,6 +14392,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> >  F:	drivers/pci/controller/dwc/pcie-histb.c
> >  
> > +PCIE DRIVER FOR INTEL LGM GW SOC
> > +M:	Rahul Tanwar <rtanwar@maxlinear.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> > +F:	drivers/pci/controller/dwc/pcie-intel-gw.c
> > +
> 
> Hi Bjorn,
> 
> do you think we can merge this patch as a fix in one of the upcoming
> -rcX ?

Applied to for-linus for v5.14, thanks!
