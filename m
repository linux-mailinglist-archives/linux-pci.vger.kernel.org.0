Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA1467FD9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbhLCWWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 17:22:23 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40930 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354009AbhLCWWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 17:22:19 -0500
Received: by mail-wr1-f50.google.com with SMTP id t9so8568655wrx.7
        for <linux-pci@vger.kernel.org>; Fri, 03 Dec 2021 14:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CO0ztj7/pipmp7ehHwcTcmjZVnurHNfUozf0SYjuN0k=;
        b=SVDAVtCDOH8cgtx0CLbCcvHX1mVkJBWkIZLOsFsj8WpL5MgGHpMz+GS6JwUEaS8PP9
         LyJQiFG8weivAN7c/aqq5O5xjGt0wOcXNKqkLWr2YVAXncqcwEbHS70g0dia8yfCnO3w
         KnKx/XuyPuqa7tuFIxTKPiowEcL3gh0e7r2ucr+tdml3+NGclsFVWOgXugqqsBim0UUr
         spwL3NdiuLZsxS38kmIMN+Qf7pflvva6C3G7PsDrCM2cMvBTcfoRDqrCw594wvZiVzV9
         s15uKEYm75ydcWxfzsAa/bb/4pXlJLX5zvTPBVH72dwvmL8rtDTm5FGxotsZHvIrOLVf
         gOSw==
X-Gm-Message-State: AOAM533mekefh5NyoM4A9m9c9RPQQvr9g0D+Q8bDd7YIJbeEzWBKz1pV
        EUSRIYm7tjj/TaMvZtCyZ6alMLqSVHbTag==
X-Google-Smtp-Source: ABdhPJwIZAT7V+zfKg3QEgIFZfN8RUtdJ/4Jogw8BqDUqMQKcnG36fIKz1uBJ6/j8LA9LAXeZemLRQ==
X-Received: by 2002:adf:ab53:: with SMTP id r19mr24861903wrc.584.1638569934450;
        Fri, 03 Dec 2021 14:18:54 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f13sm4639330wmq.29.2021.12.03.14.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:53 -0800 (PST)
Date:   Fri, 3 Dec 2021 23:18:52 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: IMX8MM PCIe performance evaluated with NVMe
Message-ID: <YaqXzOxjScP1IC99@rocinante>
References: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0OZvy4RamHZ18aJ6+AiO3BxXQx-3-sQYop6sF1QRMmwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Jens as he is the block, I/O scheduler, NVMe, etc., maintainer]

Hi Tim,

[...]
> What would a more appropriate way of testing PCIe performance be?

I am adding Jens here for visibility as he does a lot of storage and I/O
performance testing on various platforms and with various hardware, he also
wrote fio[1], which I would recommend for testing over dd, and also is
a NVMe driver maintainer.  If he has a moment, then perhaps he could give
us some tips too.

1. https://github.com/axboe/fio

	Krzysztof
