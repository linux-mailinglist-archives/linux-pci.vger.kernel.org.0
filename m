Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A513303AD
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhCGSDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 13:03:55 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34243 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhCGSD2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 13:03:28 -0500
Received: by mail-lj1-f173.google.com with SMTP id i26so460599ljn.1;
        Sun, 07 Mar 2021 10:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rp9Ajp+YYJcCgM99aoRk4hlqe6NTc3+mtt4KEeaxBmY=;
        b=Sm++gHi+RrLoIkp8uR6GspU3+AX1qscO62SP2WPt0k321Byw+rJWMUGXzKY/MwX2xX
         1/FEhYV9HJOVqGlO+WNjIDxPIXbQeVyeB0M7c3snMjywo5A0AYfLRVobdDXSsDgIKLQ7
         madms5fBCcgpGfZm7HXKpvNToVGW6QpPfsYfBgVY0oV4s9DzWOyOj6Oc+E8cO2+0ne4B
         1tA/xJsUJNQ9Dek11mD9UrrZGNX2RZiHfxodrAuc5b/Xrz60j4j8IIfAHUnvxiza5oO7
         Jkb3xHn0/NqzohRyg+F01v0dpKkTkeTBtDHY4L868CYTpmbzDcgwxdslhFlvEAA4gjbP
         sucw==
X-Gm-Message-State: AOAM532SBjIaScrEU/bdLoL190J11jcwjTKL/xvBJyU0fRInq/WUl1df
        7DPqQ2Uddg/0sBPblYo+tsM=
X-Google-Smtp-Source: ABdhPJyGz9aDqVePeENK9Q1ZDwnELnIllQ4lJJa3ciBOv+TQMWY/Zl7sZZPJdaqyxFmxdjxtihHgLQ==
X-Received: by 2002:a2e:391d:: with SMTP id g29mr11534106lja.484.1615140205379;
        Sun, 07 Mar 2021 10:03:25 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h3sm1134136ljc.67.2021.03.07.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:03:24 -0800 (PST)
Date:   Sun, 7 Mar 2021 19:03:23 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, helgaas@kernel.org,
        gustavo.pimentel@synopsys.com, andriy.shevchenko@intel.com,
        treding@nvidia.com, vidyas@nvidia.com, eswara.kota@linux.intel.com,
        hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com,
        wesley.sheng@microchip.com, wesley.sheng@microsemi.com
Subject: Re: [PATCH] PCI:tegra:Correct typo for PCIe endpoint mode in Tegra194
Message-ID: <YEUVa+6i1t8qGqYj@rocinante>
References: <20201231032539.22322-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201231032539.22322-1-wesley.sheng@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

A small nitpick.  There are spaces missing in the subject line.

[...]
>  	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -	  work in host mode. There are two instances of PCIe controllers in
> +	  work in endpoint mode. There are two instances of PCIe controllers in
>  	  Tegra194. This controller can work either as EP or RC. In order to
>  	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
[...]

Nice catch!  Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
