Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB5421899
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhJDUou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 16:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhJDUot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 16:44:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1FC061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 13:42:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i24so27373769lfj.13
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me0z+ME7EPFb6ZEEoqdQdGy5VTWw4ckYvRJPBouWGig=;
        b=FY8tIni/Znx8Ji/q6Z7oei+cFOnMvUl/8NwIUDj9x6Qnxm3se6ToBRMhAi43rG2HT+
         UlorbUBm1R/P68pVUnnOpcvS6TMthydily2pUvupAQJd4T+zHQOXsVO7y/XV4p935qmN
         vVN7Vlqb0weZ0XqofDIYp4sENj4Hez4EMgeZnrdctdv9YF/SY7NbgQ0b2AtKIuKxhD/R
         R1SOL+qRSZjFHgTRcl6GZTAXTJQ2fsuhBSCZzDFNFq0ZOmZf0oDXjFyLOqVHwSRsRg3m
         7Nu5Y+bVJA/7UZTtWJvBE0Zy/KBQS+7CGHdsaJJgd4SM6gg9141nLa9orSoiw3uD6Fs6
         4liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me0z+ME7EPFb6ZEEoqdQdGy5VTWw4ckYvRJPBouWGig=;
        b=R/q7Ujpu5uGx5wWTw/hkb6nGDR99Em92HQXKXA6br+Mt5/oqGyq58sf/09QiBISyFF
         HcOKCUjJtmBM2h4h0nKcza0jH3TdTapqC2GveyAeaV7P3OaJZLePYw+IKjkokgK3aa2m
         NSRgA15vwfzPevxDJkbeWr006Mk5m5V88+VXBxncVQ7OdbBJkz7IR1Q3+BFUZFhCi4YE
         cNVh2KmAClHgb15sT+GDBCoNJac1rGxy85Q+MwQABvtdP80AkGHwiCEo1HUloVN12rJ0
         +gmcudPuPLy/mJE1CYLAsXYzGUVDK1wvKT11lmm5VrPzPs0KJi1BCL58SI3ZZ52nWcSj
         sKXA==
X-Gm-Message-State: AOAM530eTUrUL8M48LwTPGTOJagMipFPT6eAssRizEwJTI3vCrdYgTAA
        67rHUI8ymlzL6H+lH62e75J2HeZ7HSj6cnP+MaGVNw==
X-Google-Smtp-Source: ABdhPJwoN+NxJ/fGV7inPNKtUbAVhVuzzxdipfKm/E4oc24DxLBb4XL4OQmZ5Rmgzij431nwk23QZOChQjMyVuUGSCM=
X-Received: by 2002:a05:6512:10cc:: with SMTP id k12mr17303158lfg.72.1633380176925;
 Mon, 04 Oct 2021 13:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20211004083845.GA22336@lpieralisi>
 <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Oct 2021 22:42:45 +0200
Message-ID: <CACRpkdaL=YEfqSmAogLcP0Gn2gUqSaEXZQrJD1GR5QU+DyuyDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
To:     Rob Herring <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        opensuse-ppc@opensuse.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 4, 2021 at 9:52 PM Rob Herring <robh+dt@kernel.org> wrote:

> FYI, I pushed patches 1-3 to kernelCI and didn't see any regressions.
> I am a bit worried about changes to the DT interrupt parsing and
> ancient platforms (such as PowerMacs). Most likely there wouldn't be
> any report until -rc1 or months later on those old systems.

Lets page the PPC lists to see if someone can test on some powermac.

Linus Walleij
