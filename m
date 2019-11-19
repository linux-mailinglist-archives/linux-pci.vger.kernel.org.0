Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7896F102748
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKSOs1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 09:48:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36131 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKSOs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2019 09:48:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so23638458lja.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2019 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byAFlXzzH8jPBQ/aAVNrm3vOvpWN1xVTx4/MeZUVxQY=;
        b=yEbnVhm3gtJp5uGUSL7Pok3vTzWxNUWEt1wdLYeOpm9jbdCBolEwskTVQ5PPDzUlh5
         aasWp3wAeGWK7XJ7cTRBQEJmRMZF4DXusWa+M/9ixNWaB0xYJHE1+6XNAUcksjyT8/AY
         bVsChNiPEolUgUcff17R6SZYq72sKm00riC8Rvd02w9Ihz5auKvSUFdJfW0mEc51weHj
         4i4Mm+CCIg0kl4HPX2swUJOd4+Fj5InmXm+KjvmXCTl60j/d+VgpY/bnKkbsSw9mlopQ
         LtYKgQfjNOS+Q4ycfuSJGIVlUp3c+E0sJppMRHweG5oK4v+M/reknYklyUJDp4bE5/NO
         KwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byAFlXzzH8jPBQ/aAVNrm3vOvpWN1xVTx4/MeZUVxQY=;
        b=bK6hx3OQb1MG6H9yX0gTrASjTaGuma9pgtnEWHwDEKZtLViPFRv1xadGPqSkjO11XT
         htj2EvKKFC4onOguJlx0Q0RXs9S7RwJUl+zh0/Ib3xNVv3dLhaLPJAyfBGyAQaSw99bJ
         GyyBlRAd2zcl6MnN3iyWoUpgYwGFDPvwzAJKbFCOcVusuGVo9d9+38Cm5bglbmBFjZEl
         El3nB+zi026t5t+Q5gLhUowjJfdHN9OdxsytXn1PIXCpus0TBHQzseYFg8CwH3BOfAjw
         al1pdWXLrfrKmgw4YEhAyDExBEneC7ci+HBMOyUIcgdte2wYtOYl6Y7Np1RWte1+J7Aj
         r81w==
X-Gm-Message-State: APjAAAVV9WLqP4csm/P2tDDWfmVxqKldzbab431b+K96QqcEeuHZkwVM
        UNLPGUI878A8iOId0m4ZnN+XR0NuU1n1L7hyEm+2Vw==
X-Google-Smtp-Source: APXvYqypBpdcDjYi+awRNbMnaJ0xM8pEhAZMyB5wBSCbVU5PNhff35CN/EVhx1NFDxhNSxkHQUg4ODsr5mR56jda/Ns=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr4247059lji.191.1574174905582;
 Tue, 19 Nov 2019 06:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org>
In-Reply-To: <20191116005240.15722-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:48:12 +0100
Message-ID: <CACRpkdbiBAU451Tt1NqTGhemg800CH-sZQ7YMZ-RR18rzjv6fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: Convert Arm Versatile binding to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 16, 2019 at 1:52 AM Rob Herring <robh@kernel.org> wrote:

> Convert the Arm Versatile PCI host binding to a DT schema.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for doing this.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
