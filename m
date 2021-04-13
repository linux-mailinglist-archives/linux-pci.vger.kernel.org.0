Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3E35D751
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhDMFjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 01:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244195AbhDMFjt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 01:39:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EDF16124B;
        Tue, 13 Apr 2021 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618292369;
        bh=5R7ntvoWL5LsFvNyJcrCmGY3P8CzjXRu8BWzmE4arjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOVNwhqgRa8OzthSqZk+LpFcsHziJpB8XjTDZJXpUNhHKsKM+GBt5qv0epPu8zBnK
         cGBfM5GaGaOM9ooDFNTiGgpTjC8e3kghoETjwZPTElOktD6nuMcSYifHESJmUwswvU
         Fv83zJIWynYRIS1WurqVPtuzocmDkXKoAje0/UYELFkjbIxcYTTV1QPQmYsWH92CFR
         fbuW0GeF2wWxT8mXVxDoPpr+AM9+7d+cSTjIECz4mABo1lRKTIu31Iir3s9gdM3xv3
         4RVuPTc9P1gPKLLiGHR9xdr/vBVBKM7CNY5dmm9o55XpWtp0KT/a72szc+Nek/3YNL
         p1IlNkj5zEj2w==
Date:   Tue, 13 Apr 2021 08:39:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Narendra K <narendra_k@dell.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/1] Use of =?utf-8?B?L3N5cy9i?=
 =?utf-8?B?dXMvcGNpL2RldmljZXMv4oCmL2luZGV4?= for non-SMBIOS platforms
Message-ID: <YHUujU1o6bdHDfmS@unreal>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412135905.1434249-1-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 03:59:04PM +0200, Niklas Schnelle wrote:
> Hi Narendra, Hi All,
> 
> According to Documentation/ABI/testing/sysfs-bus-pci you are responsible
> for the index device attribute that is used by systemd to create network
> interface names.
> 
> Now we would like to reuse this attribute for firmware provided PCI
> device index numbers on the s390 architecture which doesn't have
> SMBIOS/DMI nor ACPI. All code changes are within our architecture
> specific code but I'd like to get some Acks for this reuse. I've sent an
> RFC version of this patch on 15th of March with the subject:
> 
>    s390/pci: expose a PCI device's UID as its index
> 
> but got no response. Would it be okay to re-use this attribute for
> essentially the same purpose but with index numbers provided by
> a different platform mechanism? I think this would be cleaner than
> further proliferation of /sys/bus/pci/devices/<dev>/xyz_index
> attributes and allows re-use of the existing userspace infrastructure.

I'm missing an explanation that this change is safe for systemd and
they don't have some hard-coded assumption about the meaning of existing
index on s390.

Thanks
