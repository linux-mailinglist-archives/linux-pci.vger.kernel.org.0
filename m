Return-Path: <linux-pci+bounces-10101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5792DA65
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D41C20944
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0C18C161;
	Wed, 10 Jul 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBASbZ07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B185DF71;
	Wed, 10 Jul 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644517; cv=none; b=H/VcDN4y/fpuVXRi7RmaTBXpWz3aXp/jGcVkePeOoCyYDAdZQdbgFPVbvNCqgo0y7621qrQSLv1ZJYLvRS0CUKpBZVnrokbENdFV+zE4s9jq2I1/Ct9a6WfhRyPexJr4dgpfTPlaK1QmirmiLRQYIuXkoopv/5ciD00ZTJaNgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644517; c=relaxed/simple;
	bh=/kfkKuVrXmiPEr6PIYbsQfX5EJvKRnQPcqUNsTwM/N4=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCgXEeCp+NJqqB/GUxWvT7AzuFRu6k8GlIrf9pEKw2FgB/aQKDm7M/e6eBIShW7a6UcKascEMA4LetXw62eAgNRn+u6nI7ZoAkexdOdIL1m4SZLi4TU91hsd16CVtzF8sZ7qhlpqpqI2GrLE475cRj0TV5Dweo4rfkqXGTunlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBASbZ07; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6512866fa87so1938817b3.2;
        Wed, 10 Jul 2024 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720644514; x=1721249314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ch/AJA/sA3QF/9K7kWs3lYEi/aLPB0ep6s8e5YeC7c=;
        b=RBASbZ07X8GnoTz2f7GT4jVxsy0Re4Wo5aEsGgRGq1cc+wor95tVCHNsVCInJxdIMa
         FOO3HnV6xozCw7Ru+WWaI8aXsNRMZbzOniS1sE3jucyz8g6a0JroG65EZ+P8lJvYmh+y
         a2NiIFGNdckzx6G1fcZV/Vq9JmZ3WD1i3CDBnE3yXOWsIaMMMFjcBPvAVhgAnFKH1bJ1
         zSyoNKEq+FwPwvQyq+i2Gv9467YEWsbVWJK3WE/AywfjJCpl3e9v/hPdGhoMM8daTbK5
         lLPNo+XpWNSVlGOB3i10AaGP1GTx84bsjIN3srcEB9ofA8SAZrD8I5d/sEhhTEn5hnrm
         uE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644514; x=1721249314;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ch/AJA/sA3QF/9K7kWs3lYEi/aLPB0ep6s8e5YeC7c=;
        b=RJuAqX3vG5abX8w5s/IIv+FnnNgAp5J3iD5MtqFATNdvObxCLk5S450aXM/7Pp9yhv
         JxvL+8U9hqnblPik/8nfzi16EtKmsK3OWeltHq7Fpj6FuipdATsyEzXufOQ33DYAMeV2
         CvcB3PXahmNG8/kRz+nAW6OULFrm3Af661UsKPsluJn58w2PtMzIZa+c4RnaEaYzh6+Y
         Ssz0niYtoHA0xC7PUxy5uzznu9tLF/ZHZHTNUAODIUT30t1yzbTC0hWjsjwGbBZpVwTZ
         LL9WHaJZIkHeNPCCdn+9bJmA/cErtObRhjlwq8x0W+3fAt/i7x1Shk0oJpyd17PGyftG
         ICtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGG0r6nEYTpQNtSr1TPABGoxHMm5Rr68SoZ3aQ/LZKxqKdmQQRkzan9JSPefv92vBRjYI8bq1fv/XM8VaH4tZyf7Xno2uaChzAEh3ZKAh5pbZICGvvY4JsA6XCJukJlwDjZaEo1KAVgog0NtCguPy/2Nf7OUJ/w8/ky2OgAbxWoARn
X-Gm-Message-State: AOJu0YxcIypiF7VRRVRmUT+3UMb26QIENNsLh3UUuJwJjQ3OKyIFj+9z
	GvS7ccdPYjDCAeTn5Q/g3UiazY0rEnFByQ41EMbbffasDBLvAbA9FtP9kQ==
X-Google-Smtp-Source: AGHT+IHqWeXS6RWFKMCzsXOI5tWyA3PleFBm/MdMw2n+0PWp6n1OfS+Q+m7ra1s61yQI2ArnS2P5Hw==
X-Received: by 2002:a0d:ee81:0:b0:64a:d5fd:f19e with SMTP id 00721157ae682-658ee790e6cmr74419587b3.3.1720644514352;
        Wed, 10 Jul 2024 13:48:34 -0700 (PDT)
Received: from gpd. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e6fb8aa8sm8608007b3.132.2024.07.10.13.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:48:34 -0700 (PDT)
Message-ID: <668ef3a2.050a0220.96a0c.4f5c@mx.google.com>
X-Google-Original-Message-ID: <Zo7zYfrURMv66JIQ@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Wed, 10 Jul 2024 13:48:31 -0700
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
 <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
 <ecc5fbd0-52e1-443f-8e5a-2546328319b2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc5fbd0-52e1-443f-8e5a-2546328319b2@amd.com>

On Mon, Jun 24, 2024 at 12:56:29PM -0500, Terry Bowman wrote:
> Hi Dan,
> 
> I added a response below.
> 
> On 6/21/24 14:17, Dan Williams wrote:
> > Terry Bowman wrote:
> >> The AER service driver does not currently call a handler for AER
> >> uncorrectable errors (UCE) detected in root ports or downstream
> >> ports. This is not needed in most cases because common PCIe port
> >> functionality is handled by portdrv service drivers.
> >>
> >> CXL root ports include CXL specific RAS registers that need logging
> >> before starting do_recovery() in the UCE case.
> >>
> >> Update the AER service driver to call the UCE handler for root ports
> >> and downstream ports. These PCIe port devices are bound to the portdrv
> >> driver that includes a CE and UCE handler to be called.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> ---
> >>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >> index 705893b5f7b0..a4db474b2be5 100644
> >> --- a/drivers/pci/pcie/err.c
> >> +++ b/drivers/pci/pcie/err.c
> >> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> >>  
> >> +	/*
> >> +	 * PCIe ports may include functionality beyond the standard
> >> +	 * extended port capabilities. This may present a need to log and
> >> +	 * handle errors not addressed in this driver. Examples are CXL
> >> +	 * root ports and CXL downstream switch ports using AER UIE to
> >> +	 * indicate CXL UCE RAS protocol errors.
> >> +	 */
> >> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> >> +		struct pci_driver *pdrv = dev->driver;
> >> +
> >> +		if (pdrv && pdrv->err_handler &&
> >> +		    pdrv->err_handler->error_detected) {
> >> +			const struct pci_error_handlers *err_handler;
> >> +
> >> +			err_handler = pdrv->err_handler;
> >> +			status = err_handler->error_detected(dev, state);
> >> +		}
> >> +	}
> >> +
> > 
> > Would not a more appropriate place for this be pci_walk_bridge() where
> > the ->subordinate == NULL and these type-check cases are unified?
> 
> It does. I can take a look at moving that.

Has that already been handled in pci_walk_bridge?

The function pci_walk_bridge() will call report_error_detected, where
the err handler will be called. 
https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/err.c#L80

Fan

> 
> Regards,
> Terry

