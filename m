Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA034A799
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 13:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZMym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 08:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCZMyN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 08:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91648619BF;
        Fri, 26 Mar 2021 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616763253;
        bh=MJUmJK07J9WuIQ3mScOK1VfUQwjeKea+oTAtpHDy0cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0Byd8d36sSgQl69KbKShLXhSwBqkhaL849pSA59Bxr0iGPzWu+TGnc4cRRltQ8SG
         xQmNycEmxJ6nAbnjOzhFwCWgIgsjxGKCGQeG/zzlBvun+cWtV3kcIUOcrDj/4Dm7Uj
         iBV6VpNp4fkJcAEOsXNvB+5HVIkd1/rtkRQUS+CE7vt8eLuvHZxyJraX0UzSICiMqY
         Na/x6plq2Xtm4pqKdB7MEf9E6OP68SZSAItpGDaJQtbp/TDo7C9Xc8Xydf1mjV13mB
         Fojwjld6YJ6rcAr5MhfPYmu0qyowLWMPROTp91FDP1SCgQEEyK0ktTPTkUwmGk3J+a
         iRnAUIJJvYaOg==
Date:   Fri, 26 Mar 2021 15:54:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YF3ZcQptMzN1Iad1@unreal>
References: <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
 <YFxL4o/QpmhM8KiH@unreal>
 <20210325085504.051e93f2@omen.home.shazbot.org>
 <YFy11u+fm4MEGU5X@unreal>
 <20210325115324.046ddca8@omen.home.shazbot.org>
 <YF2B3oZfkYGEha/w@unreal>
 <YF2m4amcwj9BkQ+S@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YF2m4amcwj9BkQ+S@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 10:18:25AM +0100, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> 
> Aside of the sysfs interface, would this new functionality also require
> anything to be overridden at boot time via passing some command-line
> arguments?  Not sure how relevant such thing would be to device, but,
> whatnot reset, though.

This is per-device property and can't be universally correct like kernel
command-line arguments. I don't think that we need to add such functionality.

> 
> I am curious whether there would be a need for anything like that.

I prefer not.

> 
> Krzysztof
