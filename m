Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69013EDA0E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhHPPk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbhHPPkk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Aug 2021 11:40:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6CC061796
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 08:40:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so33099654pjr.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AyfMcp2yhnMT8b6WgE0Tq0TI+fTS/T3AjxmgLG4RFY=;
        b=XY+nexCppv0jvgdLyAS8tfu9dWl7F48uM5zLpUFgPuJr5TASNvWiJSsMRb58l1Mdpk
         ajCsvVhN0kTxNb6wPhp2qKWAIvpEDkmvx/RIKkJG5OUoQFnQIiDBBiuRrYTDfdl0FGbZ
         O3Blyo5uA7inwySQo0MalCg5X/1J+YC3/KdaETe6dm3vRX6zGZ2pjy9EqQM9ZkyNvXIh
         RUT3EScLPM+3VVFYU7qOFir/od/db/Rrpk+QNDuvKz1FtK44wpByriIGmNQx+aEgEQkK
         Jtx69NH6tNW55mQr1lROPIx7/Ldx3iIa4NfMpDphzVU5Cy5+FI08eXlm9qmLmhrNvCOO
         zwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AyfMcp2yhnMT8b6WgE0Tq0TI+fTS/T3AjxmgLG4RFY=;
        b=WMaSuN/eXR+vMxTd5uz7C1itsR0KtryCIn8puqPGBuZ00MOQllZJnsUIPqagFMzstv
         ucUtcaWCLE4Iy3Xn6y/xul0P+Tgh5hqDKfkL++H9EPccyiIkZb6bzUHrYwD5c1n02i2U
         UY4z4Dg0OuT2rpro1AnZ0eW5aR2OudlwZrkm8Ira1b/fty/3ZzwokvN1tx0M8hfpX4TW
         EaXNKIK5NAf+p/k03rFuM1T2fI3zIVIztpsVClj99FpYpurvm5ELxgBbUkDd8WH9+ddM
         CmQORuC7CKgxg0XQH95WSX0fRjaVpSJ188JDa0OgYYv7sLwK2paWSi3CzDB2YGJ1eT1F
         KmFA==
X-Gm-Message-State: AOAM531TdnqIa/yKw3nhJlIVbsUWh/KDLx1J3ca9CLo/9wLe04TiCR/P
        NjO4yNgW0Go3yw40/cpQ+WCemeIHy2bBNfwlD1uqbA==
X-Google-Smtp-Source: ABdhPJzhnxfzdvPDrfj5hvBd4graOCrPdcFqBHhlQyegW5ZMcqxUq9IwdQQp8Ee69yX+lK+Y0hqPjSkdKOdo0sNmhRk=
X-Received: by 2002:a63:150e:: with SMTP id v14mr14590874pgl.126.1629128408340;
 Mon, 16 Aug 2021 08:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210723204958.7186-1-tharvey@gateworks.com> <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
 <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 16 Aug 2021 08:39:57 -0700
Message-ID: <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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

On Thu, Jul 29, 2021 at 6:28 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Hi Tim:
> Just as Ahmad mentioned, Lucas had issue one patch-set to support i.MX8MM PCIe.
> Some comments in the review cycle.
> - One separate PHY driver should be used for i.MX8MM PCIe driver.
> - Schema file should be used I think, otherwise the .txt file in the dt-binding.
>
> I'm preparing one patch-set, but it's relied on the yaml file exchanges and power-domain changes(block control and so on).
> Up to now, I only walking on the first step, trying to exchange the dt-binding files to schema yaml file.
>
> Best Regards
> Richard Zhu

Richard / Ahmad,

Thanks for your response - I did not see the series from Lucas. I will
drop this and wait for him to complete his work.

Thanks,

Tim
