Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A07341DBC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSNIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 09:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhCSNHx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 09:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB68564EA4;
        Fri, 19 Mar 2021 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616159272;
        bh=qvPp79Q3b23nxOhc316hNTgHA1mcm3ZJl+V47DC0UPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcgankqMXpoJDn7uaqsmTAiSmbZRLByqJNXCUUrt8Y8/Yfw1SXo/QjjGyvZUPhhjZ
         HP4G1cUIrI7YTQidlTd49VPefGUn26JoTO+e8RxFcnnKP9ygvkGf1rO3gGY7IAauPb
         mhkrPz6C+C/QZqp6yTILpQcDOfg6o2bvVsuYB55xyjWG0mKnSHiTnyN43PMHa3JZXS
         JEonEY8ZS4qJla0NORnuXFTDgHv5A11KlOLF1glkdA9/Mi5dCYvpt8fl9lnMQu+Jvs
         Ih9zbEccwqSQjd9Az8RM9J9GCM2awnP4AHJTBniN4fc+hfVj8rdMwGOYiODxnPsmNH
         9DAVqAcx71cFw==
Date:   Fri, 19 Mar 2021 15:07:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFSiJB+w+5oqNZkm@unreal>
References: <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
 <5dfcdfae-2b80-d6dd-89fe-2980faf26502@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dfcdfae-2b80-d6dd-89fe-2980faf26502@metux.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 06:58:25PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 18.03.21 18:35, Leon Romanovsky wrote:
> 
> > I see it as a good example of cheap solution. Vendor won't fix your
> > touchpad because distros provide workaround. The same will be with reset.
> 
> Usually, vendor won't fix it, anyways, regardless of any kernel
> workarounds.

It is not only vendors, but enthusiasts won't fix too, because their
distro works.

Thanks
