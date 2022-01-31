Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB04A4D8B
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 18:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbiAaRwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 12:52:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4578 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347226AbiAaRwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 12:52:08 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnbGb2LKGz67Lqc;
        Tue,  1 Feb 2022 01:51:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 18:52:06 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 17:52:05 +0000
Date:   Mon, 31 Jan 2022 17:51:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 22/40] cxl/core/hdm: Add CXL standard decoder
 enumeration to the core
Message-ID: <20220131175159.00006d3d@Huawei.com>
In-Reply-To: <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298423561.3018233.8938479363856921038.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jan 2022 19:09:25 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Unlike the decoder enumeration for "root decoders" described by platform
> firmware, standard coders can be enumerated from the component registers
> space once the base address has been identified (via PCI, ACPI, or
> another mechanism).
> 
> Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
> enumeration and share it between host-bridge, upstream switch port, and
> cxl_test defined decoders.
> 
> The locking model for switch level decoders is to hold the port lock
> over the enumeration. This facilitates moving the dport and decoder
> enumeration to a 'port' driver. For now, the only enumerator of decoder
> resources is the cxl_acpi root driver.
> 
> [ben: fixup kdoc]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Mostly looks nice.  A couple of queries inline.

Jonathan

> ---
> Changes since v3:
> - Fixup kdoc for devm_cxl_enumerate_decoders() (Ben)
> - Cleanup a sparse warning around __iomem usage (Ben)
> 
>  drivers/cxl/acpi.c            |   43 ++-----
>  drivers/cxl/core/Makefile     |    1 
>  drivers/cxl/core/core.h       |    2 
>  drivers/cxl/core/hdm.c        |  248 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c       |   57 +++++++--
>  drivers/cxl/core/regs.c       |    5 -
>  drivers/cxl/cxl.h             |   33 ++++-
>  drivers/cxl/cxlmem.h          |    8 +
>  tools/testing/cxl/Kbuild      |    4 +
>  tools/testing/cxl/test/cxl.c  |   29 +++++
>  tools/testing/cxl/test/mock.c |   50 ++++++++
>  tools/testing/cxl/test/mock.h |    3 
>  12 files changed, 434 insertions(+), 49 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm.c
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 259441245687..8c2ced91518b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -168,10 +168,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct device *host = root_port->dev.parent;
>  	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
>  	struct acpi_pci_root *pci_root;
> -	int single_port_map[1], rc;
> -	struct cxl_decoder *cxld;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	struct cxl_port *port;
> +	int rc;
>  
>  	if (!bridge)
>  		return 0;
> @@ -200,37 +200,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	rc = devm_cxl_port_enumerate_dports(host, port);
>  	if (rc < 0)
>  		return rc;
> -	if (rc > 1)
> -		return 0;
> -
> -	/* TODO: Scan CHBCR for HDM Decoder resources */
> -
> -	/*
> -	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> -	 * Structure) single ported host-bridges need not publish a decoder
> -	 * capability when a passthrough decode can be assumed, i.e. all
> -	 * transactions that the uport sees are claimed and passed to the single
> -	 * dport. Disable the range until the first CXL region is enumerated /
> -	 * activated.
> -	 */
> -	cxld = cxl_switch_decoder_alloc(port, 1);
> -	if (IS_ERR(cxld))
> -		return PTR_ERR(cxld);
> -
>  	cxl_device_lock(&port->dev);
> -	dport = list_first_entry(&port->dports, typeof(*dport), list);
> -	cxl_device_unlock(&port->dev);
> +	if (rc == 1) {
> +		rc = devm_cxl_add_passthrough_decoder(host, port);
> +		goto out;
> +	}
>  
> -	single_port_map[0] = dport->port_id;
> +	cxlhdm = devm_cxl_setup_hdm(host, port);
> +	if (IS_ERR(cxlhdm)) {
> +		rc = PTR_ERR(cxlhdm);
> +		goto out;
> +	}
>  
> -	rc = cxl_decoder_add(cxld, single_port_map);
> +	rc = devm_cxl_enumerate_decoders(host, cxlhdm);
>  	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(host, cxld);
> +		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
>  
> -	if (rc == 0)
> -		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
> +out:
> +	cxl_device_unlock(&port->dev);
>  	return rc;
>  }
>  

...

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> new file mode 100644
> index 000000000000..fd9782269c56
> --- /dev/null
> +++ b/drivers/cxl/core/hdm.c
> @@ -0,0 +1,248 @@


...

> +
> +static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> +					  void __iomem *crb)
> +{
> +	struct cxl_register_map map;
> +	struct cxl_component_reg_map *comp_map = &map.component_map;

Why can't we use a cxl_register_map directly in here?
Doesn't seem to make use of the containing structure.

> +
> +	cxl_probe_component_regs(&port->dev, crb, comp_map);
> +	if (!comp_map->hdm_decoder.valid) {
> +		dev_err(&port->dev, "HDM decoder registers invalid\n");
> +		return IOMEM_ERR_PTR(-ENXIO);
> +	}
> +
> +	return crb + comp_map->hdm_decoder.offset;
> +}
> +
> +/**
> + * devm_cxl_setup_hdm - map HDM decoder component registers
> + * @port: cxl_port to map
> + */
> +struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)

Mentioned this in earlier reply, but good to keep docs in sync with
code even if going to change it shortly.

> +{
> +	struct device *dev = &port->dev;
> +	void __iomem *crb, *hdm;
> +	struct cxl_hdm *cxlhdm;
> +
> +	cxlhdm = devm_kzalloc(host, sizeof(*cxlhdm), GFP_KERNEL);
> +	if (!cxlhdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlhdm->port = port;
> +	crb = devm_cxl_iomap_block(host, port->component_reg_phys,
> +				   CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (!crb) {
> +		dev_err(dev, "No component registers mapped\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	hdm = map_hdm_decoder_regs(port, crb);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +	cxlhdm->regs.hdm_decoder = hdm;
> +
> +	parse_hdm_decoder_caps(cxlhdm);
> +	if (cxlhdm->decoder_count == 0) {
> +		dev_err(dev, "Spec violation. Caps invalid\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	return cxlhdm;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> +

...

