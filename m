Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9F3DF72C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhHCWBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 18:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhHCWBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 18:01:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DEAB60FA0;
        Tue,  3 Aug 2021 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628028053;
        bh=YgcQRaQCrh6jgIsmUNwvtzQmhCjaAmndO3t2iNcKXog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2cypB+HhtX5Wp44qIe7fI0F+C750ap/8QDy61pJcNeG/JOKteHQmpdhU9PUlRuKt
         r/Ribms34YmPfCd4sD4oVyZ42MB3V18EM+aF85i7aN4hfD+izcr6NMig/A6jUcE/b0
         uc4M4ki5kRdM9nwq8HJcZgRwSjdJrz9GbEZfdLx1qB2vaSyucyNUe8to5B/zsBuDjB
         j94NJQjMZ+O8ozpEQMVtqqIEPOikGCdeR6WueYMJ4FA63pi8CFk6YMGZrsx6s867v8
         MPAOmBoCu9cj6eaq1j1eSt4lt1BUYb7ydxoer5C7CTbjZ8k1qSzkwnorSeiHi01QPP
         023xqPuZTOX9w==
Received: by mail-ej1-f41.google.com with SMTP id x11so729928ejj.8;
        Tue, 03 Aug 2021 15:00:53 -0700 (PDT)
X-Gm-Message-State: AOAM532upCp58cKyMd05dmabhwcR1nyq1RSmxd3cn3hW7NhpR+yT+dgy
        zrYi97AcdGDhJ1Hd9GKya9l/2aJihYxwa4ZKTg==
X-Google-Smtp-Source: ABdhPJwz4h8NNTRdPM7c3ps1AwTtRoK6yY7hOTk68sydmHZ3zrBBq8RyD3UC5zFzAt+5LtmRdAf8E9Roeeom0WxvZy8=
X-Received: by 2002:a17:906:4917:: with SMTP id b23mr23545434ejq.468.1628028051689;
 Tue, 03 Aug 2021 15:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <440bd70a-81c4-357d-9fb5-1f45fca17148@gmail.com>
In-Reply-To: <440bd70a-81c4-357d-9fb5-1f45fca17148@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Aug 2021 16:00:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKd9Yz=pEdv7bjRcvQnio1nPJzBVxz9rexmQ-u00REQYA@mail.gmail.com>
Message-ID: <CAL_JsqKd9Yz=pEdv7bjRcvQnio1nPJzBVxz9rexmQ-u00REQYA@mail.gmail.com>
Subject: Re: PCI DT regressions affecting Northstar (iproc driver)
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 3, 2021 at 1:45 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> w=
rote:
>
> Hi,
>
> I normally stick to LTS kernel releases and I just late-found 2
> regressions while switching from 5.4 to the 5.10.
>
> The whole thing is about Broadcom's Northstar platform and a bit quirky
> iproc PCI driver (precisely: pcie-iproc-bcma part). The iproc PCI driver
> supports both: platform device (based on DT) and bcma device.
>
> Northstar support uses a mix of DT and bcma. The later is a bus with
> EEPROM containing platform devices info. Its history is decades old and
> that design comes from pre-DT times. In any case:
> 1. Northstar PCI controllers are bcma devices with minimalistic DT nodes
> 2. Everything worked great with 5.4 and quite OK with 5.8
>
> Reference:
> * arch/arm/boot/dts/bcm5301x.dtsi
> * drivers/pci/controller/pcie-iproc-bcma.c
>
> Could you look at those problems and check if it's possible to fix them
> in some easy way (without a big refactoring) please?

I just sent some untested fixes.

Rob
