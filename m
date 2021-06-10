Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0913A381F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJXzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFJXzS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E95A6108E;
        Thu, 10 Jun 2021 23:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623369201;
        bh=1zH71ovmh14caYSetueMphwRQtBcsUIGDJVzbxjkDA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bAnrWtUKfsYY8bKRX96hNC9KgOJvw7yBFz6jbgyb24/i7w7jHXes/SQXiJVDjUEH0
         2RckCXVG/7wONhAz+u7LVAVPqVnzVkPBvX2fk9OuYtcvaIce0S2lY0PK29MuCZbSyd
         TC0s4/dSIeMITkYCHqIOZs3YIfyirJS3Cz5ODPp0CilGh+THHRcoeq9u6KSr0qQbtH
         i/ojbILdmQqanIpA4fRng82hMZrgr0Ig6Oa5NddDQAdqaqPx3I+RDOmwuJxm3lKIyp
         5t8JK20diJoRlaiRxk187oZIyjx72wg1Os07x8peK5QRyiwhKD72z9LSKvlezcUCSu
         Z8wV30FzjXplw==
Date:   Thu, 10 Jun 2021 18:53:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210610235319.GA2796526@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <762dd911-2899-f4e7-da38-860316febbf0@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 06:43:26PM -0500, Shanker R Donthineni wrote:
> On 6/10/21 6:16 PM, Bjorn Helgaas wrote:
> >> From: Shanker Donthineni <sdonthineni@nvidia.com>
> >>
> >> On select platforms, some Nvidia GPU devices do not work with SBR.
> > Interesting that you say "on select platforms."  Apparently SBR does
> > work for some of these GPUs, but not on all platforms?  If you have
> > any clarification here, I can still update the commit log.
> >
> Yes, SBR works for some GPUs but GPUs which are listed in this quirk will
> not work and these GPUs are available only on selected server platforms.
> I believe commit text reflects the issue but please update if needed. 

It sounds like there is no actual dependency on the platform.  So even
though these GPUs are only available on certain platforms, if one were
to move one of them to a different, non-supported platform, SBR would
still not work.

So I think I'll remove the reference to "select platforms" since it
doesn't add any useful information and might suggest that SBR should
work on some platforms, if you could only find the right ones.

Bjorn
