Return-Path: <linux-pci+bounces-22690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18379A4A84F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 04:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF66189B89A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE515D5B6;
	Sat,  1 Mar 2025 03:33:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB12CA8;
	Sat,  1 Mar 2025 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740800032; cv=none; b=i8jHQIBVqzbrMRfivFon7mY2Gz2sw0vReKs+6sIYF8TcsI0qo9ajipRxvmpT4JdxQ/EuUVY1oilhqr4DafrRS39fnBwQ0NDdvHNKb0rwxs9gI8RqBI16IcNf7n5xzPMGtbFKdgOBv++SFdgwl/pHdHx8lfMPz8V06BxVuFTqbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740800032; c=relaxed/simple;
	bh=iK2AfIKSUL8nmfJkunk9Xi1ujvLSDFVFQFMT7ZKBPTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mynap91s4Lc5HGfUddmeJs0etcUSSIxWxHl+eZOn9bEQJ6xDhkZj4ysbvFVUbfsQLpYfNfqv+FF+M725Z8lnOm4pIMURY/FpCawA2g9NGh4wF/VKZrffWVGnECpZBh03EGMD0Agbgn6fFQScC5B1AUy2S6wT9jGWsfUPC5J6akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.bgf2kBq_1740799702 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 11:28:22 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rafael@kernel.org,
	zhoushengqing@ttyinfo.com
Subject: Re: Re: [PATCHv4] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id doesn't match with spec
Date: Sat,  1 Mar 2025 03:28:22 +0000
Message-Id: <20250301032822.17486-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250227184053.GA609152@bhelgaas>
References: <20250227184053.GA609152@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Feb 27, 2025 at 6:40 PM Bjorn Helgaas wrote:
> On Mon, Dec 16, 2024 at 05:27:51AM +0000, Zhou Shengqing wrote:
> > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2.
> > But the code remains unchanged, still 1.
> > 
> > v4:Initialize *obj to NULL.
> > v3:try revision id 1 first, then try revision id 2.
> > v2:add Fixes tag.
> 
> Thanks for working on this issue.
> 
>   - Thanks for the revision history.  For future posts, put it below
>     the "---" line so it's in the email but not part of the commit log.
> 
>   - I think there's a leak in pci_acpi_preserve_config() because it
>     doesn't free "obj" before it returns true.  If you agree, add a
>     preparatory patch to fix this.
> 
>   - Add a preparatory patch to return false early in
>     pci_acpi_preserve_config() if !ACPI_HANDLE(&host_bridge->dev) so
>     the body of the function is unindented, similar to what
>     acpi_pci_add_bus() does.
> 
>   - Add another preparatory patch that adds acpi_check_dsm() of the
>     desired function/rev ID for DSM_PCI_PRESERVE_BOOT_CONFIG,
>     DSM_PCI_POWER_ON_RESET_DELAY, DSM_PCI_DEVICE_READINESS_DURATIONS.
>     Move the "Evaluate PCI Boot Configuration" comment above the
>     acpi_check_dsm() since it applies to the whole function, not just
>     the rev 1 code in this patch.
> 
>   - Rework this patch so it only adds acpi_check_dsm() and
>     acpi_evaluate_dsm_typed() for rev 2.

Could you please explain this in more detail? Do you mean we don't need to
consider rev 1 anymore?

> 
>   - Throughout, wrap code and comments to fit in 80 columns because
>     that's the convention for the rest of the file.
> 
>   - You can use "BIT(DSM_PCI_PRESERVE_BOOT_CONFIG)" and similar
>     instead of "1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG" when calling
>     acpi_check_dsm().
> 
>   - Add a [0/n] cover letter when posting the series.  Each patch
>     should be a response to the cover letter.  "git format-patch" and
>     "git send-email" will do that for you automatically.
> 
> > Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
> > 
> > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> > ---
> >  drivers/pci/pci-acpi.c | 42 ++++++++++++++++++++++++++++++++----------
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index af370628e583..f805cd134019 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -123,19 +123,41 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
> >  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
> >  {
> >  	if (ACPI_HANDLE(&host_bridge->dev)) {
> > -		union acpi_object *obj;
> > +		union acpi_object *obj = NULL;
> >  
> >  		/*
> > -		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> > -		 * exists and returns 0, we must preserve any PCI resource
> > -		 * assignments made by firmware for this host bridge.
> > +		 * Per PCI Firmware r3.2, released Jan 26, 2015,
> > +		 * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1.
> > +		 * But PCI Firmware r3.3, released Jan 20, 2021,
> > +		 * changed sec 4.6.5 to say
> > +		 * "lowest valid Revision ID value: 2". So try revision 1
> > +		 * first for old platform, then try revision 2.
> >  		 */
> > -		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> > -					      &pci_acpi_dsm_guid,
> > -					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> > -					      NULL, ACPI_TYPE_INTEGER);
> > -		if (obj && obj->integer.value == 0)
> > -			return true;
> > +		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
> > +				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
> > +			/*
> > +			 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> > +			 * exists and returns 0, we must preserve any PCI resource
> > +			 * assignments made by firmware for this host bridge.
> > +			 */
> > +			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> > +						      &pci_acpi_dsm_guid,
> > +						      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
> > +						      NULL, ACPI_TYPE_INTEGER);
> > +			if (obj && obj->integer.value == 0)
> > +				return true;
> > +		}
> > +
> > +		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 2,
> > +				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
> > +			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
> > +						      &pci_acpi_dsm_guid,
> > +						      2, DSM_PCI_PRESERVE_BOOT_CONFIG,
> > +						      NULL, ACPI_TYPE_INTEGER);
> > +			if (obj && obj->integer.value == 0)
> > +				return true;
> > +		}
> > +
> >  		ACPI_FREE(obj);
> >  	}
> >  
> > -- 
> > 2.39.2
> >

