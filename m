Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0E2ABE8B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgKIOWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 09:22:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46174 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgKIOWW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 09:22:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9EM155042079;
        Mon, 9 Nov 2020 08:22:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604931721;
        bh=BeJowArEAuNdzFs1nPVZrTg6rdA5Y2jTtFWItMvuN7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B7slKvVqlOTC6Pg4t24Iyw7L3EI75xaTQ8PD8cUYYNZIkZDBXq/dhI5rx5HKfvKyT
         jitG7SmzvlRe82TFJuJBAWHiV4yVOoQV1dsVQkRbCo0U3dzTgWzzmtAVuTOiQJNAis
         MUyN7i/qTnY79oQSrG1SOq6lNJhSLsAuIr7gzmnM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9EM1lV032432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 08:22:01 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 08:22:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 08:22:00 -0600
Received: from [10.250.213.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9ELoY6109464;
        Mon, 9 Nov 2020 08:21:53 -0600
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
References: <20200930153519.7282-16-kishon@ti.com>
 <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d6d27475-3464-6772-2122-cc194b8ae022@ti.com>
Date:   Mon, 9 Nov 2020 19:51:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sherry,

On 09/11/20 3:07 pm, Sherry Sun wrote:
> Hi Kishon,
> 
>> Subject: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express Non-
>> Transparent Bridge
>>
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add support for EPF PCI-Express Non-Transparent Bridge (NTB) device.
>> This driver is platform independent and could be used by any platform which
>> have multiple PCIe endpoint instances configured using the pci-epf-ntb driver.
>> The driver connnects to the standard NTB sub-system interface. The EPF NTB
>> device has configurable number of memory windows (Max 4), configurable
>> number of doorbell (Max 32), and configurable number of scratch-pad
>> registers.
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
>> diff --git a/drivers/ntb/hw/epf/Makefile b/drivers/ntb/hw/epf/Makefile new
>> file mode 100644 index 000000000000..2f560a422bc6
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_NTB_EPF) += ntb_hw_epf.o
>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c
>> b/drivers/ntb/hw/epf/ntb_hw_epf.c new file mode 100644 index
>> 000000000000..0a144987851a
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> @@ -0,0 +1,755 @@
> ......
>> +static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>> +			    struct pci_dev *pdev)
>> +{
>> +	struct device *dev = ndev->dev;
>> +	int ret;
>> +
>> +	pci_set_drvdata(pdev, ndev);
>> +
>> +	ret = pci_enable_device(pdev);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot enable PCI device\n");
>> +		goto err_pci_enable;
>> +	}
>> +
>> +	ret = pci_request_regions(pdev, "ntb");
>> +	if (ret) {
>> +		dev_err(dev, "Cannot obtain PCI resources\n");
>> +		goto err_pci_regions;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	if (ret) {
>> +		ret = dma_set_mask_and_coherent(dev,
>> DMA_BIT_MASK(32));
>> +		if (ret) {
>> +			dev_err(dev, "Cannot set DMA mask\n");
>> +			goto err_dma_mask;
>> +		}
>> +		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>> +	}
>> +
>> +	ndev->ctrl_reg = pci_iomap(pdev, 0, 0);
> 
> The second parameter of pci_iomap should be ndev->ctrl_reg_bar instead of the hardcode value 0, right?
> 
>> +	if (!ndev->ctrl_reg) {
>> +		ret = -EIO;
>> +		goto err_dma_mask;
>> +	}
>> +
>> +	ndev->peer_spad_reg = pci_iomap(pdev, 1, 0);
> 
> pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> 
>> +	if (!ndev->peer_spad_reg) {
>> +		ret = -EIO;
>> +		goto err_dma_mask;
>> +	}
>> +
>> +	ndev->db_reg = pci_iomap(pdev, 2, 0);
> 
> pci_iomap(pdev, ndev->db_reg_bar, 0);

Good catch. Will fix it and send. Thank you for reviewing.

Regards,
Kishon
