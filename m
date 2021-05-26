Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06AF39196B
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhEZOCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232850AbhEZOCi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 May 2021 10:02:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E0F3613D3;
        Wed, 26 May 2021 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622037667;
        bh=XQixEcJqkOpwe4ESYHwpoRdR7IlmfOnePyEk3Qccdcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VN9haU87LXmbdnblf0tdp02YTRe6ldF2fI4GmoAJks0kI1UunK48H82M28NXNBkDw
         wCjB3cB28moYNULUHXlAuomdRswdQj01qjamrNl5aj6Me8d7FK3cbcbh0cKupp3JMs
         19Md8slWDoYAWxX3E+rU9nOKtz85IErP+ZoXwC/Ms6AYGpt14gzATNLfKkHCHIJ1Sv
         N4UCX58ptU+Oy1rCbIZbDId2F8EamocrX8fbXArz++ZBP5K8bnSeJhOo8cbsHu8VyO
         YAyfztfcXN/bgfuJxows3nAXKcNhLwg04ZkPufLifzl1eQRx0tlbrNlumHy8TsMSSs
         bKCFL9K+qLVDA==
Received: by mail-ej1-f43.google.com with SMTP id lz27so2609862ejb.11;
        Wed, 26 May 2021 07:01:07 -0700 (PDT)
X-Gm-Message-State: AOAM53164ExeJLnEbZc4Be7l9sZDxtJhVPsnfgF/vOp+ZyAAsz8pGfrh
        6ilRFdlNZuU6gr5zuojYuGKrfCb4B/I6mIAZwg==
X-Google-Smtp-Source: ABdhPJwq5Xa4mNWiGziRuct/zG8jcIQ+SKXltSpc6TGskq5z9ND/LavBKS9CPZmT8FJEucWbzL+3MK60qx6+FCuOBlE=
X-Received: by 2002:a17:907:76e8:: with SMTP id kg8mr31754948ejc.130.1622037665783;
 Wed, 26 May 2021 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210526133457.3102393-1-punitagrawal@gmail.com>
In-Reply-To: <20210526133457.3102393-1-punitagrawal@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 May 2021 09:00:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLYdXFG11oSmrAfcRoCkSPQYY-VvTr=QVOn8DDmDjm-dQ@mail.gmail.com>
Message-ID: <CAL_JsqLYdXFG11oSmrAfcRoCkSPQYY-VvTr=QVOn8DDmDjm-dQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Update PCI host bridge window to
 32-bit address memory
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 8:35 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> The PCIe host bridge on RK3399 advertises a single address range
> marked as 64-bit memory even though it lies entirely below 4GB. While
> previously, the OF PCI range parser treated 64-bit ranges more
> leniently (i.e., as 32-bit), since commit 9d57e61bf723 ("of/pci: Add
> IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses") the
> code takes a stricter view and treats the ranges as advertised in the
> device tree (i.e, as 64-bit).
>
> The change in behaviour causes failure when allocating bus addresses
> to devices connected behind a PCI-to-PCI bridge that require
> non-prefetchable memory ranges. The allocation failure was observed
> for certain Samsung NVMe drives connected to RockPro64 boards.
>
> Update the host bridge window attributes to treat it as 32-bit address
> memory. This fixes the allocation failure observed since commit
> 9d57e61bf723.
>
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
> Hi,
>
> The patch fixes the failure observed with detecting certain Samsung
> NVMe drives on RK3399 based boards.
>
> Hopefully, the folks on this thread can provide some input on the
> reason the host bridge window was originally marked as 64-bit or if
> there are any downsides to applying the patch.

We can't require *only* a DT update to fix this. Ideally, the Rockchip
PCI driver should clear the 64-bit flag in the resources though I'm
not sure if the bridge driver would have access early enough.

This is not the first time we've had to work-around RK3399 PCI DT (see
commit d1ac0002dd297069 "of: address: Work around missing device_type
property in pcie nodes").

Rob
