Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9321ADE18C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 02:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfJUAlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Oct 2019 20:41:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39951 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfJUAlk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Oct 2019 20:41:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id i15so1161384lfo.7
        for <linux-pci@vger.kernel.org>; Sun, 20 Oct 2019 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+bmNIcrnyOIzrPmxwvjVgZiBAJd1fM+3wbATTNFbEI=;
        b=mLAX2bW2iX5ydQdQba6GHiEYCGuP3ryiI3ZGiaySwfC3y8Qhd9wrPmUBZI5OiTWvwT
         wPQOA7PyZyWL2zcmKOeQYLc5fwcB20NjJgUletSLLOah1HsnJ29+iSbQWuDyeB8SQWTn
         Ld9wXWuG66dbY+YAzanSVTWfpZmcgDAXgJNhEPK2VzpwUHVRm1zO39/xCUi38A7323Oi
         8WDhYNPbYDeIKFkc63K7uVj7xqE2WZfnxrd0duu6RROq5ixmu/g8+fs0dtIJUe/Ifdu9
         SuQWLo/Gfs8DPn2mc6jejc3Iw/NOwYGQNv5V97tLh1nivdcvh1Iyg/RHcLvVBnaKRX2g
         xGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+bmNIcrnyOIzrPmxwvjVgZiBAJd1fM+3wbATTNFbEI=;
        b=ZZpklmOSAFlIw10X8P9KS5z7WlTgKLvnEb0iNHufOnT16yfdZq6UF/Ei6w+30xb9eP
         bk66aDO3L/IMzCeWz+Azq1B7EoZhewCg6+B2tTobUAR7DFIl+onFKu6dfqBqUPc5F2kZ
         mSKXYcELCUgHnaPd8iVuy+3ei3gvC6z+HtXOst4ejKIMvHEDaG1ReZJw2yYtzWUO6v/b
         M7BG7oFmhSJnn3FOA9vKCfvW7w2SmhcdHBXM9+NpDlvvTizNdquJBsI2RBOKVxxb1YKc
         z1UFGetVvNnxIN9FFTIjPHJN64sGYAf7nikfrz4mTzZgOFtkROOg97DzFFxqp8hUPh/h
         zviA==
X-Gm-Message-State: APjAAAUmhFdtP2I5ELIKNNYLA1nGkOmiLz83CjKnlmZ+lqQVoZA5bz8T
        AGwQJblul7HEtvzoOb8c5Hoz0uX1GjX9PmDRagHuIQ==
X-Google-Smtp-Source: APXvYqwIyNjawN1mEod1YyKYfTSA83orVXCv2STO/nJGv1866U3Q0y95F+b9JrmTVy90oQrZGDMZUrGbFb9ILn0rOUI=
X-Received: by 2002:a19:f018:: with SMTP id p24mr2105108lfc.93.1571618496433;
 Sun, 20 Oct 2019 17:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200647.32050-1-robh@kernel.org> <20191016200647.32050-19-robh@kernel.org>
In-Reply-To: <20191016200647.32050-19-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Oct 2019 02:41:24 +0200
Message-ID: <CACRpkdYq86_h7yPr3+UJryNWHLqrzrR0SbhWRALcEVCR-pE9+Q@mail.gmail.com>
Subject: Re: [PATCH v2 18/25] PCI: versatile: Enable COMPILE_TEST
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

> Since commit a574795bc383 ("PCI: generic,versatile: Remove unused
> pci_sys_data structures") the build dependency on ARM is gone, so let's
> enable COMPILE_TEST for versatile.
>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
