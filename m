Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654E14ECD54
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiC3TjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350965AbiC3TiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:38:19 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE3D2B7;
        Wed, 30 Mar 2022 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=v6Ce0k4TNmniK2Y9UDZZoyXc13IFHfO6vNobnbLkf9E=; b=aPM771ZVE6DKM/HKelxFXhEwEX
        luSOWEeYG8aBsRs6uFway3NzxzCePzisZJh9zT38EnfharChPYRN31crrtrYHHNxFX7X+U87BzlZL
        HUgjCPLlFJecoUtc+83BdB2lXUap/18mS94zn7s3wx1L93VsBY1DDkivjOKLBQD03HSbWfuPyOkIu
        gIoNgatCPZl1tK74yjvlWJ60ZpauvZRJ7qQlKjt6LHkj9sgupYVqcREcR9riBxH3eXQfXFcJU+EtX
        mztgNJrlE8BeZspyT9zC63QshniD+AC8Keog6pGzRYnhdp9+HLb7+NPQxxXnT22qDkPI5GE7m3GiL
        Q1hGpjNw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nZe7H-00D7Zz-Jc; Wed, 30 Mar 2022 13:36:28 -0600
Message-ID: <671cb318-5f4e-4372-d0ef-45be83bdf0b9@deltatee.com>
Date:   Wed, 30 Mar 2022 13:36:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
References: <20220330153720.GF1716663@nvidia.com>
 <20220330191017.GA1700536@bhelgaas> <20220330191145.GE2120790@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220330191145.GE2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@nvidia.com, helgaas@kernel.org, shlomopongratz@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.maier@eideticom.com, bhelgaas@google.com, shlomop@pliops.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-03-30 13:11, Jason Gunthorpe wrote:
> On Wed, Mar 30, 2022 at 02:10:17PM -0500, Bjorn Helgaas wrote:
>> On Wed, Mar 30, 2022 at 12:37:20PM -0300, Jason Gunthorpe wrote:
>>> On Wed, Mar 30, 2022 at 05:08:23PM +0300, Shlomo Pongratz wrote:
>>>> @@ -350,7 +353,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>>>>  
>>>>  	if (!root)
>>>>  		return NULL;
>>>> -	if (root->devfn != PCI_DEVFN(0, 0))
>>>> +
>>>> +	/* Is it a host bridge or a root port? */
>>>
>>> This is a better comment:
>>>
>>> /* host bridges must have a 0 devfn, but some of the entries in the
>>>   whilelist are root ports that can have any devfn */
>>
>> Is this something in the spec or is it just common practice?  The PCIe
>> spec says very little about "host bridges" and I don't remember
>> anything about them having to be devfn 0 or even that they have to be
>> materialized as PCI devices.
> 
> I think we are relying on common practice here, but I don't know why
> this check was added in the first place? Logan?

Yeah, this was more about common practice than spec. Seeing we only
support a subset of devices it was expected that those added to our
support list would meet this criteria.

The main purpose here is to just get identifying information about the
host bridge. I wouldn't say that the host bridge is dev-fn 0 in any
sense of the word. What a host bridge is vs a root port is also a bit
murky . I'm really not sure what the tree looks like on this SkyLake
system, but on my test system, the two host bridges are also root ports.

00:00.0 Host bridge: Intel Corporation Xeon E5/Core i7 DMI2 (rev 07)
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00

The point was really just finding the VID/PID of one of the PCI devices
belonging to the bridge for identifying whether it was safe to use.
Originally this function was implemented as simply

    pci_get_slot(host->bus, PCI_DEVFN(0, 0));

That was replaced with the current function solely to avoid needing to
take pci_bus_sem in this path. The check for dev-fn 0 was kept to ensure
it matched the old method.

Checking simply for PCI_EXP_TYPE_ROOT_PORT instead of a zero devfn is
probably a good idea, assuming it works for all existing systems. I'd
expect it would be set for all the devices currently allowed.

Logan
