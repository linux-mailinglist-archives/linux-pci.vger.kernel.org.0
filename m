Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23A31F44BE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgFISHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbgFISHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:07:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304EFC05BD1E;
        Tue,  9 Jun 2020 11:07:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so8350253plr.0;
        Tue, 09 Jun 2020 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=leBIztLZS+gycW5tDPBUooZkb1WMMdh915dWRfvmIIw=;
        b=Udt/fSiioTBFCo+SzRpdK9Rp4MHzgaXKP91jdrViNRrlf3IhivsOFcUPaKMGiH9qjc
         fN2N0NcPwTucK5KypB17fl/nvm9CzspLJBO6als1XmamXHhSN9cnHCAsoZSvdpSWUKjN
         l825sZT/YT998dqltM51cESrg12VV98CQw+82l9Sx9501dWw8E0kGfdx+uAbRJX5s3Rl
         Z8XQaXJs3RnCd8h2jO9x5crfltFaO8epHxFzBjU/w4j25gpsNmWdSUSPAIdqP3DkhfZV
         D8a9nzX7BcUNAGspW4kLUgZ+6E0TLKXVDqo+Z7bMwmIWZKGtnMp53TPDDzVbfCJ/1Lm/
         sh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=leBIztLZS+gycW5tDPBUooZkb1WMMdh915dWRfvmIIw=;
        b=ov2MTJ0azpv25KBz7YRK/ggZv2Uw6heqt7FTrYs6AEeGP1zgoRrdzqnfZkae8PInMM
         wZ3podEvpd1ARD2H2jcUdvqPhEouE+svgvC0izmXZus21wLQHabmZ1v1RpiM0rjzQPhN
         es7kRV0Pa+18IiwsC7AqpP5/oKFTrVAhtvbaWLihIxpZCuKcxAonEJtgAbGiJF7X2k93
         W+LhZbs7FsHloEZrPyMSeEY+V3e8czukkvG2huAuAdUSx1PP8XNDOHDPgMglmv3N8zG1
         eoNxIO575eSWCg3K2reeMTiW2M4LCRJ0JMT/tfaq74HqFBrbk+u782PERX8s9pe6y3nr
         S6oQ==
X-Gm-Message-State: AOAM533Q5gw6FKQ3ycMh8gOL4ar5me4Cv87jKOrUNgyvlYnz79rOpAJk
        SgJ0szz4GWF17jtnaaxuJGmzFixn
X-Google-Smtp-Source: ABdhPJw4by/dyQj/70rTpHEZGgpHl+ORIEEB5sxvU9/qLdJKKjKPZvj7a58YrGkamO5R6/SKn4HDQw==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr742977plr.321.1591726063862;
        Tue, 09 Jun 2020 11:07:43 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o18sm11683012pfu.138.2020.06.09.11.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:07:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-2-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c3dc9b7e-4440-7e8a-3da8-b147c48c4c40@gmail.com>
Date:   Tue, 9 Jun 2020 11:07:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> The firmware running on the RPi VideoCore can be used to reset and
> initialize HW controlled by the firmware.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v1:
>  - Correct cells binding as per Florian's comment
>  - Change compatible string to be more generic
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
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

Is this a stray '>' character? If so, with that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
