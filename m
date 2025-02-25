Return-Path: <linux-pci+bounces-22289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE9A434D3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 06:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042217A5645
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC70254856;
	Tue, 25 Feb 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NfPhTd+4"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87C1527B4;
	Tue, 25 Feb 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462692; cv=none; b=TsAsCJZoeFVco/S7dnWgV4I4skEfgeVinVThe6yF2NrK+6c3jBM8mMYHfhhV5+tmdvh9904j4dBn3cYOU7ypI4ONuvKhCDy0GU9o63kxqnPLYFdiiJinn3CzOW6s8BqvNi4ogRZfb+P7Bknl7eUGja6LaQ/u7wObVpAPDVkS0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462692; c=relaxed/simple;
	bh=uSeNCFcf9l+vWtdG/0tKAMg223d8tkTSUki3qIrQlxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGw35dUBsse0kMUiBs6SyCARYCz9Axw/yTSjeQRlocFEmC05YDwnyrfQSAOz42jTM8qWqDbv2oNumzwn8Ad/gDWCuoUEPWQHG9p2NcCiJzboys04YfurQEgbpss+l+01oQTNJAHqiGMZCFlgYI5vDKhXdEoS0/YgpRaq4CwqzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NfPhTd+4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740462677; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0r00Uji6tpD1hBuVL7S7gy2Eu/d/pslK9pXro2M2coM=;
	b=NfPhTd+4Rn3OfJez/IGJX8a32L/+AouDT9jXbZed3dRg2YUL8DsDDbSbsRTiL/gCMZ+hmasq/MO0LV2bzX7/1lcJVc1IxDVnZz5Xq3+re3y4r7e+Hag03OTOAM/ieJU+sf+/pVq2O4JVvN8/4rbkT4O0McYbZ1al9Vg26Hvh4w0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQDSZrT_1740462675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 13:51:16 +0800
Date: Tue, 25 Feb 2025 13:51:15 +0800
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
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z71aU3ZOQf2xGHp_@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <abb50795-df83-511a-8850-cdf30f187935@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb50795-df83-511a-8850-cdf30f187935@linux.intel.com>

Hi Ilpo, 

On Mon, Feb 24, 2025 at 05:00:03PM +0200, Ilpo Järvinen wrote:
> On Mon, 24 Feb 2025, Feng Tang wrote:
> 
> > There was problem reported by firmware developers that they received
> > two PCIe hotplug commands in very short intervals on an ARM server,
> > which doesn't comply with PCIe spec, and broke their state machine and
> > work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> > to wait at least 1 second for the command-complete event, before
> > resending the command or sending a new command.
> > 
> > In the failure case, the first PCIe hotplug command firmware received
> > is from get_port_device_capability(), which sends command to disable
> > PCIe hotplug interrupts without waiting for its completion, and the
> > second command comes from pcie_enable_notification() of pciehp driver,
> > which enables hotplug interrupts again.
> > 
> > Fix it by adding the necessary wait to comply with PCIe spec.
> > 
> > Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> > Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >  drivers/pci/pci.h          |  2 ++
> >  drivers/pci/pcie/portdrv.c | 19 +++++++++++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 4c94a589de4a..a1138ebc2689 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -760,6 +760,7 @@ static inline void pcie_ecrc_get_policy(char *str) { }
> >  void pcie_reset_lbms_count(struct pci_dev *port);
> >  int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> >  int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms);
> > +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
> >  #else
> >  static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
> >  static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> > @@ -770,6 +771,7 @@ static inline int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
> >  {
> >  	return 0;
> >  }
> > +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
> >  #endif
> >  
> >  struct pci_dev_reset_methods {
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index bb00ba45ee51..ca4f21dff486 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -230,6 +230,22 @@ int pcie_poll_sltctl_cmd(struct pci_dev *dev, int timeout_ms)
> >  	return  ret;
> >  }
> >  
> > +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> > +{
> > +	u16 slot_ctrl = 0;
> 
> Unnecessary initialization
 
The reason I put it to 0 is, very unlikely, the pcie_capability_read_word()
might fail, and 0 can avoid the early return.

> > +
> > +	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
> > +	/* Bail out early if it is already disabled */
> > +	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
> > +		return;
> > +
> > +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> 
> Align to (. You might need to put the bits to own lines.

OK.

> > +
> > +	if (pcie_poll_sltctl_cmd(dev, 1000))
> > +		pci_info(dev, "Timeout on disabling PCIe hot-plug interrupt\n");
> > +}
> > +
> >  /**
> >   * get_port_device_capability - discover capabilities of a PCI Express port
> >   * @dev: PCI Express port to examine
> > @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  		 * Disable hot-plug interrupts in case they have been enabled
> >  		 * by the BIOS and the hot-plug service driver is not loaded.
> >  		 */
> > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > +		pcie_disable_hp_interrupts_early(dev);
> 
> Doesn't calling this here delay setup for all portdrv services, not just 
> hotplug? And the delay can be relatively long.

I don't quite follow, physically there is only one root port, the code
from commit 2bd50dd800b5 just does it once. Also the 1 second is just the
maxim waiting time, the wait will end once the command completed event
bit is set. The exact time depends on platform (x86 and ARM) and the
firmeware implementation, and it is much smaller than 1 second AFAIK.

Thanks,
Feng

> >  	}
> >  
> >  #ifdef CONFIG_PCIEAER
> > 
> 
> -- 
>  i.

