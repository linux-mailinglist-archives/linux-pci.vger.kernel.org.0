Return-Path: <linux-pci+bounces-22287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF0A43464
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 06:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A9E16E569
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC02E62B;
	Tue, 25 Feb 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ugijntmd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773442AF03
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459816; cv=none; b=dVuQ4yB3OJ3dBaNwsMv4FITkJUboBpEkqpF9WzrVkp7Gdrvw4NJwrp4Gxg9MMSklhlgPgzBHJGZcJVxhGUdXYRqcWTGdhrGReT1ES8a3VApAgD4R7oPOIAcJPqRyGl02tAtACgQy5ltYxKbcegoRdV03BrJ1I4BhcXt6SyKz4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459816; c=relaxed/simple;
	bh=6TBDSITFsa572MD7kAdvsBhnCHwcnQhcfb5mdfIhSzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhcJgCYdy3mseXdHvBtoKNWpt74o6tZd9QBq5VVXiGE/UX7Q8K8ws5/Y92tsjIn3lVtvSpnDYEI33jLzSEVZ/4Jbo/TlsoeO5SJPn+gcbGm+GoCA0fM+N3CANdv1IVtEy51WO6jJm1XWpUAxkwLJbyK6/4zCcVSYu7nRQS31OUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ugijntmd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740459814; x=1771995814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TBDSITFsa572MD7kAdvsBhnCHwcnQhcfb5mdfIhSzs=;
  b=Ugijntmdvga5dIMIzibQW8eIm9DapowazbyJal9Hql6PGOmA9zPUekVC
   bIPRErQri18TVB4KVn5LBRSl2gsPoROqHT4PCH0oX8kEDOVLIrtA62M4g
   erU1JshDDztlSMdwxbJXO5JrXH9BYfshTaZIymZ2RFRgqT8FWN7BtdG9f
   /XzxzccY8gFkXXX0wrdDnDz+wOQH8AlXLwEccynErVf1zMp28ibhMbeYn
   UkBDI2rMiG9KYCIclAKi+uGLm8BEaP2cIBju3Rdf64/eVSs2qUAXsuQTh
   c0NLm3wsyxSvblqiCfJlDdV5SSZZgwRlYfX0mw1wxxwa4/A1uXEIcqrMD
   A==;
X-CSE-ConnectionGUID: 9EBXdeqgRJ6HqRuLV+Mr3w==
X-CSE-MsgGUID: JXV1xWtJRIKl6puEpEH/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40486130"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40486130"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:03:34 -0800
X-CSE-ConnectionGUID: i9v8ynNwQuqqFxO71LACgQ==
X-CSE-MsgGUID: f5KUjnDxRh+M1xk0S43cUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121252149"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 24 Feb 2025 21:03:31 -0800
Date: Tue, 25 Feb 2025 13:01:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <Z71OuHh8nTfZgYUA@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <67bcd5743382a_1c530f29417@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bcd5743382a_1c530f29417@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Feb 24, 2025 at 12:24:20PM -0800, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> > 
> > 
> > On 6/12/24 09:24, Dan Williams wrote:
> > > There are two components to establishing an encrypted link, provisioning
> > > the stream in config-space, and programming the keys into the link layer
> > > via the IDE_KM (key management) protocol. These helpers enable the
> > > former, and are in support of TSM coordinated IDE_KM. When / if native
> > > IDE establishment arrives it will share this same config-space
> > > provisioning flow, but for now IDE_KM, in any form, is saved for a
> > > follow-on change.
> > > 
> > > With the TSM implementations of SEV-TIO and TDX Connect in mind this
> > > abstracts small differences in those implementations. For example, TDX
> > > Connect handles Root Port registers updates while SEV-TIO expects System
> > > Software to update the Root Port registers. This is the rationale for
> > > the PCI_IDE_SETUP_ROOT_PORT flag.
> > > 
> > > The other design detail for TSM-coordinated IDE establishment is that
> > > the TSM manages allocation of stream-ids, this is why the stream_id is
> > > passed in to pci_ide_stream_setup().
> > > 
> > > The flow is:
> > > 
> > > pci_ide_stream_probe()
> > >    Gather stream settings (devid and address filters)
> > > pci_ide_stream_setup()
> > >    Program the stream settings into the endpoint, and optionally Root Port)
> > > pci_ide_enable_stream()
> > >    Run the stream after IDE_KM
> > > 
> > > In support of system administrators auditing where platform IDE stream
> > > resources are being spent, the allocated stream is reflected as a
> > > symlink from the host-bridge to the endpoint.
> > > 
> > > Thanks to Wu Hao for a draft implementation of this infrastructure.
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
> > >   drivers/pci/ide.c                                  |  192 ++++++++++++++++++++
> > >   drivers/pci/pci.h                                  |    4
> > >   drivers/pci/probe.c                                |    1
> > >   include/linux/pci-ide.h                            |   33 +++
> > >   include/linux/pci.h                                |    4
> > >   6 files changed, 262 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > >   create mode 100644 include/linux/pci-ide.h
> > > 
> [..]
> > > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > > index a0c09d9e0b75..c37f35f0d2c0 100644
> > > --- a/drivers/pci/ide.c
> > > +++ b/drivers/pci/ide.c
> [..]
> > > +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> > > +{
> > > +	int pos;
> > > +	u32 val;
> > > +
> > > +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> > > +			     pdev->nr_ide_mem);
> > > +
> > > +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> > > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> > > +
> > > +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> > > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> > > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> > > +
> > > +	for (int i = 0; i < ide->nr_mem; i++) {
> > 
> > 
> > This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss 
> > especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
> 
> Good catch.
> 
> I think the more appropriate place to enforce this is in
> pci_ide_stream_probe() with something like the below... unless I am
> mistaken and address association settings do not need to be identical
> between endpoint and Root Port?
> 
> @@ -99,9 +99,13 @@ void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
>   */
>  void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
>  {
> +       struct pci_dev *rp = pcie_find_root_port(pdev);
>         int num_vf = pci_num_vf(pdev);
>  
> -       *ide = (struct pci_ide) { .stream_id = -1 };
> +       *ide = (struct pci_ide) {
> +               .stream_id = -1,
> +               .nr_mem = min(pdev->nr_ide_mem, rp->nr_ide_mem),

No, addr associations don't have to be identical.

Now we should fill EP's mem ranges to RP's addr association registers,
so Aik's idea is to check if RP's pdev->nr_ide_mem >= EP's nr_mem.

EP's nr_mem calculation is complicated,

	ep_nr_mem = pci_resource_number(PF_pdev, IORESOURCE_MEM) +
		    pci_resource_number(VF1_pdev, IORESOURCE_MEM) +
		    pci_resource_number(VF2_pdev, IORESOURCE_MEM) +
		    ...;

It is easily rp->nr_ide_mem < ep_mr_mem, so I don't think check and
fail is a good way, we have to merge ranges. Maybe merging to 1 range
is a simplest solution:

	if (rp->nr_ide_mem < ep_nr_mem) {
		ide->nr_mem = 1;
		/* merge ep ranges and fill ide->mem[0] */

	} else {
		ide->nr_mem = ep_nr_mem;
		/* copy ep ranges to ide->mem[] */
	}

A further requirement is, firmware may not agree to use all RP's address
asociation blocks, e.g. Intel TDX Module just use one block. So maybe
add an input parameter:

void pci_ide_stream_probe(struct pci_dev *pdev, int max_ide_nr_mem, struct pci_ide *ide)
{
	int nr_ide_mem = min(rp->nr_ide_mem, max_ide_nr_mem);

	int ep_nr_mem = calc_ep_nr_mem(pdev);

	if (nr_ide_mem < ep_nr_mem) {
		ide->nr_mem = 1;
		/* merge ep ranges and fill ide->mem[0] */
        } else {
		ide->nr_mem = ep_nr_mem;
		/* copy ep ranges to ide->mem[] */
        }
}


BTW: I'm not sure how to fill EP's addr association register, for now I
just skip it and works. Maybe my device doesn't care about them at all.

Thanks,
Yilun

> +       };
>  
>         /* PCIe Requester ID == Linux "devid" */
>         ide->rid_start = pci_dev_id(pdev);

