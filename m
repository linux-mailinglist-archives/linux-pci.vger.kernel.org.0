Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E83DE191
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJUAmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 20:42:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfJUAmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2019 20:42:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id d1so11345722ljl.13
        for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2019 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5RAFiewUpPwyWuNdO/9XHW8T8gkSCyTvJItx6zJP94=;
        b=KmVc3jxGab4evVVavdh8XOYseBclVoWhBn3e9VOmXOZdYnYPMcL5SpohY4awkYK3DQ
         ETOCTAvUrzeAA3ul7m/7zfE0PHm6zwSF3ye2VoN++TBijRbvYwEkQCP05TO+pB9YqrFR
         +q7MfhaCHG4BsAstUzZZHQ8PulcP3ubwfYlrvNuM/ElkY8bA2eObOyRtPuiA3p/mY54V
         VP2vhufU23hOrjdFpos+8jdfhEXZfXeYSaLsJ+vvLJAv4qBMDOfDfq/V/XtjjgF0Ai55
         +EMVQR7fFKfIUu14QUj/HT8f24/VPzQjTJwZmF+Vdyf/LYZVLXDM9MQCxVYrUDTqA1fw
         E3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5RAFiewUpPwyWuNdO/9XHW8T8gkSCyTvJItx6zJP94=;
        b=TOdms4YoYUUwi32J/39OJeXeqW6wYC9DQ2jP/52vbARyEpu6x2O83ouPAhJdDlkgZN
         MBk2nDigCQ3pWRFv78azY0Ru3uF/ac13tgscASrEqDHmRok7ujApApcm4a7vy2rBD21S
         KIVQCuXLt3a+sOQO8T0fSrCjFv32uh5UA/N1ocpW41DifUbJY+OMCJtAsIWrNGAI4um/
         e6FX9muU9ECygW755lptFQrRG49YxdqoM2FN3raY5H/V70WAQoDkNMdcY4sTERkX0xxo
         p+HqBDlCyIfXZ86gmPr/qmSaXPyT+/Aj+/s1oVE/N9GoQPjyxh/YoXBNNm39xw5rcPle
         GIBQ==
X-Gm-Message-State: APjAAAWOEy3lLPontL+8m1DWBy4B0jLT67qmIUF6ax3ev5SoQEto5b5K
        p8q+Bt7WINgzZ5W85++mdiIKT882AyfC+mjVqeogPw==
X-Google-Smtp-Source: APXvYqx02W60Klyl42qZZwLW2dzAZTfOGWXnrCHVzSdWGC2CYqb7qVDnpQS6901eL0bM7HBE5DOtd24dGywuNoa+dsM=
X-Received: by 2002:a2e:1214:: with SMTP id t20mr12711065lje.191.1571618531310;
 Sun, 20 Oct 2019 17:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-21-robh@kernel.org>
In-Reply-To: <20191016200647.32050-21-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Oct 2019 02:41:58 +0200
Message-ID: <CACRpkdby+LF5B8t8omn4CVv36NoYya0DZJPCi3a-4FUmDCFrVA@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] PCI: ftpci100: Use inbound resources for setup
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 10:07 PM Rob Herring <robh@kernel.org> wrote:

> Now that the helpers provide the inbound resources in the host bridge
> 'dma_ranges' resource list, convert Faraday ftpci100 host bridge to use
> the resource list to setup the inbound addresses.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
