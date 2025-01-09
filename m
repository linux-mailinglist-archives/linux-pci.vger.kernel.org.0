Return-Path: <linux-pci+bounces-19620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D5A08C3C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 10:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A113A27B9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262B20CCD9;
	Fri, 10 Jan 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuFrd8HU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8A209F56
	for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501382; cv=none; b=OXtOz89LZx4S0tmEYVK0rcdPFUTzDk5n/ZKTx0achmISTnMOKgaDzjcnSBZvtjdDbTnUKVylTqIBBB3fuWMhIbfN9DXWKL6DI751ceJsRU5j2tL6T6+Ckrr3rHcToKnMhA/Bidh+cQtweRAzNJOMfMg58YsM568+IAE4BzQwC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501382; c=relaxed/simple;
	bh=6+odOW9J5AxdrGgIHYh9PZ0RZzvlAD2SrSXnzkcC8A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGkKa7EvGI0gtLeHJfJeI7ekW44qIff2D82r93nN2n5rf3BbXXmE4zz9NDkRvIkHXJS06QnDDLvX31g2bJnhkjLV6k4VG//FE8K0n9YYmwFkRdYb3+vqnSalk50TrYwRkUzt6mYe9XUGPSZ0SyzD/BAHRnvL4M12xCHm59f0DTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CuFrd8HU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736501381; x=1768037381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6+odOW9J5AxdrGgIHYh9PZ0RZzvlAD2SrSXnzkcC8A8=;
  b=CuFrd8HURbFPKb8YyiavHzMJMlJLL1BXhEHPPOJmxo0YyhvpGsdjRWuq
   7ALa5ef9FjYy01ar8pvVe2CmAPjddEZ44aXxumAwW00UcwdYs/mw9BUSW
   gtnTpRVBfFoRQIC4oTJbvVFhw97K4oZ6vpUxO1z9xScMlBo8iEkXotK9M
   3boI3Q3L8xEfHDt/mln/6WjnqOQhNvQk5j/FP0DKCpyzM6VWsQdCKgjb6
   R++dbRjWzmTPUMmhI5lF+4qqXqGdAWDUCrPEW2YU6sMVIeT7RzGlyXI5M
   PBDgqdSOtGqY82FLZXzSCt1XlJ21tL/ItyORBf/63mDlYK6EXr16c9MBz
   w==;
X-CSE-ConnectionGUID: EN8wg/XGQWOt8lDIWQ88cg==
X-CSE-MsgGUID: Thc943yMTEGlUqHVYdiVrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="62161196"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="62161196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 01:29:40 -0800
X-CSE-ConnectionGUID: vlJlS4ksS4eV/KQbhZ484w==
X-CSE-MsgGUID: 2IAuBw7SSECCXUd7BJeXHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103738097"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 10 Jan 2025 01:29:38 -0800
Date: Fri, 10 Jan 2025 05:28:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>

On Thu, Jan 09, 2025 at 01:35:58PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 8/1/25 07:00, Xu Yilun wrote:
> > > > > +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct
> > > > > pci_ide *ide)
> > > > > +{
> > > > > +    int pos;
> > > > > +    u32 val;
> > > > > +
> > > > > +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> > > > > +                 pdev->nr_ide_mem);
> > > > > +
> > > > > +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> > > > > +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> > > > > +
> > > > > +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > > > > +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> > > > > +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> > > > > +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> > > > > +
> > > > > +    for (int i = 0; i < ide->nr_mem; i++) {
> > > > 
> > > > 
> > > > This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss
> > > > especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
> > 
> > Yes, but nr_ide_mem is limited HW resource and may easily smaller than
> > device memory region number.
> 
> My rootport does not have any range (instead, it relies on C-bit in MMIO

It seems strange, then how the RP decide which stream id to use.

> access to set T-bit). The device got just one (which is no use here as I
> understand).

I also have no idea from SPEC how to use the IDE register blocks on EP,
except stream ENABLE bit.

And no matter how I program the RID/ADDR association registers, it
always work...

Call for help.

> 
> 
> > In this case, maybe we have to merge the
> > memory regions into one big range.
> 
> > > > 
> > > > 
> > > > 
> > > > > +        val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
> > > > > +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
> > > > > +                 lower_32_bits(ide->mem[i].start) >>
> > > > > +                     PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
> > > > > +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
> > > > > +                 lower_32_bits(ide->mem[i].end) >>
> > > > > +                     PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
> > > > > +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
> > > > > +
> > > > > +        val = upper_32_bits(ide->mem[i].end);
> > > > > +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
> > > > > +
> > > > > +        val = upper_32_bits(ide->mem[i].start);
> > > > > +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Establish IDE stream parameters in @pdev and, optionally, its
> > > > > root port
> > > > > + */
> > > > > +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> > > > > +             enum pci_ide_flags flags)
> > > > > +{
> > > > > +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > > > > +    struct pci_dev *rp = pcie_find_root_port(pdev);
> > > > > +    int mem = 0, rc;
> > > > > +
> > > > > +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> > > > > +        pci_err(pdev, "Setup fail: Invalid stream id: %d\n",
> > > > > ide->stream_id);
> > > > > +        return -ENXIO;
> > > > > +    }
> > > > > +
> > > > > +    if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> > > > > +        pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> > > > > +            ide->stream_id);
> > > > > +        return -EBUSY;
> > > > > +    }
> > > > > +
> > > > > +    ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
> > > > > +                  dev_name(&pdev->dev));
> > > > > +    if (!ide->name) {
> > > > > +        rc = -ENOMEM;
> > > > > +        goto err_name;
> > > > > +    }
> > > > > +
> > > > > +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
> > > > > +    if (rc)
> > > > > +        goto err_link;
> > > > > +
> > > > > +    for (mem = 0; mem < ide->nr_mem; mem++)
> > > > > +        if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
> > > > > +                      range_len(&ide->mem[mem]), ide->name,
> > > > > +                      0)) {
> > > > > +            pci_err(pdev,
> > > > > +                "Setup fail: stream%d: address association conflict
> > > > > [%#llx-%#llx]\n",
> > > > > +                ide->stream_id, ide->mem[mem].start,
> > > > > +                ide->mem[mem].end);
> > > > > +
> > > > > +            rc = -EBUSY;
> > > > > +            goto err;
> > > > > +        }
> > > > > +
> > > > > +    __pci_ide_stream_setup(pdev, ide);
> > > > > +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
> > > > > +        __pci_ide_stream_setup(rp, ide);
> > > 
> > > Oh, when we do this, the root port gets the same devid_start/end as the
> > > device which is not correct, what should be there, the rootport bdfn? Need
> > 
> > "Indicates the lowest/highest value RID in the range
> > associated with this Stream ID at the IDE *Partner* Port"
> > 
> > My understanding is that device should fill the RP bdfn, and the RP
> > should fill the device bdfn for RID association registers. Same for Addr
> > association registers.
> 
> Oh. Yeah, this sounds right. So most of the setup needs to be done on the
> root port and not on the device (which only needs to enable the stream),
> which is not what the patch does. Or I got it wrong? Thanks,

I don't get you. This patch does IDE setup for 2 partners:

__pci_ide_stream_setup(pdev, ide);  This is the setup on RP
__pci_ide_stream_setup(rp, ide);    This is the setup on device

unless AMD setup IDE by firmware, and didn't set the PCI_IDE_SETUP_ROOT_PORT flag.

Thanks,
Yilun

> 
> > 
> > Thanks,
> > Yilun
> > 
> > > to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a root
> > > port. Thanks,
> > > 
> 
> -- 
> Alexey
> 

