Return-Path: <linux-pci+bounces-14665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB49A0FB5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A326282A42
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D217CA1D;
	Wed, 16 Oct 2024 16:30:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1015E5CA;
	Wed, 16 Oct 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096219; cv=none; b=I5e/4cuWhndCyaGG1A9UlZNAmtabhcp7Sn2OphVP85Edm7vIykY32qbblqmkZ+qC6GQ9A8ZLW0TyaTn415+KK+F0GNHviPEgX+ehRlkuctvFbFNJIDio5yGEj0Su+bb4Ast3rKukQaaFmwLE9jKZ/TbvfNwIha/5IRNg4fwAE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096219; c=relaxed/simple;
	bh=ifgkVkIER1fekyXXjdFz/dVArNLvS3sJe+MD8HitC70=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/l0Jj/JuoRu1VFO0XfNsvVp4MZS6d61RH0HYRQoMN9+tfMB+06yVrR99+HIiVjWsohjfpoqVcAY9RPT5zaLvLf+vOZU7UROBux90vDO2qcz/30ZU3FCZtIdDU7J65cwXrh6tr7nYtnGSqNHnGen9un0qMUrMQAODgmuC85UaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGcJ4qxZz6J67l;
	Thu, 17 Oct 2024 00:28:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E977A140B39;
	Thu, 17 Oct 2024 00:30:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:30:13 +0200
Date: Wed, 16 Oct 2024 17:30:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 06/15] cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to
 pci_ers_result type
Message-ID: <20241016173011.000021e4@Huawei.com>
In-Reply-To: <20241008221657.1130181-7-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-7-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:48 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL AER service will be updated to support CXL PCIe port error
> handling in the future. These devices will use a system panic during
> recovery handling.

Recovery handling by panic? :) That's an interesting form of recovery..

> 
> Add PCI_ERS_RESULT_PANIC enumeration to pci_ers_result type.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  include/linux/pci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4cf89a4b4cbc..6f7e7371161d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -857,6 +857,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* Device state requires system panic */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */


