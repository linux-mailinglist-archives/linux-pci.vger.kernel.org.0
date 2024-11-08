Return-Path: <linux-pci+bounces-16325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2D9C1D24
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9DA282993
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA081E7C38;
	Fri,  8 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjuz3KIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540F1E7C1B;
	Fri,  8 Nov 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069550; cv=none; b=SDSTXnfEdArTDHLpOGyALxQtBfB1G6L629iRcVjxNfbB6b9oWvdOjRbURWGWQSNvYO7YfNc7XUlnxIt98FZMU/OBXwLnt5YhZKl69+k1Ol0aXWsRLOn5Q+zcqL9d9WPQvAenJHEWWgXpWmXzNVntXJGJvARwc7JNFoPkoaTnnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069550; c=relaxed/simple;
	bh=SP72qEHVndOGTFh5I47t1NTlAW56d3lEPRHJWmdqvVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xl6UuucncMlRrp0OaYrIvtghghSiLaVi3+r8OybslX4nXlnP8nKwlodxVWct3sWIBN9430yp17WSjICpoKLWtYEdHJ0dr8vi5X0Tuz86mNnFA7/FyyPysy8cLuJGwwmSPIebnjxr0Is/o4PI5RbIfeu+2nNx7t05i5wXanO/yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjuz3KIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D472C4CECD;
	Fri,  8 Nov 2024 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731069550;
	bh=SP72qEHVndOGTFh5I47t1NTlAW56d3lEPRHJWmdqvVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fjuz3KIhLgtHhmM5yt2eALzxgWnMDFlOm0j/YhhamdIdPi2jM4KvDZrw6naITxioj
	 0lFh7HrqUp6iiCwIuKtg/LdBmOB3YVISFH5RorHhx6UaKYhnqX48N4YFUxtm8FPuJm
	 U90FprnwV1Mdqi/aYfBUtgvC0xyPcEFbSpXMuRg0rDFK66WQXqLdbwkmOM3W4SJgyY
	 BBeLnfIJ7P/HGRML4yQ5Q3a6d/4hEDoFrJWhKJi7FwqOwr6aF0tm76rBbLX2FSOuu0
	 jR0S6OiHQzFia4DcGlWZ5IddLvGlabhdtJu8T88m/zCUTR3xaQbnIRJLVxQpL9MVHm
	 X7EiijwtKdoOA==
Date: Fri, 8 Nov 2024 06:39:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"scott@os.amperecomputing.com" <scott@os.amperecomputing.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <20241108123908.GA1657702@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB44293B3E1A4860D44DD5CD8FD95D2@SJ0PR18MB4429.namprd18.prod.outlook.com>

On Fri, Nov 08, 2024 at 12:17:22PM +0000, Shijith Thotton wrote:
> >> This patch introduces a PCI hotplug controller driver for the OCTEON
> >> PCIe device, a multi-function PCIe device where the first function acts
> >> as a hotplug controller. It is equipped with MSI-x interrupts to notify
> >> the host of hotplug events from the OCTEON firmware.

> >> +config HOTPLUG_PCI_OCTEONEP
> >> +	bool "OCTEON PCI device Hotplug controller driver"
> >
> >s/Marvell PCI device/Cavium OCTEON PCI/ to match other entries.
> 
> Cavium was acquired by Marvell, but we are still using the PCI
> vendor ID  `PCI_VENDOR_ID_CAVIUM`. I hope using Marvell is
> acceptable; please let me  know if this poses any issues.

Oops, sorry, this was my mistake.  I meant to suggest "Marvell OCTEON
PCI Hotplug driver", but I messed up the editing.

> >> +#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
> >
> >Even though this is a private #define, I think something like
> >PCI_DEVICE_ID_CAVIUM_OCTEP_HP_CTLR would be nice because that's the
> >typical pattern of include/linux/pci_ids.h.
> 
> The same reason mentioned above for not using the name CAVIUM.
> Is it okay to use `PCI_DEVICE_ID_MARVELL_OCTEP_HP_CTLR`?

In this case, I think you should use PCI_DEVICE_ID_CAVIUM... because
the PCI_VENDOR_ID_CAVIUM identifies the Device ID namespace, so the
#defines for the Vendor ID and the Device IDs in that namespace should
match.

> >> +static struct pci_device_id octep_hp_pci_map[] = {
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
> >OCTEP_DEVID_HP_CONTROLLER) },
> >> +	{ },
> >> +};

