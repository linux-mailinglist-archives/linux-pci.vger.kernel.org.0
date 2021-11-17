Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C0454F24
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 22:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhKQVRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 16:17:38 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36483 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhKQVRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 16:17:37 -0500
Received: by mail-pg1-f176.google.com with SMTP id g28so3375887pgg.3;
        Wed, 17 Nov 2021 13:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ivVNQCej0tdSWk8Y3a2hZeTc5eVZRmL5qBXYay0Qssg=;
        b=imFIXWtdmc+F0Kl1MB3RVhlz08wEwR3NrNdJ9bp/CtusPMPNFBtdgBAF/3xaygjMqz
         SDh/y48cKvJO7X574IRUrb2DaovWW4dPjAh80yT//ahCE+D8YwDWCSn4putxPQtEiv3e
         24hK1aXX0Ermn9Pywa0j94V8pMCi3kizFj3Et05gietSQoHKA30bYcE+VAjKACxcEIch
         uSHlZKQfabQrWFLv6lUjhiw3cokboan+nJhVgsKsiXIizJuJXo7Cy999A2BYT6trEGaI
         Gj1dHosO3A0I5QUJWNQYUSFhuIIlJWXsIJrnlPkVRoMTI9WCRH+z5sQdhfoCr9WxIuqH
         nyng==
X-Gm-Message-State: AOAM532UagMqjJpzBKxJMCTVUlA/xC22d4BSJ/7hurTWiOPvyc5O9ohI
        qxWtXnAg01LnDnAM63E0nfA=
X-Google-Smtp-Source: ABdhPJxMlX5f8zzcfeyooK64Vu0Y74aM8Av9BkAcFkqoDw1nI+Jakf0qJH7+I6F/Und5XtvKQn0NMQ==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr50840272pfj.15.1637183678518;
        Wed, 17 Nov 2021 13:14:38 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m15sm6249374pjc.35.2021.11.17.13.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:14:38 -0800 (PST)
Date:   Wed, 17 Nov 2021 22:14:29 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: mt7621: declare 'mt7621_pci_ops' static
Message-ID: <YZVwtUO/j/ZYaL3q@rocinante>
References: <20211117152952.12271-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117152952.12271-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Sparse complains about 'mt7621_pci_ops' symbol is not declared and asks if
> it should be declared as 'static' instead. Sparse is right. Hence declare
> symbol as static.

Thank you for taking care of this!

[...]
> -struct pci_ops mt7621_pci_ops = {
> +static struct pci_ops mt7621_pci_ops = {
>  	.map_bus	= mt7621_pcie_map_bus,
>  	.read		= pci_generic_config_read,
>  	.write		= pci_generic_config_write,

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
