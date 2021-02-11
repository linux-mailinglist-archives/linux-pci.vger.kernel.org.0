Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B3318850
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhBKKgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBKKeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 05:34:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B3964E01;
        Thu, 11 Feb 2021 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613039609;
        bh=cXsCKIo6t7y9suqyuT1kz/DnYOo45INEomlNnDReod0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l78m0+5GidaiYGieGogBdTs74ImmqQBrQQJ55JXksub3LWxcV1jc5QF0ipcqjU2Jn
         yKyfijvxh19Vjo1xCvxZDimVgtdj+Tjlsw3CMgoyVAHCrlap8MVTJETQVOTPwhjtdQ
         JgPxRRQdAnIWqAkaynezCQY//nEI/3+w3wKmOkt0=
Date:   Thu, 11 Feb 2021 11:33:25 +0100
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
Message-ID: <YCUH9eCwiJiB5t3g@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT5KDnAWex8fvbz@kroah.com>
 <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCT//nmQpOJD9row@kroah.com>
 <DM5PR12MB1835522220E35874106BB924DA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1835522220E35874106BB924DA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:21:07AM +0000, Gustavo Pimentel wrote:
> On Thu, Feb 11, 2021 at 9:59:26, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Feb 11, 2021 at 09:50:33AM +0000, Gustavo Pimentel wrote:
> > > On Thu, Feb 11, 2021 at 9:30:16, Greg Kroah-Hartman 
> > > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > > > +static ssize_t write_show(struct device *dev, struct device_attribute *attr,
> > > > > +			  char *buf)
> > > > > +{
> > > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> > > > > +	u64 rate;
> > > > > +
> > > > > +	mutex_lock(&dw->mutex);
> > > > > +	dw_xdata_perf(dw, &rate, true);
> > > > > +	mutex_unlock(&dw->mutex);
> > > > > +
> > > > > +	return sysfs_emit(buf, "%llu MB/s\n", rate);
> > > > 
> > > > Do not put units in a sysfs file, that should be in the documentation,
> > > > otherwise this forces userspace to "parse" the units which is a mess.
> > > 
> > > Okay.
> > > 
> > > > 
> > > > Same for the other sysfs file.
> > > > 
> > > > And why do you need a lock for this show function?
> > > 
> > > Maybe I understood it wrongly, please correct me in that case. The 
> > > dw_xdata_perf() is called on the write_show() and read_show(), to avoid a 
> > > possible race condition between those calls, I have added this mutex.
> > 
> > What race?  If the value changes with a write right after a read, what
> > does it matter?
> > 
> > What exactly are you trying to protect with this lock?
> 
> The write_store() does a procedure to enable the traffic on the write 
> direction, however, the write_show() does a different procedure to 
> calculate the link throughput speed, which uses a different set of 
> registers on the HW.
> 
> Similar happens on the read_store() (which enable the traffic on the read 
> direction) and on the read_show()
> 
> To summarize write_store() follows the same approach of read_store() and 
> the write_show() of the read_show(). I added the mutex on those functions 
> for instance to avoid while during the write_show() call the possibility 
> of been called the read_show() messing up the link throughput speed 
> calculation.
> Or while during the write_store() call to be called the read_store or 
> even the write_show() for the same reasons.

If you need to protect these types of things, but the lock down in the
function that does this, not above it which forces people to audit
everything and manually try to determine what lock is doing what for
what.

Make it impossible to get wrong, as it is, you have to do extra work
here to keep things working properly, always a bad idea in an api.

thanks,

greg k-h
