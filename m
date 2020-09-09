Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF39263063
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIL3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 07:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgIIL2x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8002921D80;
        Wed,  9 Sep 2020 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599650932;
        bh=XKDmQ0bqy92t9jtJ3x9aobjKXKmgrA4CFv/XSy5GDXc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GKA7u0qB0ObFtx6VQw6sxG3Rnsfp0SSXh7xS597jvH0H0SRrxT264C2/0JsrA62ng
         1DeQnF7rkvNSM3oY13x2B/E6K/xQM9WY6nQE7/nl1rrIFg0DXRsZneJguFsqS2EdBf
         7GI3WmdB6PA+Qb3Jv0JQ/zbNGIZ6m3N8YfqCaUSM=
Received: by pali.im (Postfix)
        id 3E1C87A9; Wed,  9 Sep 2020 13:28:50 +0200 (CEST)
Date:   Wed, 9 Sep 2020 13:28:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20200909112850.hbtgkvwqy2rlixst@pali>
References: <20200716110423.xtfyb3n6tn5ixedh@pali>
 <20200814080824.dg57kmbimyf3ushe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200814080824.dg57kmbimyf3ushe@pali>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! I'm adding more people to loop.

Can somebody look at these race conditions and my patch?

On Friday 14 August 2020 10:08:24 Pali Rohár wrote:
> Hello! I would like to remind this issue which I reported month ago.
> 
> On Thursday 16 July 2020 13:04:23 Pali Rohár wrote:
> > Hello Bjorn!
> > 
> > I see following error message in dmesg which looks like a race condition:
> > 
> > sysfs: cannot create duplicate filename '/devices/platform/soc/d0070000.pcie/pci0000:00/0000:00:00.0/config'
> > 
> > I looked at it deeper and found out that in PCI subsystem code is race
> > condition between pci_bus_add_device() and pci_sysfs_init() calls. Both
> > of these functions calls pci_create_sysfs_dev_files() and calling this
> > function more times for same pci device throws above error message.
> > 
> > There can be two different race conditions:
> > 
> > 1. pci_bus_add_device() called pcibios_bus_add_device() or
> > pci_fixup_device() but have not called pci_create_sysfs_dev_files() yet.
> > Meanwhile pci_sysfs_init() is running and pci_create_sysfs_dev_files()
> > was called for newly registered device. In this case function
> > pci_create_sysfs_dev_files() is called two times, ones from
> > pci_bus_add_device() and once from pci_sysfs_init().
> > 
> > 2. pci_sysfs_init() is called. It first sets sysfs_initialized to 1
> > which unblock calling pci_create_sysfs_dev_files(). Then another bus
> > registers new PCI device and calls pci_bus_add_device() which calls
> > pci_create_sysfs_dev_files() and registers sysfs files. Function
> > pci_sysfs_init() continues execution and calls function
> > pci_create_sysfs_dev_files() also for this newly registered device. So
> > pci_create_sysfs_dev_files() is again called two times.
> > 
> > 
> > I workaround both race conditions I created following hack patch. After
> > applying it I'm not getting that 'sysfs: cannot create duplicate filename'
> > error message anymore.
> > 
> > Can you look at it how to fix both race conditions in proper way?
> 
> Is this workaround diff enough? Or are you going to prepare something better?
> 
> Please let me know if I should send this diff as regular patch.
> 
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77..691be2258c4e 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -316,7 +316,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	 */
> >  	pcibios_bus_add_device(dev);
> >  	pci_fixup_device(pci_fixup_final, dev);
> > -	pci_create_sysfs_dev_files(dev);
> > +	pci_create_sysfs_dev_files(dev, false);
> >  	pci_proc_attach_device(dev);
> >  	pci_bridge_d3_update(dev);
> >  
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 6d78df981d41..b0c4852a51dd 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1328,13 +1328,13 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> >  	return retval;
> >  }
> >  
> > -int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
> > +int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev, bool sysfs_initializing)
> >  {
> >  	int retval;
> >  	int rom_size;
> >  	struct bin_attribute *attr;
> >  
> > -	if (!sysfs_initialized)
> > +	if (!sysfs_initializing && !sysfs_initialized)
> >  		return -EACCES;
> >  
> >  	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
> > @@ -1437,18 +1437,21 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> >  static int __init pci_sysfs_init(void)
> >  {
> >  	struct pci_dev *pdev = NULL;
> > -	int retval;
> > +	int retval = 0;
> >  
> > -	sysfs_initialized = 1;
> >  	for_each_pci_dev(pdev) {
> > -		retval = pci_create_sysfs_dev_files(pdev);
> > +		if (!pci_dev_is_added(pdev))
> > +			continue;
> > +		retval = pci_create_sysfs_dev_files(pdev, true);
> >  		if (retval) {
> >  			pci_dev_put(pdev);
> > -			return retval;
> > +			goto out;
> >  		}
> >  	}
> >  
> > -	return 0;
> > +out:
> > +	sysfs_initialized = 1;
> > +	return retval;
> >  }
> >  late_initcall(pci_sysfs_init);
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 6d3f75867106..304294c7171e 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -19,7 +19,7 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> >  
> >  /* Functions internal to the PCI core code */
> >  
> > -int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> > +int pci_create_sysfs_dev_files(struct pci_dev *pdev, bool sysfs_initializing);
> >  void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
> >  #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
> >  static inline void pci_create_firmware_label_files(struct pci_dev *pdev)
> > 
