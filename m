Return-Path: <linux-pci+bounces-31349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F5AF6FBE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6878A3ADBC3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADC2D7809;
	Thu,  3 Jul 2025 10:11:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16D1B95B;
	Thu,  3 Jul 2025 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537491; cv=none; b=dgEeQR1EtyYqB7ganjDQVOHoDvpqB/iAYadElNgZPfgZLGVWmtLcd24vocVKM2mP/jyOaak/hwLKVF5t3WA1rNkwMnfYPDK4MehKjogcwc7Y0SugivePKl0XkPWXU1C7Y4pMuus+zqh598Ozf+1VNQIFOpGRQKU+rNR5NKxFah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537491; c=relaxed/simple;
	bh=bxmDWgAHhmAzm6s7SRxYDJIDNOqa8/FShegHd1ZDB20=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5bisNxtOS1fBGpHKffWa6DYHbd1q282HeWesZcoxcM2im+OD7XXOmNvnOEpE9XXMklDbTivy7Py/Z/k5ZoXupSLj4IIxDc9KKuKP/Qe3ojBPvpttkM0Du4Rkbr3VI8EL83dU0UoMaEK/KPacyQhlHfd3mYBpqmik+WfWHE6Bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXsw56nDfz6M4Sn;
	Thu,  3 Jul 2025 18:10:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DEDA81404FE;
	Thu,  3 Jul 2025 18:11:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 12:11:26 +0200
Date: Thu, 3 Jul 2025 11:11:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20250703111124.00007e93@huawei.com>
In-Reply-To: <0f0d74ca-a4f5-4cf0-850b-bb00126cf71b@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-7-terry.bowman@amd.com>
	<8d0949db-fa5d-4e8a-a904-61cb78ccb176@intel.com>
	<0f0d74ca-a4f5-4cf0-850b-bb00126cf71b@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 12:56:29 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 7/1/2025 6:04 PM, Dave Jiang wrote:
> >
> > On 6/26/25 3:42 PM, Terry Bowman wrote:  
> >> The AER driver is now designed to forward CXL protocol errors to the CXL
> >> driver. Update the CXL driver with functionality to dequeue the forwarded
> >> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> >> error handling processing using the work received from the FIFO.
> >>
> >> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
> >> AER service driver. This will begin the CXL protocol error processing with
> >> a call to cxl_handle_proto_error().
> >>
> >> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
> >> previously in the AER driver. Add check that Endpoint is bound to a CXL
> >> driver.
> >>
> >> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
> >> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
> >> will return a reference counted 'struct pci_dev *'. This will serve as
> >> reference count to prevent releasing the CXL Endpoint's mapped RAS while
> >> handling the error. Use scope base __free() to put the reference count.
> >> This will change when adding support for CXL port devices in the future.
> >>
> >> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
> >> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
> >> errors will be processed with a call to walk the associated Root Complex
> >> Event Collector's (RCEC) secondary bus looking for the Root Complex
> >> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
> >> so the CXL driver can walk the RCEC's downstream bus, searching for the
> >> RCiEP.
> >>
> >> VH correctable error (CE) processing will call the CXL CE handler. VH
> >> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> >> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> >> and pci_clean_device_status() used to clean up AER status after handling.
> >>
> >> Maintain the locking logic found in the original AER driver. Replace the
> >> existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
> >> lock for maintainability. CE errors did not include locking in previous driver
> >> implementation. Leave the updated CE handling path as-is.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>  
> > Couple minor comments below. Otherwise
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> Thanks Dave.

Hi Terry,

Picking a random patch, another small request process wise.

If you agree with all suggestions in a review, don't reply to that email
just put your thanks and what changed in the change log of the next version.

Skipping that reply cuts down on the volume of emails that need scrolling
through and generally helps people focus on the emails that matter where there
is a question or similar.

This one gets a lot of contributors because it feels rude to not reply
but doing it via the next version is more efficient for everyone!

Jonathan

p.s. I only bother moaning about this to contributors who are sending
     quite a bit of useful stuff!


