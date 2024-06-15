Return-Path: <linux-pci+bounces-8857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800149097AA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357531F21C78
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C710A11;
	Sat, 15 Jun 2024 10:33:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41742282F4
	for <linux-pci@vger.kernel.org>; Sat, 15 Jun 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447631; cv=none; b=pD0Tu3/sxbqL6p3qgOFvhcnG5wRBWeFlP9ITQO2vMfoXTEWtLEmaS0mntrkbxwrfl8KFvOergorUZVzHP/lOfWvtmlcGOsFGmZk7o0Fc8LDBUrAbK4hJYojvQ56wLLC+18Ibr0aLZuVL6f5JaS8hE4M3YJ1pT9PPDOsQ89og0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447631; c=relaxed/simple;
	bh=MDPTMGe9pGn2aunRtQlwYCwxxBjhYADIS9yvLmvrKI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m94RPfUUkrxMCce+pUkqG2Y9CWxkI2sTsO7Z+LbAGZciuXbKqk6h0AS6BHFR2IUswW86q1PJ4yeZ/jz7HYzH2JOZIMoXIay7tdlAvfS81oexC/yU7B05TKmwPFod4AW3Txpo6otDEz0pKEhW7QSGePzkG0ZHE1SJXkcLmssh7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A010D28141E81;
	Sat, 15 Jun 2024 12:33:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8A5591EC35D; Sat, 15 Jun 2024 12:33:45 +0200 (CEST)
Date: Sat, 15 Jun 2024 12:33:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zm1uCa_l98yFXYqf@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>

On Fri, Jun 14, 2024 at 04:06:14PM -0500, stuart hayes wrote:
> On 5/28/2024 8:19 AM, Mariusz Tkaczyk wrote:
> > +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
> > +			 int pos, u32 caps)
> > +{
[...]
> > +	ret = ops->get_active_indications(npem, &active);
> > +	if (ret) {
> > +		npem_free(npem);
> > +		return -EACCES;
> > +	}
> 
> Failing pci_npem_init() if this ops->get_active_indications() fails
> will keep this from working on most (all?) Dell servers, because the
> _DSM get/set functions use an IPMI operation region to get/set the
> active LEDs, and this is getting run before the IPMI drivers and
> acpi_ipmi module (which provides ACPI access to IPMI operation
> regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)

CONFIG_ACPI_IPMI is tristate.  Even if it's built-in, the
module_initcall() becomes a device_initcall().

PCI enumeration happens from a subsys_initcall(), way earlier
than device_initcall().

If you set CONFIG_ACPI_IPMI=y and change the module_initcall() in
drivers/acpi/acpi_ipmi.c to arch_initcall(), does the issue go away?


> (2) providing a mechanism to trigger this driver to rescan a PCI
>     device later from user space

If this was a regular device driver and -EPROBE_DEFER was returned if
IPMI drivers aren't loaded yet, then this would be easy to solve.
But neither is the case here.

Of course it's possible to exercise the "remove" and "rescan" attributes
in sysfs to re-enumerate the device but that's not a great solution.


> (3) don't cache the active LEDs--just get the active states using
>     NPEM/DSM when brightness is read, and do a get/modify/set when
>     setting the brightness... then get_active_indications() wouldn't
>     need to be called during init.

Not good.  The LEDs are published in sysfs from a subsys_initcall().
Brightness changes through sysfs could in theory immediately happen
once they're published.  If acpi_ipmi is a module and gets loaded way
later, we'd still have to cope with Set State or Get State DSMs going
nowhere.

Thanks,

Lukas

