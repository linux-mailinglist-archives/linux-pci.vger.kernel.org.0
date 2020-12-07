Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC32D13CD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLGOb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgLGOb5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:31:57 -0500
X-Gm-Message-State: AOAM531c+iUJKW3LpnDerJO3ozmy9tziAJeuSilzdlq/HvcfKwKnwpwv
        aUqCdQO9EevvP2WlMyWjVdw0HQIinfxvjxnJpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607351477;
        bh=cqmik7jy/N0+j77CAEYBbsCVlpLDCXBvftlMySKxxnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=joNQwW4k75s1SI5D4e6g0TztrAHAhKpjiF8Yt+8uhHtm5fg3FoLp8ES+Azq9YpwSk
         i7BzInVYVGmdTmTCRpL/IPbZL0JtxfUiPpw4zccr8IwMBdY7Bdn8Nxqk2qk9RehAD7
         FNaTgDthAKfYRw23JVBsQaRbyqHfxhUDEXdVG3F8Gf/EXvjVaT1zU/7T7NjjZ7nfe2
         fvz9g0U00IPi5uOTJOz0KcjBD+ot2AUisbbInqahxDNSpskyBFmIjkxRkyx0DgtAVj
         lS1dvwffs5GDNjG0bRTbzfJ0rR5htQzFnom9OuwLLy1bEp5UY+wCjuP472MISQ1udq
         HzLeRL7Kv5oiw==
X-Google-Smtp-Source: ABdhPJwmyrtH4XAio3O5k76Jb95ok7SNMUoEBjz5jd8M5vNtApkguuzQTNM9mDekCLe+iZdI+HFg332uIKzofj6eSvM=
X-Received: by 2002:a50:ab47:: with SMTP id t7mr20559440edc.289.1607351475832;
 Mon, 07 Dec 2020 06:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20201204075117.10430-1-kishon@ti.com> <20201204075117.10430-4-kishon@ti.com>
In-Reply-To: <20201204075117.10430-4-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Dec 2020 08:31:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkDu_rm1H7OQRxgRdUEKaB4_O8sNOCvAL29Q3Vj-h8qw@mail.gmail.com>
Message-ID: <CAL_JsqLkDu_rm1H7OQRxgRdUEKaB4_O8sNOCvAL29Q3Vj-h8qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j721e-main: Remove "syscon"
 nodes added for pcieX_ctrl
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 4, 2020 at 1:52 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node
> point to the parent with an offset argument. This change is as discussed in [1]
>
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>
> Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 48 ++++-------------------
>  1 file changed, 8 insertions(+), 40 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
