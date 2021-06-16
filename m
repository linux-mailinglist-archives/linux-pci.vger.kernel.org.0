Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7890B3A9EEA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhFPPZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 11:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhFPPZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 11:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E7196135C;
        Wed, 16 Jun 2021 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623857025;
        bh=P9kMQ2jD1IPtWm/U0GmUTuT+zZSu3WntBzFULA8XsKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Klm5REesq4KWd2XEmOVEITrGliAxe44pUkUfIKAC4nsSCFZ0ktmXvJtcDd2K5biyr
         cci0H4xIP403/1NFLY7WOnf2Civf62LtOb0zt1osOj22vWzZDKrFRRPgu/GjYD6s0s
         R0uAJR/2dWKVv6ENcztuZDPByuviPG+gS2Er9WlhOeL3zqPWnGX8dxm7shgXx0ZUEh
         uHyHNyevBsM681rYqUHX2rzFtYqTQ3K6WnkNvmvxjUH0yMHMdBFZQN1M3YGFrONv4K
         6fqLXBFAJy+82iZfxJknssnMXDJ0GA+9u4zAdd6Si+yljlNzb7yq9Jjw1DkWF1Tm8a
         UUOIYjeeJoeWA==
Date:   Wed, 16 Jun 2021 10:23:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linuxarm <linuxarm@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210616152343.GA2977964@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2524d34-648a-8667-dde9-3686bd4fd096@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 09:09:40AM +0800, liuqi (BA) wrote:
> On 2021/6/12 7:33, Krzysztof Wilczyński wrote:

> > > +static ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
> > > +				   struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct dev_ext_attribute *eattr;
> > > +
> > > +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> > > +
> > > +	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
> > > +}
> > 
> > I am not that familiar with the perf drivers, thus I might be completely
> > wrong here, but usually for sysfs objects a single value is preferred,
> > so that this "config=" technically would not be needed, unless this is
> > somewhat essential to the consumers of this attribute to know what the
> > value is?  What do you think?
>
> "config=" is a supported for userspace tool, it is a kind of alias, so
> cannot be remover here, thanks.

I don't understand this part.  This is brand-new functionality for the
kernel, so there's no requirement to maintain compatibility for
existing userspace tools.

If there's a similar sysfs show function for other perf drivers, and
you need to be compatible with *that*, fine.  But if this is merely
about being compatible with userspace that uses out-of-tree kernel
functionality, that's not a real factor.

Bjorn
