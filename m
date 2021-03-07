Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E546032FE2E
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 01:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCGAXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 19:23:04 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39923 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCGAWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 19:22:36 -0500
Received: by mail-wm1-f51.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1599934wma.4;
        Sat, 06 Mar 2021 16:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3RGXPi/DQKNI+9PGxYxD9SACczal3R5XOcceIHX9BI=;
        b=Gy1u/aU8H883/ctIs/Or6fkwR7ptAp9o4v5AYgP865xU2oEOmAACu4q4Nd7NJ0a4CO
         +yb4Xl+LYPBTWkNQnGlKHNzl2FqacCq7F7SDrSYbtAq7lW6M292NUpm6Fq9E2XV4d8jo
         xdC3f8gZe5MpaPHuaivqQH4xB3/fJvXE9r0riQHfpzft0kxrezH7ndxmYrFoWMQPsWSk
         1Ir7RgpkICOJtve6TRFVnpg7Sylx7HxlZvizazcoTMAIP5W377NA4zHTkhpF7wAFoeiu
         Ph5wnriAaBgmhlhbZRrDO+bkyLFZwfdlRFV4lyZyOHx6lOVjQX4nuNmPSoyL2RANclZl
         5FHg==
X-Gm-Message-State: AOAM530taVLgvpemqDoHyN2/Mme/wipqQ5upWmVpzBdIrCALiUzlDQzw
        hn80jeGeR1dGmmtwAQtGuI2UiYn8fkCdCfJu
X-Google-Smtp-Source: ABdhPJy+PrpPMUMJX1sb8bYSqqm3QX/GljDnJrK+Adxt8B8eSSjYLRx8pLjKmmFrKYiI+mR9ctHXsw==
X-Received: by 2002:a05:600c:2ca:: with SMTP id 10mr15458630wmn.40.1615076555043;
        Sat, 06 Mar 2021 16:22:35 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f7sm12554247wrm.36.2021.03.06.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 16:22:34 -0800 (PST)
Date:   Sun, 7 Mar 2021 01:22:32 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Antti =?utf-8?B?SsOkcnZpbmVu?= <antti.jarvinen@gmail.com>
Cc:     helgaas@kernel.org, alex.williamson@redhat.com,
        bhelgaas@google.com, kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH v2] PCI: quirk for preventing bus reset on TI C667X
Message-ID: <YEQcyBVLIaGWb4sk@rocinante>
References: <20210217211817.GA914074@bjorn-Precision-5520>
 <20210228135311.668-1-antti.jarvinen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210228135311.668-1-antti.jarvinen@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Antti,

A few nitpicks, so feel free to ignore these, of course.

If possible, capitalise the subject line.  Also, perhaps "Add quirk to
prevent bus (...)" might read better.

> Some TI keystone C667X devices do no support bus/hot reset. Its PCIESS
[...]

It would be KeyStone in the above sentence.

[...]
> With this change device can be assigned to VMs with VFIO, but it will
> leak state between VMs.

Following-up on Bojrn's question about the state leak, see:
  https://lore.kernel.org/linux-pci/20210129234946.GA124037@bjorn-Precision-5520/

Would there be anything else that has to be done?

Krzysztof
