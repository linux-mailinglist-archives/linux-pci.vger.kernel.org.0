Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFC156758
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBHTRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 14:17:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38957 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHTRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 14:17:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so5418730oih.6;
        Sat, 08 Feb 2020 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSeIAIUmAhkC5M6sFAkxYgTxB387Xcn3PJ9kLvph2pg=;
        b=l6KsokbtjWXGyT5bwmgRrkdXtF+FWNl3A5J8QcFXXd4/no5zZWZOI5jJxOgx2irUmh
         o/cLraaYWQfJPTUXU3Q/9/4TrdRVb0vp8bjNFTdq4IS7B2f1Gx0nYvicwqkqBx8OsMty
         WcrwYl9UZWi7fNZAMumyBdFzlW4H73Q8cyfgHmB4G4HccUlxO21sd8DJ+WoB6zYVupIE
         fbN2tMd0JaShcmqsPQ0rhVCjNBWZP01g+pzT8I0oQBqK02AeQHn+d7agP7PbiybtgU31
         +zALunsJLs3ZOeLb/YmwfzuL0waui1q10Dq2EY5JoiLWgKmykWBdP1cn9MIsQVyq7Br7
         qWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSeIAIUmAhkC5M6sFAkxYgTxB387Xcn3PJ9kLvph2pg=;
        b=i57NXX5LyATIsbcNWAPaOhIn4Lf1Fy7W0oSbcKuk+lxJa9CZjzw/epvPKUwpLLaoKm
         a/lW3c0URumbiJQIkCX0f82uShie9KrEYk+yGtRYCKHLs0d9HW6doAO9iC9kHaKQfwyY
         QLch55TeaxQ4OGBor5V/vCOSxJ2qLGUZZzlV6h+RxcOID34cr07XqYG7PZODIsqe9OEF
         23Eyx/3fwusBf5uZ6HRsgO+3unr+VFnDvIxH8ViEUKspOZQP+XTo/UXP1r6hxOeWXa9o
         ikbSXMlEY2sPO4tHZY2Tkws3GXnsxaBpayi/qYPr2PUQNHYFnMtsyfwNCUJsmdgQ1yoo
         yc4A==
X-Gm-Message-State: APjAAAVa9XWHOGm9ZB9o3Rxg3hKCg9+ZrHLRGWEAr7oP2L0Ky6R0EwvV
        UzkTi3TOHbKm6YyQAioKCT28rySbdwxu1PLsYsM=
X-Google-Smtp-Source: APXvYqzD3XmPXLz86r03TtR9E5AFzlwq6F2JlxS+aoZ3btUNJri7WcjtT31Kr7YAEJQ22zusmaQnQtJqbsRFDTnL7AE=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr6111624oib.71.1581189431309;
 Sat, 08 Feb 2020 11:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <374e26ca-cd3d-fd12-edad-5f24622b9d3d@cogentembedded.com>
In-Reply-To: <374e26ca-cd3d-fd12-edad-5f24622b9d3d@cogentembedded.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 8 Feb 2020 19:16:44 +0000
Message-ID: <CA+V-a8skgpMqCRhVERiiEECyb30s8eGvaC+oY=F21oXZ7DJ-Vg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR register
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergei,

Thank you for the review.

On Sat, Feb 8, 2020 at 7:07 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>
> Hello!
>
> On 02/08/2020 09:36 PM, Lad Prabhakar wrote:
>
> > The mask value was calculated incorrectly for PCIEPAMR register if the
> > size was less the 128bytes, this patch fixes the above by adding a check
>
>    Less than, perhaps?
>
Oops shall fix that.

Cheers,
--Prabhakar Lad

> > on size.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> [...]
>
> MBR, Sergei
