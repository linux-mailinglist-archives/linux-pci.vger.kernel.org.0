Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF534144D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 05:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhCSEnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 00:43:01 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43913 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhCSEnA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 00:43:00 -0400
Received: by mail-ej1-f49.google.com with SMTP id l4so7524721ejc.10;
        Thu, 18 Mar 2021 21:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJ5epElvIHRCLOPs35R9kJU3e4MLpSScnXNFgNaIdtY=;
        b=H385Bq9L+xyA0l9e6JkP5JkHpiIiM+paV1u8ErB25tUH4ilOxVJBIsILiUfHXq/9DF
         3GY8vRhBLrX6U3d++0Gk/fGJtMm3Mk88l0lxPWYvvNfpdaBYocfStHie/egHHAU79Aec
         bAnjQkCQxddd1UWQ88iClDNVUhtHtoyhY8bCzaPPAtfX8V+Qgp4QAUQ9IYtD+WxTLtdF
         Qt18aajyf5Oownak4hLwTDMY3vX+M2VbAb0QLiRxqWS8N2W25oMo1bzunerOGeKFlzPY
         zlqpIKjNErRpPipV29AtjR5D38mY1uNKJX04CbuBeDis0DTskjj21IALuFad3AUa11Um
         /nGA==
X-Gm-Message-State: AOAM5317db94twX5iC9RaUgIq8rdoUphQeg+1St95kc6AC+6hnXIMo0c
        wH0SPek/LX1Vi/h6JBCxQwQ=
X-Google-Smtp-Source: ABdhPJzipLn7AqsZvQHSyVxSUVKaCdMwqPG/fT+kq7UV0ELtkfHgKd6G55CioOG9UmFa84eaKaQdiQ==
X-Received: by 2002:a17:906:3882:: with SMTP id q2mr2184109ejd.540.1616128979183;
        Thu, 18 Mar 2021 21:42:59 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s20sm3296292edu.93.2021.03.18.21.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:42:58 -0700 (PDT)
Date:   Fri, 19 Mar 2021 05:42:57 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH v2 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <YFQr0bHa6nIgas2S@rocinante>
References: <cover.1615954045.git.greentime.hu@sifive.com>
 <27f491c113e1bb369d25aca02571b34422986142.1615954046.git.greentime.hu@sifive.com>
 <YFQqpojmJyX0l6lx@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFQqpojmJyX0l6lx@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> > +	/* Wait for wait_idle */
> > +	ret = readl_poll_timeout(phy_cr_para_ack, val, val, 10, 5000);
> > +	if (ret)
> > +		dev_err(dev, "Wait for wait_ilde state failed!\n");
> 
> It would be "wait_idle" rather than "wait_idle".
[...]

Apologies, meant to say "wait_ilde" in the "rather than" part, but went
ahead and somehow used the correct spelling. :)

Krzysztof
