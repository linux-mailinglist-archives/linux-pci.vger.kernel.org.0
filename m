Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA43555AB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhDFNte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 09:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232452AbhDFNtd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 09:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0090D61246;
        Tue,  6 Apr 2021 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617716965;
        bh=AHTodKbzDwdE4aT+sGBqYSzfgMa+SmLxo8yj2F+6ktU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8XVzr8pCamhBopVmKZDH1S/qhaNTTX6x5IgAXtZDVjhyYDucCaW/YPHzw/NdvDAO
         UcX5g9zsj0ofonVWjLzmzoQpioJDQujm2xCHsNkPljKqp36ohQ8gPFQIsTxulg3hax
         9fUWtdIO+GunlUTPcyp+qpQhbxZR6jn4ic30VSag=
Date:   Tue, 6 Apr 2021 15:49:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, prime.zeng@huawei.com,
        linux-doc@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 0/4] Add support for HiSilicon PCIe Tune and Trace device
Message-ID: <YGxm49c9cT69NV5Q@kroah.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:45:50PM +0800, Yicong Yang wrote:
> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> integrated Endpoint(RCiEP) device, providing the capability
> to dynamically monitor and tune the PCIe traffic(tune),
> and trace the TLP headers(trace). The driver exposes the user
> interface through debugfs, so no need for extra user space tools.
> The usage is described in the document.

Why use debugfs and not the existing perf tools for debugging?

thanks,

greg k-h
