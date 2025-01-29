Return-Path: <linux-pci+bounces-20543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6FA2203A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F91188859F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96118C31;
	Wed, 29 Jan 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXf8OwFe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E91DE2AD;
	Wed, 29 Jan 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164384; cv=none; b=Afmz0CFTBDTYRmxlOwf++2fCeIoBJwjPvzM23h1l9nivTMG15csNrBjGHiJol9WxaE7Gupgn3WLNCnQNsnF2DHcAnJPsRFLuiQb0rEXoQ1GlPwDnYcqyU1R+niIon766WIiD4SAjypK2XKalVnfgS3cuChGEcp9RxWaTGx3/WKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164384; c=relaxed/simple;
	bh=tz3T+9HteEyjT/4VKQ8qcZv7lWOxkVPuHGOChgt/kZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rY3wsC4rtCXE8lGpee29Ndp0DGcSXfTrQ22E+ZGDJH8U2KxwJWipre96v5DEgWnCrmnZTuB6y0rmquV1T7puEd9W+yKDGFjbR9xbjD32YcU+1kwAZ02Fk4vw8zbhzYzmUY2Qu7ukWiF0f005DGlLf5a63wmdsDNDjAZWJ7iO5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXf8OwFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A66C4CED1;
	Wed, 29 Jan 2025 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164383;
	bh=tz3T+9HteEyjT/4VKQ8qcZv7lWOxkVPuHGOChgt/kZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KXf8OwFeS8XdgGcnkBbyXCNGL1rYa1dLKsOLAIwc92FGMG7FG5Z8YOLG4RH/qkri4
	 d0kjWLq/APXvt9OvBWEKBC8WQc0Qi69APk4lP4cXNYwyxMPnvOxXFU68fypqRe38VD
	 U5I2uf60IWCjCEhjDLQxwVzolI3XUp2BTaouUebmKOEo7IIJdnPK3mMno4v/LMYKLd
	 /o2mT/llVwb9JFNUC1TnrSZIO2l+FiE8Sr9Ie4XB1m7T6jka4enZCxZ7aERhjLYoEN
	 oIQdD//zICCWcg1gq5x/WNrOUQxnxTV6UiMAEHt14y4y5iPauNJnzaENShIDw8nEU6
	 lr+SlDSuBshPw==
Date: Wed, 29 Jan 2025 09:26:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Enhance PCIe cadence controller driver for supporting
 HPA architecture
Message-ID: <20250129152621.GA460594@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

Take a look at the additions of previous drivers and follow the style.
For example:

  2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
  0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
  da36024a4e83 ("PCI: visconti: Add Toshiba Visconti PCIe host controller driver")
  f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")

After skimming the patch, it looks like this doesn't actually add a
new driver, but adds support to an existing driver for some kind of
different surrounding platform architecture.

On Wed, Jan 29, 2025 at 07:24:04AM +0000, Manikandan Karunakaran Pillai wrote:
> This patch enhances the Cadence PCIe controller driver to support HPA
> architecture. The Kconfig is added for PCIE_CADENCE_HPA config, which
> needs to be selected when HPA compatible PCIe controller is supported.
> The support for Legacy PCIe controller does not change.

Use imperative mood ("Enhance" instead of "This patch enhances ...").

Expand "HPA".

>  drivers/pci/controller/cadence/Kconfig        |   8 +
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
>  .../controller/cadence/pcie-cadence-host.c    |  44 ++-
>  .../pci/controller/cadence/pcie-cadence-hpa.h | 260 ++++++++++++++++++
>  .../controller/cadence/pcie-cadence-legacy.h  | 243 ++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.c |  42 ++-
>  drivers/pci/controller/cadence/pcie-cadence.h | 230 +---------------

This looks like it should be 5+ separate patches to make this
reviewable.  Each patch should do only *one* thing.  Obviously
everything must build and work correctly after each patch is added.

> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,14 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	bool
>  
> +config PCIE_CADENCE_HPA
> +	bool "PCIE controller HPA architecture"

s/PCIE/PCIe/ to match other entries.

Change the menu item to match surrounding entries (include vendor,
host/endpoint, etc).

But I don't think this is a *new* driver; it looks like it might be
optional functionality for the PCIE_CADENCE_PLAT and/or PCI_J721E
drivers?  Maybe it needs to depend on PCIE_CADENCE?

> +	help
> +	  Say Y here if you want to support Cadence PCIe Platform controller
> +	  on HPA architecture
> +	  The option should be deselected if the Cadence PCIe controller
> +	  is of legacy architecture

"HPA" must be expanded here too.

Omit the "deselect part".  A user has no way to identify what "legacy
architecture" means here.

> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -121,7 +121,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>  	else
>  		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> +#ifdef CONFIG_PCIE_CADENCE_HPA

Nope.  I don't want #ifdefs like this littered through the cadence
generic code.  The driver should be able to support both HPA and
non-HPA in the same kernel image.  You should be able to decide at
run-time, not at build-time.

> +	b = (bar < BAR_3) ? bar : bar - BAR_3;
> +#else
>  	b = (bar < BAR_4) ? bar : bar - BAR_4;
> +#endif

> +++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.h
> @@ -0,0 +1,260 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe Gen5(HPA) controller driver defines

Space before "(".  Expand HPA.

> + * This file contains the updates/changes for PCIE Gen5 Controller

s/PCIE/PCIe/ everywhere in commit logs and comments.

> +#define CDNS_PCIE_IP_REG_BANK           (0x01000000)
> +#define CDNS_PCIE_IP_CFG_CTRL_REG_BANK  (0x01003C00)
> +#define CDNS_PCIE_IP_AXI_MASTER_COMMON  (0x02020000)

No parens needed for bare numbers.

> +/* Vendor ID Register */
> +#define CDNS_PCIE_LM_ID		        (CDNS_PCIE_IP_REG_BANK + 0x1420)
> +#define  CDNS_PCIE_LM_ID_VENDOR_MASK    GENMASK(15, 0)
> +#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT   0

Omit _SHIFT definitions and use GENMASK()/FIELD_PREP()/FIELD_GET()
instead.

But it looks like this is mainly a move from one file to another.  A
move like that should be strictly a move and shouldn't change the
content at the same time.

The move should be in its own patch that does nothing other than the
move, so you can ignore some of these comments for now.

> +#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_IP_REG_BANK + 0x02c0)

Pick either upper-case or lower-case for hex numbers and stick to it.

> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_ENABLE BIT(0)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_IO BIT(1)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_MEM (0)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_32BITS (0)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_PREFETCH_MEM_DISABLE (0)

These are unused.  Don't add #defines that are not used.

When you do add them, indent the BIT() parts to they line up.

> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> ...
>  	/*
>  	 * Whatever Bit [23] is set or not inside DESC0 register of the outbound
>  	 * PCIe descriptor, the PCI function number must be set into
>  	 * Bits [26:24] of DESC0 anyway.
> +	 * for HPA, Bit [26] is set or not inside CTRL0 register of the outbound
> +	 * PCI descriptor, the PCI function num must be set into Bits [31:24]
> +	 * of DESC1 anyway.

Start sentences with a capital letter.

Add blank lines between paragraphs.

> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -10,213 +10,11 @@
>  #include <linux/pci.h>
>  #include <linux/pci-epf.h>
>  #include <linux/phy/phy.h>
> -
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES	10
> -#define LINK_WAIT_USLEEP_MIN	90000
> -#define LINK_WAIT_USLEEP_MAX	100000

This looks like a move of a lot of things out of pcie-cadence.h to
somewhere else.  A move like this should be its own patch with its own
commit log.

It looks suspect because this is a generic header used by several
drivers.

Bjorn

