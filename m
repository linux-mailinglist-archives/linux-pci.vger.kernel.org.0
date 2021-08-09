Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063593E47D1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhHIOnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 10:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235648AbhHIOjq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 10:39:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECEC60234;
        Mon,  9 Aug 2021 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628519966;
        bh=1ihZ2r+7Mr+u9hu6BG8YAHj+316a13abVADO3tMi+5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m81bRfhj2Ga/1o07fPBKAAMRT/NuWWIsGXjOV9ZcvblF3VSWEt4HHjIiFb52A4Suo
         NNwZdC3HLv+6CryXWYuhlgWusVHqN1dqjaO+cVGMaote05SH2VceXdJpcTKDjFgbio
         M1XHUD3WqB1exZfutPPGe5tDGW8auJ2ZLqVUJBsS13WCJ1IWWyGsge1qE4+Nl5F00w
         o8UkOweQjCtxB01M+GmCj6UD2ZXyRNgSwkJVVoRZSUaUXE7QGjhdtzU2glz+kOVRnt
         bC0c8dObBh7wcFJtPpBzb9eZTXP90VNnBg1whMkXZ7DsY6Whx0tw5tC4Ln/ZvDTtW2
         zz7jFeRwY2XUg==
Received: by mail-ed1-f46.google.com with SMTP id y7so24939714eda.5;
        Mon, 09 Aug 2021 07:39:26 -0700 (PDT)
X-Gm-Message-State: AOAM532MwUYja+otCvyvzKC+2pImbEcC11LazxoUEmVzhfrwT/EzpHHl
        XCj+eZ9qQN7O9z6dZWM11YiFi4AfMA6ngJCa8g==
X-Google-Smtp-Source: ABdhPJzB8Z+clDtufI8TAGx9E2xZjWgkEt6Cn39QWZwhkUxrlr7yCVT7FkzqSfuAX1zne9+n2xkutY6VnGcBuZO6x08=
X-Received: by 2002:aa7:c603:: with SMTP id h3mr30164744edq.165.1628519964968;
 Mon, 09 Aug 2021 07:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210625065511.1096935-1-xxm@rock-chips.com>
In-Reply-To: <20210625065511.1096935-1-xxm@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Aug 2021 08:39:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+b9adwUav8Ny43hsdB_mVPaKcV4wSJYydGuA1f5u-YQA@mail.gmail.com>
Message-ID: <CAL_Jsq+b9adwUav8Ny43hsdB_mVPaKcV4wSJYydGuA1f5u-YQA@mail.gmail.com>
Subject: Re: [PATCH v11] PCI: rockchip-dwc: Add Rockchip RK356X host
 controller driver
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 12:55 AM Simon Xue <xxm@rock-chips.com> wrote:
>
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  11 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 276 ++++++++++++++++++
>  3 files changed, 288 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c

Reviewed-by: Rob Herring <robh@kernel.org>
