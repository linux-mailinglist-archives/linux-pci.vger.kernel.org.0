Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B824866F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRNwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 09:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHRNwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 09:52:08 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08973206DA;
        Tue, 18 Aug 2020 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597758728;
        bh=F1UGo65DXs9OFY28Zjp/23kFoGYwJB2tDZeX0WHQAH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWcE7oAMdEGkAelwMQFfRzDDR4EPsjKKKRSCPWcR1zusul/q822eJ5A6LaxzxX5Q1
         Av/J1ix4PSiT0Az8MqyHDj7kZVjk2d0aSCmSxAmgUz/tkeUMGSnHlMvZMeoElMP71D
         TPFui8zsHWVQmyU09KtHoL9uluL6HEs2y/IIei18=
Received: by mail-oi1-f179.google.com with SMTP id b22so17945771oic.8;
        Tue, 18 Aug 2020 06:52:08 -0700 (PDT)
X-Gm-Message-State: AOAM5339h0ifrPnf1cWiO+FsTYtMrdieORdQj2zxQL1rPIMyHXHprkhq
        jy11bAxI7QRn1cHdQiAlEWzbx6/7j0iLKcOOyg==
X-Google-Smtp-Source: ABdhPJxGanlb3nCp2GWbiG6UUDuU3rs1/7fktgcZQ7ZyizkaUzNsnIsqV9iFBz6UFmXDZKYRbUztyO63qhD6WjUuI6M=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr79157oif.152.1597758727392;
 Tue, 18 Aug 2020 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Aug 2020 07:51:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+TG7JD2oWGmOSJqqBQihbHr0C12cteH5EtSRLCj63Nhw@mail.gmail.com>
Message-ID: <CAL_Jsq+TG7JD2oWGmOSJqqBQihbHr0C12cteH5EtSRLCj63Nhw@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: designware-ep: Fix the Header Type check
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 3:35 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The current check will result in the multiple function device
> fails to initialize. So fix the check by masking out the
> multiple function bit.
>
> Fixes: 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Add marco PCI_HEADER_TYPE_MASK and print the masked value.
>
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 ++-
>  include/uapi/linux/pci_regs.h                   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
