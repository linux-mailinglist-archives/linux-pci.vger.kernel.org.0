Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5866428CFA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhJKM1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhJKM1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 08:27:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF59C061570;
        Mon, 11 Oct 2021 05:25:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w19so7162589edd.2;
        Mon, 11 Oct 2021 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtSC3X9ZNZxFY+1SQ5xbzi5kf4aTpzr+ZfeOD0/N2Lc=;
        b=MFUn/nzQifw0zjVzrYd5t61syRursDjvd2J+vAgkP+GoOWyEFb9XRSY1KQdi5XzOjn
         eD3K33PatUNG0wkv+5dabfTujfF43Fbp1njQ6ayHao5pB9lDJniA8dfJUJE9JwkCs2Sc
         6jHkAPAmKukMp5+wHeXf+o/0bmDC+c/Sl4w86rGP/eZejC+Q+VHfFaR6OB9v3bfIATyV
         pHnMcShFxwtOpCRTFWYNSgS/jjGM8cLBKNJoFRxxj840IrUBd06d0n++OT891TNdNXOq
         FdJvbzPLuoPlQhoFUY2/uZdcT2zaxghxA/G2JemWSYZLNHyIR0GywAyM0aRvjw7Gpqif
         iMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtSC3X9ZNZxFY+1SQ5xbzi5kf4aTpzr+ZfeOD0/N2Lc=;
        b=RzNsJbbnQ8lnQefgIObPNhyYeIgPOrp1yl9Zmxp5ELzprbKpjDbs72fDR0/yrBUJuq
         HhUlfAH/vzEtxe0esWh48SVViQHwUSVaOeDuQqD9jwpDlNh+sCvJ9wuCzVyExLETjP/9
         rH/cRK6cJdu8idvVG67OUD7TDEjyuUqhvpm6iimu2B7Wa31bLED1N780upukMT+1nPR3
         sN10IQ0am3dUNetQGHLKd6AF3RrV2FEgQ/otSETn+XncqSQJnG33WSL961DeZzKefwUa
         VkFWJIPkKVWMFx+gMq0xyGFkWMEYxHJ2iHa0Oa6ipy7J9mC5lNRSY/1koPoFDn9QY5mw
         Xl7Q==
X-Gm-Message-State: AOAM530onCfuvMuHPiJ8n8vzHMDT8BkqGySFHRCgdMmX5vJ+IqPfeCLY
        FG1ZlY73Y5Lk/OjgTD0wg24Tsno9BzfOdRP0zBU=
X-Google-Smtp-Source: ABdhPJyDbszhGEV5+N+cuPy1cxYCmUBl4zWUwV9uX/WtaOapUtKst/4fHsOevsNA685+o+EIMVYQy8xDhyw61aAPUhI=
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr26129197ejd.332.1633955145687;
 Mon, 11 Oct 2021 05:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210723204958.7186-1-tharvey@gateworks.com> <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
 <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
 <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
In-Reply-To: <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Oct 2021 07:25:34 -0500
Message-ID: <CAHCN7xLC1ob_nxRsZezgYQ9p-me7hNd+1MNFQt2wtcRqU+z9Sw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 16, 2021 at 10:45 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Jul 29, 2021 at 6:28 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> >
> > Hi Tim:
> > Just as Ahmad mentioned, Lucas had issue one patch-set to support i.MX8MM PCIe.
> > Some comments in the review cycle.
> > - One separate PHY driver should be used for i.MX8MM PCIe driver.
> > - Schema file should be used I think, otherwise the .txt file in the dt-binding.
> >
> > I'm preparing one patch-set, but it's relied on the yaml file exchanges and power-domain changes(block control and so on).
> > Up to now, I only walking on the first step, trying to exchange the dt-binding files to schema yaml file.
> >
> > Best Regards
> > Richard Zhu
>
> Richard / Ahmad,
>
> Thanks for your response - I did not see the series from Lucas. I will
> drop this and wait for him to complete his work.
>

Tim,

It appears that the power domain changes have been applied to Shawn's
for-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=for-next

Is there any chance you could rebase and resend this series?

thanks,

adam
> Thanks,
>
> Tim
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
