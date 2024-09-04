Return-Path: <linux-pci+bounces-12796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E124696CA6A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA151C223AE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604114A62A;
	Wed,  4 Sep 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI4AFqkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56A154456;
	Wed,  4 Sep 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488855; cv=none; b=qEkRaK0j64W/V8gHZ7O5w5ax9s7rePKYPVouGHua+mtv4IyoI2VbuyFr6dYVBrujKqjYo9vBwcT8SAJqM8+szcznEUILFdHJDyd5147SFEcvNp0g/YBnOAZT5N2evjoc+91ex4/FTq0NxMZNwo8/LiPch3AUV9hQxvYC73BuxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488855; c=relaxed/simple;
	bh=mCP9Oh0+eNEIzhBGdpuLJDsqFpKcih1u5WoGh2Pa/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QNt1FyUqMUssJi4lPEIsz407qoJgB+lVxdvlltT7nwMe0kZsorimT45oZy9cZs8CkSBzFL05fTdGjazm2Y2QL4NJQyZIlMPLwUXtCybwcTOn1d61ujf7vhFB0ZkixhdK+QUfxWMdSXRTAwXqmc+861SCgQ2bq6/D/jBlBNXgpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI4AFqkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A695DC4CEC2;
	Wed,  4 Sep 2024 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725488854;
	bh=mCP9Oh0+eNEIzhBGdpuLJDsqFpKcih1u5WoGh2Pa/gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tI4AFqkVLbNYGsu5L1Uo98ouKl+nsxIjCydMWGnIDgh8Fc4FkFKQ9IIMcsgfqqZqj
	 W/bv+LIJ5fta+h1VMTOGjxPW6fMKsbouGtgYzqIpq1LVjkpVkTD4apVC6uI+GgVTAl
	 92Kd9uvwQVdZC3f3V0IEuwxwEND5CgkT477oeQwmpNy3sUdXFGJM1PohYsBghTnYA6
	 fF+VcC1odgzpfHYzjcrj5ms5Di9zCnXNNcC53noitmfvIvxsn4FqsnZM0fX/t+cQ5U
	 OKE/IHTb3baWDBl0dZEPdfKIz5JofKjuwT11tTEXdpQxlO96IRe3lXxC584Aeth+qf
	 tIbP5JTi+Jo2A==
Date: Wed, 4 Sep 2024 17:27:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 0/3] PCIe Enclosure LED Management
Message-ID: <20240904222732.GA359748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>

On Wed, Sep 04, 2024 at 12:48:45PM +0200, Mariusz Tkaczyk wrote:
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
> 
> Changes from v1:
> - Renamed "pattern" to indication.
> - DSM support added.
> - Fixed nits reported by Bjorn.
> 
> Changes from v2:
> - Introduce lazy loading to allow DELL _DSM quirks to work, reported by
>   Stuart.
> - leds class initcall moved up in Makefile, proposed by Dan.
> - fix other nits reported by Dan and Iipo.
> 
> Changes from v3:
> - Remove unnecessary packed attr.
> - Fix doc issue reported by lkp.
> - Fix read_poll_timeout() error handling reported by Iipo.
> - Minor fixes reported by Christoph.
> 
> Changes from v4:
> - Use 0 / 1 instead of LED_OFF/LED_ON, suggested by Marek.
> - Documentation added, suggested by Bjorn.
> 
> Change from v5:
> - Remove unnecessary _packed, reported by Christoph.
> - Changed "led" to "LED" and other typos suggested by Randy.
> 
> Change from v6:
> - Removed links, suggested by Bjorn.
> - npem->active_inds_initialized:1 moved to DSM commit, suggested by Bjorn.
> - Improve justification for active_inds_initialized, suggested by Bjorn.
> - Chosen backed logging added, suggested by Bjorn.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Very nice.  Applied to pci/npem for v6.12, thank you!

I noticed that b4 didn't pick up Stuart's Tested-by from the cover
letter.  I assume it covers the whole series, so I added it to each
patch.  Let me know if that's not what you intended.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Marek Behun <marek.behun@nic.cz>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com/
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
>  drivers/pci/npem.c                      | 597 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   8 +
>  drivers/pci/probe.c                     |   2 +
>  drivers/pci/remove.c                    |   2 +
>  include/linux/pci.h                     |   3 +
>  include/uapi/linux/pci_regs.h           |  35 ++
>  10 files changed, 732 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/npem.c
> 
> -- 
> 2.35.3
> 

