Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D834260290
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgIGR3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgIGR3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 13:29:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F1C061573
        for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2020 10:29:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so3823787qkf.4
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2020 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3kwXj89Yh9dEdlh52K/qRxoxl+rESWZenHBVCslYH8=;
        b=jrwGfytVrcuygqGHIER9iz2wPV/g6TUHZ6ZHbWFNgrYNCzV7n075KCgcuqM87ufZNp
         gu+r7Ec5zpTtx3JtnTPx11Oal010u4mKgrt5l7aWarknkPffdhRksqsB6VG0TKA1zowF
         VFv28I0TVj5md2YV8nLqXkq6JVcUJgtxnTbfO/AbRaIzNllC3HRk8jfnvOTA0jMlWa2q
         O3GAokfHCL6209TmrnbODA2KdumhvzkPYHYYnqFcsEWNi+2fjZKxHDW4u6raQvRFYpL7
         Z/p3+vJA/Qpc/0kvOcBZosaQzZ6JsShzVH5y7Wk3W69ZueOsYCUypPWns/LB2DzeNFOG
         7jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3kwXj89Yh9dEdlh52K/qRxoxl+rESWZenHBVCslYH8=;
        b=iJ3AbWvx3gNtZrLF1eDddvuctsjGooWsUzf88DL+jz1e9VjEKOnhB0k86vkXGmrgKT
         06SnakF1zZojVQActRta8joxzkjSz60qBT/3shQFtiT6LFLpc6cgRc0y2SjxoYxo8XRi
         0KNrZjqo0XH2KZzDiUDsGudVj48su4OnicR5MquCwh2sLzESJg7X1qShz41ef53lp1UD
         sIGbRALfgGDkCCLmHPb7y2qYwpZZB//T1Z/pqmqOShQuBNIJUpQpPmyqAlNl6uYOsTRh
         yNSnzr8Wo+LakIftgrE6mBRF74IfEsnIxnHWvBkDaU/aVpxY755hSGnlSkUyFvFrudmk
         X1CQ==
X-Gm-Message-State: AOAM532Eqnnvp8kME1dxaudyDJ37FGo0E3rcekqg8O827b8NITYewebA
        nD6bV/Z1zx/5aSXVBrl34lBpPw==
X-Google-Smtp-Source: ABdhPJw33XS5uaiOB/0gMwFN0ZG5DEyUAcgxGf6NM84ZW49PWTXHcRhsszMplWr32J5FujnTlCrTYA==
X-Received: by 2002:ae9:f306:: with SMTP id p6mr18636285qkg.104.1599499769017;
        Mon, 07 Sep 2020 10:29:29 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id y1sm11793217qti.40.2020.09.07.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 10:29:28 -0700 (PDT)
Date:   Mon, 7 Sep 2020 13:29:26 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Fix bus checks in
 rockchip_pcie_valid_device()
Message-ID: <20200907132926.27d0da14@DUFFMAN>
In-Reply-To: <20200907102016.GH6428@e121166-lin.cambridge.arm.com>
References: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
        <20200907102016.GH6428@e121166-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Sep 2020 11:20:16 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Sep 04, 2020 at 03:09:04PM +0100, Lorenzo Pieralisi wrote:
> > The root bus checks rework in:
> > 
> > commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check
> > if bus is root bus")
> > 
> > caused a regression whereby in rockchip_pcie_valid_device() if
> > the bus parameter is the root bus and the dev value == 0 the
> > function should return 1 (ie true) without checking if the
> > bus->parent pointer is a root bus because that triggers a NULL
> > pointer dereference.
> > 
> > Fix this by streamlining the root bus detection.
> > 
> > Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check
> > if bus is root bus") Reported-by: Samuel Dionne-Riel
> > <samuel@dionne-riel.com> Signed-off-by: Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)  
> 
> Hi Samuel,
> 
> I would kindly ask you please to test it since I changed the code,
> I need your Tested-by before asking Bjorn to merge it.
> 

Hi,

I'm sorry, I had tested it, but didn't reply back as it worked. Not
being familiar with the customs of the mailing list.

Again, just in case, verified to work and fix the issue on top of
v5.9-rc3.

-- 
Samuel Dionne-Riel
