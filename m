Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7264A3E2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiLLPBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 10:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiLLPBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 10:01:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BE11814
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 07:01:39 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id c129so11489345oia.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 07:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lfi9lWrLo+7Ojc9P9Gv99GttQoNFb/xzPafJS3blQPA=;
        b=Q4wvRoIQtoZlomROfJqenhWhzs0E+QNht7qBdPvAfjm26ISX83neo5mnabylPOfFpZ
         R2+bh3BfFmFZk6MKaD58htkWLc9Zrb9r7oHDVM12zJZtj73kDlV4T2X+j6NhRFIXQuoF
         CF9Xu01fXfT4lLxjAwwccvst16sn5EoG19zpWLZXJ1oxYdFsbMsWO2kdPVk+pRKygrxr
         DlGPPL4pPzHwyR10z/QU5PLcwS1CTrK12J+EkVm5KwqyR7VpJ4u/LRJ9v5xYpaFZLul9
         52LP+hD6gdNnSOdZSP9xhNf8V3ii7VlnzTxIa4V1NL5nIy3GFdKkuXu2yRf4RcEh1xSQ
         gRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfi9lWrLo+7Ojc9P9Gv99GttQoNFb/xzPafJS3blQPA=;
        b=v+QeVHC9fxlKAourdtRploEyoFThdzPw7RgRvp5wcDU7KUvlf4ayi/mNX1/iydhARb
         V8UlXQ+8z1vKGy2gq2qqDWBVg90kvnqJ0LmwLgkFq/OL9ddR/sSWemm5nGGjSsl7r7fU
         zlnchqQis2yEwo++qL5Rap169sWPjLBeHsDhr93AMmxNgw7F6/jtURkSsbsy37jE5Qpf
         QYhiMFXoq5uFXyoj+OiSi1llQUCnMTz2rCu8Dt1Erif3aB/67madL2mf+mgEVRNmWiqv
         4SLg2vBQlQpfjRskF76qSalAhU2AwzN4c+lJcAuNxgnmyNiiWoWzxh09bCoe2sWsuGIV
         E1DA==
X-Gm-Message-State: ANoB5pkifGh5chSvsI6W5987nlQ7ra8E7m81pfyNgdemUFENzmks3SpG
        qMzHGd/9b1T//XZTnusNjvw=
X-Google-Smtp-Source: AA0mqf4dmaaIuD9x9oyxXS69XWKVpcemzRmyHwN+wRfexnGiCWh2qY6371g7Dxm1+7HvU3BW8+pfmA==
X-Received: by 2002:aca:915:0:b0:35e:9090:296d with SMTP id 21-20020aca0915000000b0035e9090296dmr1814113oij.12.1670857296658;
        Mon, 12 Dec 2022 07:01:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bq20-20020a056830389400b00670679748f9sm1800otb.49.2022.12.12.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 07:01:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
Date:   Mon, 12 Dec 2022 07:01:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
In-Reply-To: <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/12/22 06:24, Alvaro Karsz wrote:
> This commit includes:
>   1) The driver to manage the controlplane over vDPA bus.
>   2) A HW monitor device to read health values from the DPU.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> --
> v2:
> 	- Auto detect the BAR used for communication.
> 	- When waiting for the DPU to write a config, wait for 5secs
> 	  before giving up on the device.
> 	- Return EOPNOTSUPP error code in vDPA set_vq_state callback if
> 	  the vq state is not the same as the initial one.
> 	- Implement a vDPA reset callback.
> 	- Wait for an ACK when sending a message to the DPU.
> 	- Add endianness comments on 64bit read/write functions.
> 	- Remove the get_iova_range and free vDPA callbacks.
> 	- Usage of managed device functions to ioremap a region.
> 	- Call pci_set_drvdata and pci_set_master before
> 	  vdpa_register_device.
> 	- Create DMA isolation between the vDPA devices by using the
> 	  chip SR-IOV feature.
> 	  Every vDPA device gets a PCIe VF with its own DMA device.
> 
> v3:
> 	- Validate vDPA config length while receiving the DPU's config,
> 	  not while trying to write the vDPA config to the DPU.
> 	- Request IRQs when vDPA status is set to
> 	  VIRTIO_CONFIG_S_DRIVER_OK.
> 	- Remove snet_reset_dev() from the PCI remove function for a VF.
> v4:
> 	- Get SolidRun vendor ID from pci_ids
> ---
>   MAINTAINERS                        |    4 +
>   drivers/vdpa/Kconfig               |   11 +
>   drivers/vdpa/Makefile              |    1 +
>   drivers/vdpa/solidrun/Makefile     |    3 +
>   drivers/vdpa/solidrun/snet_hwmon.c |  191 +++++
>   drivers/vdpa/solidrun/snet_main.c  | 1114 ++++++++++++++++++++++++++++
>   drivers/vdpa/solidrun/snet_vdpa.h  |  192 +++++
>   7 files changed, 1516 insertions(+)
>   create mode 100644 drivers/vdpa/solidrun/Makefile
>   create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
>   create mode 100644 drivers/vdpa/solidrun/snet_main.c
>   create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 046ff06ff97..ae425b3bed4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21725,6 +21725,10 @@ IFCVF VIRTIO DATA PATH ACCELERATOR
>   R:	Zhu Lingshan <lingshan.zhu@intel.com>
>   F:	drivers/vdpa/ifcvf/
>   
> +SNET DPU VIRTIO DATA PATH ACCELERATOR
> +R:	Alvaro Karsz <alvaro.karsz@solid-run.com>
> +F:	drivers/vdpa/solidrun/
> +
>   VIRTIO BALLOON
>   M:	"Michael S. Tsirkin" <mst@redhat.com>
>   M:	David Hildenbrand <david@redhat.com>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d03761..cb1ff0f9e27 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -86,4 +86,15 @@ config ALIBABA_ENI_VDPA
>   	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
>   	  virtio 0.9.5 specification.
>   
> + config SNET_VDPA
> +	tristate "SolidRun's vDPA driver for SolidNET"
> +	select HWMON

This is wrong. It should be possible to build the driver without it, and
without forcing everyone to enable hwmon just to get support for this device -
even more so since hwmon support is explicitly marked as optional below.
Why force people to compile it if it is not mandatory ?

Yes, I know, "select HWMON" is done elsewhere as well, but it is just as wrong
there. No one should be forced to enable HWMON support just to get, say, support
for the IDT PCIe-switch Non-Transparent Bridge.

> +	depends on PCI_MSI && PCI_IOV
> +	help
> +	  vDPA driver for SolidNET DPU.
> +	  With this driver, the VirtIO dataplane can be
> +	  offloaded to a SolidNET DPU.
> +	  This driver includes a HW monitor device that
> +	  reads health values from the DPU.
> +
>   endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 15665563a7f..59396ff2a31 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_IFCVF)    += ifcvf/
>   obj-$(CONFIG_MLX5_VDPA) += mlx5/
>   obj-$(CONFIG_VP_VDPA)    += virtio_pci/
>   obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
> +obj-$(CONFIG_SNET_VDPA) += solidrun/
> diff --git a/drivers/vdpa/solidrun/Makefile b/drivers/vdpa/solidrun/Makefile
> new file mode 100644
> index 00000000000..0acabd040fd
> --- /dev/null
> +++ b/drivers/vdpa/solidrun/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
> +snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o snet_hwmon.o
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> new file mode 100644
> index 00000000000..ec6d09f09c7
> --- /dev/null
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SolidRun DPU driver for control plane
> + *
> + * Copyright (C) 2022 SolidRun
> + *
> + * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
> + *
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +

I do not see why the second include would be needed.

> +#include "snet_vdpa.h"
> +
> +/* Monitor offsets */
> +#define SNET_MON_TMP0_IN_OFF      0x00
> +#define SNET_MON_TMP0_MAX_OFF     0x08
> +#define SNET_MON_TMP0_CRIT_OFF    0x10
> +#define SNET_MON_TMP1_IN_OFF      0x18
> +#define SNET_MON_TMP1_CRIT_OFF    0x20
> +#define SNET_MON_CURR_IN_OFF      0x28
> +#define SNET_MON_CURR_MAX_OFF     0x30
> +#define SNET_MON_CURR_CRIT_OFF    0x38
> +#define SNET_MON_PWR_IN_OFF       0x40
> +#define SNET_MON_VOLT_IN_OFF      0x48
> +#define SNET_MON_VOLT_CRIT_OFF    0x50
> +#define SNET_MON_VOLT_LCRIT_OFF   0x58
> +
> +static void snet_hwmon_read_reg(struct psnet *psnet, u32 reg, long *out)
> +{
> +	*out = (long)psnet_read64(psnet, psnet->cfg.hwmon_off + reg);

Tpecast seems unnecessary.

> +}
> +
> +static umode_t snet_howmon_is_visible(const void *data,
> +				      enum hwmon_sensor_types type,
> +				      u32 attr, int channel)
> +{
> +	/* Files are read only */

Kind of obvious.

> +	return 0444;
> +}
> +
> +static int snet_howmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct psnet *psnet = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_lcrit:
> +			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_LCRIT_OFF, val);
> +			break;
> +		case hwmon_in_crit:
> +			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_CRIT_OFF, val);
> +			break;
> +		case hwmon_in_input:
> +			snet_hwmon_read_reg(psnet, SNET_MON_VOLT_IN_OFF, val);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			snet_hwmon_read_reg(psnet, SNET_MON_PWR_IN_OFF, val);
> +			break;
> +
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			snet_hwmon_read_reg(psnet, SNET_MON_CURR_IN_OFF, val);
> +			break;
> +		case hwmon_curr_max:
> +			snet_hwmon_read_reg(psnet, SNET_MON_CURR_MAX_OFF, val);
> +			break;
> +		case hwmon_curr_crit:
> +			snet_hwmon_read_reg(psnet, SNET_MON_CURR_CRIT_OFF, val);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			if (channel == 0)
> +				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_IN_OFF, val);
> +			else
> +				snet_hwmon_read_reg(psnet, SNET_MON_TMP1_IN_OFF, val);
> +			break;
> +		case hwmon_temp_max:
> +			if (channel == 0)
> +				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_MAX_OFF, val);
> +			else
> +				ret = -EOPNOTSUPP;
> +			break;
> +		case hwmon_temp_crit:
> +			if (channel == 0)
> +				snet_hwmon_read_reg(psnet, SNET_MON_TMP0_CRIT_OFF, val);
> +			else
> +				snet_hwmon_read_reg(psnet, SNET_MON_TMP1_CRIT_OFF, val);
> +			break;
> +
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int snet_hwmon_read_string(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, const char **str)
> +{
> +	int ret = 0;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		*str = "main_vin";
> +		break;
> +	case hwmon_power:
> +		*str = "soc_pin";
> +		break;
> +	case hwmon_curr:
> +		*str = "soc_iin";
> +		break;
> +	case hwmon_temp:
> +		if (channel == 0)
> +			*str = "power_stage_temp";
> +		else
> +			*str = "ic_junction_temp";
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static const struct hwmon_ops snet_hwmon_ops = {/
> +	.is_visible = snet_howmon_is_visible,
> +	.read = snet_howmon_read,
> +	.read_string = snet_hwmon_read_string
> +};
> +
> +static const struct hwmon_channel_info *snet_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> +	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT | HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_CRIT | HWMON_I_LCRIT | HWMON_I_LABEL),
> +			   NULL

Badly misleading indent. No idea why checkpatch doesn't report it.

That makes me wonder: Did you not run checkpatch --strict, or did you choose
to ignore what it reports ?

> +};
> +
> +static const struct hwmon_chip_info snet_hwmono_info = {
> +	.ops = &snet_hwmon_ops,
> +	.info = snet_hwmon_info,
> +};
> +
> +/* Create an HW monitor device */
> +void psnet_create_hwmon(struct pci_dev *pdev)
> +{
> +	struct device *hwmon;
> +	struct psnet *psnet = pci_get_drvdata(pdev);
> +
> +	snprintf(psnet->hwmon_name, SNET_NAME_SIZE, "snet[%s]_hwmon", pci_name(pdev));

FWIW, a _hwmon ending in a hwmon driver device name is redundant.
What else would it be ? Why not just use pci_name() ?

> +	hwmon = devm_hwmon_device_register_with_info(&pdev->dev, psnet->hwmon_name, psnet,
> +						     &snet_hwmono_info, NULL);
> +	/* The monitor is not mandatory, Just alert user in case of an error */
> +	if (!hwmon)
> +		SNET_WARN(pdev, "Failed to create SNET hwmon\n");

devm_hwmon_device_register_with_info() returns an ERR_PTR on error,
not NULL.

I hope you know what you are doing here. This may result in people wondering
why hwmon support doesn't work if they expect it to work. No one looks
into the kernel log. Besides, ignoring the error doesn't really help
much because that error return means that something serious is wrong.

Also, I think that the logging macros should be dropped. They don't add
any real value (besides the checkpatch message).

> +}
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> new file mode 100644
> index 00000000000..7f59206686a
> --- /dev/null
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -0,0 +1,1114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SolidRun DPU driver for control plane
> + *
> + * Copyright (C) 2022 SolidRun
> + *
> + * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
> + *
> + */
> +#include <linux/iopoll.h>
> +
> +#include "snet_vdpa.h"
> +
> +/* SNET DPU device ID */
> +#define SNET_DEVICE_ID          0x1000
> +/* SNET signature */
> +#define SNET_SIGNATURE          0xD0D06363
> +/* Max. config version that we can work with */
> +#define SNET_CFG_VERSION        0x1
> +/* Queue align */
> +#define SNET_QUEUE_ALIGNMENT    PAGE_SIZE
> +/* Kick value to notify that new data is available */
> +#define SNET_KICK_VAL           0x1
> +#define SNET_CONFIG_OFF         0x0
> +/* ACK timeout for a message */
> +#define SNET_ACK_TIMEOUT	2000000
> +/* How long we are willing to wait for a SNET device */
> +#define SNET_DETECT_TIMEOUT	5000000
> +/* How long should we wait for the DPU to read our config */
> +#define SNET_READ_CFG_TIMEOUT	3000000
> +/* Size of configs written to the DPU */
> +#define SNET_GENERAL_CFG_LEN	36
> +#define SNET_GENERAL_CFG_VQ_LEN	40
> +
> +enum snet_msg {
> +	SNET_MSG_DESTROY = 1,
> +};
> +
> +
> +static struct snet *vdpa_to_snet(struct vdpa_device *vdpa)
> +{
> +	return container_of(vdpa, struct snet, vdpa);
> +}
> +
> +static int snet_wait_for_msg_ack(struct snet *snet)
> +{
> +	struct pci_dev *pdev = snet->pdev;
> +	int ret;
> +	u32 val;
> +
> +	/* The DPU will clear the messages offset once messages
> +	 * are processed.
> +	 */
> +	ret = readx_poll_timeout(ioread32, snet->bar + snet->psnet->cfg.msg_off,
> +				 val, !val, 10, SNET_ACK_TIMEOUT);
> +	if (ret)
> +		SNET_WARN(pdev, "Timeout waiting for message ACK\n");
> +
> +	return ret;
> +}
> +
> +/* Sends a message to the DPU.
> + * If blocking is set, the function will return once the
> + * message was processed by the DPU (or timeout).
> + */
> +static int snet_send_msg(struct snet *snet, u32 msg, bool blocking)
> +{
> +	int ret = 0;
> +
> +	/* Make sure the DPU acked last message before issuing a new one */
> +	ret = snet_wait_for_msg_ack(snet);
> +	if (ret)
> +		return ret;
> +
> +	/* Write the message */
> +	snet_write32(snet, snet->psnet->cfg.msg_off, msg);
> +
> +	if (blocking)
> +		ret = snet_wait_for_msg_ack(snet);
> +	else /* If non-blocking, flush the write by issuing a read */
> +		snet_read32(snet, snet->psnet->cfg.msg_off);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t snet_cfg_irq_hndlr(int irq, void *data)
> +{
> +	struct snet *snet = data;
> +	/* Call callback if any */
> +	if (snet->cb.callback)
> +		return snet->cb.callback(snet->cb.private);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t snet_vq_irq_hndlr(int irq, void *data)
> +{
> +	struct snet_vq *vq = data;
> +	/* Call callback if any */
> +	if (vq->cb.callback)
> +		return vq->cb.callback(vq->cb.private);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void snet_free_irqs(struct snet *snet)
> +{
> +	struct psnet *psnet = snet->psnet;
> +	struct pci_dev *pdev;
> +	u32 i;
> +
> +	/* Which Device allcoated the IRQs? */
> +	if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF))
> +		pdev = snet->pdev->physfn;
> +	else
> +		pdev = snet->pdev;
> +
> +	/* Free config's IRQ */
> +	if (snet->cfg_irq != -1) {
> +		devm_free_irq(&pdev->dev, snet->cfg_irq, snet);
> +		snet->cfg_irq = -1;
> +	}
> +	/* Free VQ IRQs */
> +	for (i = 0; i < snet->cfg->vq_num; i++) {
> +		if (snet->vqs[i] && snet->vqs[i]->irq != -1) {
> +			devm_free_irq(&pdev->dev, snet->vqs[i]->irq, snet->vqs[i]);
> +			snet->vqs[i]->irq = -1;
> +		}
> +	}
> +
> +	/* IRQ vectors are freed when the pci remove callback is called */
> +}
> +
> +static int snet_set_vq_address(struct vdpa_device *vdev, u16 idx, u64 desc_area,
> +			       u64 driver_area, u64 device_area)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	/* save received parameters in vqueue sturct */
> +	snet->vqs[idx]->desc_area = desc_area;
> +	snet->vqs[idx]->driver_area = driver_area;
> +	snet->vqs[idx]->device_area = device_area;
> +
> +	return 0;
> +}
> +
> +static void snet_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	/* save num in vqueue */
> +	snet->vqs[idx]->num = num;
> +}
> +
> +static void snet_kick_vq(struct vdpa_device *vdev, u16 idx)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	/* not ready - ignore */
> +	if (!snet->vqs[idx]->ready)
> +		return;
> +
> +	iowrite32(SNET_KICK_VAL, snet->vqs[idx]->kick_ptr);
> +}
> +
> +static void snet_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_callback *cb)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	snet->vqs[idx]->cb.callback = cb->callback;
> +	snet->vqs[idx]->cb.private = cb->private;
> +}
> +
> +static void snet_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	snet->vqs[idx]->ready = ready;
> +}
> +
> +static bool snet_get_vq_ready(struct vdpa_device *vdev, u16 idx)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->vqs[idx]->ready;
> +}
> +
> +static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	/* Setting the VQ state is not supported.
> +	 * If the asked state is the same as the initial one
> +	 * we can ignore it.
> +	 */
> +	if (SNET_HAS_FEATURE(snet, VIRTIO_F_RING_PACKED)) {
> +		const struct vdpa_vq_state_packed *p = &state->packed;
> +
> +		if (p->last_avail_counter == 1 && p->last_used_counter == 1 &&
> +		    p->last_avail_idx == 0 && p->last_used_idx == 0)
> +			return 0;
> +	} else {
> +		const struct vdpa_vq_state_split *s = &state->split;
> +
> +		if (s->avail_index == 0)
> +			return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int snet_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa_vq_state *state)
> +{
> +	/* Not supported */
> +	return -EOPNOTSUPP;
> +}
> +
> +static int snet_get_vq_irq(struct vdpa_device *vdev, u16 idx)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->vqs[idx]->irq;
> +}
> +
> +static u32 snet_get_vq_align(struct vdpa_device *vdev)
> +{
> +	return (u32)SNET_QUEUE_ALIGNMENT;
> +}
> +
> +static int snet_reset_dev(struct snet *snet)
> +{
> +	struct pci_dev *pdev = snet->pdev;
> +	int ret = 0;
> +	u32 i;
> +
> +	/* If status is 0, nothing to do */
> +	if (!snet->status)
> +		return 0;
> +
> +	/* If DPU started, send a destroy message */
> +	if (snet->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +		ret = snet_send_msg(snet, SNET_MSG_DESTROY, true);
> +
> +	/* Clear VQs */
> +	for (i = 0; i < snet->cfg->vq_num; i++) {
> +		if (!snet->vqs[i])
> +			continue;
> +		snet->vqs[i]->cb.callback = NULL;
> +		snet->vqs[i]->cb.private = NULL;
> +		snet->vqs[i]->desc_area = 0;
> +		snet->vqs[i]->device_area = 0;
> +		snet->vqs[i]->driver_area = 0;
> +		snet->vqs[i]->ready = false;
> +	}
> +
> +	/* Clear config callback */
> +	snet->cb.callback = NULL;
> +	snet->cb.private = NULL;
> +	/* Free IRQs */
> +	snet_free_irqs(snet);
> +	/* Reset status */
> +	snet->status = 0;
> +
> +	if (ret)
> +		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device\n", snet->sid);
> +	else
> +		SNET_DBG(pdev, "Reset SNET[%u] device\n", snet->sid);
> +
> +	return 0;
> +}
> +
> +static int snet_reset(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet_reset_dev(snet);
> +}
> +
> +static size_t snet_get_config_size(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return (size_t)snet->cfg->cfg_size;
> +}
> +
> +static u64 snet_get_features(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->cfg->features;
> +}
> +
> +static int snet_set_drv_features(struct vdpa_device *vdev, u64 features)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	snet->negotiated_features = snet->cfg->features & features;
> +	return 0;
> +}
> +
> +static u64 snet_get_drv_features(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->negotiated_features;
> +}
> +
> +static u16 snet_get_vq_num_max(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return (u16)snet->cfg->vq_size;
> +}
> +
> +static void snet_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	snet->cb.callback = cb->callback;
> +	snet->cb.private = cb->private;
> +}
> +
> +static u32 snet_get_device_id(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->cfg->virtio_id;
> +}
> +
> +static u32 snet_get_vendor_id(struct vdpa_device *vdev)
> +{
> +	return (u32)PCI_VENDOR_ID_SOLIDRUN;
> +}
> +
> +static u8 snet_get_status(struct vdpa_device *vdev)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +
> +	return snet->status;
> +}
> +
> +static int snet_write_conf(struct snet *snet)
> +{
> +	u32 off, i, tmp;
> +	int ret;
> +
> +	/* No need to write the config twice */
> +	if (snet->dpu_ready)
> +		return true;
> +
> +	/* Snet data :
> +	 *
> +	 * General data: SNET_GENERAL_CFG_LEN bytes long
> +	 *  0             0x4       0x8        0xC               0x10      0x14        0x1C     0x24
> +	 *  | MAGIC NUMBER | CFG VER | SNET SID | NUMBER OF QUEUES | IRQ IDX | FEATURES |  RSVD  |
> +	 *
> +	 * For every VQ: SNET_GENERAL_CFG_VQ_LEN bytes long
> +	 * 0                          0x4        0x8
> +	 * |  VQ SID  AND  QUEUE SIZE | IRQ Index |
> +	 * |             DESC AREA                |
> +	 * |            DEVICE AREA               |
> +	 * |            DRIVER AREA               |
> +	 * |             RESERVED                 |
> +	 *
> +	 * Magic number should be written last, this is the DPU indication that the data is ready
> +	 */
> +
> +	/* Init offset */
> +	off = snet->psnet->cfg.host_cfg_off;
> +
> +	/* Ignore magic number for now */
> +	off += 4;
> +	snet_write32(snet, off, snet->psnet->negotiated_cfg_ver);
> +	off += 4;
> +	snet_write32(snet, off, snet->sid);
> +	off += 4;
> +	snet_write32(snet, off, snet->cfg->vq_num);
> +	off += 4;
> +	snet_write32(snet, off, snet->cfg_irq_idx);
> +	off += 4;
> +	snet_write64(snet, off, snet->negotiated_features);
> +	off += 8;
> +	/* Ignore reserved */
> +	off += 8;
> +	/* Write VQs */
> +	for (i = 0 ; i < snet->cfg->vq_num ; i++) {
> +		tmp = (i << 16) | (snet->vqs[i]->num & 0xFFFF);
> +		snet_write32(snet, off, tmp);
> +		off += 4;
> +		snet_write32(snet, off, snet->vqs[i]->irq_idx);
> +		off += 4;
> +		snet_write64(snet, off, snet->vqs[i]->desc_area);
> +		off += 8;
> +		snet_write64(snet, off, snet->vqs[i]->device_area);
> +		off += 8;
> +		snet_write64(snet, off, snet->vqs[i]->driver_area);
> +		off += 8;
> +		/* Ignore reserved */
> +		off += 8;
> +	}
> +
> +	/* Clear snet messages address for this device */
> +	snet_write32(snet, snet->psnet->cfg.msg_off, 0);
> +	/* Write magic number - data is ready */
> +	snet_write32(snet, snet->psnet->cfg.host_cfg_off, SNET_SIGNATURE);
> +
> +	/* The DPU will ACK the config by clearing the signature */
> +	ret = readx_poll_timeout(ioread32, snet->bar + snet->psnet->cfg.host_cfg_off,
> +				 tmp, !tmp, 10, SNET_READ_CFG_TIMEOUT);
> +	if (ret) {
> +		SNET_ERR(snet->pdev, "Timeout waiting for the DPU to read the config\n");
> +		return false;
> +	}
> +
> +	/* set DPU flag */
> +	snet->dpu_ready = true;
> +
> +	return true;
> +}
> +
> +static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
> +{
> +	int ret, i, irq;
> +
> +	/* Request config IRQ */
> +	irq = pci_irq_vector(pdev, snet->cfg_irq_idx);
> +	ret = devm_request_irq(&pdev->dev, irq, snet_cfg_irq_hndlr, 0,
> +			       snet->cfg_irq_name, snet);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to request IRQ\n");
> +		return ret;
> +	}
> +	snet->cfg_irq = irq;
> +
> +	/* Request IRQ for every VQ */
> +	for (i = 0; i < snet->cfg->vq_num; i++) {
> +		irq = pci_irq_vector(pdev, snet->vqs[i]->irq_idx);
> +		ret = devm_request_irq(&pdev->dev, irq, snet_vq_irq_hndlr, 0,
> +				       snet->vqs[i]->irq_name, snet->vqs[i]);
> +		if (ret) {
> +			SNET_ERR(pdev, "Failed to request IRQ\n");
> +			return ret;
> +		}
> +		snet->vqs[i]->irq = irq;
> +	}
> +	return 0;
> +}
> +
> +static void snet_set_status(struct vdpa_device *vdev, u8 status)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	struct psnet *psnet = snet->psnet;
> +	struct pci_dev *pdev = snet->pdev;
> +	int ret;
> +	bool pf_irqs;
> +
> +	if (status == snet->status)
> +		return;
> +
> +	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +	    !(snet->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		/* Request IRQs */
> +		pf_irqs = PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF);
> +		ret = snet_request_irqs(pf_irqs ? pdev->physfn : pdev, snet);
> +		if (ret)
> +			goto set_err;
> +
> +		/* Write config to the DPU */
> +		if (snet_write_conf(snet)) {
> +			SNET_INFO(pdev, "Create SNET[%u] device\n", snet->sid);
> +		} else {
> +			snet_free_irqs(snet);
> +			goto set_err;
> +		}
> +	}
> +
> +	/* Save the new status */
> +	snet->status = status;
> +	return;
> +
> +set_err:
> +	snet->status |= VIRTIO_CONFIG_S_FAILED;
> +}
> +
> +static void snet_get_config(struct vdpa_device *vdev, unsigned int offset,
> +			    void *buf, unsigned int len)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	void __iomem *cfg_ptr = snet->cfg->virtio_cfg + offset;
> +	u8 *buf_ptr = buf;
> +	u32 i;
> +
> +	/* check for offset error */
> +	if (offset + len > snet->cfg->cfg_size)
> +		return;
> +
> +	/* Write into buffer */
> +	for (i = 0; i < len; i++)
> +		*buf_ptr++ = ioread8(cfg_ptr + i);
> +}
> +
> +static void snet_set_config(struct vdpa_device *vdev, unsigned int offset,
> +			    const void *buf, unsigned int len)
> +{
> +	struct snet *snet = vdpa_to_snet(vdev);
> +	void __iomem *cfg_ptr = snet->cfg->virtio_cfg + offset;
> +	const u8 *buf_ptr = buf;
> +	u32 i;
> +
> +	/* check for offset error */
> +	if (offset + len > snet->cfg->cfg_size)
> +		return;
> +
> +	/* Write into PCI BAR */
> +	for (i = 0; i < len; i++)
> +		iowrite8(*buf_ptr++, cfg_ptr + i);
> +}
> +
> +static const struct vdpa_config_ops snet_config_ops = {
> +	.set_vq_address         = snet_set_vq_address,
> +	.set_vq_num             = snet_set_vq_num,
> +	.kick_vq                = snet_kick_vq,
> +	.set_vq_cb              = snet_set_vq_cb,
> +	.set_vq_ready           = snet_set_vq_ready,
> +	.get_vq_ready           = snet_get_vq_ready,
> +	.set_vq_state           = snet_set_vq_state,
> +	.get_vq_state           = snet_get_vq_state,
> +	.get_vq_irq		= snet_get_vq_irq,
> +	.get_vq_align           = snet_get_vq_align,
> +	.reset                  = snet_reset,
> +	.get_config_size        = snet_get_config_size,
> +	.get_device_features    = snet_get_features,
> +	.set_driver_features    = snet_set_drv_features,
> +	.get_driver_features    = snet_get_drv_features,
> +	.get_vq_num_min         = snet_get_vq_num_max,
> +	.get_vq_num_max         = snet_get_vq_num_max,
> +	.set_config_cb          = snet_set_config_cb,
> +	.get_device_id          = snet_get_device_id,
> +	.get_vendor_id          = snet_get_vendor_id,
> +	.get_status             = snet_get_status,
> +	.set_status             = snet_set_status,
> +	.get_config             = snet_get_config,
> +	.set_config             = snet_set_config,
> +};
> +
> +static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
> +{
> +	char name[25];
> +	int ret, i, mask = 0;
> +	/* We don't know which BAR will be used to communicate..
> +	 * We will map every bar with len > 0.
> +	 *
> +	 * Later, we will discover the BAR and unmap all other BARs.
> +	 */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i))
> +			mask |= (1 << i);
> +	}
> +
> +	/* No BAR can be used.. */
> +	if (!mask) {
> +		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
> +	ret = pcim_iomap_regions(pdev, mask, name);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (mask & (1 << i))
> +			psnet->bars[i] = pcim_iomap_table(pdev)[i];
> +	}
> +
> +	return 0;
> +}
> +
> +static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
> +{
> +	char name[20];
> +	int ret;
> +
> +	snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
> +	/* Request and map BAR */
> +	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
> +		return ret;
> +	}
> +
> +	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
> +
> +	return 0;
> +}
> +
> +static void snet_free_cfg(struct snet_cfg *cfg)
> +{
> +	u32 i;
> +
> +	if (!cfg->devs)
> +		return;
> +
> +	/* Free devices */
> +	for (i = 0; i < cfg->devices_num; i++) {
> +		if (!cfg->devs[i])
> +			break;
> +
> +		kfree(cfg->devs[i]);
> +	}
> +	/* Free pointers to devices */
> +	kfree(cfg->devs);
> +}
> +
> +/* Detect which BAR is used for communication with the device. */
> +static int psnet_detect_bar(struct psnet *psnet, u32 off)
> +{
> +	unsigned long exit_time;
> +	int i;
> +
> +	exit_time = jiffies + usecs_to_jiffies(SNET_DETECT_TIMEOUT);
> +
> +	/* SNET DPU will write SNET's signature when the config is ready. */
> +	while (time_before(jiffies, exit_time)) {
> +		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +			/* Is this BAR mapped? */
> +			if (!psnet->bars[i])
> +				continue;
> +
> +			if (ioread32(psnet->bars[i] + off) == SNET_SIGNATURE)
> +				return i;
> +		}
> +		schedule();
> +	}
> +

Wow, a 5-second hot loop. Not my responsibility to accept or reject this
part of the code, but personally I think this is completely unaccceptable.

> +	return -ENODEV;
> +}
> +
> +static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
> +{
> +	int i, mask = 0;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (psnet->bars[i] && (i != psnet->barno))
> +			mask |= (1 << i);
> +	}
> +
> +	if (mask)
> +		pcim_iounmap_regions(pdev, mask);
> +}
> +
> +/* Read SNET config from PCI BAR */
> +static int psnet_read_cfg(struct pci_dev *pdev, struct psnet *psnet)
> +{
> +	struct snet_cfg *cfg = &psnet->cfg;
> +	u32 i, off;
> +	int barno;
> +
> +	/* Move to where the config starts */
> +	off = SNET_CONFIG_OFF;
> +
> +	/* Find BAR used for communication */
> +	barno = psnet_detect_bar(psnet, off);
> +	if (barno < 0) {
> +		SNET_ERR(pdev, "SNET config is not ready.\n");
> +		return barno;
> +	}
> +
> +	/* Save used BAR number and unmap all other BARs */
> +	psnet->barno = barno;
> +	SNET_DBG(pdev, "Using BAR number %d\n", barno);
> +
> +	psnet_unmap_unused_bars(pdev, psnet);
> +
> +	/* load config from BAR */
> +	cfg->key = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->cfg_size = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->cfg_ver = psnet_read32(psnet, off);
> +	off += 4;
> +	/* The negotiated config version is the lower one between this driver's config
> +	 * and the DPU's.
> +	 */
> +	psnet->negotiated_cfg_ver = min_t(u32, cfg->cfg_ver, SNET_CFG_VERSION);
> +	SNET_DBG(pdev, "SNET config version %u\n", psnet->negotiated_cfg_ver);
> +
> +	cfg->vf_num = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->vf_bar = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->host_cfg_off = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->max_size_host_cfg = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->virtio_cfg_off = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->kick_off = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->hwmon_off = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->msg_off = psnet_read32(psnet, off);
> +	off += 4;
> +	cfg->flags = psnet_read32(psnet, off);
> +	off += 4;
> +	/* Ignore Reserved */
> +	off += sizeof(cfg->rsvd);
> +
> +	cfg->devices_num = psnet_read32(psnet, off);
> +	off += 4;
> +	/* Allocate memory to hold pointer to the devices */
> +	cfg->devs = kcalloc(cfg->devices_num, sizeof(void *), GFP_KERNEL);
> +	if (!cfg->devs) {
> +		SNET_ERR(pdev, "Failed to allocate memory for SNET config\n");

Memory allocation failures are not commonly logged since the low level code
already does that.

> +		return -ENOMEM;
> +	}
> +
> +	/* Load device configuration from BAR */
> +	for (i = 0; i < cfg->devices_num; i++) {
> +		cfg->devs[i] = kzalloc(sizeof(struct snet_dev_cfg), GFP_KERNEL);
> +		if (!cfg->devs[i]) {
> +			SNET_ERR(pdev, "Failed to allocate memory for SNET config\n");
> +			snet_free_cfg(cfg);
> +			return -ENOMEM;
> +		}
> +		/* Read device config */
> +		cfg->devs[i]->virtio_id = psnet_read32(psnet, off);
> +		off += 4;
> +		cfg->devs[i]->vq_num = psnet_read32(psnet, off);
> +		off += 4;
> +		cfg->devs[i]->vq_size = psnet_read32(psnet, off);
> +		off += 4;
> +		cfg->devs[i]->vfid = psnet_read32(psnet, off);
> +		off += 4;
> +		cfg->devs[i]->features = psnet_read64(psnet, off);
> +		off += 8;
> +		/* Ignore Reserved */
> +		off += sizeof(cfg->devs[i]->rsvd);
> +
> +		cfg->devs[i]->cfg_size = psnet_read32(psnet, off);
> +		off += 4;
> +
> +		/* Is the config witten to the DPU going to be too big? */
> +		if (SNET_GENERAL_CFG_LEN + SNET_GENERAL_CFG_VQ_LEN * cfg->devs[i]->vq_num >
> +		    cfg->max_size_host_cfg) {
> +			SNET_ERR(pdev, "Failed to read SNET config, the config is too big..\n");
> +			snet_free_cfg(cfg);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int psnet_alloc_irq_vector(struct pci_dev *pdev, struct psnet *psnet)
> +{
> +	int ret = 0;
> +	u32 i, irq_num = 0;
> +
> +	/* Let's count how many IRQs we need, 1 for every VQ + 1 for config change */
> +	for (i = 0; i < psnet->cfg.devices_num; i++)
> +		irq_num += psnet->cfg.devs[i]->vq_num + 1;
> +
> +	ret = pci_alloc_irq_vectors(pdev, irq_num, irq_num, PCI_IRQ_MSIX);
> +	if (ret != irq_num) {
> +		SNET_ERR(pdev, "Failed to allocate IRQ vectors\n");
> +		return ret;
> +	}
> +	SNET_DBG(pdev, "Allocated %u IRQ vectors from physical function\n", irq_num);
> +
> +	return 0;
> +}
> +
> +static int snet_alloc_irq_vector(struct pci_dev *pdev, struct snet_dev_cfg *snet_cfg)
> +{
> +	int ret = 0;
> +	u32 irq_num;
> +
> +	/* We want 1 IRQ for every VQ + 1 for config change events */
> +	irq_num = snet_cfg->vq_num + 1;
> +
> +	ret = pci_alloc_irq_vectors(pdev, irq_num, irq_num, PCI_IRQ_MSIX);
> +	if (ret <= 0) {
> +		SNET_ERR(pdev, "Failed to allocate IRQ vectors\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void snet_free_vqs(struct snet *snet)
> +{
> +	u32 i;
> +
> +	if (!snet->vqs)
> +		return;
> +
> +	for (i = 0 ; i < snet->cfg->vq_num ; i++) {
> +		if (!snet->vqs[i])
> +			break;
> +
> +		kfree(snet->vqs[i]);
> +	}
> +	kfree(snet->vqs);
> +}
> +
> +static int snet_build_vqs(struct pci_dev *pdev, struct snet *snet)
> +{
> +	u32 i;
> +	/* Allocate the VQ pointers array */
> +	snet->vqs = kcalloc(snet->cfg->vq_num, sizeof(void *), GFP_KERNEL);
> +	if (!snet->vqs) {
> +		SNET_ERR(pdev, "Failed to allocate memory for SNET VQs\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate the VQs */
> +	for (i = 0; i < snet->cfg->vq_num; i++) {
> +		snet->vqs[i] = kzalloc(sizeof(struct snet_vq), GFP_KERNEL);
> +		if (!snet->vqs[i]) {
> +			SNET_ERR(pdev, "Failed to allocate memory for a SNET VQ\n");
> +			snet_free_vqs(snet);
> +			return -ENOMEM;
> +		}
> +		/* Reset IRQ num */
> +		snet->vqs[i]->irq = -1;
> +		/* VQ serial ID */
> +		snet->vqs[i]->sid = i;
> +		/* Kick address - every VQ gets 4B */
> +		snet->vqs[i]->kick_ptr = snet->bar + snet->psnet->cfg.kick_off +
> +					 snet->vqs[i]->sid * 4;
> +		/* Clear kick address for this VQ */
> +		iowrite32(0, snet->vqs[i]->kick_ptr);
> +	}
> +	return 0;
> +}
> +
> +static int psnet_get_next_irq_num(struct psnet *psnet)
> +{
> +	int irq;
> +
> +	spin_lock(&psnet->lock);
> +	irq = psnet->next_irq++;
> +	spin_unlock(&psnet->lock);
> +
> +	return irq;
> +}
> +
> +static void snet_reserve_irq_idx(struct pci_dev *pdev, struct snet *snet)
> +{
> +	struct psnet *psnet = snet->psnet;
> +	int  i;
> +
> +	/* one IRQ for every VQ, and one for config changes */
> +	snet->cfg_irq_idx = psnet_get_next_irq_num(psnet);
> +	snprintf(snet->cfg_irq_name, SNET_NAME_SIZE, "snet[%s]-cfg[%d]",
> +		 pci_name(pdev), snet->cfg_irq_idx);
> +
> +	for (i = 0; i < snet->cfg->vq_num; i++) {
> +		/* Get next free IRQ ID */
> +		snet->vqs[i]->irq_idx = psnet_get_next_irq_num(psnet);
> +		/* Write IRQ name */
> +		snprintf(snet->vqs[i]->irq_name, SNET_NAME_SIZE, "snet[%s]-vq[%d]",
> +			 pci_name(pdev), snet->vqs[i]->irq_idx);
> +	}
> +}
> +
> +/* Find a device config based on virtual function id */
> +static struct snet_dev_cfg *snet_find_dev_cfg(struct snet_cfg *cfg, u32 vfid)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < cfg->devices_num; i++) {
> +		if (cfg->devs[i]->vfid == vfid)
> +			return cfg->devs[i];
> +	}
> +	/* Oppss.. no config found.. */
> +	return NULL;
> +}
> +
> +/* Probe function for a physical PCI function */
> +static int snet_vdpa_probe_pf(struct pci_dev *pdev)
> +{
> +	struct psnet *psnet;
> +	int ret = 0;
> +	bool pf_irqs = false;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to enable PCI device\n");
> +		return ret;
> +	}
> +
> +	/* Allocate a PCI physical function device */
> +	psnet = kzalloc(sizeof(struct psnet), GFP_KERNEL);
> +	if (!psnet) {
> +		SNET_ERR(pdev, "Failed to allocate memory for PSNET device\n");
> +		return -ENOMEM;
> +	}
> +	/* Init PSNET spinlock */
> +	spin_lock_init(&psnet->lock);
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, psnet);
> +
> +	/* Open SNET MAIN BAR */
> +	ret = psnet_open_pf_bar(pdev, psnet);
> +	if (ret)
> +		goto free_psnet;
> +
> +	/* Try to read SNET's config from PCI BAR */
> +	ret = psnet_read_cfg(pdev, psnet);
> +	if (ret)
> +		goto free_psnet;
> +
> +	/* If SNET_CFG_FLAG_IRQ_PF flag is set, we should use
> +	 * PF MSI-X vectors
> +	 */
> +	pf_irqs = PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF);
> +
> +	if (pf_irqs) {
> +		ret = psnet_alloc_irq_vector(pdev, psnet);
> +		if (ret)
> +			goto free_cfg;
> +	}
> +
> +	SNET_DBG(pdev, "Enable %u virtual functions\n", psnet->cfg.vf_num);
> +	ret = pci_enable_sriov(pdev, psnet->cfg.vf_num);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to enable SR-IOV\n");
> +		goto free_irq;
> +	}
> +
> +	/* Create HW monitor device */
> +	if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_HWMON))
> +		psnet_create_hwmon(pdev);
> +
> +	return 0;
> +
> +free_irq:
> +	if (pf_irqs)
> +		pci_free_irq_vectors(pdev);
> +free_cfg:
> +	snet_free_cfg(&psnet->cfg);
> +free_psnet:
> +	kfree(psnet);
> +	return ret;
> +}
> +
> +/* Probe function for a virtual PCI function */
> +static int snet_vdpa_probe_vf(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pdev_pf = pdev->physfn;
> +	struct psnet *psnet = pci_get_drvdata(pdev_pf);
> +	struct snet_dev_cfg *dev_cfg;
> +	struct snet *snet;
> +	u32 vfid;
> +	int ret;
> +	bool pf_irqs = false;
> +
> +	/* Get virtual function id.
> +	 * (the DPU counts the VFs from 1)
> +	 */
> +	ret = pci_iov_vf_id(pdev);
> +	if (ret < 0) {
> +		SNET_ERR(pdev, "Failed to find a VF id\n");
> +		return ret;
> +	}
> +	vfid = ret + 1;
> +
> +	/* Find the snet_dev_cfg based on vfid */
> +	dev_cfg = snet_find_dev_cfg(&psnet->cfg, vfid);
> +	if (!dev_cfg) {
> +		SNET_WARN(pdev, "Failed to find a VF config..\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Which PCI device should allocate the IRQs?
> +	 * If the SNET_CFG_FLAG_IRQ_PF flag set, the PF device allocates the IRQs
> +	 */
> +	pf_irqs = PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to enable PCI VF device\n");
> +		return ret;
> +	}
> +
> +	/* Request for MSI-X IRQs */
> +	if (!pf_irqs) {
> +		ret = snet_alloc_irq_vector(pdev, dev_cfg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Allocate vdpa device */
> +	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
> +				 false);
> +	if (!snet) {
> +		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
> +		ret = -ENOMEM;
> +		goto free_irqs;
> +	}
> +
> +	/* Save pci device pointer */
> +	snet->pdev = pdev;
> +	snet->psnet = psnet;
> +	snet->cfg = dev_cfg;
> +	snet->dpu_ready = false;
> +	snet->sid = vfid;
> +	/* Reset IRQ value */
> +	snet->cfg_irq = -1;
> +
> +	ret = snet_open_vf_bar(pdev, snet);
> +	if (ret)
> +		goto put_device;
> +
> +	/* Create a VirtIO config pointer */
> +	snet->cfg->virtio_cfg = snet->bar + snet->psnet->cfg.virtio_cfg_off;
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, snet);
> +
> +	ret = snet_build_vqs(pdev, snet);
> +	if (ret)
> +		goto put_device;
> +
> +	/* Reserve IRQ indexes,
> +	 * The IRQs may be requested and freed multiple times,
> +	 * but the indexes won't change.
> +	 */
> +	snet_reserve_irq_idx(pf_irqs ? pdev_pf : pdev, snet);
> +
> +	/*set DMA device*/
> +	snet->vdpa.dma_dev = &pdev->dev;
> +
> +	/* Register VDPA device */
> +	ret = vdpa_register_device(&snet->vdpa, snet->cfg->vq_num);
> +	if (ret) {
> +		SNET_ERR(pdev, "Failed to register vdpa device\n");
> +		goto free_vqs;
> +	}
> +
> +	return 0;
> +
> +free_vqs:
> +	snet_free_vqs(snet);
> +put_device:
> +	put_device(&snet->vdpa.dev);
> +free_irqs:
> +	if (!pf_irqs)
> +		pci_free_irq_vectors(pdev);
> +	return ret;
> +}
> +
> +static int snet_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	if (pdev->is_virtfn)
> +		return snet_vdpa_probe_vf(pdev);
> +	else
> +		return snet_vdpa_probe_pf(pdev);
> +}
> +
> +static void snet_vdpa_remove_pf(struct pci_dev *pdev)
> +{
> +	struct psnet *psnet = pci_get_drvdata(pdev);
> +
> +	pci_disable_sriov(pdev);
> +	/* If IRQs are allocated from the PF, we should free the IRQs */
> +	if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF))
> +		pci_free_irq_vectors(pdev);
> +
> +	snet_free_cfg(&psnet->cfg);
> +	kfree(psnet);
> +}
> +
> +static void snet_vdpa_remove_vf(struct pci_dev *pdev)
> +{
> +	struct snet *snet = pci_get_drvdata(pdev);
> +	struct psnet *psnet = snet->psnet;
> +
> +	/* If IRQs are allocated from the VF, we should free the IRQs */
> +	if (!PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF))
> +		pci_free_irq_vectors(pdev);
> +
> +	vdpa_unregister_device(&snet->vdpa);
> +	snet_free_vqs(snet);
> +}
> +
> +static void snet_vdpa_remove(struct pci_dev *pdev)
> +{
> +	if (pdev->is_virtfn)
> +		snet_vdpa_remove_vf(pdev);
> +	else
> +		snet_vdpa_remove_pf(pdev);
> +}
> +
> +static struct pci_device_id snet_driver_pci_ids[] = {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_SOLIDRUN, SNET_DEVICE_ID,
> +			 PCI_VENDOR_ID_SOLIDRUN, SNET_DEVICE_ID) },
> +	{ 0 },
> +};
> +
> +MODULE_DEVICE_TABLE(pci, snet_driver_pci_ids);
> +
> +static struct pci_driver snet_vdpa_driver = {
> +	.name		= "snet-vdpa-driver",
> +	.id_table	= snet_driver_pci_ids,
> +	.probe		= snet_vdpa_probe,
> +	.remove		= snet_vdpa_remove,
> +};
> +
> +module_pci_driver(snet_vdpa_driver);
> +
> +MODULE_AUTHOR("Alvaro Karsz <alvaro.karsz@solid-run.com>");
> +MODULE_DESCRIPTION("SolidRun vDPA driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
> new file mode 100644
> index 00000000000..8ac15acf1ae
> --- /dev/null
> +++ b/drivers/vdpa/solidrun/snet_vdpa.h
> @@ -0,0 +1,192 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SolidRun DPU driver for control plane
> + *
> + * Copyright (C) 2022 SolidRun
> + *
> + * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
> + *
> + */
> +#ifndef _SNET_VDPA_H_
> +#define _SNET_VDPA_H_
> +
> +#include <linux/vdpa.h>
> +#include <linux/pci.h>
> +
> +#define SNET_NAME_SIZE 256
> +
> +#define SNET_ERR(pdev, fmt, ...) dev_err(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
> +#define SNET_WARN(pdev, fmt, ...) dev_warn(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
> +#define SNET_INFO(pdev, fmt, ...) dev_info(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
> +#define SNET_DBG(pdev, fmt, ...) dev_dbg(&pdev->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
> +#define SNET_HAS_FEATURE(s, f) ((s)->negotiated_features & BIT_ULL(f))
> +/* VQ struct */
> +struct snet_vq {
> +	/* VQ callback */
> +	struct vdpa_callback cb;
> +	/* desc base address */
> +	u64 desc_area;
> +	/* device base address */
> +	u64 device_area;
> +	/* driver base address */
> +	u64 driver_area;
> +	/* Queue size */
> +	u32 num;
> +	/* Serial ID for VQ */
> +	u32 sid;
> +	/* is ready flag */
> +	bool ready;
> +	/* IRQ number */
> +	u32 irq;
> +	/* IRQ index, DPU uses this to parse data from MSI-X table */
> +	u32 irq_idx;
> +	/* IRQ name */
> +	char irq_name[SNET_NAME_SIZE];
> +	/* pointer to mapped PCI BAR register used by this VQ to kick */
> +	void __iomem *kick_ptr;
> +};
> +
> +struct snet {
> +	/* vdpa device */
> +	struct vdpa_device vdpa;
> +	/* Config callback */
> +	struct vdpa_callback cb;
> +	/* array of virqueues */
> +	struct snet_vq **vqs;
> +	/* Used features */
> +	u64 negotiated_features;
> +	/* Device serial ID */
> +	u32 sid;
> +	/* device status */
> +	u8 status;
> +	/* boolean indicating if snet config was passed to the device */
> +	bool dpu_ready;
> +	/* IRQ number */
> +	u32 cfg_irq;
> +	/* IRQ index, DPU uses this to parse data from MSI-X table */
> +	u32 cfg_irq_idx;
> +	/* IRQ name */
> +	char cfg_irq_name[SNET_NAME_SIZE];
> +	/* BAR to access the VF */
> +	void __iomem *bar;
> +	/* PCI device */
> +	struct pci_dev *pdev;
> +	/* Pointer to snet pdev parent device */
> +	struct psnet *psnet;
> +	/* Pointer to snet config device */
> +	struct snet_dev_cfg *cfg;
> +};
> +
> +struct snet_dev_cfg {
> +	/* Device ID following VirtIO spec. */
> +	u32 virtio_id;
> +	/* Number of VQs for this device */
> +	u32 vq_num;
> +	/* Size of every VQ */
> +	u32 vq_size;
> +	/* Virtual Function id */
> +	u32 vfid;
> +	/* Device features, following VirtIO spec */
> +	u64 features;
> +	/* Reserved for future usage */
> +	u32 rsvd[6];
> +	/* VirtIO device specific config size */
> +	u32 cfg_size;
> +	/* VirtIO device specific config address */
> +	void __iomem *virtio_cfg;
> +} __packed;
> +
> +struct snet_cfg {
> +	/* Magic key */
> +	u32 key;
> +	/* Size of total config in bytes */
> +	u32 cfg_size;
> +	/* Config version */
> +	u32 cfg_ver;
> +	/* Number of Virtual Functions to create */
> +	u32 vf_num;
> +	/* BAR to use for the VFs */
> +	u32 vf_bar;
> +	/* Where should we write the SNET's config */
> +	u32 host_cfg_off;
> +	/* Max. allowed size for a SNET's config */
> +	u32 max_size_host_cfg;
> +	/* VirtIO config offset in BAR */
> +	u32 virtio_cfg_off;
> +	/* Offset in PCI BAR for VQ kicks */
> +	u32 kick_off;
> +	/* Offset in PCI BAR for HW monitoring */
> +	u32 hwmon_off;
> +	/* Offset in PCI BAR for SNET messages */
> +	u32 msg_off;
> +	/* Config general flags - enum snet_cfg_flags */
> +	u32 flags;
> +	/* Reserved for future usage */
> +	u32 rsvd[6];
> +	/* Number of snet devices */
> +	u32 devices_num;
> +	/* The actual devices */
> +	struct snet_dev_cfg **devs;
> +} __packed;
> +
> +/* SolidNET PCIe device, one device per PCIe physical function */
> +struct psnet {
> +	/* PCI BARs */
> +	void __iomem *bars[PCI_STD_NUM_BARS];
> +	/* Negotiated config version */
> +	u32 negotiated_cfg_ver;
> +	/* Next IRQ index to use in case when the IRQs are allocated from this device */
> +	u32 next_irq;
> +	/* BAR number used to communicate with the device */
> +	u8 barno;
> +	/* spinlock to protect data that can be changed by SNET devices */
> +	spinlock_t lock;
> +	/* Pointer to the device's config read from BAR */
> +	struct snet_cfg cfg;
> +	/* Name of monitor device */
> +	char hwmon_name[SNET_NAME_SIZE];
> +};
> +
> +enum snet_cfg_flags {
> +	/* Create a HWMON device */
> +	SNET_CFG_FLAG_HWMON = BIT(0),
> +	/* USE IRQs from the physical function */
> +	SNET_CFG_FLAG_IRQ_PF = BIT(1),
> +};
> +
> +#define PSNET_FLAG_ON(p, f)	((p)->cfg.flags & (f))
> +
> +static inline u32 psnet_read32(struct psnet *psnet, u32 off)
> +{
> +	return ioread32(psnet->bars[psnet->barno] + off);
> +}
> +
> +static inline u32 snet_read32(struct snet *snet, u32 off)
> +{
> +	return ioread32(snet->bar + off);
> +}
> +
> +static inline void snet_write32(struct snet *snet, u32 off, u32 val)
> +{
> +	iowrite32(val, snet->bar + off);
> +}
> +
> +static inline u64 psnet_read64(struct psnet *psnet, u32 off)
> +{
> +	u64 val;
> +	/* 64bits are written in 2 halves, low part first */
> +	val = (u64)psnet_read32(psnet, off);
> +	val |= ((u64)psnet_read32(psnet, off + 4) << 32);
> +	return val;
> +}
> +
> +static inline void snet_write64(struct snet *snet, u32 off, u64 val)
> +{
> +	/* The DPU expects a 64bit integer in 2 halves, the low part first */
> +	snet_write32(snet, off, (u32)val);
> +	snet_write32(snet, off + 4, (u32)(val >> 32));
> +}
> +
> +void psnet_create_hwmon(struct pci_dev *pdev);
> +
> +#endif //_SNET_VDPA_H_

