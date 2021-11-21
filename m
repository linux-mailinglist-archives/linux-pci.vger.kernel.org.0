Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E75458557
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 18:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhKURVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 12:21:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:28944 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhKURVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Nov 2021 12:21:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="234504093"
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="234504093"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 09:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="595517457"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2021 09:18:25 -0800
Received: from mradosav-MOBL1.amr.corp.intel.com (unknown [10.252.142.12])
        by linux.intel.com (Postfix) with ESMTP id 3D3AC5807C5;
        Sun, 21 Nov 2021 09:18:25 -0800 (PST)
Message-ID: <4d8ba355de09a4a806b6075305ca8d7156dc70ef.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Sun, 21 Nov 2021 09:18:25 -0800
In-Reply-To: <YZo8HUxx8LNgOMeK@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
         <20211120231705.189969-5-david.e.box@linux.intel.com>
         <YZo8HUxx8LNgOMeK@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

On Sun, 2021-11-21 at 13:31 +0100, Greg KH wrote:
> On Sat, Nov 20, 2021 at 03:17:05PM -0800, David E. Box wrote:
> > +static ssize_t registers_read(struct file *filp, struct kobject *kobj,
> > +			      struct bin_attribute *attr, char *buf, loff_t off,
> > +			      size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> > +	void __iomem *addr = priv->regs_addr;
> > +
> > +	memcpy_fromio(buf, addr + off, count);
> 
> Oh nice, this will be fun if I provide "interesting" values for off to
> the function right?
> 
> Remember:
> 	All input is evil.

I was relying on sysfs_kf_bin_read() which checks off (pos) before calling us.

        if (size) {
                if (pos >= size)
                        return 0;
                if (pos + count > size)
                        count = size - pos;
        }

> 
> > +
> > +	return count;
> > +}
> > +static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
> > +
> > +static struct bin_attribute *sdsi_bin_attrs[] = {
> > +	&bin_attr_registers,
> > +	&bin_attr_state_certificate,
> > +	&bin_attr_provision_akc,
> > +	&bin_attr_provision_cap,
> > +	NULL
> > +};
> > +
> > +static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
> > char *buf)
> > +{
> > +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "0x%x\n", priv->guid);
> 
> sysfs_emit() please.
> 
> These sysfs attributes are crazy.  Who has audited them to be correct
> and work properly? It feels like there are just buffer overflows
> waiting to be exploited in them due to the reading/writing of raw memory
> buffers all over the place.

Agree with the concern. I can submit the tests that were used. Is selftests the
best place?

> 
> Where is the userspace tool that uses these files?

The tool will be published in the same github repo as the spec once the driver
is ready.

Thanks.

David

> 
> thanks,
> 
> greg k-h

