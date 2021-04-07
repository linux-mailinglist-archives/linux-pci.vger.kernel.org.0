Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CE356990
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhDGKZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 06:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237037AbhDGKZl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 06:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E92E561205;
        Wed,  7 Apr 2021 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617791131;
        bh=KFY6DkBGO8PkHrXfq2QtFu4irgvTcd2AKSHcPzk36Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3QrEN2T1UXyDuZRiMK7s6k8UOKm3Cq1d69CJtUQr8J+5Bs+fmSXz8yG1bHn+GJrF
         uFepS6EreuItH+Yv33EhGEtqjfAVPFAetjhM6453EXHwNxOEC2q8bowGG9e+YRNWOv
         sfYP2VNN89BxMff5bYF4VE9rOagb0RY99gnCemg8=
Date:   Wed, 7 Apr 2021 12:25:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, prime.zeng@huawei.com,
        linux-doc@vger.kernel.org, linuxarm@huawei.com,
        "liuqi (BA)" <liuqi115@huawei.com>
Subject: Re: [PATCH 0/4] Add support for HiSilicon PCIe Tune and Trace device
Message-ID: <YG2Imet/tbyzYcOo@kroah.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
 <YGxm49c9cT69NV5Q@kroah.com>
 <01b6e8f7-3282-514e-818d-0e768dcc5ba3@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b6e8f7-3282-514e-818d-0e768dcc5ba3@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 06:03:11PM +0800, Yicong Yang wrote:
> On 2021/4/6 21:49, Greg KH wrote:
> > On Tue, Apr 06, 2021 at 08:45:50PM +0800, Yicong Yang wrote:
> >> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> >> integrated Endpoint(RCiEP) device, providing the capability
> >> to dynamically monitor and tune the PCIe traffic(tune),
> >> and trace the TLP headers(trace). The driver exposes the user
> >> interface through debugfs, so no need for extra user space tools.
> >> The usage is described in the document.
> > 
> > Why use debugfs and not the existing perf tools for debugging?
> > 
> 
> The perf doesn't match our device as we've analyzed.
> 
> For the tune function it doesn't do the sampling at all.
> User specifys one link parameter and reads its current value or set
> the desired one. The process is static. We didn't find a
> way to adapt to perf.
> 
> For the trace function, we may barely adapt to the perf framework
> but it doesn't seems like a better choice. We have our own format
> of data and don't need perf doing the parsing, and we'll get extra
> information added by perf as well. The settings through perf tools
> won't satisfy our needs, we cannot present available settings
> (filter BDF number, TLP types, buffer controls) to
> the user and user cannot set in a friendly way. For example,
> we cannot count on perf to decode the usual format BDF number like
> <domain>:<bus>:<dev>.<fn>, which user can use filter the TLP
> headers.

Please work with the perf developers to come up with a solution.  I find
it hard to believe that your hardware is so different than all the other
hardware that perf currently supports.  I would need their agreement
that you can not use perf before accepting this patchset.

thanks,

greg k-h
