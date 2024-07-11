Return-Path: <linux-pci+bounces-10131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F47A92DDD0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49FDB23F59
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 01:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAD18EAF;
	Thu, 11 Jul 2024 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAUiNpn4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2610A36;
	Thu, 11 Jul 2024 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660483; cv=none; b=Ai9ryazEBVve/EMowsjAvjOby7YUAa0IAUrfLUdfDCvjfoXTtoTR41IK3ejbZaT88vHRUIWj7aG1piNMr0VYHXg9nToRFQwvaqPmUep1UdbjVvVz1bHwcM3cE76CIM3psSSmNYzwt3TU5VYjCu1Wn7ReLd//y4wrNbCE8EXK/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660483; c=relaxed/simple;
	bh=6/zkEDXjZjxv6dDfH3KWAd0N7AnaFH1Zmp5aws/7dQk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI7rDliEmEIRyR5Yy1kW8j+Pgu2K/HF+Wom7MBVSQf2QcKt7XEg/UZYiWLzz4Kwzk5JYWxgKh9ITZ4lsml1FaCkTe/QuhCIOP9urhUrVzqYZEHM/QqYdUiQi21cdHzyVOFzueYI9LfHi6Wd2k5KEc7Wf+nIJQXZSSKHy3RpatuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAUiNpn4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fafc9e07f8so2504905ad.0;
        Wed, 10 Jul 2024 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660481; x=1721265281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rr7Q65/uUNMtJMngxD5LyYKesf+tbYcSf5IHS4oP4n8=;
        b=jAUiNpn4e5i8hbgW/V9nHh1y59tzaQH2MI3E39ZRSwTckpsbUPo6zdDi0M7Qj1H1Ew
         sHrPSR4u8vPArEXfIe4QSskottINLFSo3J1CCphBTdUoRgiOeg9oAPxEk76DJcVY1x2I
         YcI6sfZRVVs09dEVw8O9gdFaoVO0OGQRCGjXMyrC7VVf1/8g/Lwc4lLNr/6LrLHHoJvB
         +z2FuTKpxJ4D2kMufB/PS0heZs6wMCE/bZIlAhMNBBDHzNmdq6QgZHBr0ZzxKVmOjQXS
         4vZOTwCQYbQA9jDkLG3+erjcGabcObbLsJATKHnQHHX14MLW+SuTCbHQG/mkzPsLX7fd
         Pq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660481; x=1721265281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr7Q65/uUNMtJMngxD5LyYKesf+tbYcSf5IHS4oP4n8=;
        b=oXBvrlDHANZWtoLM326Sf/ZiLS7s7E65/KZSacRuwDgT4rBhCXbi96P79mmLuqVSuf
         lFwcsmsOqKnw7JUuj12wAXZ/QLWCB0HaO3sxpwJUibaH5RrNRxcNPFU3G3x/InTXdPvD
         4yfihOVH4EkKWDQaO7S5LKpQwULORcfA9qDwXXskLKli06RPWFjgtUqBt7ed8TMd3B6x
         XgrDZHhXca3/7F9wmtDdPdS95pgt//bk1CwneDENy71NXcXS3rhH+e0mZ0BerMDNgrsu
         sqXM/NSWPtH+DdUE+zLyk8Kt+2GzzrCRqBylGWrqhkM9CxsOWLEgLNpdMF4lIq/Va1p9
         8OBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPzrKGNiHpTDhGHvBmm0J+KZgcnYo4JbEabFLCgv8aZdPYF4pxt7eW+zEYyXFXyr3V52NIFlzhckrRVFLkNsar0U4seuGxv+QvK+gX7t9xoovjgkz1YsA/QV0533QVOk8Hh6vH5sNnqsG9qi/l/G2auppb6UOv5KPE9Y1MUxaJsYUZ
X-Gm-Message-State: AOJu0YxAfNFHfRgMIXFrZyleiHeykJdquZ7fuCEdxD7nbJmM1A3HCPdP
	jrNrIv7zvjVgClvTPxB1//KMRL/ZF2H2Xc2+s+vHmv2rrzuIrkxU
X-Google-Smtp-Source: AGHT+IFJUeFA3eAzgk0yLfvuWC7HhHDzJ0TYJRTj/e7EpBNO4Fa5aqAl/Zb3JcJpxWMpURw+W2y5RA==
X-Received: by 2002:a17:903:2bcb:b0:1f8:5a64:b468 with SMTP id d9443c01a7336-1fbb6ed9d22mr62847735ad.47.1720660480788;
        Wed, 10 Jul 2024 18:14:40 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:398f:325f:a0e2:200f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7c66sm39383215ad.121.2024.07.10.18.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:40 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 10 Jul 2024 18:14:25 -0700
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: nifan.cxl@gmail.com, Dan Williams <dan.j.williams@intel.com>,
	ira.weiny@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, ming4.li@intel.com,
	vishal.l.verma@intel.com, jim.harris@samsung.com,
	ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Message-ID: <Zo8x8YvdHSgcjGcR@debian>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
 <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
 <ecc5fbd0-52e1-443f-8e5a-2546328319b2@amd.com>
 <668ef3a2.050a0220.96a0c.4f5c@mx.google.com>
 <8bf0d1c9-632e-458b-9b78-0faeea0472f8@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf0d1c9-632e-458b-9b78-0faeea0472f8@amd.com>

On Wed, Jul 10, 2024 at 04:48:09PM -0500, Terry Bowman wrote:
> Hi Fan,
> 
> On 7/10/24 15:48, nifan.cxl@gmail.com wrote:
> > On Mon, Jun 24, 2024 at 12:56:29PM -0500, Terry Bowman wrote:
> >> Hi Dan,
> >>
> >> I added a response below.
> >>
> >> On 6/21/24 14:17, Dan Williams wrote:
> >>> Terry Bowman wrote:
> >>>> The AER service driver does not currently call a handler for AER
> >>>> uncorrectable errors (UCE) detected in root ports or downstream
> >>>> ports. This is not needed in most cases because common PCIe port
> >>>> functionality is handled by portdrv service drivers.
> >>>>
> >>>> CXL root ports include CXL specific RAS registers that need logging
> >>>> before starting do_recovery() in the UCE case.
> >>>>
> >>>> Update the AER service driver to call the UCE handler for root ports
> >>>> and downstream ports. These PCIe port devices are bound to the portdrv
> >>>> driver that includes a CE and UCE handler to be called.
> >>>>
> >>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>> Cc: linux-pci@vger.kernel.org
> >>>> ---
> >>>>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
> >>>>  1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >>>> index 705893b5f7b0..a4db474b2be5 100644
> >>>> --- a/drivers/pci/pcie/err.c
> >>>> +++ b/drivers/pci/pcie/err.c
> >>>> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >>>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> >>>>  
> >>>> +	/*
> >>>> +	 * PCIe ports may include functionality beyond the standard
> >>>> +	 * extended port capabilities. This may present a need to log and
> >>>> +	 * handle errors not addressed in this driver. Examples are CXL
> >>>> +	 * root ports and CXL downstream switch ports using AER UIE to
> >>>> +	 * indicate CXL UCE RAS protocol errors.
> >>>> +	 */
> >>>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >>>> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> >>>> +		struct pci_driver *pdrv = dev->driver;
> >>>> +
> >>>> +		if (pdrv && pdrv->err_handler &&
> >>>> +		    pdrv->err_handler->error_detected) {
> >>>> +			const struct pci_error_handlers *err_handler;
> >>>> +
> >>>> +			err_handler = pdrv->err_handler;
> >>>> +			status = err_handler->error_detected(dev, state);
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>
> >>> Would not a more appropriate place for this be pci_walk_bridge() where
> >>> the ->subordinate == NULL and these type-check cases are unified?
> >>
> >> It does. I can take a look at moving that.
> > 
> > Has that already been handled in pci_walk_bridge?
> > 
> > The function pci_walk_bridge() will call report_error_detected, where
> > the err handler will be called. 
> > https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/err.c#L80
> > 
> > Fan
> > 
> 
> You would think so but the UCE handler was not called in my testing for the PCIe 
> ports (RP,USP,DSP). The pci_walk_bridge() function has 2 cases:
> - If there is a subordinate/secondary bus then the callback is called for
> those downstream devices but not the port itself.
> - If there is no subordinate/secondary bus then the callback is invoked for the 
> port itself.
> 
> The function header comment may explain it better:
> /**                                                                                                                                                                                                                
>  * pci_walk_bridge - walk bridges potentially AER affected                                                                                                                                                         
>  * @bridge:     bridge which may be a Port, an RCEC, or an RCiEP                                                                                                                                                   
>  * @cb:         callback to be called for each device found                                                                                                                                                        
>  * @userdata:   arbitrary pointer to be passed to callback                                                                                                                                                         
>  *                                                             
>  * If the device provided is a bridge, walk the subordinate bus, including                                                                                                                                         
>  * any bridged devices on buses under this bus.  Call the provided callback                                                                                                                                        
>  * on each device found.                                                                                                                                                                                           
>  *                                                                                                                                                                                                                 
>  * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,                                                                                                                                          
>  * call the callback on the device itself. 
>  */
> 
> Regards,
> Terry

OK, interesting.
Btw, what is the "state" passed to pcie_do_recovery(...state...)?

Fan

> 
> >>
> >> Regards,
> >> Terry

