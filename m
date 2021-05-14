Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F23809E4
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhENMxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 08:53:06 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35839 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhENMxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 08:53:05 -0400
Received: by mail-wm1-f44.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso1407859wmo.0
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 05:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SESIfhMqYFc3E1CEVb69AU3q2QVBKoIo933+rDpEkME=;
        b=HlHPcoSxrB3nuwUGIny8UzkSNkDvRwru/M54u4U74sCP09ro9wcP+d2IMK/BUin8VP
         EjiKGYSxhe3E21jr8pt1ge7p4tKQmJIN2cKoVxKIJjA/5wUEhQxxXJYqtsd4QlCT6Tes
         VYXOEbAuA9G6DpM8MtoUqX2PejnY92P8TsJKRvlzYHJwtEtsD63AB+fWXcjafzrAOnu0
         zV/H/N/Sj0rFOn+j+c0dphzDz3z5SdQaMRqzWYD4UEeO2zVqNSdc8pESKYicE7Rx4DHE
         EYysTydOwa34yiTq/zOh2OFHABZaCtx6a3GfrNYxH4+te83V2SE6UwACZUqWYhnaPOAM
         xZlg==
X-Gm-Message-State: AOAM530acY770g3tjng7lP5/zb/x3PvGg8HANMqi6p3mwIinNnhnBkop
        ct4CXluTmhKQsbI+iyA/iWA=
X-Google-Smtp-Source: ABdhPJwlXmMl+EU/vLC/c/k7Xo/fZQH7FiLHfZS47vLRSxNc6hu5cj5VUaOdmSIV7/QQ+omn4Y6XOQ==
X-Received: by 2002:a1c:2704:: with SMTP id n4mr19970044wmn.147.1620996713364;
        Fri, 14 May 2021 05:51:53 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i11sm6686256wrq.26.2021.05.14.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:51:52 -0700 (PDT)
Date:   Fri, 14 May 2021 14:51:51 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] PCI: dwc/imx6: Remove redundant error printing in
 imx6_pcie_probe()
Message-ID: <20210514125151.GB9537@rocinante.localdomain>
References: <20210511114547.5601-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511114547.5601-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhen,

> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error
> information contains the device name, failure cause, and possibly resource
> information.
> 
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
