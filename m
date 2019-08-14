Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC858CAB0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHNFkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 01:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHNFkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 01:40:40 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3B120843;
        Wed, 14 Aug 2019 05:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565761239;
        bh=BcTVOpWjejlJQLRKMOuwLxgamclM2LKtYDZAFC7tU0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMzCqMDBjkofqdOZx59ict1Fr6TMdqw0s4RuTCigOU3/xywNMLDhFt/E1awRwhuyH
         uZLmCsD58zb1pfz1g2Ya3zLjA6sl+alQU9UVYjLYzSovK6pEHohGXcB58juvbRNMqS
         p35vDmmxYK6fDlwB4gNiGKRYkRG5S3pVk5mBODfY=
Date:   Wed, 14 Aug 2019 00:40:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v2 0/3] PCI: pci-sysfs.c cleanup
Message-ID: <20190814054038.GB253360@google.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg]

On Tue, Aug 13, 2019 at 02:45:10PM -0600, Kelsey Skunberg wrote:
> This series is designed to clean up device attributes and permissions in
> pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
> iov.c for better organization. Patches build off of each other.
> 
> Patch 1: Define device attributes with DEVICE_ATTR*() instead of __ATTR*().
> 
> Patch 2: Change permissions from symbolic to the preferred octal.
> 
> Patch 3: Move sysfs SR-IOV functions to iov.c to keep the feature's code
> together.
> 
> Changes since v1:
>         Add patch 1 and 2 to fix the way device attributes are defined
>         and change permissions from symbolic to octal. Patch 3 which moves
>         sysfs SR-IOV functions to iov.c will then apply cleaner.
> 
> 
> Kelsey Skunberg (3):
>   PCI: sysfs: Define device attributes with DEVICE_ATTR*()
>   PCI: sysfs: Change permissions from symbolic to octal
>   PCI/IOV: Move sysfs SR-IOV functions to iov.c
> 
>  drivers/pci/iov.c       | 168 +++++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c | 217 ++++------------------------------------
>  drivers/pci/pci.h       |   2 +-
>  3 files changed, 188 insertions(+), 199 deletions(-)

Applied to pci/virtualization for v5.4, thanks!

Beginning of thread:
https://lore.kernel.org/r/20190813204513.4790-1-skunberg.kelsey@gmail.com
