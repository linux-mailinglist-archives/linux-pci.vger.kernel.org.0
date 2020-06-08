Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7151F205F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgFHT6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgFHT6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 15:58:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314BC08C5C2;
        Mon,  8 Jun 2020 12:58:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so719393wme.3;
        Mon, 08 Jun 2020 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdQaIlY7CCtvVuS9ppbF0BzHnZFr+mv1ZVx/h1Baqkk=;
        b=i9lBX/+XoJVZ4smkO6RXjNuKvBeBSn7Jezy6IKlbX1vzVqHheo10kSfSIHx8hKrfNy
         al3momOoRbDC/qO/NExvm5ij8QaHZP+qxrY85+7iDCCflNQkQZg+GxGlU0OG/WBD6n9N
         hMHlAd3B4WPZe3FxPBwOX92MBq5DQVlV0YZ/wUQEhiPh6ghBqmUBROnYhApUugkxP8X7
         Nbgl6pWLBWOTMeVJs84+sXpXhkfmS7nbuXTKQSy0/27MxFqc39p3j8IXWS2PPuwwbNvu
         C5MHFDJuEuh83QQmyJvuGP0MmyJ0pfpoVzwlcCaG3coppPYlXTCyCvHHVK+Ll7zPJ++f
         kuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdQaIlY7CCtvVuS9ppbF0BzHnZFr+mv1ZVx/h1Baqkk=;
        b=RJuIWwvaaV+yj9bTH9gU8zkgVTiqgnuaQPNZgp/j9JNPmpYJ5hMRH1YLX9+5FsMDOx
         E+vBTS3abV6G+fZs4f1X6YE9MzN8jbe+AkbAmJWl+5gY7qpp/ahx5BhVYnvbrzujXO14
         aGrw131iqno0ybv33kwD4ie3dsCPSjmEK2Zjf97BCQzNwCKxjF2HyJnZWh037gWyRDrB
         miQx8B/YsYEhczC4SD65r/VVNv+yr1cg+ff8Ne8AHl8KskAIyo8OOHqa6uTDmPREXlok
         OJc0+J50+wB06fb0vVR4L1+Ot+HwmO4EvdwHmz5obDtpXGGH1wC9Nc0nFdR130eOOA7w
         ZIRw==
X-Gm-Message-State: AOAM5321CrGzQG5WXTMIevGvuB6ZUbJz/LYfZEDzdiukmTcRyNdSfSnW
        6AbCZ2t8wRt1IJeAR3yOx78=
X-Google-Smtp-Source: ABdhPJypEeqfejRUltyYbz5n5bW5+Ans7YR1WBmQV7ByI2tOOKYM8eGJckH5rGeMzXQrm13AkAWBIw==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr349108wmi.30.1591646295437;
        Mon, 08 Jun 2020 12:58:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id e10sm782956wrn.11.2020.06.08.12.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:58:14 -0700 (PDT)
Subject: Re: [PATCH 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware USB reset
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        Rob Herring <robh+dt@kernel.org>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
 <20200608192701.18355-2-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ffc9ec9e-bd1c-a8dd-8a68-a15bf95c919b@gmail.com>
Date:   Mon, 8 Jun 2020 12:58:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608192701.18355-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> The firmware running on the RPi VideoCore can be used to reset and
> initialize the board's xHCI controller. The reset controller is passed
> to the PCI device through the DT, hence this binding.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> index b48ed875eb8e..8f9d0986c28f 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> @@ -39,6 +39,22 @@ properties:
>        - compatible
>        - "#clock-cells"
>  
> +  usb-reset:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: raspberrypi,firmware-usb-reset

I would make this less USB centric, even if this is the only consumer of
the reset controller for now, there could, in premise be other blocks
that require a reset (e.g.: V3D) that would involve going to the VPU
firmware because of various requirements (security, register blocking etc.).

> +
> +      "#clock-cells":

Did not you mean #reset-cells here?


> +        const: 0
> +        description: >
> +          There is only one reset line available, so no need for cell decoding.
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
> +        usb_reset: usb-reset {
> +            compatible = "raspberrypi,firmware-usb-reset";
> +            #reset-cells = <0>;
> +        };
>      };
>  ...
> 

-- 
Florian
