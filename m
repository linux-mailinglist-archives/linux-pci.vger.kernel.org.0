Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56E6457633
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhKSSSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 13:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhKSSS3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 13:18:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74DFD61A40;
        Fri, 19 Nov 2021 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637345727;
        bh=3SVDSZjkOF6U1A3CtTTPDDGY+roafh5r8pacCA/JGns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MsX6zdftx8+0Zz07sM4mKr3QfkhGMATrNbmV9H+t+i4higNLXpcf6yzDzCJB8moDp
         fUwm+q8eanF9HoS0dGsJSWdeY923OqwHgnRbmLpqSMpwSEkiV4QukYVcVygdBKyVIX
         d7mVUWAx4cKIWSOnT5xy4mLKaF8mHohCRWQ6mg8Mi4+mZrMk04EmPNuPdaGXpaL0Se
         ey1gVgFmmgzKTxtRkyhtvmyQs/3ZjyUetfJifF+GFhDd+mgHce0H/dPjyfjZXtWiMt
         4O8nQSbXUWYcKi5ee2KENfAZLOh+ihDonL0sj+czJjcMSQmY0WaUjnu9WvyHTLcV6K
         EjFiPIFG4883Q==
Date:   Fri, 19 Nov 2021 12:15:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvincao@outlook.com
Subject: Re: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Message-ID: <20211119181526.GA1948335@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119003803.2333-1-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 04:38:01PM -0800, Kelvin Cao wrote:
> Hi,
> 
> This patchset introduces device IDs for the Switchtec Gen4 automotive
> variants and a minor tweak for the MRPC execution.
> 
> The first patch adds the device IDs. Patch 2 makes the tweak to improve
> the MRPC execution efficiency [1].
> 
> This patchset is based on v5.16-rc1.
> 
> [1] https://lore.kernel.org/r/20211014141859.11444-1-kelvin.cao@microchip.com/
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (2):
>   Add device IDs for the Gen4 automotive variants
>   Declare local array state_names as static
> 
>  drivers/pci/quirks.c           |  9 +++++++++
>  drivers/pci/switch/switchtec.c | 11 ++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)

Applied to pci/switchtec for v5.17, thanks!

I tidied up the subjects for you so they match the style of previous
ones, 7a30ebb9f2a2 ("PCI/switchtec: Add Gen4 device IDs") in
particular:

  bb17b15813ea ("PCI/switchtec: Add Gen4 automotive device IDs")
  b76521f6482d ("PCI/switchtec: Declare local state_names[] as static")

