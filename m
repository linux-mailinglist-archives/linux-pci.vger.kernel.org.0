Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BFD13164C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFQv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 11:51:56 -0500
Received: from ale.deltatee.com ([207.54.116.67]:52638 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQv4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 11:51:56 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ioVbd-0002qj-Sl; Mon, 06 Jan 2020 09:51:54 -0700
To:     Deepa Dinamani <deepa.kernel@gmail.com>, bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200104225149.27342-1-deepa.kernel@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <724d80ee-3a81-23bc-74b0-4b786b3ace53@deltatee.com>
Date:   Mon, 6 Jan 2020 09:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200104225149.27342-1-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, alex.williamson@redhat.com, mika.westerberg@linux.intel.com, bhelgaas@google.com, deepa.kernel@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] drivers: pci: Clear ACS state at kexec
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-01-04 3:51 p.m., Deepa Dinamani wrote:
> ACS bits remain sticky through kexec reset. This is not really a
> problem for Linux because turning IOMMU on assumes ACS on. But,
> this becomes a problem if we kexec into something other than
> Linux and that does not turn ACS on always.
> 
> Reset the ACS bits to default before kexec or device remove.

Hmm, I'm slightly hesitant about disabling ACS on a device's unbind...
Not sure if that's going to open up a hole on us.

> +
> +/* Standard PCI ACS capailities
> + * Source Validation | P2P Request Redirect | P2P Completion Redirect | Upstream Forwarding
> + */
> +#define PCI_STD_ACS_CAP (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> +
>  /**
> - * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> + * pci_std_enable_disable_acs - enable/disable ACS on devices using standard
> + * ACS capabilities
>   * @dev: the PCI device
>   */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> +static void pci_std_enable_disable_acs(struct pci_dev *dev, int enable)
>  {
>  	int pos;
>  	u16 cap;
>  	u16 ctrl;
> +	u16 val = 0;
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>  	if (!pos)
> @@ -3278,19 +3286,26 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
>  	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
>  
> -	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> +	val = (cap & PCI_STD_ACS_CAP);

Can we open code PCI_STD_ACS_CAP? I don't see any value in it being
defined above the function, it just makes the code harder to read.

Logan
