Return-Path: <linux-pci+bounces-14201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4C998D3C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AFC1F24C35
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B81CDFD3;
	Thu, 10 Oct 2024 16:23:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BA7DA62;
	Thu, 10 Oct 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577412; cv=none; b=IYFG47sk6eiQ/nzWH7wLnoiasD4+kFSLHOOJLAmaYSbgJH+A1x6ZyCmL8a+ag6rQCMlxMVpq+827Fp73H2qrjffPV+T27OVAPhQIaqETrePsAgpY5HUPlqka37inzjIJgG3dqEyhpBQtdUOGE7EkzMaQWppyNkYG2jLJbZ/TxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577412; c=relaxed/simple;
	bh=r5RQUSqIRifgak7HHNmWG3aZxu+/9+hiSZdy3uPwCVs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbP4pPw8S0KJ4QJBijnO5dBQIduKveKBupZasjC01QRiDbNtF4bLqCW8MsXM8++TbO2ibXmgPKxSw8GoPNUNiDHy3lEZ8Go1HO+ZZjUEGPMZ1UFTcj7jeXVmpg7/OmoYPJXWbavWExPubMU+2bT1/NXicxE8TFrvmCV7JygCAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPZlf44Lsz67MRx;
	Fri, 11 Oct 2024 00:22:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EB1B01400CB;
	Fri, 11 Oct 2024 00:23:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:23:27 +0200
Date: Thu, 10 Oct 2024 17:23:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Gregory Price <gourry@gourry.net>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <20241010172326.00004d1a@Huawei.com>
In-Reply-To: <ZweukOWeqFy8vd4W@wunner.de>
References: <20241004162828.314-1-gourry@gourry.net>
	<ZweukOWeqFy8vd4W@wunner.de>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 12:38:08 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Fri, Oct 04, 2024 at 12:28:28PM -0400, Gregory Price wrote:
> > Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
> > interval (1 second), resolves this issues cleanly.  
> 
> Nit: s/issues/issue/
> 
> > Subsqeuent code in doe_statemachine_work and abort paths also wait  
> 
> Nit: s/Subsqeuent/Subsequent/
> 
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >  	size_t length, remainder;
> >  	u32 val;
> >  	int i;
> > +	unsigned long timeout_jiffies;  
> 
> Nit: Reverse Christmas tree.
> 
> With that addressed,
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
Looks good to me with Lukas' nits tidied up.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



