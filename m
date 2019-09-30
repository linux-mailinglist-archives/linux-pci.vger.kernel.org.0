Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3156C20CC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfI3Mpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:45:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46779 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfI3Mpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:45:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so11123405wrv.13;
        Mon, 30 Sep 2019 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iI178b6o0qZVFBE5FgkMuuPfgQeMCHtWWim2bH0vxbY=;
        b=jO6onDotzDWCKXEXFzt5lNj+IXe2cN21TYeChnFaKzRs7HYnmYbsPmIYHIi7enbNF4
         mQa8u5bgxNDWXpiEFIs5ZU6+ff+9UycRj24TGk9n5RnpNPVRd43/j3BJ78zZDDMf+pRR
         eB3SrMQ58CgKzB11kCbIOLDU5KRIEutAgyT8dgXTWRj2EJEPHS+ixySzNJTfLBNhxYgJ
         68AGeSyl39hAgbzMKsNkX2YRRvfBbRGjNjtFunngdVEhPzQuH8b/tBZ6nu3SuLhPiP9g
         yVX8bBsl9XObGaG++9XSz8OagizFufFlSRWqnFyFk1gq+W34kWd+Y4icip9DcFuwGZCh
         aNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iI178b6o0qZVFBE5FgkMuuPfgQeMCHtWWim2bH0vxbY=;
        b=gOd8hldZfuQJR756Bl7LrlroILWsaYtF0nWAHjlW///U2de5emWh7j7RaNMRsiM/7Q
         cACBMVUvUstX6GsVS0di346LYUGsPL3HAKLb5H12zjYX3t89hQvpHvK88ho3+D1U9g1P
         Dd21NLsI9jfi15949abhVuFUQKzSqprjm7dL33mmuuJKa+P2UuA4BOHozVIFyyLIUxR9
         313mhwQu2Hy61WO8AxUwGQtl1P4MBHRJ8GK24LfhOwPcfc4VIXqhalJVUGPTlpUHGLOM
         a17Eq5U8kNKeVI6eZZxLpiHbRP4PJY1lbMX50BQFepuqSO1m8ZyV3mlNbtUZs1DIT6rl
         SFDw==
X-Gm-Message-State: APjAAAVptAZn2zmJsUbjAjhBBfE3cenyF5a9kaj3+k5nxAutPPO73QvH
        KWD6SmV8qB/v25FeiSZ9ams=
X-Google-Smtp-Source: APXvYqxXqlxnCTWpHdUcHd+CsyWUyx5za3cbr+Ty3uRN7gE1JPrkoUFKktywA+G0M4up4B1gCXbvvA==
X-Received: by 2002:adf:e951:: with SMTP id m17mr12954736wrn.154.1569847546974;
        Mon, 30 Sep 2019 05:45:46 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z1sm26014947wre.40.2019.09.30.05.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 05:45:46 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
References: <20190927002455.13169-1-robh@kernel.org>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <106d5b37-5732-204f-4140-8d528256a59b@gmail.com>
Date:   Mon, 30 Sep 2019 14:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/27/19 2:24 AM, Rob Herring wrote:
> This series fixes several issues related to 'dma-ranges'. Primarily,
> 'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
> devices not described in the DT. A common case needing dma-ranges is a
> 32-bit PCIe bridge on a 64-bit system. This affects several platforms
> including Broadcom, NXP, Renesas, and Arm Juno. There's been several
> attempts to fix these issues, most recently earlier this week[1].
> 
> In the process, I found several bugs in the address translation. It
> appears that things have happened to work as various DTs happen to use
> 1:1 addresses.
> 
> First 3 patches are just some clean-up. The 4th patch adds a unittest
> exhibiting the issues. Patches 5-9 rework how of_dma_configure() works
> making it work on either a struct device child node or a struct
> device_node parent node so that it works on bus leaf nodes like PCI
> bridges. Patches 10 and 11 fix 2 issues with address translation for
> dma-ranges.
> 
> My testing on this has been with QEMU virt machine hacked up to set PCI
> dma-ranges and the unittest. Nicolas reports this series resolves the
> issues on Rpi4 and NXP Layerscape platforms.

With the following patches applied:
      https://patchwork.ozlabs.org/patch/1144870/
      https://patchwork.ozlabs.org/patch/1144871/
on R8A7795 Salvator-XS
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>

-- 
Best regards,
Marek Vasut
