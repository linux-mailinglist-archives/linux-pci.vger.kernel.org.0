Return-Path: <linux-pci+bounces-11681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C095235A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3FD283814
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF21C37A4;
	Wed, 14 Aug 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOvVZOuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA71BC070;
	Wed, 14 Aug 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667274; cv=none; b=FtehVc/pkw9hFBcGL5Zesv2qvj7GR1C04iNd2AkJ84RV8+mKQLnwsVOf3mNlwAKGdpqU9HOHa08L18sshkIjLck1vqhGZjeqP9uxmn1U2NO+qFdOOBExurIu4gceCXmCnFtvdaIxcoPkudxDF9nCM+BvYE4IDdNPXxj3dNjjcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667274; c=relaxed/simple;
	bh=oaCuQlnfhd/VF5DKoDEs+KZNArNfIyrOIyOb+OoqtXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GQ/YpDKmUrhdd8zR7zwzbxvRkOKVR3ZqEEfMTx4xiiZrwBez9xcBYXHOxThRbAcSZ/RZAt5TCmLjYsHYruA64rbv1iVTgrjpXJmZvf2jJK+WKwTVMupddbg3yYaR7dqwPStIxdmD60P6XG9wZ8RSmN09ixVUiMVYTbdlB+W20tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOvVZOuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB6EC116B1;
	Wed, 14 Aug 2024 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723667273;
	bh=oaCuQlnfhd/VF5DKoDEs+KZNArNfIyrOIyOb+OoqtXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fOvVZOuuoimaL5LWzlqmTiGViTD3eXoI1LwiSv5xNR+SnGjBG2deDoyvysZKyw0PF
	 pA1DNRbvtuMoSBIhtDYbVCPATcw2QNsymJ8NlTUQby5l3uAtiV7UNVshuVgsX4Vf7t
	 eQeCoxzJs+qa1eXqbzuLcVxGSdPmpZywBJAntbYHrSY5JghFi9x5N1QEQt24KlKZjP
	 6FNXrwr3whgfHNW5N0XeuGEFJq7BtnAd69VHNbDHGC/1mspOW/Nh+KKNhaT57Ikzpb
	 OAwKgdiW9JM2OW35GbYoHWIBDMx57O0BNa9Ei3qZWTOAoapnFTIMS3iIb80aA+ir9z
	 HIZtUkvxV/jOg==
Date: Wed, 14 Aug 2024 15:27:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCIe Enclosure LED Management
Message-ID: <20240814202751.GA359905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>

[+cc Lee, linux-leds for comment on using the LED subsystem as
described in patch 2/3; would be nice to have a reviewed-by or ack for
this.  Thread at
https://lore.kernel.org/r/20240814122900.13525-4-mariusz.tkaczyk@linux.intel.com]

On Wed, Aug 14, 2024 at 02:28:57PM +0200, Mariusz Tkaczyk wrote:
> Patchset is named as PCIe Enclosure LED Management because it adds two
> features:
> - Native PCIe Enclosure Management (NPEM)
> - PCIe SSD Status LED Management (DSM)
> 
> Both are pattern oriented standards, they tell which "indication"
> should blink. It doesn't control physical LED or pattern visualization.
> 
> Overall, driver is simple but it was not simple to fit it into interfaces
> we have in kernel (We considered leds and enclosure interfaces). It reuses
> leds interface, this approach seems to be the best because:
> - leds are actively maintained, no new interface added.
> - leds do not require any extensions, enclosure needs to be adjusted first.
> 
> There are trade-offs:
> - "brightness" is the name of sysfs file to control led. It is not
>   natural to use brightness to set patterns, that is why multiple led
>   devices are created (one per indication);
> - Update of one led may affect other leds, led triggers may not work
>   as expected.

v1 at https://lore.kernel.org/r/20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com

> Changes from v1:
> - Renamed "pattern" to indication.
> - DSM support added.
> - fixed nits reported by Bjorn.

v2 at https://lore.kernel.org/r/20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com

> Changes from v2:
> - Introduce lazy loading to allow DELL _DSM quirks to work, reported by
>   Stuart.
> - leds class initcall moved up in Makefile, proposed by Dan.
> - fix other nits reported by Dan and Iipo.

v3 at https://lore.kernel.org/r/20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com

> Changes from v3:
> - Remove unnecessary packed attr.
> - Fix doc issue reported by lkp.
> - Fix read_poll_timeout() error handling reported by Iipo.
> - Minor fixes reported by Christoph.

v4 at https://lore.kernel.org/r/20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com

> Changes from v4:
> - Use 0 / 1 instead of LED_OFF/LED_ON, suggested by Marek.
> - Documentation added, suggested by Bjorn.

v5 at https://lore.kernel.org/r/20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com

> Change from v5:
> - Remove unnecessary _packed, reported by Christoph.
> - Changed "led" to "LED" and other typos suggested by Randy.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Evidently you intend these tags to be applied to each patch, but b4
doesn't distribute tags from the cover letter across each individual
patch.

You included Christoph's Reviewed-by directly in patches 1 and 2, but
not Ilpo's.  I didn't dig through the previous postings to verify all
this.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Marek Behun <marek.behun@nic.cz>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com
> 
> Mariusz Tkaczyk (3):
>   leds: Init leds class earlier
>   PCI/NPEM: Add Native PCIe Enclosure Management support
>   PCI/NPEM: Add _DSM PCIe SSD status LED management
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  72 +++
>  drivers/Makefile                        |   4 +-
>  drivers/pci/Kconfig                     |   9 +
>  drivers/pci/Makefile                    |   1 +
>  drivers/pci/npem.c                      | 590 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   8 +
>  drivers/pci/probe.c                     |   2 +
>  drivers/pci/remove.c                    |   2 +
>  include/linux/pci.h                     |   3 +
>  include/uapi/linux/pci_regs.h           |  35 ++
>  10 files changed, 725 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/npem.c
> 
> -- 
> 2.35.3
> 

