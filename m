Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD946DC98
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 21:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhLHUGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 15:06:15 -0500
Received: from gir.skynet.ie ([193.1.99.77]:46209 "EHLO gir.skynet.ie"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236542AbhLHUGP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 15:06:15 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 15:06:15 EST
Received: from skynet-temp.skynet.ie (unknown [193.1.99.76])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gir.skynet.ie (Postfix) with ESMTPS id 95B95101BD;
        Wed,  8 Dec 2021 19:55:08 +0000 (GMT)
Date:   Wed, 8 Dec 2021 19:55:08 +0000 (UTC)
From:   Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet-temp.skynet.ie
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] agp: convert to generic power management
In-Reply-To: <20211208193305.147072-1-helgaas@kernel.org>
Message-ID: <alpine.DEB.2.20.2112081942330.32242@skynet-temp.skynet.ie>
References: <20211208193305.147072-1-helgaas@kernel.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 8 Dec 2021, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Vaibhav has converted around 180 drivers to generic power management, and
> over 100 of those conversions have made it upstream.  If we can finish off
> the remaining ones, we'll be able to remove quite a bit of ugly legacy code
> from the PCI core.
> 
> This is a repost of Vaibhav's patches for AGP.  I rebased them to v5.16-rc1
> and updated the commit logs to try to make it easier to verify them.
> 
> In the most recent posting here:
> 
>   https://lore.kernel.org/linux-pci/20211201025419.2797624-1-helgaas@kernel.org/
> 
> my commit log updates were incorrect.  This v3 has updates that I believe
> to be correct, but of course I'd be grateful for more corrections.

Hi Bjorn,

Do you want to merge these via your tree?

if so,
Acked-by: Dave Airlie <airlied@redhat.com>

Dave.

> 
> Vaibhav Gupta (3):
>   amd64-agp: convert to generic power management
>   sis-agp: convert to generic power management
>   via-agp: convert to generic power management
> 
>  drivers/char/agp/amd64-agp.c | 24 ++++++------------------
>  drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
>  drivers/char/agp/via-agp.c   | 25 +++++--------------------
>  3 files changed, 17 insertions(+), 57 deletions(-)
> 
> 
