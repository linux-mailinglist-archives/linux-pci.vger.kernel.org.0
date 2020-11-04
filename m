Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161E2A6E8B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgKDULo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 15:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgKDULo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 15:11:44 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8980720759;
        Wed,  4 Nov 2020 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604520702;
        bh=BZuoiWNP5YUNV8L2knespd8jVS/WNI51dRzjtd+WsSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XnZP0M0metvuOsf2SZW4yTqrtWx8Q/evxyeidLv9FTIihD7RxJRWPW//M6t6ARD5N
         NmA8SYHJvPuHtv/uFJxqHvTy1ftZ7ASghK/28LrUxNvMHXtZWznyIv5BljWrw5pJkE
         1RVAZff32p6TF0xC6LwF3xPhxb28/Gr+RZ2M0h90=
Date:   Wed, 4 Nov 2020 14:11:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        david.e.box@intel.com, sean.v.kelley@intel.com,
        ashok.raj@intel.com, rdunlap@infradead.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] PCI: add helper function to find DVSEC
Message-ID: <20201104201141.GA399378@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160441629367.1427673.8803864097727237280.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 08:12:28AM -0700, Dave Jiang wrote:
> Add function that searches for DVSEC and returns the offset in PCI
> configuration space for the interested DVSEC capability.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

I'm sorry, I screwed this up.  I should have merged the
PCI_EXT_CAP_ID_DVSEC definitions and pci_find_dvsec() for v5.11 to
resolve the mess of dependencies, but I didn't.  Lee applied the
#defines already [1], but I think we're going to have a similar
problem with multiple features that want to add pci_find_dvsec() but
be merged via different trees.

I'm a simple-minded git user, and I don't want to mess with merging
Lee's branch into my tree, so I think the easiest thing would be for
each of these features to implement their own static version of
pci_find_dvsec() (and the DVSEC #defines, if necessary) in the series
that needs it.  That way all the series can be merged independently,
and we can deduplicate them in a future cycle.

So I'm going to drop this for now and assume you'll move it to the
file that uses it and include it in that series.

The patch itself looks good.  Thanks for changing the "not found"
return value to 0.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=ib-mfd-x86-5.11&id=1dc2da5cd51f648de6d1df87e2bc6ea13f72f19c

> ---
> 
> v2:
> - Comment fixups (Randy)
> - Function return 0 on fail to be consistent with other find cap functions.  (Randy)
> 
>  drivers/pci/pci.c   |   30 ++++++++++++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..09208a31114a 100644
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
> + * @id: the DVSEC capability ID
> + *
> + * Return: the offset of DVSEC on success or 0 if not found
> + */
> +int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
> +{
> +	u16 dev_vendor, dev_id;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
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
> +	return 0;
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
>  
>  static inline u64 pci_get_dsn(struct pci_dev *dev)
>  { return 0; }
> 
> 
