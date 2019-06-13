Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1C438D7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfFMPJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732364AbfFMN61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 09:58:27 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614EB20673;
        Thu, 13 Jun 2019 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560434306;
        bh=Ue3Z7U9hr74Z8GIjZ585RF0eCSwfODtZtHlyBbMZnKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I11A0m7YsjaGCU0KvbICAk2pDIL3R4p/wm2jSc5Abg2a+vVhGz234KAI2DV/7CXpn
         iyBhVQSfqQQRPqQj8XKdIyzVIyqI0ROflt+OWK9d4EL7FSYt8MStkxNeoIMN4XvYOD
         CZbWAbmLkVfFIEQMLjJLyrNqOom4y0cL/YG6UViU=
Date:   Thu, 13 Jun 2019 08:58:25 -0500
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
Message-ID: <20190613135825.GG13533@google.com>
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
Another thought here:

>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		ret = read##bw(PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
> +		size_t sz = sizeof(type);				\
>  									\
> -		if (entry && entry->ops)				\
> -			ret = entry->ops->in(entry->hostdata,		\
> -					addr, sizeof(type));		\
> +		if (range && range->ops)				\
> +			ret = range->ops->in(range->hostdata, addr, sz);\
>  		else							\
>  			WARN_ON_ONCE(1);				\

Could this be simplified a little by requiring callers to set
range->ops for LOGIC_PIO_INDIRECT ranges *before* calling
logic_pio_register_range()?  E.g.,

  hisi_lpc_probe(...)
  {
    range = devm_kzalloc(...);
    range->flags = LOGIC_PIO_INDIRECT;
    range->ops = &hisi_lpc_ops;
    logic_pio_register_range(range);
    ...

and

  logic_pio_register_range(struct logic_pio_hwaddr *new_range)
  {
    if (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops)
      return -EINVAL;
    ...

Then maybe you wouldn't need to check range->ops in the accessors.

Bjorn
