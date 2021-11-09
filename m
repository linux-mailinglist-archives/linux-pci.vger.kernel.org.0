Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1744B08A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhKIPme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhKIPme (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:42:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C4A610F7;
        Tue,  9 Nov 2021 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636472388;
        bh=hIirh4UeB/DaGSPrnWH7rbjCj+/A2qiIajva7rVgF7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v1RpVxCHid8xuKq9K1hjupH/OR5s4fdI2n5nzmwzBir5gNF0hXx7bzU9VHuy0jV+D
         WH8p+k82eEfxAaVJcIF5PwMTOYoaO9cF/OFeiBChrD9TFg9x1gL5A2RwgjzbE6DczL
         vjoRpzVpc7tIL9KVyKJm/W8yA3+37p0h3gIB7huU=
Date:   Tue, 9 Nov 2021 16:39:45 +0100
From:   Greg Kroah Hartmann <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCI/MSI: Destroy sysfs before freeing entries
Message-ID: <YYqWQaah0gNW9OqK@kroah.com>
References: <87sfw5305m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfw5305m.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 02:53:57PM +0100, Thomas Gleixner wrote:
> free_msi_irqs() frees the MSI entries before destroying the sysfs entries
> which are exposing them. Nothing prevents a concurrent free while a sysfs
> file is read and accesses the possibly freed entry.
> 
> Move the sysfs release ahead of freeing the entries.
> 
> Fixes: 1c51b50c2995 ("PCI/MSI: Export MSI mode using attributes, not kobjects")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/msi.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
