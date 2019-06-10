Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CF53BB31
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbfFJRn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 13:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJRn5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 13:43:57 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61277212F5;
        Mon, 10 Jun 2019 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560188636;
        bh=AZlQL9E2ROhE9dNEWLxTzeKWJPg5GnszFYOvXmJbBg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CrkXG5wzrMqurUflE6xs0eXDpspfh1CAZP1781AveldXZWZOfaRKic4GxAG0tqNPd
         zh5oPa+/V/Kp6pLCYHJJyKZMrZ3Eqg6gBH2M4OqRThkgZ3hn+CODbDBqirClpMRH4H
         F7A2m9ROQPEpCCNtsRiVUnRemEm5cXLnDw5LTiXs=
Received: by mail-qt1-f173.google.com with SMTP id a15so11442870qtn.7;
        Mon, 10 Jun 2019 10:43:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUg2K6unKsXNWSCcp11kmWeR2XbzYkkEmlouRSsmUmDMzLCc2O7
        9FF5arv4OmHCSKkNfFjls8RTBr52ndtFsoCLMw==
X-Google-Smtp-Source: APXvYqzDejCp888til0iSdGiqZLydQgb5LlMSykGZiQj0zmAnd1634cGl5crZnyD5/9LsdKeiuv6AfpNt6+njC+kFIU=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr7491168qth.136.1560188635556;
 Mon, 10 Jun 2019 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190604131516.13596-1-kishon@ti.com> <20190604131516.13596-24-kishon@ti.com>
In-Reply-To: <20190604131516.13596-24-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 11:43:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
Message-ID: <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
Subject: Re: [RFC PATCH 23/30] of/platform: Export of_platform_device_create_pdata()
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 4, 2019 at 7:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Export of_platform_device_create_pdata() to be used by drivers to
> create child devices with the given platform data. This can be used
> by platform specific driver to send platform data core driver. For e.g.,
> this will be used by TI's J721E SoC specific PCIe driver to send
> ->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.

NAK

of_platform_device_create_pdata() is purely for legacy handling of
auxdata which is something I hope to get rid of someday. Or to put it
another way, auxdata use is a sign of platforms not fully converted to
DT.

Rob
