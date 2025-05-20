Return-Path: <linux-pci+bounces-28126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B9ABE0B3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645CC162FC8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC722D78D;
	Tue, 20 May 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZPrfh52"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03F2B9A9;
	Tue, 20 May 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758663; cv=none; b=GXbj+foCmV8eCB8Rm3RX1GmMucklbKYi7nTYBbiqLLHT6mPivmxIptsdGKl7ds6uhRynbm3NKv976vQvYOWMwSFFxf/Jmalc8PEnDx/iG6PNcO93IxkZunVNzPeD+3WgCofU7Gg2zOVG9whGT1Fbp2dnSwcPQBsa2t5TPEg4NF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758663; c=relaxed/simple;
	bh=Hem8uB3zD/uymJ9qJM41N8VYIt7YRxLcq73u4y3iXZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sUYaNraYH3Y0+MgpDbweSn4wigLYDrILCwk6N9RQpMOiEheOTwXv1T5dFTzxWs+m3wehZ1h/exAsTTJzpkQq25VxZhsPyHoEKKca3hMWNmYqyr2AyLmXLnc3HyXhezfT612vkellPiT0FCQOB08IFKlhrepJQT5H7Y9SdXQ+Gmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZPrfh52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5206CC4CEE9;
	Tue, 20 May 2025 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747758662;
	bh=Hem8uB3zD/uymJ9qJM41N8VYIt7YRxLcq73u4y3iXZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qZPrfh52H9nmCtaZEzHwRsuSjNG60L8K+op7YjP/4d3Clt8YrQ61bHb4RMRebkQYp
	 ZlfbFO/xEeyf3YewDEOrx+Gsz/ioRAER2UxfGLorG8iVIO7cNDTqMWBFQ9n2/f1+5p
	 GaUbj1QCopmcrQvH294U3xHiBoEaRf0UPLpni9r23pLebn/8/003ycFdkfhuI2VLlt
	 BLLWuhfkeGcf26KXqG192DtM77svvxhattM5I7y1gXS+2A5aZTh+G+/KIZFjAuGbT9
	 CSBhrSR1NKdXdr06Ibm3CHtR7lB9c9Z5ns4XBHRJzFPUd1oFaKN9HSZLBplRI/Alg7
	 TSa9BmbDkwVWQ==
Date: Tue, 20 May 2025 11:31:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 16/16] PCI/AER: Add sysfs attributes for log ratelimits
Message-ID: <20250520163100.GA1307206@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe3d2a5-fe32-ca35-98f5-812da367dc99@linux.intel.com>

On Tue, May 20, 2025 at 03:02:06PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> 
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Allow userspace to read/write log ratelimits per device (including
> > enable/disable). Create aer/ sysfs directory to store them and any
> > future aer configs.
> > 
> > Update AER sysfs ABI filename to reflect the broader scope of AER sysfs
> > attributes (e.g. stats and ratelimits).
> > 
> >   Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats ->
> >     sysfs-bus-pci-devices-aer
> > 
> > Tested using aer-inject[1]. Configured correctable log ratelimit to 5.
> > Sent 6 AER errors. Observed 5 errors logged while AER stats
> > (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) shows 6.
> > 
> > Disabled ratelimiting and sent 6 more AER errors. Observed all 6 errors
> > logged and accounted in AER stats (12 total errors).
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> > 
> > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  ...es-aer_stats => sysfs-bus-pci-devices-aer} | 34 +++++++
> >  Documentation/PCI/pcieaer-howto.rst           |  5 +-
> >  drivers/pci/pci-sysfs.c                       |  1 +
> >  drivers/pci/pci.h                             |  1 +
> >  drivers/pci/pcie/aer.c                        | 99 +++++++++++++++++++
> >  5 files changed, 139 insertions(+), 1 deletion(-)
> >  rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > similarity index 77%
> > rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> > rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > index d1f67bb81d5d..771204197b71 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > @@ -117,3 +117,37 @@ Date:		July 2018
> >  KernelVersion:	4.19.0
> >  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
> >  Description:	Total number of ERR_NONFATAL messages reported to rootport.
> > +
> > +PCIe AER ratelimits
> > +-------------------
> > +
> > +These attributes show up under all the devices that are AER capable.
> > +They represent configurable ratelimits of logs per error type.
> > +
> > +See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
> > +
> > +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_log_enable
> > +Date:		March 2025
> > +KernelVersion:	6.15.0
> 
> This ship has sailed.

Updated to May 2025 and 6.16.0 (I hope :)).

> > +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> > +Description:	Writing 1/0 enables/disables AER log ratelimiting. Reading
> > +		gets whether or not AER is currently enabled.
> 
> AER or AER ratelimiting is enabled?

I think we want "AER ratelimiting" here, thanks!

> > + * Ratelimit enable toggle
> > + * 0: disabled with ratelimit.interval = 0
> > + * 1: enabled with ratelimit.interval = nonzero
> > + */
> > +static ssize_t ratelimit_log_enable_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	bool enabled = pdev->aer_report->cor_log_ratelimit.interval != 0;
> > +
> > +	return sysfs_emit(buf, "%d\n", enabled);
> > +}
> > +
> > +static ssize_t ratelimit_log_enable_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	bool enable;
> > +	int interval;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (kstrtobool(buf, &enable) < 0)
> > +		return -EINVAL;
> > +
> > +	if (enable)
> > +		interval = DEFAULT_RATELIMIT_INTERVAL;
> > +	else
> > +		interval = 0;
> > +
> > +	pdev->aer_report->cor_log_ratelimit.interval = interval;
> > +	pdev->aer_report->uncor_log_ratelimit.interval = interval;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(ratelimit_log_enable);

