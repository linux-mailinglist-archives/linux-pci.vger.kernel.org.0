Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B111B2D2234
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 05:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLHEog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 23:44:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgLHEog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 23:44:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B84hPmG038350;
        Mon, 7 Dec 2020 22:43:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607402605;
        bh=aORTlvK3UG1DVvDgM/DY4UvAIqUGSMoDP1mLzm2o8/E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZEH0SmMB1/sWUZdA2qDBQTtntXB4EsPmwuzFughSfEqDa8F628rj/PpXuuS3Tc9kk
         NBz5XI0+KhWFsSXCT+Y5r9GPkZaHhYhzIj8/uPrEoG3iodfndpVGzs7NuojZF99dHU
         6Vc+qAs3KCOft8uSkZqaoXuH640DBQ5RJfTLGm9E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B84hPGj113582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 22:43:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 22:43:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 22:43:24 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B84hJbo107231;
        Mon, 7 Dec 2020 22:43:20 -0600
Subject: Re: [PATCH v8 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-16-kishon@ti.com>
 <b63d37bccd4f4afc833fd0b9078c3b89@intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8611fcad-9af7-857e-5aa1-b680aef28db6@ti.com>
Date:   Tue, 8 Dec 2020 10:13:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b63d37bccd4f4afc833fd0b9078c3b89@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dave,

On 07/12/20 9:27 pm, Jiang, Dave wrote:
> 
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Wednesday, November 11, 2020 8:36 AM
>> To: Bjorn Helgaas <bhelgaas@google.com>; Jonathan Corbet
>> <corbet@lwn.net>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
>> Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>;
>> Jon Mason <jdmason@kudzu.us>; Jiang, Dave <dave.jiang@intel.com>;
>> Allen Hubbe <allenbh@gmail.com>; Tom Joseph <tjoseph@cadence.com>;
>> Rob Herring <robh@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>> pci@vger.kernel.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-ntb@googlegroups.com
>> Subject: [PATCH v8 15/18] NTB: Add support for EPF PCI-Express Non-
>> Transparent Bridge
>>
>> Add support for EPF PCI-Express Non-Transparent Bridge (NTB) device.
>> This driver is platform independent and could be used by any platform which
>> have multiple PCIe endpoint instances configured using the pci-epf-ntb
>> driver. The driver connnects to the standard NTB sub-system interface. The
>> EPF NTB device has configurable number of memory windows (Max 4),
>> configurable number of doorbell (Max 32), and configurable number of
>> scratch-pad registers.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/ntb/hw/Kconfig          |   1 +
>>  drivers/ntb/hw/Makefile         |   1 +
>>  drivers/ntb/hw/epf/Kconfig      |   6 +
>>  drivers/ntb/hw/epf/Makefile     |   1 +
>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 755
>> ++++++++++++++++++++++++++++++++
>>  5 files changed, 764 insertions(+)
>>  create mode 100644 drivers/ntb/hw/epf/Kconfig  create mode 100644
>> drivers/ntb/hw/epf/Makefile  create mode 100644
>> drivers/ntb/hw/epf/ntb_hw_epf.c
>>
>> diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig index
>> e77c587060ff..c325be526b80 100644
>> --- a/drivers/ntb/hw/Kconfig
>> +++ b/drivers/ntb/hw/Kconfig
>> @@ -2,4 +2,5 @@
>>  source "drivers/ntb/hw/amd/Kconfig"
>>  source "drivers/ntb/hw/idt/Kconfig"
>>  source "drivers/ntb/hw/intel/Kconfig"
>> +source "drivers/ntb/hw/epf/Kconfig"
>>  source "drivers/ntb/hw/mscc/Kconfig"
>> diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile index
>> 4714d6238845..223ca592b5f9 100644
>> --- a/drivers/ntb/hw/Makefile
>> +++ b/drivers/ntb/hw/Makefile
>> @@ -2,4 +2,5 @@
>>  obj-$(CONFIG_NTB_AMD)	+= amd/
>>  obj-$(CONFIG_NTB_IDT)	+= idt/
>>  obj-$(CONFIG_NTB_INTEL)	+= intel/
>> +obj-$(CONFIG_NTB_EPF)	+= epf/
>>  obj-$(CONFIG_NTB_SWITCHTEC) += mscc/
>> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig new
>> file mode 100644 index 000000000000..6197d1aab344
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/Kconfig
>> @@ -0,0 +1,6 @@
>> +config NTB_EPF
>> +	tristate "Generic EPF Non-Transparent Bridge support"
>> +	depends on m
>> +	help
>> +	  This driver supports EPF NTB on configurable endpoint.
>> +	  If unsure, say N.
>> diff --git a/drivers/ntb/hw/epf/Makefile b/drivers/ntb/hw/epf/Makefile
>> new file mode 100644 index 000000000000..2f560a422bc6
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_NTB_EPF) += ntb_hw_epf.o
>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c
>> b/drivers/ntb/hw/epf/ntb_hw_epf.c new file mode 100644 index
>> 000000000000..3855bb0ecacd
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> @@ -0,0 +1,755 @@
.
.
<snip>
.
.
>> +static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev) {
>> +	struct pci_dev *pdev = ndev->ntb.pdev;
>> +	struct device *dev = &pdev->dev;
>> +	int i;
>> +
>> +	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL,
>> ndev->db_count + 1);
>> +
>> +	for (i = 0; i < ndev->db_count + 1; i++)
>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), ndev);
> 
> This is called during shutdown. Does that defeats the purpose of using devm API?

Yeah, here devm_* API is not required since we have to invoke free_irq()
before invoking pci_free_irq_vectors(). Will change this to non devm API.

Thank You,
Kishon

> 
> - Dave
> 
>> +	pci_free_irq_vectors(pdev);
>> +}
>> +
>> +static int ntb_epf_pci_probe(struct pci_dev *pdev,
>> +			     const struct pci_device_id *id) {
>> +	enum pci_barno peer_spad_reg_bar = BAR_1;
>> +	enum pci_barno ctrl_reg_bar = BAR_0;
>> +	enum pci_barno db_reg_bar = BAR_2;
>> +	struct device *dev = &pdev->dev;
>> +	struct ntb_epf_data *data;
>> +	struct ntb_epf_dev *ndev;
>> +	int ret;
>> +
>> +	if (pci_is_bridge(pdev))
>> +		return -ENODEV;
>> +
>> +	ndev = devm_kzalloc(dev, sizeof(*ndev), GFP_KERNEL);
>> +	if (!ndev)
>> +		return -ENOMEM;
>> +
>> +	data = (struct ntb_epf_data *)id->driver_data;
>> +	if (data) {
>> +		if (data->peer_spad_reg_bar)
>> +			peer_spad_reg_bar = data->peer_spad_reg_bar;
>> +		if (data->ctrl_reg_bar)
>> +			ctrl_reg_bar = data->ctrl_reg_bar;
>> +		if (data->db_reg_bar)
>> +			db_reg_bar = data->db_reg_bar;
>> +	}
>> +
>> +	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
>> +	ndev->ctrl_reg_bar = ctrl_reg_bar;
>> +	ndev->db_reg_bar = db_reg_bar;
>> +	ndev->dev = dev;
>> +
>> +	ntb_epf_init_struct(ndev, pdev);
>> +	mutex_init(&ndev->cmd_lock);
>> +
>> +	ret = ntb_epf_init_pci(ndev, pdev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to init PCI\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = ntb_epf_init_dev(ndev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to init device\n");
>> +		goto err_init_dev;
>> +	}
>> +
>> +	ret = ntb_register_device(&ndev->ntb);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register NTB device\n");
>> +		goto err_register_dev;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_register_dev:
>> +	ntb_epf_cleanup_isr(ndev);
>> +
>> +err_init_dev:
>> +	ntb_epf_deinit_pci(ndev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ntb_epf_pci_remove(struct pci_dev *pdev) {
>> +	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
>> +
>> +	ntb_unregister_device(&ndev->ntb);
>> +	ntb_epf_cleanup_isr(ndev);
>> +	ntb_epf_deinit_pci(ndev);
>> +	kfree(ndev);
>> +}
>> +
>> +static const struct ntb_epf_data j721e_data = {
>> +	.ctrl_reg_bar = BAR_0,
>> +	.peer_spad_reg_bar = BAR_1,
>> +	.db_reg_bar = BAR_2,
>> +};
>> +
>> +static const struct pci_device_id ntb_epf_pci_tbl[] = {
>> +	{
>> +		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>> +		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask =
>> 0xffff00,
>> +		.driver_data = (kernel_ulong_t)&j721e_data,
>> +	},
>> +	{ },
>> +};
>> +
>> +static struct pci_driver ntb_epf_pci_driver = {
>> +	.name		= KBUILD_MODNAME,
>> +	.id_table	= ntb_epf_pci_tbl,
>> +	.probe		= ntb_epf_pci_probe,
>> +	.remove		= ntb_epf_pci_remove,
>> +};
>> +module_pci_driver(ntb_epf_pci_driver);
>> +
>> +MODULE_DESCRIPTION("PCI ENDPOINT NTB HOST DRIVER");
>> +MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.17.1
> 
