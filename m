Return-Path: <linux-pci+bounces-10840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577E93D2C8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 14:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB091C21241
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B7317B424;
	Fri, 26 Jul 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HlXXtBas"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0017B41B;
	Fri, 26 Jul 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995641; cv=none; b=OPrsYVAMidjv20KMggJ4wAaxYODOCXjvEUobSetZkBr+rns3X2/QMANf/xRR2P+P7PjbcW+dmOqrDskavNgLwXFj3L43QNOPYjjLzqzyPsQFsh15SwrZnivKHuMi7RLjxcP1ZSJGo4JG96NDRYLKlLqVJrfPDZNxxxD17CaAXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995641; c=relaxed/simple;
	bh=bMl77tOSd51zz1D3u2B0loJWkNusxsZyBhr+5DsdKYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f53uEKoKutcnOsyQ3WqCmam9UGacrEfBi7thW/Eshm98h/489cCtMa1HnynOB5aZzLtau3GAr6sabZLyOl3zsEjeu54uuI+AlszOq69OZGcrdCSo/vur5J5BFDbOZ6x/kjSNGTQVGDKNdozRiRg9/EIHoxxz5kN0VBTOp9gCSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HlXXtBas; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QC6x8S023189;
	Fri, 26 Jul 2024 07:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721995619;
	bh=vsqNMysQUHjEuHaKrRwfGzQ5izr5DrtDTkWgNjf9rQM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HlXXtBasnbagEpJyIlKNevd0sziAo+ztMtRUo+DcgwTljrPKiYldlv2SdyJiQxZ5C
	 Go912/l8kT6Kowf19mxVnyWnBanPp7E09EFve3Y87aTVzTUwLMosrnsa1GupuvnNQH
	 yyYbJayAnYzRPXGI/wqD+fU3aOHRN59AI3Rfqxkk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QC6w6K041746
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 07:06:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 07:06:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 07:06:58 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QC6vkp129002;
	Fri, 26 Jul 2024 07:06:58 -0500
Date: Fri, 26 Jul 2024 17:36:56 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <ahalaney@redhat.com>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <465fbf0f-39b9-4ea6-be99-f726e275d099@ti.com>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
 <20240725074708.GB2770@thinkpad>
 <5f7328f8-eabc-4a8c-87a3-b27e2f6c0c1f@ti.com>
 <4cb79826-5945-40d5-b52c-22959a5df41a@ti.com>
 <20240726113008.GE2628@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240726113008.GE2628@thinkpad>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Jul 26, 2024 at 05:00:08PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 26, 2024 at 03:54:17PM +0530, Siddharth Vadapalli wrote:

[...]

> > Mani,
> > 
> > I prefer setting 'swizzle_irq' to NULL as well unless you have an objection
> > to it. Kindly let me know. I plan to post the v2 for this patch addressing
> > Bjorn's feedback and collecting Andrew's "Tested-by" tag as well.
> > 
> 
> Ok, fine with me.

Thank you for the confirmation.

Regards,
Siddharth.

