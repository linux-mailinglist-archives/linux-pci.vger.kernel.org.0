Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A21120124
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 10:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLPJ2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 04:28:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34696 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfLPJ2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 04:28:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so8417998otf.1;
        Mon, 16 Dec 2019 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg5InTeU1+5SFJs1OkGX+MSzCriOaN0CGMKcgjVfhPY=;
        b=REYdlWoCppoJSnQwoBaE+mlNj/PWBu2hmjNYDPB3EHKKn9ekNqeKBaqE5S+WEvj5eP
         mIaOoJmFrZRpmT2YwDXMnszw1lDZUYFxnjs/tQVIalouwWG0HEHlE74hFo275GegcKTS
         dIvktzgT7iSkOp5KFfHf3gICWW9UVUplMnhk+UFJ3hZAdOpZE1UoJy2hwc0ZOjTJSZW0
         MHzZ+4sWJyuGy/MhabiLR4qrNTF25t3/9Ms5+WBAF1C/qEaz2ezxDv/XS3S6vEn2tWpU
         vZhy3yPAcT3xNalK5FcjqBI74kSsU+6nNY1b3r9GSfsS9o4ABXvei8js/FgwPczmKU4y
         9CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg5InTeU1+5SFJs1OkGX+MSzCriOaN0CGMKcgjVfhPY=;
        b=hHtRTBcHm8l66N7v5pfT5LGH+JATA167YOiLMj4nR11SMUTY5SiwFKhNzMD+k1sYCI
         fVxG/YvQN+feDrq6MPKqs4kavcAQohXejV1vGkk8cvyzUnuzix4ZCvYPLBMbwfCWU3pB
         7PiZlSUpZN2Xkj5ALst9WuNb8ncWDRTZwjc5c/YdYEYsk2H+F52nhXfWyADUYCwxfX7Q
         745lZyYtNiRNq+oxIszHeNTjTXPYFqayWgrJ9aQfk8Z3fFxzTbj4tThi3Jhol8Yk56eW
         4j55BOcHlqNjYk209EUiyeZFUdvlieRTEdJP8zpZidfqdL5+eDim/ufdrS+HbFPWAX0R
         ccDQ==
X-Gm-Message-State: APjAAAUAUK73h4B6cVsgWsTI1pEdP4bU334QWNkpnD8L3GKk0stNSXJo
        EQ0SrU+1Ayle4TOq0Don4t+xjp5H4LitP2L8H68=
X-Google-Smtp-Source: APXvYqyGefY4ixRGGGVDGR32f4i/isJOglkcBFAsGS3yQVb39Cm/FzUVt3sGpLUqE3PoqwHroNp3cfe6VCKqeo0YAnY=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr15240871otp.44.1576488495702;
 Mon, 16 Dec 2019 01:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213184627.GA169673@google.com>
In-Reply-To: <20191213184627.GA169673@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 16 Dec 2019 09:27:49 +0000
Message-ID: <CA+V-a8ugehRVuV2kwYgkTVp3Vk4ftKsQVfW0=vL4L7BZbDdeNg@mail.gmail.com>
Subject: Re: [v2 0/6] Add support for PCIe controller to work in endpoint mode
 on R-Car SoCs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Dec 13, 2019 at 9:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 13, 2019 at 08:47:42AM +0000, Lad Prabhakar wrote:
>
> > Lad, Prabhakar (6):
> >   pci: pcie-rcar: preparation for adding endpoint support
> >   pci: endpoint: add support to handle features of outbound memory
> >   of: address: add support to parse PCI outbound-ranges
> >   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
> >     controller
> >   pci: rcar: add support for rcar pcie controller in endpoint mode
> >   misc: pci_endpoint_test: add device-id for RZ/G2E pcie controller
>
> The next time you post this, please update the subject lines to match
> existing conventions (capitalize "PCI", description is a complete
> sentence starting with a capitalized verb, etc").  Run "git log
> --online" on the file you're changing and make yours look the same.
>
>   s/pci: /PCI: /
>   s/pcie-rcar: /rcar: /
>   s/pcie/PCIe/
>   s/device-id/Device ID/

Thank you for the review, I'll fix the above in next iteration.

Cheers,
--Prabhakar
