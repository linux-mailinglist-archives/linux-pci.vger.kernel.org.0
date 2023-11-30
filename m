Return-Path: <linux-pci+bounces-298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60647FF74A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E191C21049
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A15577C;
	Thu, 30 Nov 2023 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U85gaENi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69A10DE
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 08:55:24 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b5714439b3so652338b6e.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701363323; x=1701968123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmxSAO3fdyrKwaTqGd3YSx6BBvFQHSOmyrJHBt/Yn5A=;
        b=U85gaENisn4eFT7aw9gz+s14lGbhRLN6aXvcAZloi7KdDsfEskyaGEnTN+ahxna+Z6
         8xbqcJrIhGQNi2cpSmfPm9y9ywjE0hIsoG3gMUazzaYgsbKt1FG1RJOlplF//SUXCoQA
         UNqFja6IPPmvxMu9LOAX3ql1Ftks7Ugw8NfvJxvlz508kL750tdPZzHPzaw5BGI9pDV4
         AfbQ3bETbM+zDK399sAhU71C9eqBCFJYzgy+NogHa7vTbAYpY1JcAJ2WbVD8T7U1IZMu
         mrqL5ePuX2Xwq+lofT6H31Ip8QvVi3WX36MTjGKJtloaqsHSMP97w24aC+ZUDatHNaPM
         H40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363323; x=1701968123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmxSAO3fdyrKwaTqGd3YSx6BBvFQHSOmyrJHBt/Yn5A=;
        b=tr3PxQz9CZ8J93VHG6GtIwVZv0YTCjEa4Itu4tUm/2dx8t+1Jq+CCylw5JahznvAud
         zxPrMtykFeiQ9bwdHgcVnbZXd5PSm0wzp2MEo4QeeHpocdoLFk+OHB0HwGr0AzB0tdBX
         vMfhq6s5VvFxaKxnXKJC8NkY7GRqLJnzHHEA0J7o3rrLhveKteh04Q2MJRy0MPOciDzS
         XI75WYZ7ViRr+RIc/Ac6oFO0lP7VKb4rHxdl1+vu+hlCPqHx3bjopXNWpxCpEYY9jbJg
         UJmrz8lF5rtp90P1gAafR28lJ6ElWbWZPr2Jztpf6LLAZzlTS0dm9KHZ05L6QvtOlZvV
         5OsA==
X-Gm-Message-State: AOJu0YyiH5KwcfdUGqq8qCFD9qmSTt7yQWjyP0vV+dQZaicWlKG2o2xM
	AJWIoNwI8kponPhSJq1e9eEx
X-Google-Smtp-Source: AGHT+IEz7XuDUqXYdI4J/jG28y1tc/o5oyAeuhg85Lkt1tkDT7TzfRm7sgOObpymwMghWxY+ERa48Q==
X-Received: by 2002:a54:4389:0:b0:3b8:9bf6:66e8 with SMTP id u9-20020a544389000000b003b89bf666e8mr114366oiv.21.1701363323569;
        Thu, 30 Nov 2023 08:55:23 -0800 (PST)
Received: from thinkpad ([117.213.102.92])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b0077d6443ae82sm643960qkb.83.2023.11.30.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:55:23 -0800 (PST)
Date: Thu, 30 Nov 2023 22:25:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com,
	pankaj.dubey@samsung.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20231130165514.GW3043@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
 <20231130115044.53512-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130115044.53512-1-shradha.t@samsung.com>

On Thu, Nov 30, 2023 at 05:20:41PM +0530, Shradha Todi wrote:
> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>  - Debug registers to know the state of the link or controller. 
>  - Error injection mechanisms to inject various PCIe errors including
>    sequence number, CRC
>  - Statistical counters to know how many times a particular event
>    occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.
> 
> v1 version was posted long back and for some reasons I couldn't work on
> it. I apologize for the long break. I'm restarting this activity and
> have taken care of all previous review comments shared.
> v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
> 

There is already a series floating to add similar functionality via perf
subsystem: https://lore.kernel.org/linux-pci/20231121013400.18367-1-xueshuai@linux.alibaba.com/

- Mani

> Shradha Todi (3):
>   PCI: dwc: Add support for vendor specific capability search
>   PCI: debugfs: Add support for RASDES framework in DWC
>   PCI: dwc: Create debugfs files in DWC driver
> 
>  drivers/pci/controller/dwc/Kconfig            |   8 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 476 ++++++++++++++++++
>  .../controller/dwc/pcie-designware-debugfs.h  |   0
>  drivers/pci/controller/dwc/pcie-designware.c  |  20 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  18 +
>  6 files changed, 523 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

