Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4E326D0E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Feb 2021 13:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0McT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Feb 2021 07:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhB0McS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Feb 2021 07:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D27864EED;
        Sat, 27 Feb 2021 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614429098;
        bh=xCbEHh+FkWpSJkLJVph2u7gMhzOwLYE0/eak4nPjjxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GlkK5zzF3cOoHDgGOwPCURT5LSJHIiIjfahVY7wyjoik5XrnsJ6f8Wct4rTnhveGM
         u5kpDEa54ghQ//woMoAdpCQyZPAEYWfgTlDOWeQuORMECtJs5srnpMyRDxZfUeildM
         tevzrjkIVXrsb09geHHAcflskXAqfuXYIR0EhjCb7rbDpFUVJ5cEiEuftX1q1eFbC+
         HbYAd9YhxYoRbwTW10hKms88rePgnaWbomLAtteX+iNpGMHTjmH3F1TDRqo7tQTUvd
         c2Whpu5GCDHX0Ggmd3njgIDDQUYdRJ1u7uggg0Cmc3s/WWa4VpyT06zzJXw56ET1Dt
         kL8q89WL5fWpg==
Received: by mail-ot1-f45.google.com with SMTP id k13so11762488otn.13;
        Sat, 27 Feb 2021 04:31:38 -0800 (PST)
X-Gm-Message-State: AOAM533z/LdoTn2IyI1UuKayxVZPTD5+jFlgYmGoUZTSMOTt9XUZ7IzL
        anipH1k4RvBZT41nM2fn3XmeSbO3/Gq61em5HBo=
X-Google-Smtp-Source: ABdhPJwcnl8F5FKz59tIBI0s9av0ixuP1VHt2AlYhsmpbwl2BHS6VeMe96XVuDdzDoM6mkkRvk7YKxiHU1a8Kb/IKDM=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr6368646otq.251.1614429097292;
 Sat, 27 Feb 2021 04:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20210225143727.3912204-1-arnd@kernel.org> <20210225143727.3912204-2-arnd@kernel.org>
 <YDlHSYxayqq5WMt0@rric.localdomain>
In-Reply-To: <YDlHSYxayqq5WMt0@rric.localdomain>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 27 Feb 2021 13:31:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1DMCUPgJ5CMfJv3MnTLV8cmv0BdeyCuRjsL0oEZwaJ+g@mail.gmail.com>
Message-ID: <CAK8P3a1DMCUPgJ5CMfJv3MnTLV8cmv0BdeyCuRjsL0oEZwaJ+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: controller: avoid building empty drivers
To:     Robert Richter <rric@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 26, 2021 at 8:08 PM Robert Richter <rric@kernel.org> wrote:
> On 25.02.21 15:37:10, Arnd Bergmann wrote:
>
> A possible double inclusion isn't really nice here, but it should work
> that way.
>
> Also, the menu entry for the driver is in fact only for the OF case,
> as it is always included for ACPI even if the option is disabled (and
> thus the choice is useless). But this is unrelated to this patch.

Yes, I considered doing this using Kconfig syntax by adding another
symbol for each affected driver and selecting those, but the Makefile
hack seemed easier here.

> Reviewed-by: Robert Richter <rric@kernel.org>

Thanks,

        Arnd
