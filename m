Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540EF3AA265
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFPR3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 13:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhFPR3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 13:29:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73D4160D07;
        Wed, 16 Jun 2021 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623864465;
        bh=DOHk4jFxa0NKi1FRc0HymIfKoP5GJ5H3EDosFnFv5Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLrPfuXgXvISAFK/Xj3+3dMcYQ5Y+BoJFpphr24AQUF3EzaPFFzeEYNguSozK4i2L
         IO8wv/q/84ImD66N3hh6pumYPGdcd7PMwFgoE8ti2l1OwM4bTQ/HgYTjukAF5YIIF+
         gLxtazSVeY/wcbQoVVllYASxgJlT7HYXAq7FpBARhcovkECI7vhDTUqHs1ZNVl+4t/
         D7VYtaxspe5ZwwuYyBkWhks2ojHGEePp0o2nWDlI+ab/zKC7amfUPoLzrL0wgNc8A4
         np/EwmWDPlxr6DjaF/KKCMdRAUYNlVmF/H/6gt7I7bnsaS1Dp9cX4yfiN363C0fPrZ
         bzea0zQym0dEw==
Date:   Wed, 16 Jun 2021 18:27:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "liuqi (BA)" <liuqi115@huawei.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linuxarm <linuxarm@huawei.com>, mark.rutland@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210616172739.GA23280@willie-the-truck>
References: <d2524d34-648a-8667-dde9-3686bd4fd096@huawei.com>
 <20210616152343.GA2977964@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210616152343.GA2977964@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 10:23:43AM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 16, 2021 at 09:09:40AM +0800, liuqi (BA) wrote:
> > On 2021/6/12 7:33, Krzysztof Wilczyński wrote:
> 
> > > > +static ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
> > > > +				   struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct dev_ext_attribute *eattr;
> > > > +
> > > > +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> > > > +
> > > > +	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
> > > > +}
> > > 
> > > I am not that familiar with the perf drivers, thus I might be completely
> > > wrong here, but usually for sysfs objects a single value is preferred,
> > > so that this "config=" technically would not be needed, unless this is
> > > somewhat essential to the consumers of this attribute to know what the
> > > value is?  What do you think?
> >
> > "config=" is a supported for userspace tool, it is a kind of alias, so
> > cannot be remover here, thanks.
> 
> I don't understand this part.  This is brand-new functionality for the
> kernel, so there's no requirement to maintain compatibility for
> existing userspace tools.
> 
> If there's a similar sysfs show function for other perf drivers, and
> you need to be compatible with *that*, fine.  But if this is merely
> about being compatible with userspace that uses out-of-tree kernel
> functionality, that's not a real factor.

Right, I think this is standard for all perf drivers as it is how the perf
tool figures out how to select a given event in the perf_event_attr (which
has a 'config' field, which is what this refers to).

Will
