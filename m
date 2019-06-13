Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866E9446C7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfFMQy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 12:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbfFMCjy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 22:39:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0A2208CA;
        Thu, 13 Jun 2019 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560393592;
        bh=IITyHjiv62SNhJ4yXoRzm4f7+2+5GIlSE+irIAPOEwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAZN3L4pHvi36KeY3wFF29+S+Rf1vVorb8eMMyYAEdD89hesFlqveQcV376mHhamQ
         5btlDzDL6f2O89IrmMl3lGt+06Zf83DuFF3JD9kBn41bB1gMw8wy0U8POMNRIXBuoP
         T8jfC3V0Lq5yhgm7EZN2qo3QwgHqWFedHrKm/xrk=
Date:   Wed, 12 Jun 2019 21:39:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, arnd@arndb.de,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        wangkefeng.wang@huawei.com, linuxarm@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
Message-ID: <20190613023947.GD13533@google.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560262374-67875-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 11, 2019 at 10:12:52PM +0800, John Garry wrote:
> Currently we only use logical PIO low-level accessors for when
> CONFIG_INDIRECT_PIO is enabled.
> 
> Otherwise we just use inb/out et all directly.
> 
> It is useful to now use logical PIO accessors for all cases, so we can add
> legality checks to accesses. Such a check would be for ensuring that the
> PCI IO port has been IO remapped prior to the access.

IIUC, *this* patch doesn't actually add any additional checks, so no
need to mention that in this commit log.

One thing this patch *does* do is "#define inb logic_inb" whenever
PCI_IOBASE is defined (we used to do that #define only when
CONFIG_INDIRECT_PIO was defined).  That's a pretty important change
and needs to be very clear in the commit log.

I'm not sure it's even safe, because CONFIG_INDIRECT_PIO depends on
ARM64, but PCI_IOBASE is defined on most arches via asm-generic/io.h,
so this potentially affects arches other than ARM64.

If possible, split out the cleanup patches as below and make the patch
that does this PCI_IOBASE change as small as possible so we can
evaluate that change by itself.

> Using the logical PIO accesses will add a little processing overhead, but
> that's ok as IO port accesses are relatively slow anyway.
> 
> Some changes are also made to stop spilling so many lines under
> CONFIG_INDIRECT_PIO.

"Some changes are also made" is a good hint to me that this patch
might be able to be split up :)

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/linux/logic_pio.h |  7 ++--
>  lib/logic_pio.c           | 83 ++++++++++++++++++++++++++++-----------
>  2 files changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> index cbd9d8495690..06d22b2ec99f 100644
> --- a/include/linux/logic_pio.h
> +++ b/include/linux/logic_pio.h
> @@ -37,7 +37,7 @@ struct logic_pio_host_ops {
>  		     size_t dwidth, unsigned int count);
>  };
>  
> -#ifdef CONFIG_INDIRECT_PIO
> +#if defined(PCI_IOBASE)

Why change the #ifdef style?  I understand these are equivalent, but
unless there's a movement to change from "#ifdef X" to "#if defined(X)"
I wouldn't bother.

>  u8 logic_inb(unsigned long addr);
>  void logic_outb(u8 value, unsigned long addr);
>  void logic_outw(u16 value, unsigned long addr);
> @@ -102,6 +102,7 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
>  #define outsl logic_outsl
>  #endif
>  
> +#if defined(CONFIG_INDIRECT_PIO)
>  /*
>   * We reserve 0x4000 bytes for Indirect IO as so far this library is only
>   * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
> @@ -109,10 +110,10 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
>   */
>  #define PIO_INDIRECT_SIZE 0x4000
>  #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
> -#else
> +#else /* CONFIG_INDIRECT_PIO */
>  #define MMIO_UPPER_LIMIT IO_SPACE_LIMIT
>  #endif /* CONFIG_INDIRECT_PIO */
> -
> +#endif /* PCI_IOBASE */
>  struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
>  unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
>  			resource_size_t hw_addr, resource_size_t size);
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index feea48fd1a0d..40d9428010e1 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -191,7 +191,8 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
>  	return ~0UL;
>  }
>  
> -#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> +#if defined(PCI_IOBASE)
> +#if defined(CONFIG_INDIRECT_PIO)
>  #define BUILD_LOGIC_IO(bw, type)					\
>  type logic_in##bw(unsigned long addr)					\
>  {									\
> @@ -200,11 +201,11 @@ type logic_in##bw(unsigned long addr)					\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		ret = read##bw(PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\

I don't mind changing "entry" to "range" and adding "sz".  But that
could be done in a separate "no functional change" patch that is
trivial to review, which would make *this* patch smaller and easier to
review.

Another "no functional change" simplification patch would be to
replace this:

  type ret = (type)~0;

  if (addr < MMIO_UPPER_LIMIT) {
    ret = read##bw(...);
  } else if (...) {
    if (range && range->ops)
      ret = range->ops->in(...);
    else
      WARN_ON_ONCE();
  }
  return ret;

with this:

  if (addr < MMIO_UPPER_LIMIT)
    return read##bw(...);

  if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
    if (range && range->ops)
      return range->ops->in(...);
    else
      WARN_ON_ONCE();
  }

  return (type)~0;

Finally, I think the end result would be a little easier to read if
you restructured the #ifdefs like this:

  #ifdef PCI_IOBASE
  #define BUILD_LOGIC_IO(...)
  type logic_in##bw(...)
  {
    if (addr < MMIO_UPPER_LIMIT)
      return read##bw(...);

  #ifdef CONFIG_INDIRECT_PIO
    if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
      if (range && range->ops)
	return range->ops->in(...);
      else
	WARN_ON_ONCE();
    }
  #endif

    return (type)~0;
  }

That does mean a CONFIG_INDIRECT_PIO #ifdef in each in/out/ins/outs
builder, but it's more localized so I think it's easier to understand
that INDIRECT_PIO is just adding a new case to the default path.

> -		if (entry && entry->ops)				\
> -			ret = entry->ops->in(entry->hostdata,		\
> -					addr, sizeof(type));		\
> +		if (range && range->ops)				\
> +			ret = range->ops->in(range->hostdata, addr, sz);\
>  		else							\
>  			WARN_ON_ONCE(1);				\
>  	}								\
> @@ -216,49 +217,83 @@ void logic_out##bw(type value, unsigned long addr)			\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		write##bw(value, PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->out(entry->hostdata,		\
> -					addr, value, sizeof(type));	\
> +		if (range && range->ops)				\
> +			range->ops->out(range->hostdata,		\
> +					addr, value, sz);		\
>  		else							\
>  			WARN_ON_ONCE(1);				\
>  	}								\
>  }									\
>  									\
> -void logic_ins##bw(unsigned long addr, void *buffer,		\
> -		   unsigned int count)					\
> +void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>  {									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
> -		reads##bw(PCI_IOBASE + addr, buffer, count);		\
> +		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->ins(entry->hostdata,		\
> -				addr, buffer, sizeof(type), count);	\
> +		if (range && range->ops)				\
> +			range->ops->ins(range->hostdata,		\
> +					addr, buf, sz, cnt);		\
>  		else							\
>  			WARN_ON_ONCE(1);				\
>  	}								\
>  									\
>  }									\
>  									\
> -void logic_outs##bw(unsigned long addr, const void *buffer,		\
> -		    unsigned int count)					\
> +void logic_outs##bw(unsigned long addr, const void *buf,		\
> +		    unsigned int cnt)					\
>  {									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
> -		writes##bw(PCI_IOBASE + addr, buffer, count);		\
> +		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->outs(entry->hostdata,		\
> -				addr, buffer, sizeof(type), count);	\
> +		if (range && range->ops)				\
> +			range->ops->outs(range->hostdata,		\
> +					 addr, buf, sz, cnt);		\
>  		else							\
>  			WARN_ON_ONCE(1);				\
>  	}								\
>  }
>  
> +#else /* CONFIG_INDIRECT_PIO */
> +
> +#define BUILD_LOGIC_IO(bw, type)					\
> +type logic_in##bw(unsigned long addr)					\
> +{									\
> +	type ret = (type)~0;						\
> +									\
> +	if (addr < MMIO_UPPER_LIMIT)					\
> +		ret = read##bw(PCI_IOBASE + addr);			\
> +	return ret;							\
> +}									\
> +									\
> +void logic_out##bw(type value, unsigned long addr)			\
> +{									\
> +	if (addr < MMIO_UPPER_LIMIT)					\
> +		write##bw(value, PCI_IOBASE + addr);			\
> +}									\
> +									\
> +void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
> +{									\
> +	if (addr < MMIO_UPPER_LIMIT)					\
> +		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
> +}									\
> +									\
> +void logic_outs##bw(unsigned long addr, const void *buf,		\
> +		    unsigned int cnt)					\
> +{									\
> +	if (addr < MMIO_UPPER_LIMIT)					\
> +		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
> +}
> +#endif /* CONFIG_INDIRECT_PIO */
> +
>  BUILD_LOGIC_IO(b, u8)
>  EXPORT_SYMBOL(logic_inb);
>  EXPORT_SYMBOL(logic_insb);
> @@ -277,4 +312,4 @@ EXPORT_SYMBOL(logic_insl);
>  EXPORT_SYMBOL(logic_outl);
>  EXPORT_SYMBOL(logic_outsl);
>  
> -#endif /* CONFIG_INDIRECT_PIO && PCI_IOBASE */
> +#endif /* PCI_IOBASE */
> -- 
> 2.17.1
> 
