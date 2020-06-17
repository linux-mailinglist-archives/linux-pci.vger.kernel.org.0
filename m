Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6571FCA40
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgFQJzj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Jun 2020 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgFQJzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 05:55:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76070C06174E
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 02:55:37 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUn0-0003fS-7d; Wed, 17 Jun 2020 11:55:26 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUmx-0004Mo-Be; Wed, 17 Jun 2020 11:55:23 +0200
Message-ID: <babff895a0b5e2cd63082bd38f087bd1bc345671.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Date:   Wed, 17 Jun 2020 11:55:23 +0200
In-Reply-To: <20200612171334.26385-2-nsaenzjulienne@suse.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> The firmware running on the RPi VideoCore can be used to reset and
> initialize HW controlled by the firmware.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> ---
> Changes since v2:
>  - Add include file for reset IDs
> 
> Changes since v1:
>  - Correct cells binding as per Florian's comment
>  - Change compatible string to be more generic
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
>  .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> index b48ed875eb8e..23a885af3a28 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> @@ -39,6 +39,22 @@ properties:
>        - compatible
>        - "#clock-cells"
>  
> +  reset:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: raspberrypi,firmware-reset
> +
> +      "#reset-cells":
> +        const: 1
> +        description: >
> +          The argument is the ID of the firmware reset line to affect.
> +
> +    required:
> +      - compatible
> +      - "#reset-cells"
> +
>      additionalProperties: false
>  
>  required:
> @@ -55,5 +71,10 @@ examples:
>              compatible = "raspberrypi,firmware-clocks";
>              #clock-cells = <1>;
>          };
> +
> +        reset: reset {
> +            compatible = "raspberrypi,firmware-reset";
> +            #reset-cells = <1>;
> +        };
>      };
>  ...
> diff --git a/include/dt-bindings/reset/raspberrypi,firmware-reset.h b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
> new file mode 100644
> index 000000000000..1a4f4c792723
> --- /dev/null
> +++ b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Nicolas Saenz Julienne
> + * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
> +#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
> +
> +#define RASPBERRYPI_FIRMWARE_RESET_ID_USB	0
> +#define RASPBERRYPI_FIRMWARE_RESET_NUM_IDS	1
> +
> +#endif

Are there going to be any more firmware controlled resets in the future?

regards
Philipp
