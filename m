Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07794DE17A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfJUAif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 20:38:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJUAif (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2019 20:38:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so11366062ljj.10
        for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2019 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUqtT92AZ9lrnd20Di/UpzfjLJC1pbg37G7/c5IKKgY=;
        b=p21Noq3CV55U0A8VkoqX9m278rUiKa/xxLlh7wdB854lwoLBsD/p2++t0xmNEycGIK
         ANYQQ14P9emosdRn1GHlGds1elZqSmc61JQxwsOk+HFpvm/lrsd1yD/4YJTzbmMzt+Q5
         KTMY/zdvQSJLiuV3K6AQ1QGcIBpkc4R37ftWyRLh9IAm8FQQEHlxsp1q6SfVBobY10Xw
         7AExxFLYrCcP18tEtj8tAyDAm0jUCs4v0IoD/0RrJvvr1mMcc/9hWRivKyNDU07OfqMx
         gzbCsW2jvKPzSCUdmmeSrghFYS3dB0zTeJxQvDHXdK684lBmD+LdrJJQqxko/+eHauF9
         /HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUqtT92AZ9lrnd20Di/UpzfjLJC1pbg37G7/c5IKKgY=;
        b=AuNhChcSTlwlwLQjJU7k2M/IQrN2izrDjHaEb1LD9KEsERlnrfBHBjHlUpx/qbDEz/
         /3dAqcX1kSIliqD8dDlcYIsKG/ML1R6idM3LFR0blhjVMkgqqYBSKaVbgrQH62HKwmVJ
         HryK2mqNUXa69rcfNvH7ZaSDjvYzP8yYudybrX2D9EOxp65QSrLz7mVszSooHyipcU/3
         cuoWMj+fOTfPsc8cwnC85Cpp9deCqkEnTAn8+eTofY3OtFPmrGWEsz6R6HNujlwObI4D
         tXDriClvx/i+aMtb1BbKzerjh2XGnLa5Gt6ca44DgRxEEYTugqM0zU8WL0Hz6Nge+vz5
         +iEA==
X-Gm-Message-State: APjAAAWct8Vz0Q1PA9XmitgxRXOnFgAbtJz++S0cZfVimCYikAQAmGSi
        jp2k65pivF5ThR+hGUN9fBEXqGmACbF3fygr+0Ip6A==
X-Google-Smtp-Source: APXvYqx+Sv2qws2AyWYB+jVZthwdqV3ztSd28/13A632cZQGo2Czb2JB4I8085joST3g83E93e5BoQ6uVRT+sDP11QY=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr12883755ljk.183.1571618313283;
 Sun, 20 Oct 2019 17:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-13-robh@kernel.org>
In-Reply-To: <20191016200647.32050-13-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Oct 2019 02:38:20 +0200
Message-ID: <CACRpkdaxm-mdULkgm3NwncizELJ14SgLAnGLVy6UE+dUXN2ynQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] PCI: v3-semi: Use pci_parse_request_of_pci_ranges()
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

> Convert V3 host bridge to use the common
> pci_parse_request_of_pci_ranges().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - New patch

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
