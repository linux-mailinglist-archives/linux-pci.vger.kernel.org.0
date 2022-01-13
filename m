Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8248CF7F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiAMAAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 19:00:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37816 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiAMAAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 19:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68D7DCE1DD0;
        Thu, 13 Jan 2022 00:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19064C36AE9;
        Thu, 13 Jan 2022 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642032029;
        bh=trGh1l73wrj5RPiPc/D2fF8FI27Khi/DM6q9d+U1vLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ecCNkSAnUPWNmK0Wzw+EbLssThumLTtWn53naeIAFCaRaa1Tmsi9Nnb2TUubrDj9X
         WPRo+f30n0oJ2miMjpS2FXe90FI5CKKkNYhOoXJFe8R+iK3hMD7I6keegZyD/37AzQ
         XYuBcv5YesYeA7kFt7ARI0fmebQEUhMTNjp1vRmI+Lju4WfC0i8OcWefcBItE7RgBs
         FbLcuNP7VAZdi0w3fRcK3c0igXDnoS8jC8JxonZApnokgPcJKTm71WEX9pFWqVN4wO
         cKnuzTVI6HspmzgTLw3lsX6y6E51Y3LNfxqT85EmTzS5yIyQ+7KWLy0s1VihFE/YgJ
         Usv0YYhVjfM0A==
Date:   Wed, 12 Jan 2022 18:00:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH dt + pci 2/2] PCI: Add function for parsing
 `slot-power-limit-milliwatt` DT property
Message-ID: <20220113000027.GA294943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112222822.7yirl7k57ju5d2ox@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 11:28:22PM +0100, Pali Rohár wrote:
> On Wednesday 12 January 2022 16:08:15 Bjorn Helgaas wrote:
> > On Sun, Oct 31, 2021 at 04:07:06PM +0100, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Add function of_pci_get_slot_power_limit(), which parses the
> > > `slot-power-limit-milliwatt` DT property, returning the value in
> > > milliwatts and in format ready for the PCIe Slot Capabilities Register.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Do we have a caller of of_pci_get_slot_power_limit() yet?  I didn't
> > see one from a quick look
> > (https://lore.kernel.org/linux-pci/?q=b%3Aof_pci_get_slot_power_limit).
> > 
> > Let's merge this when we have a user for it.
> 
> I have a patch for both pci-mvebu.c and pci-aardvark.c drivers. But
> there are lot of patches for these drivers waiting on mailing list for
> review... Should I sent another patch for pci-mvebu.c which will use
> this of_pci_get_slot_power_limit() function?

If the of_pci_get_slot_power_limit() patches are independent of the
ones waiting for review, they could be added to *this* series.

Bjorn
