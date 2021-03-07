Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD393303F6
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhCGShE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 13:37:04 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34005 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhCGShC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 13:37:02 -0500
Received: by mail-lf1-f45.google.com with SMTP id v9so15950816lfa.1;
        Sun, 07 Mar 2021 10:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ThbITLkHOU2/dQSeUt335dQeSvRoHsbaI5Fk6bsL6es=;
        b=uTXnV3OArt5NUjL81bGOMCd5xjBq7325jkIb5YCaLaSyZXytZqC/9WqNh6eDBbMHR1
         ni6FggMAIQ78hbgJSxTuJlxkXwoRWPtrNocAhg+TccezrydFsooogrMqb4GGUhrxoP1o
         S3fs7MCClZaFQrFZDz7ZcsvOrGRsIrAYoMJNBM0KKl7wgO28plwnCM7ZWeKST6asyuYO
         ao6vM4bigO5C8Bqm55VdhfZYxOzv2Apww8DaMjD+kfxzxEb0WEWcittGXR8xE4co1msu
         zQ1jEL8RWrurlTCL577U4K3PvaaN1MmZrBlPguUYV0S2XUY+BvQODkRsXtoybj1sUWah
         qTmA==
X-Gm-Message-State: AOAM5325ywLlCv0AgGQdI+OiubnQNL9sX7996vUQHLoEwVBctPlfKv68
        8rugwmyB4Fdm/EpRLzjJi9w=
X-Google-Smtp-Source: ABdhPJwzkmkqC/Pw8HWTIEHGBNMbMZdlHNa4mm3nBRwXwyxM6V/4OrZHbwQtOm9tb4iSU0SGC7jDEQ==
X-Received: by 2002:ac2:4465:: with SMTP id y5mr12100641lfl.70.1615142219485;
        Sun, 07 Mar 2021 10:36:59 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g2sm1179250ljk.15.2021.03.07.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:36:58 -0800 (PST)
Date:   Sun, 7 Mar 2021 19:36:57 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        robh@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci/controller/dwc: convert comma to semicolon
Message-ID: <YEUdSZpwzg0k5z2+@rocinante>
References: <20201216131944.14990-1-zhengyongjun3@huawei.com>
 <20210106190722.GA1327553@bjorn-Precision-5520>
 <20210115113654.GA22508@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115113654.GA22508@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> I would request NXP maintainers to take this patch, rewrite it as
> Bjorn requested and resend it as fast as possible, this is a very
> relevant fix.
[...]

Looking at the state of the pci-layerscape-ep.c file in Linus' tree,
this still hasn't been fixed, and it has been a while.

NXP folks, are you intend to pick this up?  Do let us know.

Krzysztof
