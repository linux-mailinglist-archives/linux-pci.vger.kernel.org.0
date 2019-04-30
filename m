Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E95FD8E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfD3QLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 12:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3QLy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 12:11:54 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D126820835;
        Tue, 30 Apr 2019 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556640713;
        bh=KyJDGavjSpp4AuaU07L+2c6XypQvQiHt5+bPye/hGks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqsZ5BoME8haEyekKzM65WyuYHNiOijsLhfWQkt+MUOiL/MqQ1H0yg94wEIj5ekmB
         +iSYf1rtA4JbjPbspm9HA7YRmWpOl3alprs/1Kzpe/o6LeT8wwzN/2ZgGu/FPJRuJL
         HdNv22y9V1h1RcGzVYFi67ja4OxASysmlk4fa1n0=
Date:   Tue, 30 Apr 2019 11:11:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20190430161151.GB145057@google.com>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 29, 2019 at 08:07:53PM -0500, Alex G wrote:
> On 4/29/19 1:56 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This reverts commit e8303bb7a75c113388badcc49b2a84b4121c1b3e.
> > 
> > e8303bb7a75c added logging whenever a link changed speed or width to a
> > state that is considered degraded.  Unfortunately, it cannot differentiate
> > signal integrity-related link changes from those intentionally initiated by
> > an endpoint driver, including drivers that may live in userspace or VMs
> > when making use of vfio-pci.  Some GPU drivers actively manage the link
> > state to save power, which generates a stream of messages like this:
> > 
> >    vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5 GT/s x16 link)
> > 
> > We really *do* want to be alerted when the link bandwidth is reduced
> > because of hardware failures, but degradation by intentional link state
> > management is probably far more common, so the signal-to-noise ratio is
> > currently low.
> > 
> > Until we figure out a way to identify the real problems or silence the
> > intentional situations, revert the following commits, which include the
> > initial implementation (e8303bb7a75c) and subsequent fixes:
> 
> I think we're overreacting to a bit of perceived verbosity in the system
> log. Intentional degradation does not seem to me to be as common as
> advertised. I have not observed this with either radeon, nouveau, or amdgpu,
> and the proper mechanism to save power at the link level is ASPM. I stand to
> be corrected and we have on CC some very knowledgeable fellows that I am
> certain will jump at the opportunity to do so.

I can't quantify how common it is, but the verbosity is definitely
*there*, and it seems unlikely to me that a hardware failure is more
common than any intentional driver-driven degradation.

If we can reliably distinguish hardware failures from benign changes,
we should certainly log the failures.  But in this case even the
failures are fully functional, albeit at lower performance, so if the
messages end up being 99% false positives, I think it'll just be
confusing for users.

> What it seems like to me is that a proprietary driver running in a VM is
> initiating these changes. And if that is the case then it seems this is a
> virtualization problem. A quick glance over GPU drivers in linux did not
> reveal any obvious places where we intentionally downgrade a link.

I'm not 100% on board with the idea of drivers directly manipulating
the link because it seems like the PCI core might need to be at least
aware of this.  But some drivers certainly do manipulate it today for
ASPM, gen2/gen3 retraining, etc.

If we treat this as a virtualization problem, I guess you're
suggesting the host kernel should prevent that sort of link
manipulation?  We could have a conversation about that, but it
doesn't seem like the immediate solution to this problem.

> I'm not convinced a revert is the best call.

I have very limited options at this stage of the release, but I'd be
glad to hear suggestions.  My concern is that if we release v5.1
as-is, we'll spend a lot of energy on those false positives.

Bjorn
