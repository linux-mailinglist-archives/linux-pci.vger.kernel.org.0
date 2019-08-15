Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B538F023
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfHOQIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 12:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfHOQIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 12:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630C920644;
        Thu, 15 Aug 2019 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565885303;
        bh=vSk1b8p8CN/xt3ceJ3QVyQ27kuR0ZWUAKF9gUzpXsiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsFdBaTdcEF2qtOfvApSmCWRes1LPq20CTI+NlZ/pZf/ynfOCCTkcytYIKNWpZiOO
         eUjB2UVxOLQQl2KTLu0aMfZspS+YNLVpO1aTwyzENv6xJgM/7POMrWLCHjeuGOO/BI
         kqb+3XaXuwxet8apsIWwMttAbFO8/kJ9YjpRd1Bk=
Date:   Thu, 15 Aug 2019 18:08:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com
Subject: Re: [PATCH v3 0/4] PCI: Clean up pci-sysfs.c
Message-ID: <20190815160821.GA12911@kroah.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815153352.86143-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 09:33:49AM -0600, Kelsey Skunberg wrote:
> This series is designed to clean up device attributes and permissions in
> pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
> iov.c for better organization.
> 
> Patch 1: Define device attributes with DEVICE_ATTR* instead of __ATTR*.
> 
> Patch 2: Change permissions from symbolic to the preferred octal.
> 
> Patch 3: Change DEVICE_ATTR() with 0220 permissions to DEVICE_ATTR_WO().
> 
> Patch 4: Move sysfs SR-IOV functions to iov.c to keep the feature's code
> together.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
