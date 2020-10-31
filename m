Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F52A13AC
	for <lists+linux-pci@lfdr.de>; Sat, 31 Oct 2020 06:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJaFfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Oct 2020 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgJaFfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Oct 2020 01:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13FC0613D5
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2020 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZL3Qgzfq4nmBfTM49VNjh9sFuIDxZ0i94glXnFFtEmY=; b=HqGd0ktfB7kAQO4iZwthL0kscs
        L35Zv87Sn/IZ2pDNzh3u4j28WoEprjWe6Elk3laCPouAc5jlfwcVkGgVSkMaEpJiiPy24t/JJitfl
        XJtda0ftRvCaN0XhCIHVInJWWgn476U3akLOVUjsdsFz9rcMSyMV69YklVh4SAh66Y+1w59CnrXTl
        VqGDoikIMixKKdwMsYuHHHdkF3rlMbOQYRGbpzlT0xqOxRyP3X+IxX5R0IzztJ2cjjX13VRDFzTHm
        AbY6I3BXMNbqmXbrW9Rww/WLxvStMV8lHR1vnY2EpqfWFOffwMP3CnLCOipL/or1sZib9CQWaTbUE
        ZHW+GLGw==;
Received: from [2601:1c0:6280:3f0::371c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYjXd-0004zy-MQ; Sat, 31 Oct 2020 05:35:06 +0000
Subject: Re: [PATCH] PCI: add helper function to find DVSEC
To:     Dave Jiang <dave.jiang@intel.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, david.e.box@intel.com,
        sean.v.kelly@intel.com, ashok.raj@intel.com
References: <160409768616.919324.13994867117217584719.stgit@djiang5-desk3.ch.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b742b19e-7ac6-901d-909a-15fb266ccffe@infradead.org>
Date:   Fri, 30 Oct 2020 22:35:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160409768616.919324.13994867117217584719.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/30/20 3:42 PM, Dave Jiang wrote:
> Add function that searches for DVSEC and returns the offset in PCI
> configuration space for the interested DVSEC capability.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
> 
> The patch has dependency on David Box’s dvsec definition patch:
> https://lore.kernel.org/linux-pci/bc5f059c5bae957daebde699945c80808286bf45.camel@linux.intel.com/T/#m1d0dc12e3b2c739e2c37106a45f325bb8f001774
> 
>  drivers/pci/pci.c   |   30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..49e57b831509 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -589,6 +589,36 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_ext_capability);
>  
> +/**
> + * pci_find_dvsec - return position of DVSEC with provided vendor and DVSEC ID
> + * @dev: the PCI device
> + * @vendor: vendor for the DVSEC
> + * @id: the DVSEC capibility ID

                     capability

> + *
> + * Return the offset of DVSEC on success or -ENOTSUPP if not found

    * Return: the offset of DVSEC on success or -ENOTSUPP if not found

> + */
> +int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
> +{
> +	u16 dev_vendor, dev_id;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return -ENOTSUPP;
> +
> +	while (pos) {
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &dev_vendor);
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &dev_id);
> +		if (dev_vendor == vendor && dev_id == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_dvsec);
> +
>  /**
>   * pci_get_dsn - Read and return the 8-byte Device Serial Number
>   * @dev: PCI device to query
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..6c692d32c82a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1069,6 +1069,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
>  int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>  int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
> +int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  
>  u64 pci_get_dsn(struct pci_dev *dev);
> @@ -1726,6 +1727,8 @@ static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
>  { return 0; }
>  static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
>  { return 0; }
> +static inline int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
> +{ return 0; }

Why shouldn't this return -ENOTSUPP instead of 0?

>  
>  static inline u64 pci_get_dsn(struct pci_dev *dev)
>  { return 0; }
> 
> 

-- 
~Randy

