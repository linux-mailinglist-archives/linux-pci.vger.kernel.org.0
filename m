Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5735DB5B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 11:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhDMJgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 05:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhDMJgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 05:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FD066120E;
        Tue, 13 Apr 2021 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618306559;
        bh=1ZHvVxaYn8sWSZCttC4uj4mnBeN/xTh5Y+GIL7vkWvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfEbbt4frHBY+NOM90yWhGd1TURNKSxuNZyOtaH4v42oPpx9ZWlVZGgBUA754fn7d
         NwKxPBvq/hXJeunAmkQ+ovC9ZQ4+2MtLGS2xJksHPsdbBoCefW/ceW7DAiikhZccrE
         bvN91rN1xTIKmiyrcVcZlGNAfm4st/+grYUMpATvrWHrN2H27CyvXhNK2uNgl4InKt
         O6/AYAzzoj7w/AshCXayVtvJ8EKiEQ+Cser8ZlJeSe6ntJXai/2qyOxOYdYx+jJS4q
         m0rDtRtagtYHwe1iRTMEWdnpUYw7YtVlucajHaufOGba1FOO3RFuvSnIMOfMCAtCDN
         b49NnigX9pg6g==
Received: by pali.im (Postfix)
        id CF697860; Tue, 13 Apr 2021 11:35:56 +0200 (CEST)
Date:   Tue, 13 Apr 2021 11:35:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210413093556.g24nzwhgmpgvqoxt@pali>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
 <20210410162622.GA23381@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410162622.GA23381@wunner.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 10 April 2021 18:26:22 Lukas Wunner wrote:
> On Sat, Apr 10, 2021 at 05:17:09PM +0200, Pali Rohár wrote:
> > On Saturday 10 April 2021 16:25:24 Lukas Wunner wrote:
> > > raw_spin_locks are not supposed to be held for a prolonged
> > > period of time.
> > 
> > What is "prolonged period of time"? Because for example PCIe controller
> > on A3720 has upper limit about 1.5s when accessing config space. This is
> > what I measured in real example. It really took PCIe HW more than 1s to
> > return error code if it happens.
> 
> Linux Device Drivers (2005) says:
> 
>    "The last important rule for spinlock usage is that spinlocks must
>     always be held for the minimum time possible. The longer you hold
>     a lock, the longer another processor may have to spin waiting for
>     you to release it, and the chance of it having to spin at all is
>     greater. Long lock hold times also keep the current processor from
>     scheduling, meaning that a higher priority process -- which really
>     should be able to get the CPU -- may have to wait. The kernel
>     developers put a great deal of effort into reducing kernel latency
>     (the time a process may have to wait to be scheduled) in the 2.5
>     development series. A poorly written driver can wipe out all that
>     progress just by holding a lock for too long. To avoid creating
>     this sort of problem, make a point of keeping your lock-hold times
>     short."
> 
> 1.5 sec is definitely too long.  This sounds like a quirk of this
> specific hardware.  Try to find out if the hardware can be configured
> differently to respond quicker.

I have not found any option how to configure it to respond quicker.
Upper limit for controller hw in error condition (e.g. when card does
not respond) seems to be always 1.5 sec.
