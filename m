Return-Path: <linux-pci+bounces-20168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF480A174CF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 23:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1B188A1DC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7091EEA5F;
	Mon, 20 Jan 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCma4gKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4B54765;
	Mon, 20 Jan 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737413805; cv=none; b=UdOP3dgHRWjH3WVaZX8z7zDFy9A81QAQmQ8aeA5lG5w0yj2PEmkRF7QGMWFBubLiFj5UMIIWDtEK83jcnp/OkSBrnxB3Znemx5mpZmeI99ncZnHxz36MiyTbpOTBEMrYa92XEyn/qry0HWcRfd3k0UBPe1AlVxxBgiN5ql8bdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737413805; c=relaxed/simple;
	bh=OwPtwlfCUJmN7goY6n75EonzQu+nj1+MBmvLc+9JzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B1YRhb7PmNwfEltvwB27W+2mDCV6oPgKAfta66nK+uFhSSx8Ea6xdgO0s5OvBaeywLsLC19WjEAi8AVDgaXlf8P8nT7nUiw3yMKmZWmsCr2bE6MLUVmdCxU46E/3SfWK0VPNXfB6FEaGiaSG698gwHEKhf/Rmn+aLcOh10SmpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCma4gKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC74EC4CEDD;
	Mon, 20 Jan 2025 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737413804;
	bh=OwPtwlfCUJmN7goY6n75EonzQu+nj1+MBmvLc+9JzgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dCma4gKfjeXSLeIqlzdaw2EPusqFjPETTPljTrz5pU/05S2vIaDuHtGcV6eZB7FqF
	 /Y+DgZ7PXfpeDsumEaJJilsliB5H1teZCs4icC3W5QYbqSQX0pdz0CIP3MVmyUjhDE
	 v1RvpgUiG+YgPSNi9tLGJSW+OvKwiF8iQ/g2jmKLrhYILOGLQUMSInhixHQ7tgaDOj
	 phXMJTy4ovgbY/xnazwcYJ5SEctYpCyq/Fh4MQ18TyDvakjn6u5uQL3MbgGhr+sQ4n
	 YmIXKRmCeprovCdY58GaTVbL5/KA0Brk1MXVodg9ktzezzBNune325O+NnVAAchrl7
	 AJMrIvrCjqVRA==
Date: Mon, 20 Jan 2025 16:56:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	logang@deltatee.com, bhelgaas@google.com,
	kurt.schwemmer@microsemi.com, unglinuxdriver@microchip.com
Subject: Re: [PATCH] PCI: switchtec: Include PCI100X devices support
Message-ID: <20250120225642.GA906528@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com>

On Mon, Jan 20, 2025 at 03:25:24PM +0530, Rakesh Babu Saladi wrote:
> Add the Microchip Parts to the existing device ID
> table so that the driver supports PCI100x devices too.
> 
> Add a new macro to quirk the Microchip switchtec PCI100x parts
> to allow DMA access via NTB to work when the IOMMU is turned on.
> 
> PCI100x family has 6 variants, each variant is designed for different
> application usages, different port counts and lane counts.
> 
> PCI1001 has 1 x4 upstream port and 3 x4 downstream ports.
> PCI1002 has 1 x4 upstream port and 4 x2 downstream ports.
> PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports and 2 x2
> downstream ports.
> PCI1004 has 4 x4 upstream ports.
> PCI1005 has 1 x4 upstream port and 6 x2 downstream ports.
> PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports.
> 
> Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
> ---
>  drivers/pci/quirks.c           | 11 +++++++++++
>  drivers/pci/switch/switchtec.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..266ab5f8c6e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5906,6 +5906,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
>  SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
>  SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
>  
> +#define SWITCHTEC_PCI100X_QUIRK(vid) \
> +	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
> +		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
> +SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
> +
> +
>  /*
>   * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
>   * These IDs are used to forward responses to the originator on the other
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5b921387eca6..faaca76407c8 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1726,6 +1726,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  		.driver_data = gen, \
>  	}
>  
> +#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
> +	{ \
> +		.vendor     = PCI_VENDOR_ID_EFAR, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
> +		.class_mask = 0xFFFFFFFF, \
> +		.driver_data = gen, \
> +	}, \
> +	{ \
> +		.vendor     = PCI_VENDOR_ID_EFAR, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
> +		.class_mask = 0xFFFFFFFF, \
> +		.driver_data = gen, \

We have this:

  #define PCI_VENDOR_ID_EFAR              0x1055

but searching the PCI-SIG Vendor ID database for 0x1055 doesn't find
anything:

  https://pcisig.com/membership/member-companies

You mention "Microchip", and it looks like Microchip is assigned
Vendor ID 0x11f8:

  https://pcisig.com/membership/member-companies?combine=microchip

which we also have defined:

  #define PCI_VENDOR_ID_PMC_Sierra        0x11f8
  #define PCI_VENDOR_ID_MICROSEMI         0x11f8

Can you clarify what's going on here?  I assume these parts actually
do have Vendor ID 0x1055.  But the PCI-SIG really should know about
the usage of this ID.  There's an email contact address on that web
page; can you straighten this out?

> +	}
> +
>  static const struct pci_device_id switchtec_pci_tbl[] = {
>  	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
>  	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
> @@ -1820,6 +1840,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
>  	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
>  	{0}
>  };
>  MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
> -- 
> 2.34.1
> 

