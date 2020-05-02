Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB261C243E
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBJFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 May 2020 05:05:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:42917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgEBJFd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 May 2020 05:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588410317;
        bh=q9VJyCnFY+/O21OZN8bVN/A8qThXFaSA5sJxzEm7oeI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aOeUD+aQCk+gcQCM0GFQzBa2oFcpCZ53QkQTN8ymUeAZs7Ta8AA9ipfjC3JgdZ1m6
         pD1HN+VirGZ0LJu3LZBWBuFho1Du5QaZKH6qmnbBq8u3vpBEfSFn2uZdyT30LQvbkz
         hTCyiifr4mojlhBisLlV1YyN9bmidcbuYbiBPatI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.164] ([37.4.249.134]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1j6lrZ1K6y-016NEe; Sat, 02
 May 2020 11:05:17 +0200
Subject: Re: [PATCH v7 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
 <20200429164734.21506-3-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <5fce05ca-5d7e-f4cc-be34-0764fbe4edff@gmx.net>
Date:   Sat, 2 May 2020 11:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429164734.21506-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:QA/aSLOy+cPlvO18nEM/MicqwS747XxEXAG4GyaaHnDfSZ4Tmtk
 PVcVoCLuH1g/fLaI+QAorJKQs+/yGXo+BeCehPvf79n+ALJv+1n29kftcUmC+bOBBRFLf4i
 k02zj8VEOarH08P1FI3V2bmFG/JFF5fmLFDaU8+/SbVGitbryg1gRaOHJMtECq7XfKPBArS
 gUzl/xGwaNB1He1/zQu7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b27J4oTjFnA=:k0TtacXgZeH36zxXHNZPGs
 TleOnzvFCN3iCKhE2i8sdtvI0FiBx7Ia22XXttoaCtWN/1Gkahl9vsihmfNcUB45kGutY+pwR
 U8m3n7Npx8ETCstRraHr452FmRE/cTA544O4lFbOLwRh9uq0dxn0ODXcuQamYaBFiuoOGm8M7
 0z0qNoYZ0rJXI5Oe4IxV/MBZprac9xoBUg8NZP7vyBvnLv9LI/nSciaKBkrkUS4df5rlAN/M1
 Enxo4EcMht9ADR+IIRiRkd+HXy0wSv/PHgIkligGrZ9GGUn+hnl2zDUJpnqE1sM6fvI5X/dH5
 Xy+O8bzZ1S2MsT4zPZSWxuUNBBjVVLFJqdQKKgiwpBTA5qClEIle6M0vo3L+zjzdbTK6QJZBb
 Ya9YMU0R+Rp0GTkzvBEIiBXjOGcyENNjZGWnBYsgKpFS14W73bwH18mpEYBA4XwJZybxjfZJz
 fnC84yulfUOs+Ra/MUxFRmqikbRaAeLu89bYbQ1UmJZwf/jMgHsJCzxmcncaPilUgPPWbLwCO
 4fhVZRilboJG5bfI7DxWmB35Oex2rWunLO44NBv5XUyeYkYp6lxhZofN8Toitkc5kIuxhRUY1
 RLkFRmIn1PKTWDpWrLIvrFomus7meNiOimZDH6cBFUaX8lRHBTmO6Ulkaev81vwkLoAkN7Juh
 0APXUwRoRLhutGvBLqpib7CBi3/MvJ1MFV+9cUlnPJo6LDCzfDhCdu9t5tPcdpFateIPQd0Py
 HiFNQUbT5dZLsxPwjDF8E0V89mIKapPo+/5fxylHUmdWC3Y0xprurkLDmeANxnJZeCIPAHai2
 +1WDW0nB2Xi3HqSsnhuY49d6uooNq26ESuvXq4pnvdQv/PYyjfPNlQziar6aimF7+QnLcUVkb
 O/R+FVKHDeNWrsOUwhKWaFaIalEFpPi3U83jq0hPkFlge7klg+jT3KeFkymVz/YCTxonFJ1dY
 PjBg16uj7KyjNtnE0V15kkCWeG35yvJ9KlnpOgXzdadmLCobmE5OB1kYQXqFu+1Y5xVaIlOPQ
 oBGYe9QKDjxi+4THEGbXS3RU2tor7kF9mSBSilaf2eu51RXOWFpbqfvvgMDXKmaaoi/GGo1Xj
 7auD/5AJsg9J5jNSAi/Yw4IOJrvry4rUcTcRRTcRIBO2Frjddgf+URmRbujAyONrjQhIJm6Qb
 vY1CWwCCVlmK2lzp/GgQehtfdcjN8dV5M9yIY4IESn177MuWft5ImhNkg0UPeTde5cFkiT/b5
 4/a1ovijJfdmtRj8l
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

Am 29.04.20 um 18:47 schrieb Nicolas Saenz Julienne:
> The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
> that implements xHCI. After a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> co-processor, VideoCore. RPi4's VideoCore OS contains both the non publi=
c
> firmware load logic and the VL805 firmware blob. The function this patch
> introduces triggers the aforementioned process.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Change since v6:
> - Add test to avoid loading the firmware when not needed
> - Since we have it around, print VL805's firmware version, it'll make
> debugging easier in the future
> - Correct typos
> - Add a clearer view of HW topology in patch description
>
> Changes since v4:
> - Inline function definition when RASPBERRYPI_FIRMWARE is not defined
>
> Changes since v1:
> - Move include into .c file and add forward declaration to .h
>
>  drivers/firmware/raspberrypi.c             | 52 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  7 +++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberry=
pi.c
> index da26a584dca0..230c05e53403 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -12,6 +12,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
>  #include <soc/bcm2835/raspberrypi-firmware.h>
>
>  #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> @@ -19,6 +21,8 @@
>  #define MBOX_DATA28(msg)		((msg) & ~0xf)
>  #define MBOX_CHAN_PROPERTY		8
>
> +#define VL805_PCI_CONFIG_VERSION_OFFSET		0x50
> +
>  static struct platform_device *rpi_hwmon;
>  static struct platform_device *rpi_clk;
>
> @@ -286,6 +290,54 @@ struct rpi_firmware *rpi_firmware_get(struct device=
_node *firmware_node)
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_get);
>
> +/*
> + * The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chi=
p that
> + * implements xHCI. After a PCI reset, VL805's firmware may either be l=
oaded
> + * directly from an EEPROM or, if not present, by the SoC's co-processo=
r,
> + * VideoCore. RPi4's VideoCore OS contains both the non public firmware=
 load
> + * logic and the VL805 firmware blob. This function triggers the aforem=
entioned
> + * process.
> + */
> +int rpi_firmware_init_vl805(struct pci_dev *pdev)
> +{
> +	struct device_node *fw_np;
> +	struct rpi_firmware *fw;
> +	u32 dev_addr, version;
> +	int ret =3D 0;
> +
> +	fw_np =3D of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!fw_np)
> +		return 0;
> +
> +	fw =3D rpi_firmware_get(fw_np);
> +	of_node_put(fw_np);
> +	if (!fw)
> +		return -ENODEV;
> +
> +	/* Make sure we don't trigger a firmware load unnecesarely *
s/unnecesarely/unnecessarily/
> +	pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET, &version)=
;
pci_read_config_dword() can fail, we might want to store the return value?
> +	if (version)
> +		goto exit;
> +
> +	dev_addr =3D pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> +		   PCI_FUNC(pdev->devfn) << 12;
> +
> +	ret =3D rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> +				    &dev_addr, sizeof(dev_addr));
> +	/* Wait for vl805 to startup */
> +	udelay(200);

I know, it makes it harder to read but do we really want to wait
unnecessarily if rpi_firmware_property failed?

Btw i assume we are in non-atomic context, so maybe it's worth to use
usleep_range() here?

> +
> +exit:
> +	if (!version)
> +		pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET,
> +				      &version);
> +	pci_info(pdev, "VL805 firmware version %08x\n", version);

In case pci_read_config_dword() fails the return code would be more helpfu=
l.

Best regards

> +	return ret;
> +
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);
> +
>  static const struct of_device_id rpi_firmware_of_match[] =3D {
>  	{ .compatible =3D "raspberrypi,bcm2835-firmware", },
>  	{},
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bc=
m2835/raspberrypi-firmware.h
> index cc9cdbc66403..3025aca3c358 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -10,6 +10,7 @@
>  #include <linux/of_device.h>
>
>  struct rpi_firmware;
> +struct pci_dev;
>
>  enum rpi_firmware_property_status {
>  	RPI_FIRMWARE_STATUS_REQUEST =3D 0,
> @@ -141,6 +142,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
>  			       void *data, size_t tag_size);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node=
);
> +int rpi_firmware_init_vl805(struct pci_dev *pdev);
>  #else
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 ta=
g,
>  					void *data, size_t len)
> @@ -158,6 +160,11 @@ static inline struct rpi_firmware *rpi_firmware_get=
(struct device_node *firmware
>  {
>  	return NULL;
>  }
> +
> +static inline int rpi_firmware_init_vl805(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>  #endif
>
>  #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
