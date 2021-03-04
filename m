Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0095A32DAC4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 21:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhCDUC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 15:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236804AbhCDUB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 15:01:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67A9664F70;
        Thu,  4 Mar 2021 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888076;
        bh=9dMhZPq9D422+IL6rVa9msXPTDUICqE4sgB10E/HnpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyhRBZ8kYCdcsoBNjuK6E0510Q7ZvdOA+YJm1Z385PpYbZHvg3suxnEFT0sf5Ikij
         il2cmDIS+dsA19EHuBzIPP9SwHyKeuDYe6C1uv3Zc7nF8vMv6VKF2xYMyc5fCmR4TI
         maqd7UCi1Z0V06RKP0WfbsyX7PszM93VoxwqX3zFSPs/AbUOrO/y9rMPxSDJtcR9XM
         qcUTxsoNCQXU+IHO32XRXb1gk2PRwafb08QTdGp2RNWgKjNhY9xV2eJNkdyUGvkOSj
         NnhD6uF1kUdJo7nSrJmlw3uG9h8V4zBKS9CFqIWIfEHm5juG0z9a/CAQNIAomnz+qc
         N9PGtXoyOCJBQ==
Date:   Fri, 5 Mar 2021 05:01:09 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
Message-ID: <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 02, 2021 at 09:46:40PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 3/2/21 9:34 PM, Williams, Dan J wrote:
> > [ Add Sathya ]
> > 
> > On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
> > > Overwriting the frozen detected status with the result of the link reset
> > > loses the NEED_RESET result that drivers are depending on for error
> > > handling to report the .slot_reset() callback. Retain this status so
> > > that subsequent error handling has the correct flow.
> > > 
> > > Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> > > Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Just want to report that this fix might be a candidate for -stable.
> Agree.
> 
> I think it can be merged in both stable and mainline kernels.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Just FYI, this patch is practically a revert of this one:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6d2c89441571ea534d6240f7724f518936c44f8d

so please let me know if that is still a problem for you.
