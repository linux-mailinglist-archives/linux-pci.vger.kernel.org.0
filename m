Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02713BC5FC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGFFTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 01:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhGFFTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 01:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DA036198D;
        Tue,  6 Jul 2021 05:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625548614;
        bh=edB+NZGbtwJk7L6BVpbgoPQhl0P5jFCe19xYmXZZT2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSPJ68a3v7NSvxFeoCmMSj/mTNZ1BlvNevZW7LEeK66Y6MGIrG4L4RgeJSGK+/TDo
         dcsQLfubO+Jh5py06TjnBO1QrKtra+Yq9/QjyWiPmqvEXpOaNlVb0zlQLkINJmCtyl
         VRgqKLzb3Mn+zmEfo09d+ahKlprWhdgqvGSF2psQlqHnrkO1H+3781asKUAwLnLn4v
         LmN6aCD2V3mLVxx+4p35ajUY5IZ27E21TJQesu4lwmDZxqBTwjeoxuKxjpV8bmTND9
         0+zg2pTS+9pMP2Gnlktv8PukX1sAhO7P1/CgXIZiiycShD5umZiJe8dknTeHKtkJ2x
         C3aYfc8vRNceA==
Date:   Tue, 6 Jul 2021 08:16:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <YOPnQiHFGFlQC8iq@unreal>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-5-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705142138.2651-5-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 07:51:34PM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
