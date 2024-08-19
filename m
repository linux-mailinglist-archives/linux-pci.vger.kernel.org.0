Return-Path: <linux-pci+bounces-11837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B495736B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE421F22768
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAE1898FA;
	Mon, 19 Aug 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT5metu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A993188CD9;
	Mon, 19 Aug 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092522; cv=none; b=iQwFTTXHBNXNfEgj3Y3ATqo+TGSuhJVTYBMIOqevpf/msSxbfEqJ+uJPnvxt1iZlvlQ1fxhEt4RC4iap7Qnsf0cyoOjl/VG5pzn1UXHB8XhldBDLl3ASN3CHU0SGCgwdZ7dusbmP1SipuVBT/TyrWodOoCUh0X/waw7sa2b+sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092522; c=relaxed/simple;
	bh=qN25ESiBluW/Wgf7nnUMEGNcqsWMOVJegLeAlewK/VM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK9iiaHok2TTMlHplEKwXyMd+DOs1n6STI7etfZP+Buay2IlTHCo4Yd94UdWauPp53CR4CY3sNISyvqvtoV/Ut6KrRLkn3Yz/t6okpIgUeTFOuDKe+4CFFCbVnHF4OVWdnCLmSPs13+07Zo0vhGEscKWm7Dc6IGQRzBEze6Qqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT5metu4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3392735276.1;
        Mon, 19 Aug 2024 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724092519; x=1724697319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYH3TQeVTTY68Kyifj6Lhi9y33FdIk3s3eh/aNh8/P8=;
        b=ZT5metu4fisNshzO8bdO9LG40gGB0MlLmfAbKmpmCTiFQzOrQ6WzeOD56wb0yAMlMx
         GVr2mVigApqvyTFxlX4E/5wUgxzleCqUC02J9YultePE2HNwXXjP1uW4bpOOe4/3xE0N
         6UhlxCWPTWMMDKacPEJvBvEMMu9NAcEs242VWqHOSq5qoM9TxTGqlJzO8UVkOIrd2+IQ
         pp/qRbvKIyQIpz2Ebu/yrgwdLg1Klok2Am2fkBD96Fd8tYFe5D7Ake8w2nuBM1uReNC2
         HWU01Vi6BGmUmi6Z62ugV0JLyXT5jz6C48ak7YlK5fR1TjtQABTBRv2addL+8s/oBlk2
         B9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092519; x=1724697319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYH3TQeVTTY68Kyifj6Lhi9y33FdIk3s3eh/aNh8/P8=;
        b=CrnUZm+XgxPBkaBbFi1rZqp9wBHX2siawTsIkGWbO5tewF/78up1lgdhVj4kjJPsXL
         njx7+lAgXTYHTPUCBLAbIGXZ9KiKdsom216iU0Ha/lA3z4sUG7uz//sDLBxnpJFBDtsc
         5hDRJbjEV8I1wch28oChMmahD8zKArYxiWwVbPng9wzl9bFYWLWaIeWgmUQPFxfECk6U
         ikrWi1H34Bt5DMJM3FctXKvwyu59icOlCqwUqcVDouZMaMhfLDy7wkl2rofiPpdJnQJC
         sdwniSqh74yGF6JWJ5y3eacsbJR46rCNL5dHSYkl+02n1LBmSVklCgkPiivyprmxwoYQ
         U39A==
X-Forwarded-Encrypted: i=1; AJvYcCUeeqKjCnqkCrQlrqshh6zgOEiCNA+cyz6EOCZTQYu+QrpUVwaozoGVenaRBRFGvZK29iiEDdH7u/8=@vger.kernel.org, AJvYcCWNAVIlAriw1JeqD6ttReCsrdeymMcF7CFjNNR6YzF9N4L6O5Oz3UdvSi7pJ8NWnU75oaIR4+tsr2KB@vger.kernel.org, AJvYcCWiPf+rgorjgVVoRRyC+jHhwLXnh7Q9BjZRD6sYc1XLCPVbXTJ8AZsTiqnN2Z1FCzQVsAyHvp0W/h3ZHONH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7nM0kYb8fk25NyFuGSyFFzhZfXuzIyrl/z7niwO4FjB8D5Px
	3TnTHlbuYAfLNtpB8P1PUlb3dRZ2AYTBOO74eFb3nk4PC7FCLs1p
X-Google-Smtp-Source: AGHT+IHJ4yX6twOUj+yvQhYg9lvd7DEHA7ViXOMbSjRZ2dxNnD3umeQUVsbdUZjFH0URzjCEzKV38Q==
X-Received: by 2002:a5b:74b:0:b0:e11:44b9:6bc5 with SMTP id 3f1490d57ef6-e164a9a7865mr460329276.22.1724092519398;
        Mon, 19 Aug 2024 11:35:19 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1172008bdfsm2167805276.51.2024.08.19.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:35:18 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 19 Aug 2024 11:35:15 -0700
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	a.manzanares@samsung.com
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Message-ID: <ZsOQYyh-_t3QRSTW@fan>
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
> 

Based on current code logic, the code added here will be executed as
long as the type matches (downstream port or root port), and I also
noticed the case ->subordinate == NULL never gets touched when I try to
inject an error through the aer_inject module and the user space tool. 
If my way to do error injection is right, it means the behaviour will
get changed after the code move.

Here is some of my experimental setup:

QEMU +  cxl topology (one type3 memdev directly attached to a HB with a
single root port).

1. Load the cxl related drivers before error injection

2. Do aer inject with aer_inject inside the QEMU VM

# aer_inject ~/nonfatal

aer inject input file looks like below
-----------------------------------------------------
fan:~/cxl/linux-fixes$ cat ~/nonfatal 
# Inject an uncorrectable/non-fatal training error into the device
# with header log words 0 1 2 3.
#
# Either specify the PCI id on the command-line option or uncomment and edit
# the PCI_ID line below using the correct PCI ID.
#
# Note that system firmware/BIOS may mask certain errors, change their severity
# and/or not report header log words.
#
AER
PCI_ID 0000:0c:00.0
UNCOR_STATUS COMP_ABORT
HEADER_LOG 0 1 2 3
-----------------------------------------------------

The "lspci" output on the VM looks like below
----------------------------------------------------
Qemu: execute "lspci" on VM
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
00:03.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
00:04.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
00:05.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
0c:00.0 PCI bridge: Intel Corporation Device 7075
0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
--------------------------------------------------

Fan


> Regards,
> Terry

