Return-Path: <linux-pci+bounces-8469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D1900A85
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0811B1F23FD9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EB197501;
	Fri,  7 Jun 2024 16:32:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB217C73;
	Fri,  7 Jun 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777976; cv=none; b=nISM3ZAvWDGklnanBEu1shIeOYcdHyOKRRXuUBfq+rogT6fUKVJp1+yfNyL1XYcigKt1nBTDJyuceJYpF7Rg5DKkXqcQwlFYzG4HbgGSUIE9HTYW7pY0mnjUQB8QF7mtoG6lWPARDT1hepr8PyMalWxVUSr4ck/zLv/yWYOzyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777976; c=relaxed/simple;
	bh=xjv1zFkmCPNQYjWEzOpbV3VX1wRuOu9jH2q93dMSu1I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfF2AWoFwWrKfq5JfI7G4DKP8Y11AHWvBb3xmXtOJvYTHUfV/SelShLogeBXPr8hZwGmV8eM4sX0gWy/GftqatkMbWKnVRI0k5euE4VhSV3GEkmd0VjjE2DSRNTfXKqFjPFdgiGuWBIIZQ1cQsiy2/pFf0QIIFDWwbKxCsRZUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwmpJ5cDFz67RyC;
	Sat,  8 Jun 2024 00:28:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A9CAE140A70;
	Sat,  8 Jun 2024 00:32:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 17:32:51 +0100
Date: Fri, 7 Jun 2024 17:32:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wei Huang <wei.huang2@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alex.williamson@redhat.com>,
	<gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<bagasdotme@gmail.com>
Subject: Re: [PATCH V2 4/9] PCI/TPH: Implement a command line option to
 force No ST Mode
Message-ID: <20240607173250.000065d7@Huawei.com>
In-Reply-To: <20240531213841.3246055-5-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-5-wei.huang2@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:36 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> When "No ST mode" is enabled, end-point devices can generate TPH headers
> but with all steering tags treated as zero. A steering tag of zero is
> interpreted as "using the default policy" by the root complex. This is
> essential to quantify the benefit of steering tags for some given
> workloads.

This is a good explanation. Need similar in the previous patch to
justify the disable TPH entirely.

> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index 5dc533b89a33..d5f7309fdf52 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -43,6 +43,27 @@ static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
>  	return ret;
>  }
>  
> +int tph_set_dev_nostmode(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	/* set ST Mode Select to "No ST Mode" */
> +	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
> +				    PCI_TPH_CTRL_MODE_SEL_MASK,
> +				    PCI_TPH_CTRL_MODE_SEL_SHIFT,
> +				    PCI_TPH_NO_ST_MODE);
> +	if (ret)
> +		return ret;
> +
> +	/* set "TPH Requester Enable" to "TPH only" */
> +	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
> +				    PCI_TPH_CTRL_REQ_EN_MASK,
> +				    PCI_TPH_CTRL_REQ_EN_SHIFT,
> +				    PCI_TPH_REQ_TPH_ONLY);

Unless these have to be two RMW operations. (if they do add a spec reference)
then this is a good example of why a field update function may not be
the right option.  We probably want to RMW once.

return tph_set_reg_field_u32()

> +
> +	return ret;
> +}
> +
>  int pcie_tph_disable(struct pci_dev *dev)
>  {
>  	return  tph_set_reg_field_u32(dev, PCI_TPH_CTRL,


