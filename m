Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA4616ADF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKBRhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBRhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 13:37:34 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21E2E68F;
        Wed,  2 Nov 2022 10:37:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C6A126C2042;
        Wed,  2 Nov 2022 17:37:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 03C5D6C2376;
        Wed,  2 Nov 2022 17:37:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1667410651; a=rsa-sha256;
        cv=none;
        b=mBvmOt9b5IL2+BiX++E+PCamD+0uUOEMHu8lz+YXwplwzdj7dpuHj0FVjM6pKOKQrMNlaw
        eGRXsP+C5C3jRY3ElmGUWkiX4JP9O8uaWXgOKGQlII1FeS5l1/Bii5+N/gEOJyDM7F/qQx
        Jzmq4/32+8da6bL7TQT0jRMHLenOhFeCuZ70ZCXkagcyx6mGgv29/r43C95PcMNzNOkvqn
        ql3HGAQiRdojVXuWVVoRkpwzEVCLZF+y34dzHuLONgyng1uaudByw2HewNOAFMYNMoX1m8
        15ixnsX6N52veQKsbhO/AmuxMftt8pMkF0hDcqOMeL5dk+xbhfEPTJ1Lzf52lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1667410651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2NoUxIpLTDZ8lDvlY/HWORKVP66zScBnVQ1cm5Vtqow=;
        b=IJB+2OLKVm96s8NQVB30fV5hQnH8qRLk+c2r2zoQ5X0c+cYE4pDUBE4JGM3ZNdYGzQqQ0F
        WFIVoVMoZ7sdrz5Lnrfw2W0cdpmQuS3MqA1ssGEUkoqax6CcPJvZ+XZENPWCOjblzmC02y
        wopm1Kgz/NXw55yCQSkBUh8vnunMV5W8UNyWL/hqdd1+qjJBD3jyPt6aoDxAB3jaipzdhE
        9vXAykISYYsFJKNMRxDCkPJMPS18AKuTSDCFwErZ6JMz4fpFHukgaqnu6ZY7epY5N+BuMj
        B8oLunfRTzb+7088r9aTvlVJ4iiQpmnZ/hzMmB1pJ0+9bG5zbckE9oEk4e7fiw==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-nc5q9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Versed: 79a5dbd969deb7c1_1667410651472_1928156444
X-MC-Loop-Signature: 1667410651472:1870974050
X-MC-Ingress-Time: 1667410651472
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.95.137 (trex/6.7.1);
        Wed, 02 Nov 2022 17:37:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4N2YxP2pmYz3C;
        Wed,  2 Nov 2022 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1667410650;
        bh=2NoUxIpLTDZ8lDvlY/HWORKVP66zScBnVQ1cm5Vtqow=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HZ0t0e+BBK8h4WOCCysLyhqnMvrxvtvAxGyesobxPJKRAwEwT/uwQ3jTQN1NvxPWL
         Woyjd/N2j4pIiiNJMYInalM1fV2MVLDYR4UkdB5Mt1nUBaf+G+X4YL58hkCUQCqIel
         5iQTKMvqAFI5S9RSa5dYyZfnZZbYzuZ77gulwm6aeb4W7oITQjaS0c7bRtyenaA//x
         avr1psxPYFyTJtdf+mXzUyiKyF3Xn4fpb2TOQyaOS2DiYbTmDb8g2v8bazdoy3c8oW
         hAH7/WWOtWb2WjTMa7dGoAqfa7qRk4WRk9rk6sewbzfPnZx9JsAFmY4mSnZ1XtoN1i
         /jpmxtsRIXZFA==
Date:   Wed, 2 Nov 2022 10:15:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com,
        alison.schofield@intel.com, bwidawsk@kernel.org,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221102171524.thsz2kwtirhxn7ee@offworld>
References: <20221024133633.00000467@huawei.com>
 <20221025232535.GA579167@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221025232535.GA579167@bhelgaas>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Oct 2022, Bjorn Helgaas wrote:

>> In short that calls:
>> /* Allocate the maximum possible number of MSI/MSI-X vectors */
>> nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
>>			PCI_IRQ_MSIX | PCI_IRQ_MSI);
>>
>> /* See how many and which Interrupt Message Numbers we actually use */
>> nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
>>
>> if (nvec != nr_entries) {
>>	pci_free_irq_vectors(dev);
>>
>>	nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
>>			PCI_IRQ_MSIX | PCI_IRQ_MSI);
>> }
>>
>> My worry here is that the implicit assumption is that the vectors
>> won't move if we reduce the overall number of vectors we are asking
>> for...

This would also apply to what is currently in portdrv machinery, no?

>>
>> However, imagine the case that we have a feature the driver doesn't
>> know about that was previously at a higher vector.  After reducing
>> the vectors allocated the hardware might decide that feature needs
>> its own vector whereas some others can be combined.  Hence we'd end
>> up with a less than ideal packing for the features we actually
>> support.
>>
>> Could do something iterative to solve this if it actually matters
>> (increase number of vectors until the layout matches what we get
>> with max possible vectors).

Maybe do a bounded retry loop until we get stable value?

retry = 1;
do {
	pci_alloc_irq_vectors(1, 32);
	nvecs = get_max_msgnum(); // max(pmu, events, mbox, isolation)
	pci_free_irq_vectors();

	pci_alloc_irq_vectors(nvecs, nvecs);
	new_nvecs = get_max_msgnum();

	if (likely(new_nvecs == nvecs))
		return 0;

	pci_free_irq_vectors();
}  while (retry--);

return -1; // no irq support

But yeah I'm not sure how much we actually care about this. But if so,
it  also might be worth re-visiting the generic table thing, as if
nothing else it can standalone co-exist and avoid allocating any irqs
altogether if we know a-priori that there is no irq support.

>
>Is this cxl code allocating vectors for devices that might also be
>claimed by portdrv?  I assume not because that sounds like a problem.
>
>Ugh.  I always feel like the portdrv design must be sub-optimal
>because this seems so hard to do cleanly.
>
>pci_alloc_irq_vectors() has a lot of magic inside it and is great for
>most drivers, but the PCIe service IRQs are definitely unusual and
>maybe it's not the best fit for this situation.
>
>If I understand correctly, Interrupt Message Numbers for all these
>PCIe services (hotplug, AER, DPC, etc) are restricted to 0-31 for both
>MSI and MSI-X, and the reason we don't just allocate 32 vectors all
>the time is to avoid consuming too many IRQs.

Most CXL features that can have irqs will normally use only the first 16,
with the exception of isolation (cxl 3.0), which per the spec is up to 32.

>The MSI case is ugly because the Interrupt Message Number can change
>when we set Multiple Message Enable.  Maybe we can separate it out and
>have a less than optimal solution for this case, like allocating one
>or two vectors and polling if that's not enough.  I expect most
>devices will support MSI-X.

Would only supporting MSI-X be so terrible?

Thanks,
Davidlohr
