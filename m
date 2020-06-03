Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745611ED3BA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCPsd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 11:48:33 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:49254 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgFCPsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 11:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DyVOjmlqCoKrltZ3JPtYUcrysE4EcCkPrYQ15a88f1I=; b=KJZoQGSdzu8aT/x0nP7GDG4mhv
        YXHgrtcmGutsi6M/QqSVFhEZph8GjQTCc0fH5dRu419ybc3eaKsfHe7pF7Q9RLvSZtLZIMGlOqjhH
        tezXOve/o+IhhV0l0xHMlgLFh6oN5cxUrAPqTr+tcCjqkMBFUHuR+63X2nsSGOZ+8UabQNBNfowLw
        pOB6TIkzVQadGDQCOHlMRilwvKO4XsBE6QW3tpppxGzYe4YX+xd7f5C3bZ9YHjh4C3z9l2ZvTcvko
        HdeTHnMGL0I9vvWIwlJZNavyD22W6mfRLr38VZRBnnvjJJDeuFy9qpytU7heMfD2qe5S3zE6ckasu
        vglWNAXA==;
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jgVcz-0001vT-1U; Wed, 03 Jun 2020 09:48:31 -0600
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114425.12734-1-piotr.stankiewicz@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3bc1522b-33ba-04ee-4d8e-e4a31ec50756@deltatee.com>
Date:   Wed, 3 Jun 2020 09:48:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603114425.12734-1-piotr.stankiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jian-hong@endlessm.com, rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com, piotr.stankiewicz@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-06-03 5:44 a.m., Piotr Stankiewicz wrote:
> When debugging an issue where I was asking the PCI machinery to enable a
> set of MSI-X vectors, without falling back on MSI, I ran across a
> behaviour which seems odd. The pci_alloc_irq_vectors_affinity() will
> always return -ENOSPC on failure, when allocating MSI-X vectors only,
> whereas with MSI fallback it will forward any error returned by
> __pci_enable_msi_range(). This is a confusing behaviour, so have the
> pci_alloc_irq_vectors_affinity() forward the error code from
> __pci_enable_msix_range() when appropriate.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/pci/msi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7a..443cc324b196 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1231,8 +1231,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	if (msix_vecs == -ENOSPC)
> -		return -ENOSPC;
> +	if (msix_vecs == -ENOSPC ||
> +	    (flags & (PCI_IRQ_MSI | PCI_IRQ_MSIX)) == PCI_IRQ_MSIX)
> +		return msix_vecs;
>  	return msi_vecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> 

It occurs to me that we could clean this function up a bit more... I
don't see any need to have two variables for msi_vecs and msix_vecs and
then have a complicated bit of logic at the end to decide which to return.

Why not instead just have one variable which is set by
__pci_enable_msix_range(), then __pci_enable_msi_range(), then returned
if they both fail?

Logan
