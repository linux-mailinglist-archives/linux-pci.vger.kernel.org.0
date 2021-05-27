Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226993937B7
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhE0VB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 17:01:57 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:43656 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhE0VB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 17:01:57 -0400
Received: by mail-ej1-f42.google.com with SMTP id f18so2144601ejq.10;
        Thu, 27 May 2021 14:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znfxTyjOyh61A5NCvUIulFxXnSNwjudLfChZnJBw++I=;
        b=X/xZzML60xBvg7/QLc7/RhQPB100R7gi6HyUBbo/OXgMQayYQsHW6W+tYrEP6GNXyH
         QmPeF1apOjKookFYA7oz1boFLaqkaONPmKikZjACU4P0qYxMm+GSLuT4QFsTsRHx/5JD
         H3WVx53xJIOUsFeGj0BFADJnCwhfoYLcxuq5XYFWFNq3zy9CvJNnZB1PHH1+q8qjP1Ry
         boOp0hn9FCg0Mz2pu8a5iDtuu+pFG54sq6jc/CRFa5W/0xPvAwReVTRW9gUg6cZ3uL+s
         VEZTafjD/fYPmmcol3RsYBnaDACahhkfDZpotF+SSCJbzw2ZYWNWqS8KaMveRo4IlR4A
         WMnw==
X-Gm-Message-State: AOAM5327WQ+xAUl4DJw43xnFNqTVMGIe18e4fnSKsadFFdokK44rzQc/
        cPBqWEQKbOWSaGysNMbm1Z0=
X-Google-Smtp-Source: ABdhPJyqLmxfnXDkMJxhiUMCcV+ZtOIzhnbfT3hs19Dv9MOJujRsLZmXSV3e5fgGaB5bpDeEsJ0JZg==
X-Received: by 2002:a17:906:694b:: with SMTP id c11mr5715720ejs.420.1622149222782;
        Thu, 27 May 2021 14:00:22 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id qo19sm1506336ejb.7.2021.05.27.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:00:22 -0700 (PDT)
Date:   Thu, 27 May 2021 23:00:21 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 4/5] PCI: tegra: Don't allow suspend when Tegra
 PCIe is in EP mode
Message-ID: <20210527210021.GA32109@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527115246.20509-5-omp@nvidia.com>
 <20210527120531.GB213718@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527120531.GB213718@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> > +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> > +		dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed");
> > +		return -EPERM;
> > +	}
> 
> Would the -EINVAL be more appropriate here?  It seem more appropriate
> when something is an invalid operation, rather than access to the
> resource being denied (or something along these lines), what do you
> think?

After looking at this again, perhaps -ENOTSUPP would be a better fit,
and then the message could say that the suspend is not supported.

	Krzysztof
