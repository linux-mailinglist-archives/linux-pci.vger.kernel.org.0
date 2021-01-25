Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25363302344
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbhAYJfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 04:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbhAYJeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 04:34:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E473F22CA2;
        Mon, 25 Jan 2021 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611567223;
        bh=LoIB1bA+ezvZ2fc38suz7JsU86cjah1sWpf33c33KCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxyvdXpZdSd+tQ6y7hcdHc1tpr3SvvIJV204esOcoj7xl5KVPHUxcaz1kVhapD2Fx
         9RI8RtYzYhowA0DNLDm7KnE8JZWyXWlQCZoBxeViYRFfxvJ3ByxfubL4syOAS8GaOP
         Vf3Fu13OfIFNjJTgz2bzuT5WubD4zdzf4eEKj8B2rcw7TjVfXzRpXThIVPzN4xK1ha
         0+72e3miTW/6/d841fnvcpre8wzVFspT+F1Bx9BQBfV1fP2ufGOLdEr4WIdpTo8I9e
         AvPKIiolgUr6ZbqU3HvfSCs/v+tZhnKM1usmkD0vobHd4Za/H10CteqgtturW2ZVn2
         JJVzNSxSkc8ng==
Date:   Mon, 25 Jan 2021 11:33:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        Cyril.Jean@microchip.com
Subject: Re: [PATCH v20 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20210125093339.GG579511@unreal>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
 <20210122145137.29023-4-daire.mcnamara@microchip.com>
 <20210124113337.GA5038@unreal>
 <MN2PR11MB42694FE9CF48F7904035660696BD9@MN2PR11MB4269.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB42694FE9CF48F7904035660696BD9@MN2PR11MB4269.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 09:29:01AM +0000, Daire.McNamara@microchip.com wrote:
> Hi Leon,
>
> thanks.
>
> Just:
> > +builtin_platform_driver(mc_pcie_driver);
> > +MODULE_LICENSE("GPL v2");
> to
> > +builtin_platform_driver(mc_pcie_driver);
> > +MODULE_LICENSE("GPL");
>
> or does
> +// SPDX-License-Identifier: GPL-2.0
> need to change as well, to:
> +// SPDX-License-Identifier: GPL

You should change only MODULE_LICENSE(..) and leave SPDX as is.
See Documentation/process/license-rules.rst

  448     "GPL v2"                      Same as "GPL". It exists for historic
  449                                   reasons.

Thanks
