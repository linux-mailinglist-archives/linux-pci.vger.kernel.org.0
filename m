Return-Path: <linux-pci+bounces-22295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FBA43781
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071B11898BF2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2452627E7;
	Tue, 25 Feb 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M7aN0UOp"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692D25EFBA;
	Tue, 25 Feb 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471529; cv=none; b=YUUriX0rNq3A4CpbUYOvM9L9emsA4crMx0WglVfFyoPJj0rAR5diQaf7wpAW7KnoP4qER/a3TOIbx2sgPm7XIQsGAATcC0XJot4MzuegJMKg4ZxCx+uJlQD+G6UCk5Hh6LX3WJcpI0TMx5eXZYpqzv5B1VoqePgyaTZzX3tcZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471529; c=relaxed/simple;
	bh=aAEij0s3AFK49t2u7VbLu49lBeb4N8gA0Qn/alK+8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFnPMUEGVh3cjmnSWSsUkPZmqjqItSgAIM2EamOct5rZoJf6pDbVbOKj35dDR0IqhsQQivoao95LPIyOczzaaOgq/lV5TR7fc5HsMwUqMdryTR9LjPn7S4A+IB60tqka4WyTuMeMrd1DdA2if59A12hRx2iSo9xdI/DchuELyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M7aN0UOp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740471518; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=I1uXO/DS+IQ3WG9a33egswv7VHDYKVeFvkKUZfgvUwk=;
	b=M7aN0UOp5zPBfVqznrL89htm/RxetNnybl2xPmm0PtD5jTd+YM2KEJWs1qN69JIrELaY0AnYLfU4A72p51oJRySJKlQqUlYm9MjL2KVWNyZPK51YNz08PvCTmW4Fq37kHFUOvwkwITp0sEeXbLt8I0W3w43bGg6kM6+3Ht0+HgU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQDqRf9_1740471517 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 16:18:37 +0800
Date: Tue, 25 Feb 2025 16:18:36 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] PCI: portdrv: pciehp: Move PCIe hotplug command
 waiting logic to port driver
Message-ID: <Z7183Dbg5QbgQj10@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-2-feng.tang@linux.alibaba.com>
 <f0f8f376-9f9c-16ce-9683-f09e088bdc22@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0f8f376-9f9c-16ce-9683-f09e088bdc22@linux.intel.com>

Hi Ilpo,

On Mon, Feb 24, 2025 at 05:06:26PM +0200, Ilpo Järvinen wrote:
> On Mon, 24 Feb 2025, Feng Tang wrote:
> 
> > According to PCIe spec, after sending a hotplug command, software should
> > wait some time for the command completion. Currently the waiting logic
> 
> Where is it in the spec, please put a more precise reference.

Will do, if the patch is kept.
> 
> > is implemented in pciehp driver, as the same logic will be reused by
> > PCIe port driver, move it to port driver, which complies with the logic
> > of CONFIG_HOTPLUG_PCI_PCIE depending on CONFIG_PCIEPORTBUS.
> > 
> > Also convert the loop wait logic to helper read_poll_timeout() as
> > suggested by Sathyanarayanan Kuppuswamy.
> 
> You could express the second part of this with a tag:
> 
> Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> # Use to read_poll_timeout()

Thanks for the suggestion!

> 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++------------------------
> >  drivers/pci/pci.h                |  5 +++++
> >  drivers/pci/pcie/portdrv.c       | 25 +++++++++++++++++++++
> >  3 files changed, 39 insertions(+), 29 deletions(-)
[...]

> >  
> > +/* Return 0 on command completed on time, otherwise return -ETIMEOUT */
> 
> Since you're making this visible outside of the file, please document this 
> properly using a kerneldoc compliant comment.

OK.

> 
> > +int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
> > +{
> > +	u16 slot_status = 0;
> > +	u32 slot_cap;
> > +	int ret = 0;
> 
> Unnecessary initialization.

The initialization is actually used below.
> 
> > +	int __maybe_unused ret1;
> > +
> > +	/* Don't wait if the command complete event is not well supported */
> > +	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
> > +	if (!(slot_cap & PCI_EXP_SLTCAP_HPC) || slot_cap & PCI_EXP_SLTCAP_NCCS)
> > +		return ret;

Used here to return early if the event is not supported.

> > +
> > +	ret = read_poll_timeout(pcie_capability_read_word, ret1,
> > +				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
> > +				timeout_ms * 1000, true, dev, PCI_EXP_SLTSTA,
> 
> Replace:
>         10000 -> 10 * USEC_PER_MSEC
>         timeout_ms * 1000 -> USEC_PER_SEC (the variable can be dropped)
> 
> Please also check you have linux/units.h included for those defines.

Will use the macros, which are indeed self-describing. 

If you are referring 'timeout_ms', I don't think it can be dropped as
it is needed in the logic of pcie_poll_cmd().

> > +				&slot_status);
> > +	if (!ret)
> 
> Use the normal error handling logic by reversing the condition.
> 
> > +		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
> > +						PCI_EXP_SLTSTA_CC);
> > +
> > +	return  ret;
> 
> Remove extra space but this will become return 0; once the error handling 
> is done with the usual pattern.

This is not error handling, but rather "normal" and "expected", that
the command-completed bit is set and will be cleared here.

Thanks,
Feng

> 
> > +}
> > +
> >  /**
> >   * get_port_device_capability - discover capabilities of a PCI Express port
> >   * @dev: PCI Express port to examine
> > 
> 
> -- 
>  i.

