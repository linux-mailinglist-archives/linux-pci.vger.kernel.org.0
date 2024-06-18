Return-Path: <linux-pci+bounces-8926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A030390DA62
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6E1C224C9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198774BE0;
	Tue, 18 Jun 2024 17:13:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD71E877
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730801; cv=none; b=QvFGF1N5RTR5Py9hVpUCnr59J+6zpd8yo57bVrQj1cPd25AR0YEC9/px0lYWdSEtNzTbhvb/Xwg2FUZb2CjHa8dUupPXr8WXfd/FOUvBHVhmEo02/Ab3n7sb/VFUUWXKdDNXszqM1eZN9hKMYJiJREp1Ff+MXyqxTB/JzhzLMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730801; c=relaxed/simple;
	bh=IQSvQg/yyfJMZN2HKVKdlb7f0FdohworS0vsNBso98I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyAOM/sCO56ZYmjnj9JGw/KlcH8XuSB9/34PqEGDofS+CAGOadj8sye/qxkr55+3fL8y/KvIb/gFi8qqKSuU448vyCvrTD7Jou03iNgC/WoBpzTQUjYVevAYAVVet1s7htsBUZ3w3GuZzy8gIRDptuUUIQtm2ZRI7LG1Db0Nh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 411DD100EF4DF;
	Tue, 18 Jun 2024 19:13:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 10B4B307156; Tue, 18 Jun 2024 19:13:15 +0200 (CEST)
Date: Tue, 18 Jun 2024 19:13:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: stuart hayes <stuart.w.hayes@gmail.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <ZnHAK_P9acBo3i7D@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
 <Zm1uCa_l98yFXYqf@wunner.de>
 <20240618105653.0000796d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618105653.0000796d@linux.intel.com>

On Tue, Jun 18, 2024 at 10:56:53AM +0200, Mariusz Tkaczyk wrote:
> On Sat, 15 Jun 2024 12:33:45 +0200 Lukas Wunner <lukas@wunner.de> wrote:
>> > On Fri, Jun 14, 2024 at 04:06:14PM -0500, stuart hayes wrote:
> > > Failing pci_npem_init() if this ops->get_active_indications() fails
> > > will keep this from working on most (all?) Dell servers, because the
> > > _DSM get/set functions use an IPMI operation region to get/set the
> > > active LEDs, and this is getting run before the IPMI drivers and
> > > acpi_ipmi module (which provides ACPI access to IPMI operation
> > > regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)  
> > 
> > CONFIG_ACPI_IPMI is tristate.  Even if it's built-in, the
> > module_initcall() becomes a device_initcall().
> > 
> > PCI enumeration happens from a subsys_initcall(), way earlier
> > than device_initcall().
> > 
> > If you set CONFIG_ACPI_IPMI=y and change the module_initcall() in
> > drivers/acpi/acpi_ipmi.c to arch_initcall(), does the issue go away?
> 
> That seems to be the best option. Please test Lukas proposal and let me know.
> Shouldn't I make a dependency to ACPI_IPMI in Kconfig (with optional comment
> about initcall)?
> 
> +config PCI_NPEM
> +	bool "Native PCIe Enclosure Management"
> +	depends on LEDS_CLASS=y
> +	depends on ACPI_IPMI=y

This would effectively disallow NPEM on non-ACPI systems.

I think what you want instead is to allow either ACPI_IPMI=y or
ACPI_IPMI=n, but not ACPI_IPMI=m, so:

	depends on ACPI_IPMI!=m

Thanks,

Lukas

