Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85191318AA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFTZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:25:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34687 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 14:25:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id l8so48396207edw.1;
        Mon, 06 Jan 2020 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oqr2FQAulIxpSkksg2KrbLjWQCcEyE1/4zH2weVvEGk=;
        b=W2hCXxvO138KfOS/rbi8J4XlHeNh/WFhCfqIuiryqRtG3l2+JkdNYsDBfhgbb1bAMn
         bNXMsMsLCurbCbPBsPM4MOCjOBrovV7VZMQPfquu66JpNe7zVQAeGLphTwgDA06bTJzw
         fj8tgGGDP6MwH3IdOIZ/CLad4OskebBdtD7bMflGyhRLiusCXPZTCTGKyzKS1j+bUbgp
         h/XtnMwx+stLIfVPAYJ4c925vEneZspBMv7+oa0mqg9ZEBfqnElgikTUrKYUoH+GXMUE
         BX6q5DAPv9wMnG5aqBLXO7GRVw/ITwWqkPgtE0oHC9zFxv7RVzLoo/zoX2ZwOYiXkie4
         iOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Oqr2FQAulIxpSkksg2KrbLjWQCcEyE1/4zH2weVvEGk=;
        b=JggUUyVCBZO9DT5udb25Yl2xxOwmR6fniuYeX34CWJWqO6L6F5N6Kjmx/GcXqm8z6Z
         gA062hxZwTgHQu0TxIH60zUAjrYFvgJqqSNCsKzP/kuknmu+SZXReqTjpsYJMBtsFeAI
         Nw9t4sj4DfWX2gUfEtrrS9iwFxonQljByWJcfJzUlsC8HAOxMovhDC1j3vQlSg4XkHxF
         3Ztks2UiDLDO9uJb2UdyWl+Q22dlYih7oBkgjeuMokzeGUczc+rRIHm1yHCcjtTgBS7T
         0OxKoeEKdIQH8RkemE0+YVZ6WxbL2yts73hMdCHWNaDaemqxRlaWCUoCF051p9bZEXHv
         epEg==
X-Gm-Message-State: APjAAAVf+jd6ROITfw8BsPPugaI92pNzRpWaFYevmbnpQeVqKufkBu/w
        bxGwk7UxWEf4t8T/qSyz9tCoyLir
X-Google-Smtp-Source: APXvYqzhizcV2Uca1Sgc0aSluf8gITKgnDOjc/3HT/DE48Q+Xr0pRJaM5YzDhM37rvwUwQtZpJa2Lg==
X-Received: by 2002:a17:906:b208:: with SMTP id p8mr71974271ejz.191.1578338746504;
        Mon, 06 Jan 2020 11:25:46 -0800 (PST)
Received: from [10.67.50.41] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ck19sm7920095ejb.48.2020.01.06.11.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 11:25:45 -0800 (PST)
Subject: Re: [PATCH v4 0/6] PAXB INTx support with proper model
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOwU0EVxvH8AEQAOqv6agYuT4x3DgFIJNv9i0e
 S443rCudGwmg+CbjXGA4RUe1bNdPHYgbbIaN8PFkXfb4jqg64SyU66FXJJJO+DmPK/t7dRNA
 3eMB1h0GbAHlLzsAzD0DKk1ARbjIusnc02aRQNsAUfceqH5fAMfs2hgXBa0ZUJ4bLly5zNbr
 r0t/fqZsyI2rGQT9h1D5OYn4oF3KXpSpo+orJD93PEDeseho1EpmMfsVH7PxjVUlNVzmZ+tc
 IDw24CDSXf0xxnaojoicQi7kzKpUrJodfhNXUnX2JAm/d0f9GR7zClpQMezJ2hYAX7BvBajb
 Wbtzwi34s8lWGI121VjtQNt64mSqsK0iQAE6OYk0uuQbmMaxbBTT63+04rTPBO+gRAWZNDmQ
 b2cTLjrOmdaiPGClSlKx1RhatzW7j1gnUbpfUl91Xzrp6/Rr9BgAZydBE/iu57KWsdMaqu84
 JzO9UBGomh9eyBWBkrBt+Fe1qN78kM7JO6i3/QI56NA4SflV+N4PPgI8TjDVaxgrfUTV0gVa
 cr9gDE5VgnSeSiOleChM1jOByZu0JTShOkT6AcSVW0kCz3fUrd4e5sS3J3uJezSvXjYDZ53k
 +0GS/Hy//7PSvDbNVretLkDWL24Sgxu/v8i3JiYIxe+F5Br8QpkwNa1tm7FK4jOd95xvYADl
 BUI1EZMCPI7zABEBAAHCwagEGBECAAkFAlcbx/ACGwICKQkQYVeZFbVjdg7BXSAEGQECAAYF
 Alcbx/AACgkQh9CWnEQHBwSJBw//Z5n6IO19mVzMy/ZLU/vu8flv0Aa0kwk5qvDyvuvfiDTd
 WQzq2PLs+obX0y1ffntluhvP+8yLzg7h5O6/skOfOV26ZYD9FeV3PIgR3QYF26p2Ocwa3B/k
 P6ENkk2pRL2hh6jaA1Bsi0P34iqC2UzzLq+exctXPa07ioknTIJ09BT31lQ36Udg7NIKalnj
 5UbkRjqApZ+Rp0RAP9jFtq1n/gjvZGyEfuuo/G+EVCaiCt3Vp/cWxDYf2qsX6JxkwmUNswuL
 C3duQ0AOMNYrT6Pn+Vf0kMboZ5UJEzgnSe2/5m8v6TUc9ZbC5I517niyC4+4DY8E2m2V2LS9
 es9uKpA0yNcd4PfEf8bp29/30MEfBWOf80b1yaubrP5y7yLzplcGRZMF3PgBfi0iGo6kM/V2
 13iD/wQ45QTV0WTXaHVbklOdRDXDHIpT69hFJ6hAKnnM7AhqZ70Qi31UHkma9i/TeLLzYYXz
 zhLHGIYaR04dFT8sSKTwTSqvm8rmDzMpN54/NeDSoSJitDuIE8givW/oGQFb0HGAF70qLgp0
 2XiUazRyRU4E4LuhNHGsUxoHOc80B3l+u3jM6xqJht2ZyMZndbAG4LyVA2g9hq2JbpX8BlsF
 skzW1kbzIoIVXT5EhelxYEGqLFsZFdDhCy8tjePOWK069lKuuFSssaZ3C4edHtkZ8gCfWWtA
 8dMsqeOIg9Trx7ZBCDOZGNAAnjYQmSb2eYOAti3PX3Ex7vI8ZhJCzsNNBEjPuBIQEAC/6NPW
 6EfQ91ZNU7e/oKWK91kOoYGFTjfdOatp3RKANidHUMSTUcN7J2mxww80AQHKjr3Yu2InXwVX
 SotMMR4UrkQX7jqabqXV5G+88bj0Lkr3gi6qmVkUPgnNkIBe0gaoM523ujYKLreal2OQ3GoJ
 PS6hTRoSUM1BhwLCLIWqdX9AdT6FMlDXhCJ1ffA/F3f3nTN5oTvZ0aVF0SvQb7eIhGVFxrlb
 WS0+dpyulr9hGdU4kzoqmZX9T/r8WCwcfXipmmz3Zt8o2pYWPMq9Utby9IEgPwultaP06MHY
 nhda1jfzGB5ZKco/XEaXNvNYADtAD91dRtNGMwRHWMotIGiWwhEJ6vFc9bw1xcR88oYBs+7p
 gbFSpmMGYAPA66wdDKGj9+cLhkd0SXGht9AJyaRA5AWB85yNmqcXXLkzzh2chIpSEawRsw8B
 rQIZXc5QaAcBN2dzGN9UzqQArtWaTTjMrGesYhN+aVpMHNCmJuISQORhX5lkjeg54oplt6Zn
 QyIsOCH3MfG95ha0TgWwyFtdxOdY/UY2zv5wGivZ3WeS0TtQf/BcGre2y85rAohFziWOzTaS
 BKZKDaBFHwnGcJi61Pnjkz82hena8OmsnsBIucsz4N0wE+hVd6AbDYN8ZcFNIDyt7+oGD1+c
 PfqLz2df6qjXzq27BBUboklbGUObNwADBQ//V45Z51Q4fRl/6/+oY5q+FPbRLDPlUF2lV6mb
 hymkpqIzi1Aj/2FUKOyImGjbLAkuBQj3uMqy+BSSXyQLG3sg8pDDe8AJwXDpG2fQTyTzQm6l
 OnaMCzosvALk2EOPJryMkOCI52+hk67cSFA0HjgTbkAv4Mssd52y/5VZR28a+LW+mJIZDurI
 Y14UIe50G99xYxjuD1lNdTa/Yv6qFfEAqNdjEBKNuOEUQOlTLndOsvxOOPa1mRUk8Bqm9BUt
 LHk3GDb8bfDwdos1/h2QPEi+eI+O/bm8YX7qE7uZ13bRWBY+S4+cd+Cyj8ezKYAJo9B+0g4a
 RVhdhc3AtW44lvZo1h2iml9twMLfewKkGV3oG35CcF9mOd7n6vDad3teeNpYd/5qYhkopQrG
 k2oRBqxyvpSLrJepsyaIpfrt5NNaH7yTCtGXcxlGf2jzGdei6H4xQPjDcVq2Ra5GJohnb/ix
 uOc0pWciL80ohtpSspLlWoPiIowiKJu/D/Y0bQdatUOZcGadkywCZc/dg5hcAYNYchc8AwA4
 2dp6w8SlIsm1yIGafWlNnfvqbRBglSTnxFuKqVggiz2zk+1wa/oP+B96lm7N4/3Aw6uy7lWC
 HvsHIcv4lxCWkFXkwsuWqzEKK6kxVpRDoEQPDj+Oy/ZJ5fYuMbkdHrlegwoQ64LrqdmiVVPC
 TwQYEQIADwIbDAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2Do+FAJ956xSz2XpDHql+Wg/2qv3b
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <5e551d0f-0304-1cea-0899-a4c1d6c2f3e8@gmail.com>
Date:   Mon, 6 Jan 2020 11:25:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576814058-30003-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/19/19 7:54 PM, Srinath Mannam wrote:
> This patch series adds PCIe legacy interrupt (INTx) support to the iProc
> PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
> INTB, INTC, INTD share the same interrupt line connected to the GIC
> in the system. This is now modeled by using its own IRQ domain.
> 
> Also update all relevant devicetree files to adapt to the new model.
> 
> This patch set is based on Linux-5.5-rc1.

Lorenzo are you good with those patches so I can apply the device tree
changes to the 5.6 Broadcom SoC pull request?

> 
> Changes from v3:
>   - Addressed Andrew Murray's comments
>   - Add change to dispose VIRQ when disabling INTx
> 
> Changes from v2:
>   - Addressed Lorenzo's comments
>     - Corrected INTx to PIN mapping.
> 
> Changes from v1:
>   - Addressed Rob, Lorenzo, Arnd's comments
>     - Used child node for interrupt controller.
>   - Addressed Andy Shevchenko's comments
>     - Replaced while loop with do-while.
> 
> Ray Jui (6):
>   dt-bindings: pci: Update iProc PCI binding for INTx support
>   PCI: iproc: Add INTx support with better modeling
>   arm: dts: Change PCIe INTx mapping for Cygnus
>   arm: dts: Change PCIe INTx mapping for NSP
>   arm: dts: Change PCIe INTx mapping for HR2
>   arm64: dts: Change PCIe INTx mapping for NS2
> 
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 +++++++--
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 +++++-
>  arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 +++++-
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 +++++++--
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++++-
>  drivers/pci/controller/pcie-iproc.c                | 108 ++++++++++++++++++++-
>  drivers/pci/controller/pcie-iproc.h                |   6 ++
>  7 files changed, 268 insertions(+), 27 deletions(-)
> 


-- 
Florian
