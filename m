Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723CC1ED426
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFCQWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 12:22:21 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:49702 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgFCQWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 12:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LBoBxoGsBmzyCez6mYzhh8bje58137/Gvmb4lxqwSsw=; b=Ua29264LU/U8Ko49gYOZ0iXTxY
        +3BagQlHopT9NJC0Yn/3wXl1/mzjn9iYrphf0ArYNCH6g58dS2WIxtPYJLQtHnh0K1VUM7xKWSqYE
        1VzACgJJUBz6nPHrx/3wtHmQsYu/6xYLpbr49HisbUyyxxIqcJhX7WJ0X/fjsKf7ohqJPsbLRxVzi
        0muXXp33BZwWGhZjZX05QEEhFMjQ7BfQ602mkWqBikvF1u6PWWV7TxoDun1qSngjxbIRjWRi/VTbf
        OcwktivNVX8EBUgFCJtp0Iq0JDuLe5p99rWrDfB/23/ddaAu7yE/6IBtoC4++XwtXqkjezn4vg+OV
        WSlJfomg==;
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jgW9i-0002hs-N5; Wed, 03 Jun 2020 10:22:19 -0600
To:     "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114425.12734-1-piotr.stankiewicz@intel.com>
 <3bc1522b-33ba-04ee-4d8e-e4a31ec50756@deltatee.com>
 <CY4PR11MB152819A4C01C524E06A48EBFF9880@CY4PR11MB1528.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6bfeb14e-b2b7-3843-f417-1a2858859869@deltatee.com>
Date:   Wed, 3 Jun 2020 10:22:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB152819A4C01C524E06A48EBFF9880@CY4PR11MB1528.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jian-hong@endlessm.com, rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com, piotr.stankiewicz@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-06-03 10:04 a.m., Stankiewicz, Piotr wrote:
>> -----Original Message-----
>> From: Logan Gunthorpe <logang@deltatee.com>
>> Sent: Wednesday, June 3, 2020 5:48 PM
>>
>>
>>
>> On 2020-06-03 5:44 a.m., Piotr Stankiewicz wrote:
>>> When debugging an issue where I was asking the PCI machinery to enable a
>>> set of MSI-X vectors, without falling back on MSI, I ran across a
>>> behaviour which seems odd. The pci_alloc_irq_vectors_affinity() will
>>> always return -ENOSPC on failure, when allocating MSI-X vectors only,
>>> whereas with MSI fallback it will forward any error returned by
>>> __pci_enable_msi_range(). This is a confusing behaviour, so have the
>>> pci_alloc_irq_vectors_affinity() forward the error code from
>>> __pci_enable_msix_range() when appropriate.
>>>
>>> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> ---
>>>  drivers/pci/msi.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>> index 6b43a5455c7a..443cc324b196 100644
>>> --- a/drivers/pci/msi.c
>>> +++ b/drivers/pci/msi.c
>>> @@ -1231,8 +1231,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev
>> *dev, unsigned int min_vecs,
>>>  		}
>>>  	}
>>>
>>> -	if (msix_vecs == -ENOSPC)
>>> -		return -ENOSPC;
>>> +	if (msix_vecs == -ENOSPC ||
>>> +	    (flags & (PCI_IRQ_MSI | PCI_IRQ_MSIX)) == PCI_IRQ_MSIX)
>>> +		return msix_vecs;
>>>  	return msi_vecs;
>>>  }
>>>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>>>
>>
>> It occurs to me that we could clean this function up a bit more... I
>> don't see any need to have two variables for msi_vecs and msix_vecs and
>> then have a complicated bit of logic at the end to decide which to return.
>>
>> Why not instead just have one variable which is set by
>> __pci_enable_msix_range(), then __pci_enable_msi_range(), then returned
>> if they both fail?
>>
> 
> That wouldn't preserve the original bit of logic where -ENOSPC is returned
> any time __pci_enable_msix_range() fails with -ENOSPC, irrespective of whether
> MSI fallback was requested. Though I don't know if that is desired behaviour.

That does look very odd, but ok... Then, couldn't we just set msi_vecs
to msix_vecs after calling __pci_enable_msix_range() such that if
__pci_enable_msi_range() doesn't get called we will return the same
error without needing the messy second conditional?

Logan



