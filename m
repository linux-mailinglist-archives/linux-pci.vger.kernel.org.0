Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F73D9189
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhG1PKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbhG1PIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 11:08:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96091C061764
        for <linux-pci@vger.kernel.org>; Wed, 28 Jul 2021 08:08:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u15so1659810wmj.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jul 2021 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y0Oxv7FSNFEltVg4Evcp+IiFZ6zdpGchbxfgnaolaO8=;
        b=Tz31OFTwL+yRNaj/JrXEOOjFyy+JEpDVpYCEMQQmHIpLnwMFuIG+HUb5PLYw9GPGSW
         VxlhbmIrkhF0ZcX9emVfLMt8vtjOx7wJXzTJ5ACPsNLZr818iBjdSsGNVA6hErwNBmdd
         h6MdeMT08aJ86+oj83tjmr+MogrMzwGsKiDvGEwXjHf9VH42jIizSHyoafXsLKvLeaH1
         zj4jyPQY0Be+WCy7v32PIEhUK/alwxNrTPOgyO4PQtT0rCK5XXlvmpAy9qbi76nQjPbw
         itQuzoaC1uOcV7+n6tqVIAI77XIXpEe9mALXndbOdSLMlUPqMNyN18tWEllWEuDVLxgi
         NMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y0Oxv7FSNFEltVg4Evcp+IiFZ6zdpGchbxfgnaolaO8=;
        b=DJwk9zH/cHY5Od3nhwWoWkYnDTf6CGX1ghFtnJl+/Uu/qrpPPKfbv3rn3r+s1snn+z
         rG3ThWwmAWMKH8N/u6ZidCgjut2NaPuInVq/+K5QkNLzrB6O0n8iRUju/qaQTJVfMWyj
         1+bRH55xYONtcThKlzYIlO53PRqriy0LC3NNVMqVgrJMx1BmELNXKK7S4YOkdk9seDWu
         nWyHI/hkEfaE2J+km6lyqj6owGpsTjuS9jjVjN8+3pY2L9funvNRyQyp2sLVCAXZZ9DY
         jfIx/1lxKuyvausbARPcBq/uCNXTvi4LWk8CjN7aFAz93mWtahVhwad2WrtPf2boyWEZ
         98qw==
X-Gm-Message-State: AOAM530sCkvY3N2OwHsB3ciDuSvosueSBNpuJ7BXc0kJeSep5iC9JHmS
        RXn+D+mP/zGlkda73EJZUfXV/A==
X-Google-Smtp-Source: ABdhPJz9/1JRRhO2jzvXgHlf/omHSHLO2FSaTH9Cryo2mHZyi9st2t5VNn5Lb2L7iEypP4bk7girCw==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr177672wmi.166.1627484919970;
        Wed, 28 Jul 2021 08:08:39 -0700 (PDT)
Received: from [10.1.3.29] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a191sm277151wme.15.2021.07.28.08.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 08:08:23 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: DWC: meson: add 256 bytes MRRS quirk
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Artem Lapkin <email2tema@gmail.com>
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
References: <20210727194323.GA725763@bjorn-Precision-5520>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <63838b21-3073-0b07-53d3-b85d6e89f0eb@baylibre.com>
Date:   Wed, 28 Jul 2021 17:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727194323.GA725763@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 27/07/2021 21:43, Bjorn Helgaas wrote:
> On Tue, Jul 27, 2021 at 10:30:00AM +0800, Artem Lapkin wrote:
>> 256 bytes maximum read request size. They can't handle
>> anything larger than this. So force this limit on
>> any devices attached under these ports.
> 
> This needs to say whether this is a functional or a performance issue.
> 
> If it's a functional issue, i.e., if meson signals an error or abort
> when it receives a read request for > 256 bytes, we need to explain
> exactly what happens.
> 
> If it's a performance issue, we need to explain why MRRS affects
> performance and that this is an optimization.
> 
>> Come-from: https://lkml.org/lkml/2021/6/18/160
>> Come-from: https://lkml.org/lkml/2021/6/19/19
> 
> Please use lore.kernel.org URLs instead.  The lore URLs are a little
> uglier, but are more functional, more likely to continue working, and
> avoid the ads.  These are:
> 
>   https://lore.kernel.org/r/20210618230132.GA3228427@bjorn-Precision-5520
>   https://lore.kernel.org/r/20210619063952.2008746-1-art@khadas.com
> 
>> It only affects PCIe in P2P, in non-P2P is will certainly affect
>> transfers on the internal SoC/Processor/Chip internal bus/fabric.
> 
> This needs to explain how a field in a PCIe TLP affects transfers on
> these non-PCIe fabrics.
> 
>> These quirks are currently implemented in the
>> controller driver and only applies when the controller has been probed
>> and to each endpoint detected on this particular controller.
>>
>> Continue having separate quirks for each controller if the core
>> isn't the right place to handle MPS/MRRS.
> 
> I see similar code in dwc/pci-keystone.c.  Does this problem actually
> affect *all* DesignWare-based controllers?
> 
> If so, we should put the workaround in the common dwc code, e.g.,
> pcie-designware.c or similar.  
> 
> It also seems to affect pci-loongson.c (not DesignWare-based).  Is
> there some reason it has the same problem, e.g., does loongson contain
> DesignWare IP, or does it use the same non-PCIe fabric?

As my reply on the previous thread, the Synopsys IP can be configured with a
maximum TLP packet to AXI transaction size, which is hardcoded AFAIK Amlogic
doesn't explicit it. And it doesn't seem we can read the value.

This means is a TPL size if higher than this maximum packet size, the IP will
do multiple AXI transactions, and this can reduce the system overall performance.

The problem is that it affects the P2P transactions aswell, which can support any MPS/MRRS.
But honestly, it's not a big deal on a PCIe 2.0 1x system only designed for NVMe and basic
PCIe devices.

The fun part is that the pci=pcie_bus_perf kerne cmdline solves this already,
isn't there any possibility to force pcie_bus_perf for a particular root port ?

Neil

> 
>>>> Neil
>>
>> Signed-off-by: Artem Lapkin <art@khadas.com>
>> ---
>>  drivers/pci/controller/dwc/pci-meson.c | 31 ++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 686ded034..1498950de 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -466,6 +466,37 @@ static int meson_pcie_probe(struct platform_device *pdev)
>>  	return ret;
>>  }
>>  
>> +static void meson_mrrs_limit_quirk(struct pci_dev *dev)
>> +{
>> +	struct pci_bus *bus = dev->bus;
>> +	int mrrs, mrrs_limit = 256;
>> +	static const struct pci_device_id bridge_devids[] = {
>> +		{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
> 
> I don't really believe that PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 is the
> only device affected here.  Is this related to the Meson root port, or
> is it related to a PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 on a plug-in card?
> I guess the former, since you're searching upward for a root port.
> 
> So why is this limited to PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3?
> 
>> +		{ 0, },
>> +	};
>> +
>> +	/* look for the matching bridge */
>> +	while (!pci_is_root_bus(bus)) {
>> +		/*
>> +		 * 256 bytes maximum read request size. They can't handle
>> +		 * anything larger than this. So force this limit on
>> +		 * any devices attached under these ports.
>> +		 */
>> +		if (!pci_match_id(bridge_devids, bus->self)) {
>> +			bus = bus->parent;
>> +			continue;
>> +		}
>> +
>> +		mrrs = pcie_get_readrq(dev);
>> +		if (mrrs > mrrs_limit) {
>> +			pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
>> +			pcie_set_readrq(dev, mrrs_limit);
>> +		}
>> +		break;
>> +	}
>> +}
>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);
>> +
>>  static const struct of_device_id meson_pcie_of_match[] = {
>>  	{
>>  		.compatible = "amlogic,axg-pcie",
>> -- 
>> 2.25.1
>>

