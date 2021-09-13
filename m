Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51E409CA1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhIMTCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 15:02:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:19016 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240228AbhIMTCt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 15:02:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="201945531"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="201945531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 12:01:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="481454630"
Received: from dvannith-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.128.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 12:01:32 -0700
Date:   Mon, 13 Sep 2021 12:01:31 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 07/13] cxl/memdev: Determine CXL.mem capability
Message-ID: <20210913190131.xiiszmno46qie7v5@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-8-ben.widawsky@intel.com>
 <20210903162157.00000a43@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210903162157.00000a43@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-09-03 16:21:57, Jonathan Cameron wrote:
> On Thu, 2 Sep 2021 12:50:11 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > If the "upstream" port of the endpoint is an enumerated downstream CXL
> > port, and the device itself is CXL capable and enabled, the memdev
> > driver can bind. This binding useful for region configuration/creation
> > because it provides a clean way for the region code to determine if the
> > memdev is actually CXL capable.
> > 
> > A memdev/hostbridge probe race is solved with a full CXL bus rescan at
> > the end of ACPI probing (see comment in code for details). Switch
> > enumeration will be done as a follow-on patch. As a result, if a switch
> > is in the topology the memdev driver will not bind to any devices.
> > 
> > CXL.mem capability is checked lazily at the time a region is bound.
> > This is in line with the other configuration parameters.
> > 
> > Below is an example (mem0, and mem1) of CXL memdev devices that now
> > exist on the bus.
> > 
> > /sys/bus/cxl/devices/
> > ├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
> > ├── mem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0
> > ├── mem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1
> > ├── pmem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0/pmem0
> > ├── pmem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1/pmem1
> > ├── port1 -> ../../../devices/platform/ACPI0017:00/root0/port1
> > └── root0 -> ../../../devices/platform/ACPI0017:00/root0
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> +CC Bjorn.  Given we are moving the (nearly) generic DVSEC lookup routine, perhaps now
> is time to move it into PCI core code?
> 

Fine with me. Adding linux-pci as well...

> > ---
> >  drivers/cxl/acpi.c        | 27 +++++++-----------
> >  drivers/cxl/core/bus.c    | 60 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/memdev.c |  6 ++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  drivers/cxl/cxlmem.h      |  2 ++
> >  drivers/cxl/mem.c         | 55 ++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/pci.c         | 23 ---------------
> >  drivers/cxl/pci.h         |  7 ++++-
> >  8 files changed, 141 insertions(+), 41 deletions(-)
> > 
> 
> ...
> 
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 256e55dc2a3b..56f57302d27b 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> 
> ...
> 
> > @@ -596,6 +625,37 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
> >  
> > +/**
> > + * cxl_pci_dvsec - Gets offset for the given DVSEC id
> > + * @pdev: PCI device to search for the DVSEC
> > + * @dvsec: DVSEC id to look for
> > + *
> > + * Return: offset within the PCI header for the given DVSEC id. 0 if not found
> > + */
> > +int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > +{
> > +	int pos;
> > +
> > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > +	if (!pos)
> > +		return 0;
> > +
> > +	while (pos) {
> > +		u16 vendor, id;
> > +
> > +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> > +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> > +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> > +			return pos;
> > +
> > +		pos = pci_find_next_ext_capability(pdev, pos,
> > +						   PCI_EXT_CAP_ID_DVSEC);
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mem_dvsec);
> 
> That's not going to work. (pci/mem)  + Can we move this to the PCI core now?
> Wasn't done originally because there were several copies in various different
> trees that needed to all come together. Oddly only this one seems to have
> made it in though.

I'm confused about why it won't work - nevertheless, PCI core is probably the
right place.

Something like?

/**
 * pci_find_dvsec_capability - Find DVSEC for vendor
 * @dev: PCI device to query
 * @vendor: Vendor ID to match for the DVSEC
 * @dvsec: Designated Vendor-specific capability ID
 *
 * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
 * offset in config space; otherwise return 0.
 */
u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
{
	int pos;

	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
	if (!pos)
		return 0;

	while (pos) {
		u16 vendor, id;

		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
		if (vendor == vendor && dvsec == id)
			return pos;

		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
	}

	return 0;
}
EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);

> 
> 
> > +
> >  /**
> >   * __cxl_driver_register - register a driver for the cxl bus
> >   * @cxl_drv: cxl driver structure to attach
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index c9dd054bd813..0068b5ff5f3e 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -337,3 +337,9 @@ void cxl_memdev_exit(void)
> >  {
> >  	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> >  }
> > +
> > +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
> > +{
> 
> This feels like it needs a comment to say why that's a valid check to use
> to find out if it is mem capable.
> 
> > +	return !!cxlmd->dev.driver;
> > +}
> > +EXPORT_SYMBOL_GPL(is_cxl_mem_capable);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index b48bdbefd949..a168520d741b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -283,8 +283,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  				   resource_size_t component_reg_phys,
> >  				   struct cxl_port *parent_port);
> >  
> > +bool is_cxl_port(struct device *dev);
> >  int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> >  		  resource_size_t component_reg_phys);
> > +struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev);
> >  
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 811b24451604..88264204c4b9 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -51,6 +51,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> >  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> >  				       struct cxl_mem *cxlm);
> >  
> > +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
> > +
> >  /**
> >   * struct cxl_mbox_cmd - A command to be submitted to hardware.
> >   * @opcode: (input) The command set and command submitted to hardware.
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 978a54b0a51a..b6dc34d18a86 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -2,8 +2,10 @@
> >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/pci.h>
> >  
> >  #include "cxlmem.h"
> > +#include "pci.h"
> >  
> >  /**
> >   * DOC: cxl mem
> > @@ -17,9 +19,60 @@
> >   * components.
> >   */
> >  
> > +static int port_match(struct device *dev, const void *data)
> > +{
> > +	struct cxl_port *port;
> > +
> > +	if (!is_cxl_port(dev))
> > +		return 0;
> > +
> > +	port = to_cxl_port(dev);
> > +
> > +	if (find_dport_by_dev(port, (struct device *)data))
> Why the cast?
> 
> If this isn't modified in later patches
> 
> 	return find_dport_by_dev(port, data);
> 
> 
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static bool is_cxl_mem_enabled(struct pci_dev *pdev)
> > +{
> > +	int pcie_dvsec;
> > +	u16 dvsec_ctrl;
> > +
> > +	pcie_dvsec = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
> > +	if (!pcie_dvsec) {
> > +		dev_info(&pdev->dev, "Unable to determine CXL protocol support");
> > +		return false;
> > +	}
> > +
> > +	pci_read_config_word(pdev,
> > +			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
> > +			     &dvsec_ctrl);
> > +	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
> > +		dev_info(&pdev->dev, "CXL.mem protocol not supported on device");
> 
> In the ctrl field that indicates it's not on, rather than not supported.
> Hence I think the dev_info message is wrong.
> 
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int cxl_mem_probe(struct device *dev)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_mem *cxlm = cxlmd->cxlm;
> > +	struct device *pdev_parent = cxlm->dev->parent;
> > +	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
> > +	struct device *port_dev;
> > +
> > +	if (!is_cxl_mem_enabled(pdev))
> > +		return -ENODEV;
> > +
> > +	/* TODO: if parent is a switch, this will fail. */
> > +	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
> > +	if (!port_dev)
> > +		return -ENODEV;
> > +
> > +	return 0;
> >  }
> >  
> >  static void cxl_mem_remove(struct device *dev)
> 
> ...
> 

I took all the rest of the feedback up to here...

> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index 8c1a58813816..d6b9978d05b0 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -11,7 +11,10 @@
> >   */
> >  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> >  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> > -#define PCI_DVSEC_ID_CXL		0x0
> > +
> > +#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0
> 
> Why the rename to this?  DVSEC x3???  Can we get away with something like...
> 
> > +#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
> > +#define   CXL_PCIE_MEM_ENABLE			BIT(2)
> >  
> >  #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
> 
> Mind you I'm not clear why this one has DVSEC twice either...
> 
> >  #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> 
> This one has nothing to do with DVSEC ID... 
> 

I've already forgotten the motivation for the existing names and I don't care to
go back in the history. I was trying to create a schema here.

As you point out, both the description name and the field name introduce
redundant words. So how about all redundant of CXL and DVSEC are removed and the
schema becomes:

CXL DVSEC IDs : CXL_DVSEC_<description>
Offsets: DVSEC_<description>_<field>_OFFSET
Bits/mask DVSEC_<description>_<field>_<attribute>

#define CXL_DVSEC_PCIE_DEVICE		0
#define CXL_DVSEC_FUNCTION_MAP		2
#define CXL_DVSEC_PORT_EXTENSIONS	3
#define CXL_DVSEC_PORT_GPF		4
#define CXL_DVSEC_DEVICE_GPF		5
#define CXL_DVSEC_PCIE_FLEXBUS_PORT	7
#define CXL_DVSEC_REGISTER_LOCATOR	8
#define CXL_DVSEC_MLD			9
#define CXL_DVSEC_PCIE_TEST_CAPABILITY	10

Then an offset within one of the DVSECs...
#define CXL_DVSEC_REGISTER_LOCATOR		8
#define   DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET	0xC

Then a bit/mask...
#define CXL_DVSEC_PCIE_DEVICE			0
#define  DVSEC_PCIE_DEVICE_CAP_OFFSET		0xA
#define    DVSEC_PCIE_DEVICE_CAP_MEM_CAPABLE	BIT(2)

I'm open to other suggestions. I feel like translating registers from spec to
header files is one thing I've done over and over on many projects and I think
I'm unhappy with every solution we've managed to implement.

> > @@ -29,4 +32,6 @@
> >  
> >  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> >  
> > +int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec);
> > +
> >  #endif /* __CXL_PCI_H__ */
> 
