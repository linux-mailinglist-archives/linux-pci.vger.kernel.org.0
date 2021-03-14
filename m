Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44733A4A6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Mar 2021 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhCNMKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 08:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhCNMJa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Mar 2021 08:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB4E064EBE;
        Sun, 14 Mar 2021 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615723770;
        bh=IgS6KBqy76gAu5ZRvkKGi/mcLf4n7juzSR1j6hNwxBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4wFUT5auwReUPkrHk4bKLfEFE433mTTUyav4QDiS9bVPnMA/KDvYWvJypVmmBGjF
         pUmwPDw3hcUpcC3hKInb29TKQojNIuQZMRGRmoq+9Sg2iUtqUvzDnYqe97ZNubqL1C
         WKY9jptRqv5ZqRPFvewW/hj8G1vV8lpOTc1B0Gs+8KD8MDb+4hfXEVh7m+IcSm04Rq
         tOY0zIbOYvfGjn2iCP1WgUG2oftKcLOgjd9EBhFRXHglouFL82Iw1LqlF8HSLt45rh
         hC54LTEixqJEX2eCeLEz2j8xxXEawznmDiatS1fu01kNt9r32imSSX+qm3L1lA7JJ6
         j5PelUpfkRFPQ==
Date:   Sun, 14 Mar 2021 14:09:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     ameynarkhede03@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Message-ID: <YE389lAqjJSeTolM@unreal>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312173452.3855-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 11:04:48PM +0530, ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
>
> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.
>
> Expose the reset methods available per device to userspace, via sysfs
> and allow an administrative user or device owner to have ability to
> manage per device reset method priorities or exclusions.
> This feature aims to allow greater control of a device for use cases
> as device assignment, where specific device or platform issues may
> interact poorly with a given reset method, and for which device specific
> quirks have not been developed.

Sorry, are we talking about specific devices/flows/applications that
must have this functionality or about theoretical use case?

Thanks
