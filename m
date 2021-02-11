Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF893187B2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBKKDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhBKKAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 05:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28C9364E92;
        Thu, 11 Feb 2021 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613037569;
        bh=Zj8EM5Xx2JdkHBzV0ZcjFswDPawBzyPCgGJvYO+nIu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWWZoRuP1RODcWAYJNKCM5+kpL3fmGLyr9DvCV/ZQ2eEJ9z2skeQfz363Q4jD0lYz
         MpLPk2vG4KdlTlTSuyCCd5cDnCUEfeI0AbHRukiZXBQtUL1zLIkwXtcf/TXrA7psuM
         wR5GQzW5oQqTSOsmK3tCpvjatd85poXQ9XDi/UOU=
Date:   Thu, 11 Feb 2021 10:59:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YCT//nmQpOJD9row@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT5KDnAWex8fvbz@kroah.com>
 <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 09:50:33AM +0000, Gustavo Pimentel wrote:
> On Thu, Feb 11, 2021 at 9:30:16, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > +static ssize_t write_show(struct device *dev, struct device_attribute *attr,
> > > +			  char *buf)
> > > +{
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> > > +	u64 rate;
> > > +
> > > +	mutex_lock(&dw->mutex);
> > > +	dw_xdata_perf(dw, &rate, true);
> > > +	mutex_unlock(&dw->mutex);
> > > +
> > > +	return sysfs_emit(buf, "%llu MB/s\n", rate);
> > 
> > Do not put units in a sysfs file, that should be in the documentation,
> > otherwise this forces userspace to "parse" the units which is a mess.
> 
> Okay.
> 
> > 
> > Same for the other sysfs file.
> > 
> > And why do you need a lock for this show function?
> 
> Maybe I understood it wrongly, please correct me in that case. The 
> dw_xdata_perf() is called on the write_show() and read_show(), to avoid a 
> possible race condition between those calls, I have added this mutex.

What race?  If the value changes with a write right after a read, what
does it matter?

What exactly are you trying to protect with this lock?

thanks,

greg k-h
