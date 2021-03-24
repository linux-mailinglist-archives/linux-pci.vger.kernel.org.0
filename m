Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA03346EE1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 02:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhCXBcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 21:32:17 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:39772 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhCXBbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 21:31:45 -0400
Received: by mail-lf1-f42.google.com with SMTP id b4so5585588lfi.6;
        Tue, 23 Mar 2021 18:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxiNq12BBkrbM53aTNkI6bHyLip/3/EfWfu40n01gwI=;
        b=I5ofrO43zpTmAPNMOWxXiQ/rryE4psbG+w/gCtwsoJCIy1RHEDtZ3kHf2FnKweoHEn
         MJPliRAcaIn1ozvpWSpqtaKfvz18pIflWp15F6zEbR9g6o16W6Gnm8i/0ZY1zzVLRfrM
         e2KkVC/ptpFU0OCDVn7LqFrbQsGG1MyYgpaLlmdzlgtDdHd9Px8QOi/aaoX3wpT8Bdfy
         08ZmfAXX3zhYwBzBN7bolbahTtrAYNdVU8uNZxuw96jCqp+/2f9NzNTqpi3O9iClkkFt
         drbIhTwlOVrLuUTSvJYrVr1/CJ484bdyOQZ6pqKd4l1aRNTqMlfw8lZ5bHphfO11j1rq
         DiQA==
X-Gm-Message-State: AOAM530l+lEhv2r1RgGrXc+x5kmP2s9v8VU0/lJgWWhoaZcVOQxoNJCM
        e7DDG/O21U5gKA6F6Tm8OsI=
X-Google-Smtp-Source: ABdhPJwwm1H6hy6izV3QUqfh+Sv3+rWYvbjmPeAZrxKVbhXL+n4b0rSUKunbP1A31kywGgq0MlsIOA==
X-Received: by 2002:a19:98a:: with SMTP id 132mr479464lfj.139.1616549504215;
        Tue, 23 Mar 2021 18:31:44 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f9sm95975ljg.115.2021.03.23.18.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:31:43 -0700 (PDT)
Date:   Wed, 24 Mar 2021 02:31:42 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: dwc: put struct dw_pcie::{ep,pp} into a
 union to reduce its size
Message-ID: <YFqWftATEbuxsJbn@rocinante>
References: <20210312140116.9453-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312140116.9453-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexander,

Thank you for sending the patch over!

> A single dw_pcie entity can't be a root complex and an endpoint at
> the same time.

Nice catch!

A small nitpick: this would be Root Complex and Endpoint, as it's
customary to capitalise these.

Also, if you could capitalise the subject line - it could also perhaps
be simplified to something like, for example:

  Optimize struct dw_pcie to reduce its size

Feel free to ignore both suggestions, as these are just nitpicks.

> We can use this to reduce the size of dw_pcie by 80, from 280 to 200
> bytes (on x32, guess more on x64), by putting the related embedded
> structures (struct pcie_port and struct dw_pcie_ep) into a union.

[...]
> -	struct pcie_port	pp;
> -	struct dw_pcie_ep	ep;
> +	union {
> +		struct pcie_port	pp;
> +		struct dw_pcie_ep	ep;
> +	};
[...]

How did you measure the difference?  Often, people include pahole output
for the "before" and "after", so to speak, to showcase the difference
and/or improvement.  Do you have something like that handy?

Krzysztof
