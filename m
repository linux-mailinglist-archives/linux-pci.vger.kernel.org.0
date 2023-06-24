Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5A73CB5F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFXOXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFXOXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 10:23:34 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5EC1BD6;
        Sat, 24 Jun 2023 07:23:33 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-666ecb21f86so1516276b3a.3;
        Sat, 24 Jun 2023 07:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687616613; x=1690208613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l61WbsGIflGvlUxdvoJkBkB8edAun9mmIBPamQIpoWM=;
        b=WlhZh2un2W+mSqxtEXiZl+aosNZr2GYzB6kzB7tAOnkWQ/Qs4zBKuDh2AJl+12AUSX
         Q5UMywz4ZgGR5h2XJn4mfWukV+sS4MMLKuoYFyrGUkLI8yE+3qFXuEVc6l/MpL+8wEDk
         GH9FEnwSq3liU5dRgBVreGcBUBNDwwN6nhkxdr7NxT9gjw7TaW+VAyJ0Y/e2t70lsT2p
         oiNbAd10Zgujbyt6HPZT8l4KoQu+twbANJ/STAgH7z2e4AonJb6JkI+DEUASSozV+KHN
         QJTyAYiTJIzsAIi7wg5bTIxj8GwaB7oMl3SBa4IaUD8S7jygc7BdZUbFL1VrZKiJA33M
         ToZw==
X-Gm-Message-State: AC+VfDz1UHbypIPUbQZbIlLAHv4xIBV/CkvulPH3/ABGpNwU0rmH5GHw
        I/64kAJnAO/9yOKZAT08yqI=
X-Google-Smtp-Source: ACHHUZ4/e98bK2UmPfEy4r3yCMJ6M+KXaviUSrYfc5Ra0ti+kRhvfGmLjPU3w2ysu/LA7SWvpPix5Q==
X-Received: by 2002:a05:6a00:22d2:b0:668:7143:50b0 with SMTP id f18-20020a056a0022d200b00668714350b0mr26865595pfj.31.1687616613173;
        Sat, 24 Jun 2023 07:23:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j21-20020aa783d5000000b006580e98326esm1155839pfn.42.2023.06.24.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 07:23:32 -0700 (PDT)
Date:   Sat, 24 Jun 2023 23:23:30 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-msm@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-tegra@vger.kernel.org, kernel@pengutronix.de,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tom Joseph <tjoseph@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH 00/15] PCI: Convert to platform remove callback returning
 void
Message-ID: <20230624142330.GC2636347@rocinante>
References: <20230530140742.ebbrxmpieuphbmz3@pengutronix.de>
 <ZHphHkNLO4tEJIm/@bhelgaas>
 <20230606160234.elcvyqlz2j3mggih@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606160234.elcvyqlz2j3mggih@pengutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > > These patches wait for application for quite some time now. They apply
> > > just fine to v6.4-rc1 and next/master. Would be great to get them in
> > > during the next merge window and ideally give them some time in next
> > > before.
> > 
> > Thanks, these seem fine to me, and Lorenzo normally takes care of
> > drivers/pci/controller/.  Lorenzo, if it's easier to have me apply
> > them, that's fine, too, just let me know.
> > 
> > The only tweaks I would make would be:
> > 
> >   PCI: j721e: Convert to platform remove callback returning void
> >   PCI: dwc: Convert to platform remove callback returning void
> 
> If it's easier for you (or Lorenzo) I can resend with these tweaks.
> Otherwise if these are adapted when applying them, that's fine for me,
> too. Just tell me if I should do anything here.

I took the entire series and tweaked the subject lines as Bjorn requested.

Thank you!

	Krzysztof
