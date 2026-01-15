Return-Path: <linux-pci+bounces-44975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12021D25AF1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E42C309F747
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFEA2C11E7;
	Thu, 15 Jan 2026 16:12:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4013A7DFD;
	Thu, 15 Jan 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493554; cv=none; b=rXKp3OBv3Wr2tiJ4eMPklGVmdQq06L1EbExyZKVWXCWgA8Relt/7OgD7YRp6zAbMsd4wYyXohxa0s74hvhvScxqIdTZVhKZIUy+ipDsHL3mVdtHAtHQySWc4xt8d9Li9/tJpRfgOezGJroj79qg96wF5P1TcvuQ0uFIFkmeZBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493554; c=relaxed/simple;
	bh=hNov5F2LTdlNWayImHLF8ZGBkOaoIozgFIDUq31gNfo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFshxzzEJgIMokvvg0ZmCDLRNoMrnKibLeX6oBQFh3OhskAv7TrekD+Hd/V1ggK5Rhe2/5PMdqXZiiD2pcc42U/8m4wDiizRF5t/mPg6lAFH4GGocCNuuLB1ETx7b7MNHpAceidVoWB2c2vKt713SdOMm06nSMLIDWtw+OOrMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsSft16LszHnGfT;
	Fri, 16 Jan 2026 00:12:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5598140563;
	Fri, 16 Jan 2026 00:12:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 16:12:27 +0000
Date: Thu, 15 Jan 2026 16:12:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 31/34] PCI: Introduce CXL Port protocol error
 handlers
Message-ID: <20260115161226.00004845@huawei.com>
In-Reply-To: <e3fd4ada-bcbe-4d7c-9ffe-4518b68292be@intel.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-32-terry.bowman@amd.com>
	<e3fd4ada-bcbe-4d7c-9ffe-4518b68292be@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)


> > diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> > index 0c640b84ad70..96ce85cc0a46 100644
> > --- a/drivers/cxl/core/ras.c
> > +++ b/drivers/cxl/core/ras.c

> > +
> > +static pci_ers_result_t cxl_port_error_detected(struct device *dev);
> > +
> > +static void cxl_do_recovery(struct pci_dev *pdev)
> > +{
> > +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);  
> To minimize errors, move this line to right above when you check !port. It's acceptable to do inline declaration when it comes cleanup macros. 
> 
> DJ
> > +	pci_ers_result_t status;
> > +
> > +	if (!port) {
> > +		pci_err(pdev, "Failed to find the CXL device\n");
> > +		return;
> > +	}
> > +
> > +	status = cxl_port_error_detected(&pdev->dev);
> > +	if (status == PCI_ERS_RESULT_PANIC)
> > +		panic("CXL cachemem error.");
> > +
> > +	/*
> > +	 * If we have native control of AER, clear error status in the device
> > +	 * that detected the error.  If the platform retained control of AER,
> > +	 * it is responsible for clearing this status.  In that case, the
> > +	 * signaling device may not even be visible to the OS.
> > +	 */
> > +	if (pcie_aer_is_native(pdev)) {
> > +		pcie_clear_device_status(pdev);
> > +		pci_aer_clear_nonfatal_status(pdev);
> > +		pci_aer_clear_fatal_status(pdev);
> > +	}
> > +}

> > +
> >  void cxl_cor_error_detected(struct pci_dev *pdev)
> >  {
> >  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > @@ -346,6 +425,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> >  
> >  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> >  {
> > +	struct pci_dev *pdev = err_info->pdev;
> > +
> > +	if (err_info->severity == AER_CORRECTABLE) {
> > +
> > +		if (!pcie_aer_is_native(pdev))
> > +			return;
> > +
> > +		if (pdev->aer_cap)
> > +			pci_clear_and_set_config_dword(pdev,
> > +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
> > +						       0, PCI_ERR_COR_INTERNAL);
> > +
> > +		cxl_port_cor_error_detected(&pdev->dev);
> > +
> > +		pcie_clear_device_status(pdev);
> > +	} else {
> > +		cxl_do_recovery(pdev);
> > +	}

Could flip logic to get out of here quickly in one case.

	if (err_info->severity != AER_CORRECTABLE) {
		cxl_do_recovery(pdev);
		return;
	}

	if (!pci...

just to reduce indent we don't need.  Up to you though.
> >  }
> >  
> >  static void cxl_proto_err_work_fn(struct work_struct *work)
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 13dbb405dc31..b7bfefdaf990 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
> >  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> >  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> >  }
> > +EXPORT_SYMBOL_GPL(pcie_clear_device_status);
To me it's a little odd that we restrict this to AER
given it's not in AER specific registers or anything like that.

It only happens to be used in that code right now so I guess
it is ok to do this anyway.

> >  #endif

> > diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> > index 0f616f5fafcf..aa69e504302f 100644
> > --- a/drivers/pci/pcie/aer_cxl_vh.c
> > +++ b/drivers/pci/pcie/aer_cxl_vh.c
> > @@ -34,7 +34,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> >  	if (!info || !info->is_cxl)
> >  		return false;
> >  
> > -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> > +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> > +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> > +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
> > +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
> >  		return false;

Ah.  This fixes the earlier comment.  Maybe add a temp comment
or similar there to say you'll handle others later.
Also, maybe this is cleaner as a switch to avoid all those pci_pcie_type(pdev)
(or a local variable might also work).

	switch (pci_pcie_type(pdev)) {
	case PCI_EXP_TYPE_ENDPOINT:
	case PCI_EXP_TYPE_ROOT_PORT:
	case PCI_EXP_TYPE_UPSTREAM:
	case PCI_EXP_TYPE_DOWNSTREAM:
		return is_aer_internal_error(info);
	default:
		return false;
	}
> >  
> >  	return is_aer_internal_error(info);



