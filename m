Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87B2F2A88
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 10:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405802AbhALJCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 04:02:03 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35620 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405799AbhALJCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 04:02:03 -0500
Received: by mail-lj1-f171.google.com with SMTP id p13so2021199ljg.2;
        Tue, 12 Jan 2021 01:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haCXkiEdHtQn5zcL0eeYqZrMblZ/rhEiT3dh2wlTt4U=;
        b=sYcwzjav/fBkwBvxLlTLdjkPWbCvlRweeQ/WV7IQALoRgJaKglrw6QbkIZhX2ioWbM
         +NP8tf+aFdeTcpe7wvGOiUt81LDFO4rGoLl3Qkb3sU8XUcc7ivQfoz2bUwq2sqqvbU75
         ZTqSnGOEHmFjfj4621yI1dYYoApWkBB2cNVPc1exgn6Fk6VcablSXGE0jTOXukWaS4sq
         c6fXClviYHSMGS/xHR0yHIPRFJe3T9Q1qSdjPlFs08USsoQafTDfzTpDo7lfr84eKSvi
         7A2P+AkMNjf1dWk26wlWSyW0AkMlD4y+KGQACsKGXB+W9yLvEFfWgkxY3uOtx7Opy571
         qygg==
X-Gm-Message-State: AOAM531V5WbljG7Qz9xd1IWbhX2FD9CU1R30JeLg9344HvcGv4BxblLe
        h8yq+HC8n6H4cxvilwqNeDx8r7d+dv3cpw==
X-Google-Smtp-Source: ABdhPJzEBGdx89BKmB8bHuXXvLUiH6SB24L853o2jEqMjVRy/Ew7V1ZW7ayyhebCIrjUC82DPP8toQ==
X-Received: by 2002:a2e:9d95:: with SMTP id c21mr1620526ljj.51.1610442080558;
        Tue, 12 Jan 2021 01:01:20 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id l84sm310130lfd.75.2021.01.12.01.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 01:01:19 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u25so2232066lfc.2;
        Tue, 12 Jan 2021 01:01:19 -0800 (PST)
X-Received: by 2002:a19:c783:: with SMTP id x125mr1692517lff.303.1610442079205;
 Tue, 12 Jan 2021 01:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20210106134617.391-1-wens@kernel.org> <20210106134617.391-3-wens@kernel.org>
In-Reply-To: <20210106134617.391-3-wens@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 12 Jan 2021 17:01:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v67qXN1FX7cupTvVZrM8XRA4LWxVkfFbWh220CWrU7tyAg@mail.gmail.com>
Message-ID: <CAGb2v67qXN1FX7cupTvVZrM8XRA4LWxVkfFbWh220CWrU7tyAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 6, 2021 at 9:46 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The NanoPi M4B is a minor revision of the original M4.
>
> The differences against the original Nanopi M4 that are common with the
> other M4V2 revision include:
>
>   - microphone header removed
>   - power button added
>   - recovery button added
>
> Additional changes specific to the M4B:
>
>   - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
>     USB 2.0 ports
>   - ADB toggle switch added; this changes the top USB 3.0 host port to
>     a peripheral port
>   - Type-C port no longer supports data or PD
>   - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
>     but only 1T1R (down from 2T2R) for WiFi
>
> Add a compatible string for the new board revision.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This was

Acked-by: Rob Herring <robh@kernel.org>

back in v2.
