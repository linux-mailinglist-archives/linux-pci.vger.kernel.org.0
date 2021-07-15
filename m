Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421B73CAEBF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhGOVw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhGOVw7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D2E061289;
        Thu, 15 Jul 2021 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626385805;
        bh=FlTCVtnOfZ/q/bydhlFZUS0ueXxtwLtN2JpM3VR1HZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+b29LLYrWRyA+/6QVr2qmOxp2PZ0U23nwgmDLWJCF0x9sIZAOx1lBNr/ISvcIPck
         vixKS4tZox5o5VS3etBVibCufEUIkAnaocAYBjMJQy5WuMZTUjEklXG1BqTqq5+8Ek
         BoRyOJrfijQqeaqKOY6bh0BynGEn9oLFtWRcj3A5Raxa7bozonCSCHZCetLHuimsOy
         cxg+Yz9eWxJ1e7+Cx6BdOy3FbLUNJn1uUMzB6o/DjSwSdGqxpCJoO3SjXnGcuNS6Dd
         Tt5pnqJpcbkhZpWBsy9tgmMlJUm76B9LK2XJf5fsUaGx+Ddhi/vICFp778Wt05kWlB
         m+W8AM7kqbnKQ==
Date:   Thu, 15 Jul 2021 14:50:02 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ruben <rubenbryon@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [question]: BAR allocation failing
Message-ID: <20210715215002.GA1839645@dhcp-10-100-145-180.wdc.com>
References: <CALdZjm6TsfsaQZRxJvr5YDh9VRn28vQjFY+JfZv-daU=gQu_Uw@mail.gmail.com>
 <20210715144952.GA1960220@bjorn-Precision-5520>
 <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 11:39:54PM +0300, Ruben wrote:
> Thanks for the response, here's a link to the entire dmesg log:
> https://drive.google.com/file/d/1Uau0cgd2ymYGDXNr1mA9X_UdLoMH_Azn/view
> 
> Some entries that might be of interest:
> 
> [    0.378712] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.378712] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
> [    0.378712] pci_bus 0000:00: root bus resource [bus 00-ff]

I have not seen anything like that before. Usually you get non-zero
offset windows for memory resources separating 32-bit non-prefetchable
from the prefetchable.

Assuming what you're showing is fine, this says you've 1TB memory
addressable space available to the root bus. Each of your device's
memory requires 128GB and 32MB, both 64-bit non-prefetchable BARs. Due
to alignment requirements, your GPUs should need at least 2TB of IO
memory space to satisfy their memory request.

That's probably not very helpful information, though. I'll look if
there's something creating a 1TB limit in qemu, but I'm honestly not
very familiar enough in that particular area.
