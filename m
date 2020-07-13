Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424C621DF89
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGMSYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 14:24:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37333 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGMSX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 14:23:59 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so14554187iob.4;
        Mon, 13 Jul 2020 11:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ifx3aALNuF7rKl8vX3SdTnNE70Q3qXp0lBlunsaf+O4=;
        b=VPOOTJhoLj5Cb150y6p1TwenBQzNfDKOJ5wyIUWq4XesRghFuTupXuNDC6XNt5OrZa
         Y2mvcXADpPiRngSgJJMkFr1gD3AYhLU7GsEGv8Yk1NjjGhs0PShMjaoA0yiZ9Vj3bHHI
         f0tHrDuUtWjy0YmU2DPTP72NHuzF2htDmG+Xv3vspo1FQn28gbZBbCsFlWFJA5UbdEE2
         tKMAaZp1qC+gDMfv2kJqggJI5H/WvroU6A/Pv1xt2X1IRwbyMxsjC6GDQho6qnrG8rCG
         jv+p0WXJsc5kYMuXSj/fBo3dLxk3e4kUc/sSHhG2fi9RMkU9le6t9UnLvXXhu1dm1mg7
         DJWA==
X-Gm-Message-State: AOAM531xcWgCijWFCMHSfaq2+gqfDJ4IR4U1yAwOsPTsPXK2TLW17jM4
        aFtGB5nmVKZljP8THAO4sQ==
X-Google-Smtp-Source: ABdhPJya3sqMPQiW2H/b993RNfsrgt3J2EBCVEUsT+0P5mubEbH1CLbcW6JdVEJ2qL9zNx+NokQEPw==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr1090199iop.14.1594664638827;
        Mon, 13 Jul 2020 11:23:58 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t1sm8159994iob.16.2020.07.13.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 11:23:58 -0700 (PDT)
Received: (nullmailer pid 493759 invoked by uid 1000);
        Mon, 13 Jul 2020 18:23:56 -0000
Date:   Mon, 13 Jul 2020 12:23:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
Message-ID: <20200713182356.GA413630@bogus>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
 <20200612171334.26385-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612171334.26385-2-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 12, 2020 at 07:13:25PM +0200, Nicolas Saenz Julienne wrote:
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

I'm not really thrilled how this is evolving with a node per provider. 
There's no reason you can't just add #clock-cells and #reset-cells to 
the parent firmware node.

I probably should have complained with the clocks node, but that's only 
pending for 5.9.

The bigger issue is this stuff is just trickling in one bit at a time 
which gives no context for review. What's next? Is it really a mystery 
as to what functions the firmware provides? You don't have to have a 
driver in place for every function.

Rob
