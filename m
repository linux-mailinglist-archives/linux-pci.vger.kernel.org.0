Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD38CBB58
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfJDNMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 09:12:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45464 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfJDNMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 09:12:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so3856015pfb.12;
        Fri, 04 Oct 2019 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUiox1R0hROdY9yZCRzopfRKb7Hpw5iaEBfomVYH688=;
        b=Tkv5tyzstWxtAX48sv4MmTvBh/2aoOmbHQ4GWe3DDeEUh50Mu+CVc0XZnkyvxPeyZT
         cv6SYzd1IkCbX5mhcjecpCkMXi3KAcWXx7iNZs0iX5qWTsmcYjIJe9MZeEg8LY2bFYEq
         bqLR286u7JXrKHuteFWWBKTXqNtVnFmGWTPtZmvOLXs2uFZSrLuiIaGjShhdvVNZGAwc
         Qj6+nqlrOc/NCWXMAaiVnNvg9mSr+c7vzl2D7rEjigosye6r5rITcHsQvMcoIr2NJ3dK
         x+hP2Ce6iQ9h3gZV5DGObP4VZG09W9zJXvUz5CdSLIadPaFmag5HwtSfIFs5lS/LzmYy
         RpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUiox1R0hROdY9yZCRzopfRKb7Hpw5iaEBfomVYH688=;
        b=BVjk3zNiU4gYFTNnpS/CduQS9HFQVUpVTjGgoBpwwigt+Z0DRGvTUudPDQRXMvg1Uu
         7vb3JlzUvgRJrunSCL2l6DBYHmigp7/kf/7pKjmozY8N2UsjDFKNX8DB0ag8VxgvOWk5
         K9nUnmb+frw26ryPmRx0h5+j6rUSFNzR5j3B1icLUFHtHCfEQmDThgdba6/KqRNHv5OA
         61I3FPbvwDNXMHOGk1HI6dLSLfy9qcsYbUx3KZZV2c8GCxFGGH6cRZx6ksPpFr1Flu1C
         ebOAp7neJhEMLGZsb+DACICQx80leVQArlLIbmhdUBnn74gbSw5kYsWSpL50hqtKsD6T
         sucw==
X-Gm-Message-State: APjAAAWgBrVMSkykea1UY2Lgbmz7eveYscpEWEbd1gKi42vXKsAXSqCX
        A/gkMyD/+jFAtbOr3NNe0Ic=
X-Google-Smtp-Source: APXvYqzlaXM5fjESQSK7RC4J4zjj6oZfbuc5mLrgPIL+rCnBhELyYRT4+WOBbnOQG2sxTANj+gZfnA==
X-Received: by 2002:a17:90b:946:: with SMTP id dw6mr16904660pjb.48.1570194742398;
        Fri, 04 Oct 2019 06:12:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15sm6194435pfa.65.2019.10.04.06.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:12:21 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: watchdog: renesas-wdt: Document r8a774b1
 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <eabf732e-33ba-8011-2cbc-f1df1f6dadb3@roeck-us.net>
Date:   Fri, 4 Oct 2019 06:12:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/4/19 1:35 AM, Fabrizio Castro wrote:
> RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
> with R-Car Gen3, therefore add the relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> index 9f365c1..a5bf04d 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
> @@ -10,6 +10,7 @@ Required properties:
>   		 - "renesas,r8a7745-wdt" (RZ/G1E)
>   		 - "renesas,r8a77470-wdt" (RZ/G1C)
>   		 - "renesas,r8a774a1-wdt" (RZ/G2M)
> +		 - "renesas,r8a774b1-wdt" (RZ/G2N)
>   		 - "renesas,r8a774c0-wdt" (RZ/G2E)
>   	         - "renesas,r8a7790-wdt" (R-Car H2)
>   	         - "renesas,r8a7791-wdt" (R-Car M2-W)
> 

