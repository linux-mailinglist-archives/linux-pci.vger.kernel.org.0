Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0A325930
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhBYWBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 17:01:43 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40962 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhBYWBU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2021 17:01:20 -0500
Received: by mail-lf1-f52.google.com with SMTP id d24so10855222lfs.8;
        Thu, 25 Feb 2021 14:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwZzks7Q+wOWRhrZQ3mgFpMbrn31iT5NyLTYPPzf06c=;
        b=dwYUkxZJcVcClAxL/wTopQTpUl16CZi8XH44rK7oWGM/+BLPoqsD1uEgNu+xd6XkZa
         IjemA/8ZmB8WUqA+A2KbF35y+EzMCgzBmX37OTwIuyJBVKQmdw7TkOvChqsdbcilC1EX
         dMoJyQXmiPWqZe0g5W+7qBMm/wV8632DRj66nSFGyayVpKylC2SoeglYnVR7XrSYEsxP
         m9bBm/AcF3TS8YvEgZoSTwG98p5UWxZpTJcRqJzNZCp1Vo6/lIvHj2OaXfJtA6BHkbw1
         vnJEa5n35Nfx9ZTDxa8KE5Tx0jD8p1xANlDEAvlK9VEo7roP8+N8W4IB76qRmMlDjfTL
         N/8Q==
X-Gm-Message-State: AOAM532//eOltAWY8uQacjVjuekEeVOAwj1Zi9YSoLoxxKcxTEbBTMLK
        9qrXcBXySz9uJiJ0qZywaz8=
X-Google-Smtp-Source: ABdhPJxQhSDTdjqQUt4Uhh4bJavdU7KNQTizh7/YRmYQ9PMRZYRbGObddOL6QGouxeeQ0cAjfwn15g==
X-Received: by 2002:a19:b47:: with SMTP id 68mr2844434lfl.343.1614290436989;
        Thu, 25 Feb 2021 14:00:36 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r9sm1228682lfn.200.2021.02.25.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:00:36 -0800 (PST)
Date:   Thu, 25 Feb 2021 23:00:34 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,6/7] PCI: mediatek-gen3: Add system PM support
Message-ID: <YDgeAoYHgiAyU16a@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-7-jianjun.wang@mediatek.com>
 <YDZeRc6CHV/WzyCm@rocinante>
 <1614224089.25750.14.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1614224089.25750.14.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

[...]
> Thanks for your review,

Thank YOU for all the work here!
 
[...]
> > > Add suspend_noirq and resume_noirq callback functions to implement
> > > PM system suspend hooks for MediaTek Gen3 PCIe controller.
> > 
> > So, "systems suspend" and "resume" hooks, correct?
> 
> The callback functions is suspend_noirq and resume_noirq, should I use
> "systems suspend" and "resume" in the commit message?
[...]


What I meant was something along these lines:

  Add suspend_noirq and resume_noirq callback functions to implement PM
  system suspend and resume hooks for the MediaTek Gen3 PCIe controller.
  
  When the system suspends, trigger the PCIe link to enter the L2 state
  and pull down the PERST# pin, gating the clocks of the MAC layer, and
  then power-off the physical layer to provide power-saving.
  
  When the system resumes, the PCIe link should be re-established and the
  related control register values should be restored.

The above is just a suggestion, thus feel tree to ignore it completely,
and it's heavily based on your original commit message.

Krzysztof
