Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00A646F35A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 19:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhLISxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 13:53:07 -0500
Received: from relay029.a.hostedemail.com ([64.99.140.29]:17864 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhLISxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 13:53:07 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 13:53:07 EST
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id B79B860640;
        Thu,  9 Dec 2021 18:40:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id B26BD2F;
        Thu,  9 Dec 2021 18:40:58 +0000 (UTC)
Message-ID: <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
Subject: Re: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when
 device is not available
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.de>
Date:   Thu, 09 Dec 2021 10:40:57 -0800
In-Reply-To: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
References: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.83
X-Stat-Signature: m3d4tdjxymtfyyj39rq48sbnqs141ziy
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B26BD2F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zSZ+fio54rGM2bgUVP0BjMA1iMRrqIhQ=
X-HE-Tag: 1639075258-380010
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-12-09 at 20:27 +0200, Andy Shevchenko wrote:
> In some cases PCI device structure is not available and we want to print
> information based on the bus and devfn parameters. For this cases introduce
> pci_bus_*() printing macros and replace in existing users.
[]
> diff --git a/include/linux/pci.h b/include/linux/pci.h
[]
> @@ -2482,4 +2482,12 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  	WARN_ONCE(condition, "%s %s: " fmt, \
>  		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
>  
> +#define pci_bus_printk(level, bus, devfn, fmt, arg...) \
> +	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
> +	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##arg)

I have a small preference for using ... and __VA_ARGS___

#define pci_bus_printk(level, bus, devfn, fmt, ...) \
	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##__VA_ARGS__)

and likely this should have parentheses around bus

	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
	       pci_domain_nr(bus), (bus)->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##__VA_ARGS__)

> +#define pci_bus_err(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_ERR, bus, devfn, fmt, ##arg)
> +#define pci_bus_warn(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_WARNING, bus, devfn, fmt, ##arg)
> +#define pci_bus_info(bus, devfn, fmt, arg...)	pci_bus_printk(KERN_INFO, bus, devfn, fmt, ##arg)

__VA_ARGS__ etc...


