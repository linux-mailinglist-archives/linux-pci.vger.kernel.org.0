Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93488491
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfHIVWd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 17:22:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHIVWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 17:22:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b3so7050123wro.4;
        Fri, 09 Aug 2019 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kE1tfn2CJDN20QybOhvTtuNLs+NfuuQ3TwsC/Bn5MbQ=;
        b=p613dnSKzC4Um6UD/bACOYVV2MLpAzmaBbL9jVmQpSSREn2z4G+UoKKFaXvohTuNjs
         oJUpLXz6ykImjivRNwmRpZgyU3sDPbWJagjR4dbrISq4bfXCNunOPanZsFYI89Qy4ppM
         TA9KekqO61+emdT8ac6RQTTKe93o+FB/HQYSpYETzFYNq493o+X4siapHc+vgicU590M
         ROwRNdJ88NApuriOhOupX9DiscfuHp6tM5fiM0aQb0r3FOFi3toseNEyrLjmnKfqFJt6
         qa+l+0fD1z79G8IzPJZbsFtnLdt950Y4/rha4hXIUze/e+FfE5xmMTXKY4a0JjRRFXRV
         2Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kE1tfn2CJDN20QybOhvTtuNLs+NfuuQ3TwsC/Bn5MbQ=;
        b=ECQGaM/Rok0k4RVo7ZitJ8o6PELmBs25haimkDgYDdCneiJSDGwUozHK/qgYN4CWXc
         KRAaBrK8EJXdPamsBeJczEKm0zHOu2+vIOeDPvm01FrQKbkBzirLm3ppzXd14DSz89AE
         hK+9mYSwjJL32dEZfvoYHNvaH16Sd1xyRdHz8qRx8iOVGxpDfg7bJDDB50CvC+YZ1UYk
         6Af5kEUTRy6cKsfNWPaQkcmwjtIA+9qObttN6EmuIVSMS7Em5QGMaWWFMdUNCy9VCXqi
         ThZ7n1/XzW4WPq6hHCRlmU12HUZfrUVp85oMEZj46XDka+7s8m156MILme/CHdNqlxUr
         Ucag==
X-Gm-Message-State: APjAAAXo/NiS1LEp/z3SgqkgW0aGsqlrgb6JJQI+lTRi6nihQ1zNX9F2
        u+9e7uqREhvimaDe+UmKvirbYVAA
X-Google-Smtp-Source: APXvYqyYx2YpcAjFH9BByI433RsnLdBrAS2w1Ih5b0+XmCwVLPYNIVE7AO+gyRXVPlqVijm9mMAs5A==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr10149203wrm.188.1565385750898;
        Fri, 09 Aug 2019 14:22:30 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id e10sm18688025wrn.33.2019.08.09.14.22.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:22:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC
 drivers.
To:     Simon Horman <horms@verge.net.au>
Cc:     linux-pci@vger.kernel.org, Oza Pawandeep <oza.oza@broadcom.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809173449.20126-1-marek.vasut@gmail.com>
 <20190809205631.eru5gmv4d4yj3pfs@verge.net.au>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7cee3b06-6e0c-53a8-3f8d-ebd518b6ebf5@gmail.com>
Date:   Fri, 9 Aug 2019 23:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809205631.eru5gmv4d4yj3pfs@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/9/19 10:56 PM, Simon Horman wrote:
> On Fri, Aug 09, 2019 at 07:34:48PM +0200, marek.vasut@gmail.com wrote:
>> From: Oza Pawandeep <oza.oza@broadcom.com>
>>
>> The patch exports interface to PCIe RC drivers so that,
>> Drivers can get their inbound memory configuration.
>>
>> It provides basis for IOVA reservations for inbound memory
>> holes, if RC is not capable of addressing all the host memory,
>> Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
>> could be allocated.
>>
>> It handles multiple inbound windows, and returns resources,
>> and is left to the caller, how it wants to use them.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/of.c       | 96 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of_pci.h |  7 +++
>>  2 files changed, 103 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index bc7b27a28795..4018f1a26f6f 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -347,6 +347,102 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>  	return err;
>>  }
>>  EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
>> +
>> +/**
>> + * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
>> + * @np: device node of the host bridge having the dma-ranges property
>> + * @resources: list where the range of resources will be added after DT parsing
>> + *
>> + * It is the caller's job to free the @resources list.
>> + *
>> + * This function will parse the "dma-ranges" property of a
>> + * PCI host bridge device node and setup the resource mapping based
>> + * on its content.
>> + *
>> + * It returns zero if the range parsing has been successful or a standard error
>> + * value if it failed.
>> + */
>> +
>> +int of_pci_get_dma_ranges(struct device_node *dn, struct list_head *resources)
>> +{
>> +	struct device_node *node = of_node_get(dn);
>> +	int rlen;
>> +	int pna = of_n_addr_cells(node);
>> +	const int na = 3, ns = 2;
>> +	int np = pna + na + ns;
>> +	int ret = 0;
>> +	struct resource *res;
>> +	const u32 *dma_ranges;
> 
> It seems that const __be32 * would be a more appropriate type
> for dma_ranges as that seems to be the expected type in
> all uses below.

Noted, but I'm more interested in some conceptual input about this --
whether this is the right approach or not.

Seems like we now have iMX8, R-Car3 and some Broadcom SoCs affected by
this issue, with no solution in sight for years, so I think something
has to be done here.

-- 
Best regards,
Marek Vasut
