Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28E33BC467
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 02:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGFAhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 20:37:43 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34754 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGFAhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 20:37:43 -0400
Received: by mail-lf1-f52.google.com with SMTP id f30so35237094lfj.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 17:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MZ4jApzqtd80hAV663k7wI/+6IGjf1DufXgkD98rCI=;
        b=MQ6NyDIX4nSGt/t421wL6aI8FC8VMWl9wSm3HJEDLVMQ2JOT2P83fET6mXbbWA2Ftb
         l/JzTA3DsQcCNNnnJl34MI+bIgq7wF6m+lEPSxiheyB6qNmjIdZa8XYtOoQCe1qZFvL/
         o+Yu+OYYT7VRdBmFFjg+JI6k+MeMGy4knH0N/SvSPtmNJ2u8KC7zN6Id8K9LdAAhSthC
         Ka2w9sbFucgGa4YCyI/1oYbATX8GvqTz+3JVjFpqW9IqAfOONDam54F8MwtuqE8lqGK2
         XguAn1b/vMM99Nhmz7WUDL0YiDBEOxucYNoDv+nNQ0RJxzgdXKLyRjaU4FGbdk43Ce3S
         yLEg==
X-Gm-Message-State: AOAM531hyWITO1FquscEvdKl2WTiyk7yTkKRjM63Th+549khWyjXyHCC
        oRii9FO1rqb8dTB7ehDXkbQ=
X-Google-Smtp-Source: ABdhPJx43OxKFss0r7vE4ncMe03dClaeAq7H4FLPRrF47JfMgv14c0jsLefL4sfIdSUnWDhK1SkgSg==
X-Received: by 2002:ac2:4109:: with SMTP id b9mr11763676lfi.566.1625531703520;
        Mon, 05 Jul 2021 17:35:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v18sm1232782lfd.189.2021.07.05.17.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:35:02 -0700 (PDT)
Date:   Tue, 6 Jul 2021 02:35:02 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI/sysfs: Return -EINVAL consistently from "store"
 functions
Message-ID: <20210706003502.GA158297@rocinante>
References: <20210705212308.3050976-3-kw@linux.com>
 <202107060836.P5flQNoN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107060836.P5flQNoN-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robot,

[...]
>    drivers/pci/iov.c:378:9: note: initialize the variable 'ret' to silence this warning
>            int ret;
>                   ^
>                    = 0
>    1 warning generated.

Ah oh.  Good point!  I missed this one.

Thank you!

	Krzysztof
