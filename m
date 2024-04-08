Return-Path: <linux-pci+bounces-5860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DC89BA62
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24511F22BA8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C3383AC;
	Mon,  8 Apr 2024 08:34:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74343A1A1;
	Mon,  8 Apr 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565274; cv=none; b=h6W9qCoVCyiplvh2xatwAca8I0wATWXPhPwcsrcLqW+/guwJV9VzK7Ar7Nwl7W2jrTIkGyxRHc2egToDhZetBi16hD/OVj8XKYexoVoVW1eI7gKfXgINX/I7+KCCpm8nimx1BN3kbeTo2zo5XBrWc04z5qxbwftZGy8HEWZv6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565274; c=relaxed/simple;
	bh=x17ORC32Viklhe62/M9AbxsYOugUrbs6BdpjADn5zX0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c371PMLQv4ZnDLOIs8Mvx/3QXKmgKWAQCM7TzbraJza0PakKCsfiWhOSvSBxy8E7jmXIy9wgpqAkGtvf8CQfQfhDtJCZCLqQj2iNUR11IdcN8SdkhBd8R5Fv9xT3AdhQafHmrruMSFgX4v5crSAUY5HCT2R7xz8m5GJYlGmrDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VCj1v1qsJz6K6hC;
	Mon,  8 Apr 2024 16:29:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD81140A79;
	Mon,  8 Apr 2024 16:34:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 8 Apr
 2024 09:34:22 +0100
Date: Mon, 8 Apr 2024 09:34:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: PJ Waskiewicz <ppwaskie@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <20240408093422.000062d9@Huawei.com>
In-Reply-To: <ZhNQa8wAflycciNA@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
	<ZhMP-NBMb387KD4Y@wunner.de>
	<ZhNQa8wAflycciNA@snoopy>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 7 Apr 2024 19:03:23 -0700
PJ Waskiewicz <ppwaskie@kernel.org> wrote:

> On 24/04/07 11:28PM, Lukas Wunner wrote:
> 
> Hi Lukas,
> 
> > On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:  
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> > >  
> > >  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> > >  	if (rc != AE_OK) {
> > > -		dev_err(dev, "unable to retrieve _UID\n");
> > > +		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
> > >  		return -ENOENT;
> > >  	}  
> > 
> > dev_err(dev, FW_BUG "unable to retrieve _UID\n");
> >              ^^^^^^
> > 
> > There's a macro for that.  
> 
> Doh...it's been awhile since I've crossed buggy BIOS's.  Thanks for the
> review and comment.
> 
> Updated patch:
> 
> cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup failure
> 
> From: PJ Waskiewicz <ppwaskie@kernel.org>
> 
> Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
> drivers on Emerald Rapids systems.  However, on some production
> systems from some vendors, a buggy BIOS exists that improperly
> populates the ACPI => PCI mappings.  This leads to the cxl_acpi
> driver to fail probe when it cannot find the root port's _UID, in
> order to look up the device's CXL attributes in the CEDT.
> 
> Add a bit more of a descriptive message that the lookup failure
> could be a bad BIOS, rather than just "failed."
> 
> v2: Updated message to use existing FW_BUG macro
Move the change log "v2..." etc below the ---
as we don't want it in the long term git log + better to send a fresh
patch in a separate thread.

Other than that seems reasonable to hint it is probably a bios
bug - however I wonder how many other cases we should do this for and
whether it is worth the effort of marking them all?

Jonathan



> 
> Signed-off-by: PJ Waskiewicz <ppwaskie@kernel.org>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af5cb818f84d..d321cfbd4682 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>  
>  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
>  	if (rc != AE_OK) {
> -		dev_err(dev, "unable to retrieve _UID\n");
> +		dev_err(dev, FW_BUG "unable to retrieve _UID\n");
>  		return -ENOENT;
>  	}
>  


