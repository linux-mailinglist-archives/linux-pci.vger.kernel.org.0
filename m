Return-Path: <linux-pci+bounces-18865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454509F8DC1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951FA167FEE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEB1A00DF;
	Fri, 20 Dec 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN533Uey"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10096A31
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682477; cv=none; b=loeCbfqr7fxaW6kIPqfPYsz3FYmwl4nrM8edKWI9p1SX7xQ1a2OeIjnHHpf90bBAvuf+y1s0w1guP76JKtQqpCkmVWnF/XUl3oAHM/UhVSOA/VEGnudyK2LLPLfwXviBKDsvAhFAR4nzrvsviRRlCkOYunV2wt5yiKbasX3Hh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682477; c=relaxed/simple;
	bh=MhmVE8I64wMUAoUGAEcG3Z/C3pfwBov/1EH0EraUHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzrTz1Ytqec6Re+qU3QpB0uXzALRrRkxBrxOHvwf6uxe+XWTY04ckXF9+L7xK32RWqPIYq+f6sTj6/isOoU0tztWi+k3tZ3vjJLmSYPcFr60+L3FiBuwdejb4XQwLFjPqojQqdpJ/vGM9kYoOBpmFof40YJ8ebIReITSP9d6k58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vN533Uey; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1225609a91.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734682475; x=1735287275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5boJminZgitxq3r5NaydDCyPtGRydqEl633WaiR2zg=;
        b=vN533UeyudJN/LcwoLMAKpyNxPetLzQOGcVoFpzZLFnXv7GHrwsBI2PEhsN+M0NZcy
         +TFdHv50e+NRVai44XploDSX12jSfDn9tDHHooNDwGrx2l2tJYcoq/tsyuUUYM8Rq7ux
         TbgjbgbJ0jlrZFk0K96d50x5HyqXGG1h+hwj+G2nDFLgQJFnLj1RhMfeq8pkpKoqbn2J
         mRQGUJUI6+ZFWoYDmW7lb63zS1m2dAQcpL3cLQYIQ9qizhYH9eSZkC8SK2084zSyLu47
         UGOnXLbC4xVS+TSqHkU5algpRb2gh8aOdw8DQkBkcWSZCkCit1+BK+34cffMALZ627vn
         FM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682475; x=1735287275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5boJminZgitxq3r5NaydDCyPtGRydqEl633WaiR2zg=;
        b=ToRrVp2NmQgfELc3slHXU6pp9to9ypANj4CFvpxpYm0yyM9ouyfjBaV98s180SHrUC
         LLGaSKb/yYY92pT8Y8gFUlK/ctFdSeobsTnOY5H6p+P1/D8JDvZI9zqB6X1m+KnV4Dbu
         s8X2EvlZVBHFX+GXDoeXhnLZILyAWpX45jips2cxz4CBeX8sCaWCzOQhKuZW7lbF5KMA
         1yeetVDTljk4uJpvXnWr8qDudjcaD/CxnNNPp0kouv+QmaPZWmzYSB0TEyYAncYfCyt1
         BJDPc607CFCPkC8faFUUYIy6ClPp5zugtMbH/TJec6CNy66ws3/T06hGWRZe16YzWv4X
         NfPw==
X-Forwarded-Encrypted: i=1; AJvYcCX87Ub4lRXWiSlC87AEKObYXzsBlRXA6V/lCZEi9d14cdCUdmiwLpW/DknArUiFjKiyJGBQW4xy/VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqA5S8sAwKGXSC89w63n+uUFFqFiAhNDBngxaVyEvYM0e7O0r
	J0UIXnfoRu26gVy7SltT5+hwmMirnZGXzq4T8kuGB2E8lBJRibdHrLlZfd7K0w==
X-Gm-Gg: ASbGncsimtv/oZnA+EwzTB4K1ocF3D2lkn8PeHleJ+I++G+J7JJ/RruBjY58DcqzsyX
	iLfXtQ433jGjCkMFkyaAqbhrWAt3ldXXH/3au8uSk+Qa1Gf5Pdest7IXLYdvIRh8qhsDqyBz2IH
	vOiKv1icUSLbeOFkP6IBBVfSJfB6EmNh+gRyr0VK5PlRHnqwpIw2gANrEDor+6QZ9toZp1ZwsFr
	GGfHlB7rXR4s8sMLbQDL+EWKffrW/wb0cefPJX9XWktnPQsK30PR5ZiKkJDUsr+NcOa
X-Google-Smtp-Source: AGHT+IHOl61JImRQqmKCDrXFRMLTrXVw/zhuZfo68uKgYeo2DlE/cbas/GF5RcYOFesppKrRBmopqA==
X-Received: by 2002:a17:90b:514d:b0:2ee:dd79:e046 with SMTP id 98e67ed59e1d1-2f452e2e49dmr3073613a91.13.1734682475386;
        Fri, 20 Dec 2024 00:14:35 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd54sm5070410a91.41.2024.12.20.00.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:14:34 -0800 (PST)
Date: Fri, 20 Dec 2024 13:44:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220035441.600193-19-dlemoal@kernel.org>

On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
> Add a documentation file
> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> endpoint target driver. This provides an overview of the driver
> requirements, capabilities and limitations. A user guide describing how
> to setup a NVMe PCI endpoint device using this driver is also provided.
> 
> This document is made accessible also from the PCI endpoint
> documentation using a link. Furthermore, since the existing nvme
> documentation was not accessible from the top documentation index, an
> index file is added to Documentation/nvme and this index listed as
> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> API index.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Small nit below.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-nvme-function.rst        |  13 +
>  Documentation/nvme/index.rst                  |  12 +
>  .../nvme/nvme-pci-endpoint-target.rst         | 368 ++++++++++++++++++
>  Documentation/subsystem-apis.rst              |   1 +
>  5 files changed, 395 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
>  create mode 100644 Documentation/nvme/index.rst
>  create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 4d2333e7ae06..dd1f62e731c9 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -15,6 +15,7 @@ PCI Endpoint Framework
>     pci-ntb-howto
>     pci-vntb-function
>     pci-vntb-howto
> +   pci-nvme-function
>  
>     function/binding/pci-test
>     function/binding/pci-ntb
> diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
> new file mode 100644
> index 000000000000..df57b8e7d066
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
> @@ -0,0 +1,13 @@

[...]

> +Configure the function using any device ID (the vendor ID for the device will
> +be automatically set to the same value as the NVMe target subsystem vendor
> +ID)::
> +
> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
> +        # echo 0xBEEF > nvmepf.0/deviceid

It'd be good to mention that the vendor id set with nvmet configfs will be
reused here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

