Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190653F76A8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhHYN40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 09:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhHYN4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 09:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BDE261181;
        Wed, 25 Aug 2021 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629899740;
        bh=CMOIWCczQT4MgFaI6GqXH+oiMJf1br9qrx50dqeRq5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V3SgFiNhC0R9bdoddbTu5Pg06dVEss6l1c+OfOQj39ExOPiFGwoZ4QgvxQ9MdvZLv
         4ZOJpIMkj+bMESUXcbMUSUW+FEuX3pJGnltEGwJ4wzuUhxq4ECJs1SBY93mvu4a4xe
         NX+99v5e/UHzDjzEGBuFvKEvNE0LUkgLSMPeH85rmuA++6rzMHhPH3FOPkJnzvg5F4
         +l+R4TBt3otnnjQvcuRRLhq+LaU8Qt5PTb3czhhIeLOQ6Lw0gblTcZqXQh514JEuTM
         CgPqVo1Oi1BGPP05lcWoOr3oKnQr0PLs6ds/GaVF/bwhEbH63IlV0NYzb2awvuifNx
         PzyKP8N51W5Nw==
Received: by mail-ed1-f46.google.com with SMTP id y5so6270704edp.8;
        Wed, 25 Aug 2021 06:55:40 -0700 (PDT)
X-Gm-Message-State: AOAM532NZuShtGh6hlBurYSuOCYm20sCxfmSOMjVgGPoiRDFXB7FK4VO
        AaY2b3uG+iw9BOP5dQ6OJjy9An38PHRdu3f2MQ==
X-Google-Smtp-Source: ABdhPJyovIqS10mCF1OXQh8B8tpgcX65+nKq32xtqbR1AtrPh00wtS6rwINBkiF8zOk6WoNntaaBmmAmO3DZuJhOBYk=
X-Received: by 2002:a50:eb8a:: with SMTP id y10mr5724315edr.137.1629899738846;
 Wed, 25 Aug 2021 06:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210825083425.32740-1-yajun.deng@linux.dev>
In-Reply-To: <20210825083425.32740-1-yajun.deng@linux.dev>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Aug 2021 08:55:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
Message-ID: <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
Subject: Re: [PATCH linux-next] PCI: Fix the order in unregister path
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> device_del() should be called first and then called put_device() in
> unregister path, becase if that the final reference count, the device
> will be cleaned up via device_release() above. So use device_unregister()
> instead.
>
> Fixes: 9885440b16b8 (PCI: Fix pci_host_bridge struct device release/free handling)
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/pci/probe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

NAK.

The current code is correct. Go read the comments for device_add/device_del.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ec5c792c27d..abd481a15a17 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -994,9 +994,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>         return 0;
>
>  unregister:

We get here if device_register() failed. Calling device_unregister()
in that case is never right.

> -       put_device(&bridge->dev);

This is for the get_device() we do above, not the get the driver core does.

> -       device_del(&bridge->dev);

This undoes the device_add() we do following the comment: "NOTE: this
should be called manually _iff_ device_add() was also called
manually."

> -
> +       device_unregister(&bridge->dev);
>  free:
>         kfree(bus);
>         return err;
> --
> 2.32.0
>
