Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2729BD10
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811709AbgJ0Qku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 12:40:50 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:39843 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1811702AbgJ0Qkt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 12:40:49 -0400
Received: by mail-ej1-f68.google.com with SMTP id bn26so3169935ejb.6;
        Tue, 27 Oct 2020 09:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2aRmOUCB2iPCOZZsctRilB95j4DsikOC8ouZyPxqNk=;
        b=kyhlaZbHKL+nh5H9HY7eKMiZxjQAQ1chGSskqKX7gecgc+K0rQXPzEqXccFuout6hc
         X0kC34YfOvEInCHOGsh1dg25rE3T2/3rMMru8NssXNEWZs8iF3Fimu2olPs+uIwphuMy
         iR3H6pNZW8JFDaC7mJDYDRK8M+t4YUkKY510kyLWR855Xih9VjdjLD4wCalk3w7obnoI
         qfUco6fhvc0zeig/mbOoh78SHAtzffB7mgJQ55qc6MDaVV4YxEhqprVH2rHNAwSCCzcv
         w4KwIDuUFJ7rRrjWMVnyPjdajFr3oDBAXD921Zwi23p6O2QB2QSUuYpokUlEUhaKapdV
         ctug==
X-Gm-Message-State: AOAM532iyhTLXBEE3On3/7MjdOwmGdyer28g+AkiZtxcwPYOPvi71Pv0
        qDAhiVvDyUIYIG7p66JHe0Q=
X-Google-Smtp-Source: ABdhPJwQjFWRXSb1bTPEz5eK20YG7cZ2g7qIInH9s4FcQn3HP9MbOrD2AX7NL2raHxRNET7/VYvpAQ==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr3402723eji.509.1603816846280;
        Tue, 27 Oct 2020 09:40:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id z2sm1275593edr.64.2020.10.27.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:40:45 -0700 (PDT)
Date:   Tue, 27 Oct 2020 17:40:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: pci-exynos.c coverity issue #1437287
Message-ID: <20201027164042.GA123158@kozik-lap>
References: <20201027163446.GA184135@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027163446.GA184135@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 11:34:46AM -0500, Bjorn Helgaas wrote:
> Hi Jingoo,
> 
> Please take a look at this issue reported by Coverity:
> 
> 222 static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
> 223 {
> 224        struct dw_pcie *pci = ep->pci;
> 225        struct device *dev = pci->dev;
> 226
>    	1. Condition ep->reset_gpio >= 0, taking true branch.
> 227        if (ep->reset_gpio >= 0)
> 
> CID 1437287 (#1 of 1): Unchecked return value (CHECKED_RETURN) 2.
> check_return: Calling devm_gpio_request_one without checking return
> value (as is done elsewhere 112 out of 113 times).
> 
> 228                devm_gpio_request_one(dev, ep->reset_gpio,
> 229                                GPIOF_OUT_INIT_HIGH, "RESET");
> 
> 
> Maybe you can guarantee that it's safe to ignore the return value by
> doing a lot of code analysis, but I think it would be better to check
> like all the other callers do.

+Cc Marek,

Hi Bjorn,

I think this is being removed by Marek's patchset:
https://lore.kernel.org/linux-samsung-soc/20201023075744.26200-1-m.szyprowski@samsung.com/

Best regards,
Krzysztof

