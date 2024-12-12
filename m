Return-Path: <linux-pci+bounces-18213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA119EDDB0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 03:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440CE167D5B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7513633F;
	Thu, 12 Dec 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CZ9Gxy0Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740F18643;
	Thu, 12 Dec 2024 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970744; cv=pass; b=I4go03uZw0SaixQnHjN4jMFC2zNPFz41DjPwWCkhvYFfSzUyc48c/gxG3CQhBe11Q9xVSG9EMMh+hMPvmKJ6gLCx/QlfGgr2ZXZKzwii0++fWhqLAHD42NNlf1rryPHD4VhuYICr9YejqAT052QcWNiEoFIEpbFGXp/hcwtAsoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970744; c=relaxed/simple;
	bh=eaQkOF9Jf0wWrpGxlEZdBUsEoqXgdpd1jEUbHm2nYzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HrXD5Knf+LLMVDEWxu5AAGLyDp1OIOBdkkGtyGgZSo/bnUqm7XGukLTQqy3kbGj6CI7uuoqCtEfpPvgzOk8nlqGw4le1rXKiNTKcI1esBaJAZl6uiaLsjOFhKhDT2fYu1MUB9sjXX90Fg9z5XPFtwlZBJzu2AoRXBEswpfEpHvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CZ9Gxy0Q; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1733970715; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RVCicII0a0uX3SfzyFmIPlesRDI6vtdCVQcOMQr2pCeRQJ5kBsXP5KYFXFj5BCnA6wVWTwBJPmtZP5SdNmCiLVLjWwOLHf7bKpq7KfcR4PT9TYc8IR8Ia+GaOdmHDl+NAgFTFF4bzJ2tk8kciy1A2jMp1eO5SCiOOo7Cvhlp+d4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733970715; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=zalQu0pwbiDcw7F1cqJxg4GJJw/8VFQDLsWjoxoHGZE=; 
	b=UqeM4SsBtUIQWkK/t0dZqvRLvYLIhS1HPLCYJajzSB76zdV0yEyiXgIu3WMyC6KlgNbkVASaeUvqtIr6r7hGjjKkZtMhnqy6+k6bQdnYlrgIRqB+JgM1fqd5+RSz2JHcnaxk8YkzoHna29vXx90koWIplo3dpfNiimcY6cV+xWM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733970715;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=zalQu0pwbiDcw7F1cqJxg4GJJw/8VFQDLsWjoxoHGZE=;
	b=CZ9Gxy0QI9RCQkNiMOMvPyRuNI0ADoMv7xwKjfemw/ESUbqyJW4t4CrjX6hm+aXJ
	Cq40VaaGo1vwuyAxMG30aVlMWzEh9Ivfy05Gj3esUtYcXG1wvoGMqWgrfoyay4jFOnx
	gv59QQwFE+KUbS+k+N/KnJVJjnKu7gCRFfHHQwnk=
Received: by mx.zohomail.com with SMTPS id 1733970712877505.3115459643508;
	Wed, 11 Dec 2024 18:31:52 -0800 (PST)
Message-ID: <04d33184-be7b-432b-a83f-fce649de3491@zohomail.com>
Date: Thu, 12 Dec 2024 10:31:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-15-terry.bowman@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20241211234002.3728674-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227a8d71315135e6df905226dad0000b46c5a0ec3049f1397ddb2bbb36d57fe028d6ab660cef789bd:zu08011227c80956e6aebd3b7708812ab00000a28035694b60fea3c85626c1d66a0bc76b905c4c075ff8af94:rf0801122b5e795df8b5a8350207d939970000ab71120650df791615a4674ba8b98e5c19e9daa9075a2f7c5c5182f9cb:ZohoMail
X-ZohoMailClient: External

On 12/12/2024 7:40 AM, Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
>
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
>
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
>
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3294ad5ff28f..9734a4c55b29 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>  	return __cxl_handle_ras(&pdev->dev, ras_base);
>  }
>  
> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> +	.error_detected	= cxl_port_error_detected,
> +	.cor_error_detected = cxl_port_cor_error_detected,
> +};
> +
> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> +{
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver)
> +		return;
> +
> +	pdrv = pdev->driver;
> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> +}
> +
> +static void cxl_clear_port_error_handlers(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver)
> +		return;
> +
> +	pdrv = pdev->driver;
> +	pdrv->cxl_err_handler = NULL;
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
> +
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	if (port->uport_regs.ras)
>  		return;
> @@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);

I think the first parameter of devm_add_action_or_reset() should be 'port->dev' rather than 'port->uport_dev'.

'port->uport_dev' is 'pci_dev->dev' which will be destroyed on pci side, 'port->dev' will be destroyed on cxl side.

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>  
> @@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>  
>  	dport->reg_map.host = dport_dev;
>  	if (dport->rch && host_bridge->native_aer) {
> @@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>  		return;
>  	}
> +
> +	if (dport->rch)
> +		return;
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);

Same as above, should use 'port->dev'.

please correct me if I am wrong.


Ming

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>  



