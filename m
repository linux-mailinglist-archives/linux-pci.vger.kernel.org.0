Return-Path: <linux-pci+bounces-26434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C603CA97501
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F2B1B61434
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D71EF360;
	Tue, 22 Apr 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P6An4FqX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE51E0DD1
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348440; cv=none; b=mq8VMaX7mq+puQUa5dp55Zb3SvUYJQ3WCYUyrNbqI+UQSfRts1hSrsOsIAQzhB2KIGIjA5UeJ3aTQu1EMIjIKNyuk6SlMzBVda8rgTCeXCsEVE7+4Ulg1PSroeUJHCqSLOqqzLBY3MxiirRSMbELH/wZuBuFbLAh4o9n9yCwXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348440; c=relaxed/simple;
	bh=4QLSLmrkPbs1yBBussuVmcH9d86k1ZJ8t0dZp5NXcyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oorc+cMnhwa3luzoU3l6YdXK0JvUDJ+eFMJmp7lnL436oW/c4sD9sx3cC9aU/IW2OJnpixK8dgXpIAP8SeiZawjGnZre8OEdIFe7uZ29KjHV2UZY/zNxjNIX4Y1x/lq3fpHQP3Q7gVtPOqezBHbIqWBwPwaTo5YLcMVG1pj89/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P6An4FqX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fce04655so51895526d6.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745348438; x=1745953238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=P6An4FqXYkn/qDIpIO/V4aqUvjb9gGpRy+Dyi6lC+QPKX+pIHvFk3USrWDrBZEqjz3
         sFNjf//wcLiVek7moBqmm5R2M8YA5p52p7PS3jyey8EhAqmB2kMD/t83xS+As7Zu5+V+
         KariW9977E3v+Mm6E9+naMgFlmNUOaDFWstlX5TyD+DEI7Q9Jo4DH+bdt1r5LJ23+owK
         kgpc2ri8b1Zm1EJQ42M40Ni20GG/UkrScw7ud7oVjdqw2sBSknVDKz0HQ3WEHHUwb0OU
         v2BQeKe2K8yyEP6pMb3cwA1pPLauwmYzYYPopbKgpmzzHpTsrvNqhT6DH4S4zvxY5b2M
         vuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348438; x=1745953238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=f720h3id8eolUa2Q2+F/G6KcbfuBBJdt8wArWv5Olsg0Q3fODhv8PhHyQCT7VYZncV
         MnIiKLrKytNXQXFKo+7Vj58eLPkMGNHRBA3K003FJ4Jw7YTi/rUz7kH4QfOUbluJF/U9
         H9yFf/crz3jTcBtobFdi3zSB1vQ8CS0kIDt4gNIv5UPsZ7jAdTJmd6SAoEXSH+kgDIT+
         9W8NS+19a9gQV4y0Nsq7HQcnOTCi3bQV6CziOyDpPxoTcTdDfRsWkUelOPPKyggQZ1px
         IJ5LNrHvkIWJB5VIJ4QU2n7VnVtIybYE8WW96GQ/skAUBq1YdskpvzPud99zlTXw52W8
         eFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsPUsoi8P9xIyBP42dmuO/QMJtoSVZenhZNTlE7HI5ijbjFVk/JVAl4Rtx5yW8Tz2augPsDM+XEFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQc1T8ZfBjDfCnhAyJyRNn9BNCcXDburbIH9nHCJ3CbOpRnCN
	EfCuhQpM9m7Qb7GW9R93AxBrWEeth+lOiIERF95lzRwUP1VahnvFeu4vvIVA1WE=
X-Gm-Gg: ASbGnct4xJYp1eoioaaTDe3/oGUiNEjHGI+JFGh67nen46U0sOwDUCjdzSRfIJPRQai
	/4Dlye7qReojUFocojNvr/GNelKNnj9IYjXwkguht1iuWle0OugUlCqWJQMOiaqNgpNjInBduws
	dfONdFIIQVDui4+pRpJS8I7941kGunFAK4zfD/W8U4MhZbc6DSABQhrDeOHLPcNfO0E2amNLP2A
	/OCHInUsQBBUOUceavrLGvkjHfsucW9xx5td5Jgd25c2TrOEneeW6Cc40ScMlmZ7NkN6Q89gYSL
	yFNHAsmHuKP7ObyrcjeduCBLInjirH9PWrkX4WD0NMbiPcf63sl88PhEB5/OCHsv2+nAPVWVYvT
	IjdcI5zYYTr+rXb9wT/Y=
X-Google-Smtp-Source: AGHT+IHbq+pHzTQuxxdUufVp0+5UWeEWnmEdvfzQVGDaZiAVyxBLUWwXVLbiir8zvtHTZQ/owxmlMQ==
X-Received: by 2002:a05:6214:3008:b0:6ea:d361:a4ca with SMTP id 6a1803df08f44-6f2c46557e7mr318335806d6.32.1745348437625;
        Tue, 22 Apr 2025 12:00:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21da6sm60863536d6.98.2025.04.22.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:00:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7IrE-00000006vVF-1Cvg;
	Tue, 22 Apr 2025 16:00:36 -0300
Date: Tue, 22 Apr 2025 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250422190036.GA1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAa2Zx86yUfayPSG@google.com>

On Mon, Apr 21, 2025 at 02:19:35PM -0700, William McVicker wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1813cfd0c4bd..6d124447545c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
>  
>  static int platform_dma_configure(struct device *dev)
>  {
> -       struct platform_driver *drv = to_platform_driver(dev->driver);
>         struct fwnode_handle *fwnode = dev_fwnode(dev);
> +       struct platform_driver *drv;
>         enum dev_dma_attr attr;
>         int ret = 0;
>  
> @@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
>                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>                 ret = acpi_dma_configure(dev, attr);
>         }
> -       /* @drv may not be valid when we're called from the IOMMU layer */
> -       if (ret || !dev->driver || drv->driver_managed_dma)
> +       /* @dev->driver may not be valid when we're called from the IOMMU layer */
> +       if (ret || !dev->driver)
> +               return ret;
> +
> +       drv = to_platform_driver(dev->driver);
> +       if (drv->driver_managed_dma)
>                 return ret;
>  
>         ret = iommu_device_use_default_domain(dev);

The diagnosis looks right to me, but pedantically I think it should
have a READ_ONCE():

struct driver *drv = READ_ONCE(dev->driver);

And then never touch dev->driver again in the function.

Send a proper patch?

Jason

