Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D833269EE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZWXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 17:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhBZWXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 17:23:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05BF464EC4;
        Fri, 26 Feb 2021 22:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378148;
        bh=8s/XKXRb4CorJtfRkBsrGYYS9jN/xNVULVhEkfuwWoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W3lg2uVmBFu70NeWztp1viDjVk/IuVnP4C15SR/psLdV6UvBIKHdNiDBrqlcnjMQ3
         e1RVLRQQb4WWh6tBlgc9F0i8u17ywIrUly/IOBA42nqZSGQxVUFKhYULZfTy6o5mzb
         OLydfBuOyyDr01ofY+ZHRYUvZFDEt+629wKQotOJBKu+eA/JODLfa/LDtdNtFv0PWI
         uhNTvqjigLhg1RsoP1+rKPNgUZtzG3amjGloWYu5AdZSiRJCb1ullm1IOqcIVqnh1i
         amLsbzeAPG+hnXrOe2kjiK1fcVwUT8OuGQwvUPaOBEbgXE7I46Eueco4hXjzdVxiHA
         UMJIhe5ZSm41Q==
Date:   Fri, 26 Feb 2021 16:22:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: PME while runtime suspend
Message-ID: <20210226222225.GA164608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi9PGWcPOHKk3cNU3Nw+hdVOsivLeXzqyd2FQ7nn8dDfvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Dave (author of 42eca2302146), Vaibhav, linux-pm]

On Fri, Feb 26, 2021 at 11:37:12AM +0100, Loic Poulain wrote:
> Hi Bjorn,
> 
> Trying to support runtime suspend in a driver, which puts the device
> in D3hot and wait either for host/driver initiated resume
> (runtime_get), or device initiated resume (PME).
> 
> But, given that old change: 42eca2302146 ("PCI: Don't touch card regs
> after runtime suspend D3")
> 
> PME that was enabled from pci_finish_runtime_suspend() is not enabled
> anymore for almost all drivers in case of runtime-suspend. The only
> way to enable this is by calling pci_wake_from_d3() from the PCI device
> driver's runtime_suspend() callback, but this function fails if the
> device wake_up is not enabled, which makes sense since it targets
> system-wide sleep wake-up (and wake-up is user/distro policy).
> 
> So is there a proper way to allow PME while the device is runtime
> suspended, without having to tell the user to enabled 'unrelated' wake_up
> capability?

pci_pm_runtime_suspend() calls pci_finish_runtime_suspend(), which
enables wake-up, unless "pci_dev->state_saved".  IIUC we should be
enabling wake-up unless the driver has called pci_save_state() itself.

So I infer that your driver does call pci_save_state() and the PCI
core does not enable wake-up.  Right?

Why does your driver call pci_save_state()?  In most cases I don't
think drivers should need to do that themselves because the PCI core
will do it for them.  E.g., see Vaibhav's recent eb6779d4c505 ("e1000:
use generic power management") [1]

Bjorn

[1] https://git.kernel.org/linus/eb6779d4c505
