Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E43F53DD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 01:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhHWX45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 19:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233278AbhHWX45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 19:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629762973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RF+d9qpVprIgoIZ0mXGZUwRPD3HGuqO+bXOLg0En698=;
        b=TjrQUVXiJRnZm5zdmiMSgNJM8Mz4QUaHHG/Z62UymjbI9HNCRXB352A6+ylM01kehZPLga
        fgigsL7HPBFhN0gZspn969usecXH5HSrik36Km+PHQI4BB3usiez5X4n5XiC6jSG50ncdU
        IiWUJTngOLA0p4IKybgaISdO8LX6qxw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-pIH0Jy3XNL2dS5m_R01yrQ-1; Mon, 23 Aug 2021 19:56:11 -0400
X-MC-Unique: pIH0Jy3XNL2dS5m_R01yrQ-1
Received: by mail-ed1-f70.google.com with SMTP id v13-20020a056402174d00b003c25d6b2f13so2860957edx.4
        for <linux-pci@vger.kernel.org>; Mon, 23 Aug 2021 16:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RF+d9qpVprIgoIZ0mXGZUwRPD3HGuqO+bXOLg0En698=;
        b=DZ+7nG043uAf0iyuLU1Pc0+JeeI0gWAlty5HY2zzL/ZGUaHP+UzBSYGsOSjcRUHqaX
         e41zwz2iwxFKJD+WxJkGb/0/OIoh2wxmJD3Iv/zXDlpfPIZ94dfjLgO8Qh5i5REkAvpK
         3xf7u/FMln6ymhNfqlEfu6JaAXHdK2CPKYelvZgzS1hTLE63GmpxhBku4HKxZhZwWfg9
         D432Z3r2tzb/pNJITlV3qdJvky4ly2C8DpJqsmD6sqi9MSPjEcKYL84ClsHz21uTBHJ4
         lF4B8NF0wqdgo2mY+vMfpAWlrMdSh0YHigGtdxBiLRioWWYC8EXWPn4gbtozr82ynYGR
         bRMQ==
X-Gm-Message-State: AOAM531DG80UmLghX0qUT5V495VF4Y76s83FtCJyMbLltv5h+2DHk/Tl
        3d5HkxRsL5lma4xHBCUZKsGFVXmMrapaUsh/bjHpP+ondRw27gMkAARBLqvZkWKrODk4wG5SgpX
        G2jUo4/i5FnDxhU7I3Cne
X-Received: by 2002:a17:907:2cf1:: with SMTP id hz17mr32841065ejc.438.1629762970797;
        Mon, 23 Aug 2021 16:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlg8FJcUqFiderk/GNwJI39sbQlYErPR6APlNK/zjSzsj+DjKP0nKP8p+wjD6AR325FzPuGA==
X-Received: by 2002:a17:907:2cf1:: with SMTP id hz17mr32841039ejc.438.1629762970610;
        Mon, 23 Aug 2021 16:56:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id m17sm4928372ejr.27.2021.08.23.16.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:56:09 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:56:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210823195409-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 05:52:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a new variant of pci_iomap for mapping all PCI resources
> of a devices as shared memory with a hypervisor in a confidential
> guest.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

I'm a bit puzzled by this part. So why should the guest *not* map
pci memory as shared? And if the answer is never (as it seems to be)
then why not just make regular pci_iomap DTRT?

Thanks!

> ---
>  include/asm-generic/pci_iomap.h |  6 +++++
>  lib/pci_iomap.c                 | 46 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index d4f16dcc2ed7..0178ddd7ad88 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -18,6 +18,12 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
>  					unsigned long offset,
>  					unsigned long maxlen);
> +extern void __iomem *pci_iomap_shared(struct pci_dev *dev, int bar,
> +				      unsigned long max);
> +extern void __iomem *pci_iomap_shared_range(struct pci_dev *dev, int bar,
> +					    unsigned long offset,
> +					    unsigned long maxlen);
> +
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectures
>   * to override */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 6251c3f651c6..b04e8689eab3 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -25,6 +25,11 @@ static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
>  	return ioremap_wc(addr, size);
>  }
>  
> +static void __iomem *map_ioremap_shared(phys_addr_t addr, size_t size)
> +{
> +	return ioremap_shared(addr, size);
> +}
> +
>  static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
>  					 int bar,
>  					 unsigned long offset,
> @@ -101,6 +106,47 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
>  
> +/**
> + * pci_iomap_shared_range - create a virtual shared mapping cookie for a
> + *                          PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Remap a pci device's resources shared in a confidential guest.
> + * For more details see pci_iomap_range's documentation.
> + *
> + * @maxlen specifies the maximum length to map. To get access to
> + * the complete BAR from offset to the end, pass %0 here.
> + */
> +void __iomem *pci_iomap_shared_range(struct pci_dev *dev, int bar,
> +				     unsigned long offset, unsigned long maxlen)
> +{
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap_shared);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_shared_range);
> +
> +/**
> + * pci_iomap_shared - create a virtual shared mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * See pci_iomap for details. This function creates a shared mapping
> + * with the host for confidential hosts.
> + *
> + * @maxlen specifies the maximum length to map. To get access to the
> + * complete BAR without checking for its length first, pass %0 here.
> + */
> +void __iomem *pci_iomap_shared(struct pci_dev *dev, int bar,
> +			       unsigned long maxlen)
> +{
> +	return pci_iomap_shared_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_shared);
> +
>  /**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> -- 
> 2.25.1

