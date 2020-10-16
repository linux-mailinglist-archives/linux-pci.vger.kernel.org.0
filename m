Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A728FE2D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 08:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392129AbgJPGT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 02:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391810AbgJPGT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 02:19:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA802074F;
        Fri, 16 Oct 2020 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602829196;
        bh=zazvmy1lt9Z41+MMNemilywN+s6lX54NA7oWGo08ESs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZD3AxQIG5rD8dJ4sz01tmhN2a1F/9VP38doUhhoNGV7aPqGjMK4nu+OGfrvGC4tbr
         Oih4VBbUxgS9IZ1tsXG+zWeAFQaemBzzYfjO6+N/lDW+XPa4iVNJDuWS5iv0DM2T0A
         M0+OcNkDOJ1CrLGLkT0LhhnbOuA3FFtHt0xCfibk=
Date:   Fri, 16 Oct 2020 08:20:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, ast@kernel.org,
        linux-kernel@vger.kernel.org,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with
 CAP_SYS_RAWIO
Message-ID: <20201016062027.GB569795@kroah.com>
References: <20201016055235.440159-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016055235.440159-1-allen.lkml@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 11:22:35AM +0530, Allen Pais wrote:
> From: Allen Pais <apais@linux.microsoft.com>
> 
>  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> in order to read configuration space past the frist 64B.
> 
>  Since the path is only for reading, could we use CAP_SYS_RAWIO?

Why?  What needs this reduced capability?

> This patch contains a simpler fix, I would love to hear from the
> Maintainers on the approach.
> 
>  The other approach that I considered was to introduce and API
> which would check for multiple capabilities, something similar to
> perfmon_capable()/bpf_capable(). But I could not find more users
> for the API and hence dropped it.
> 
>  The problem I am trying to solve is to avoid handing out
> CAP_SYS_ADMIN for extended reads of the PCI config space.

Who is reading this config space that doesn't have admin rights?  And
what are they doing with it?

One big problem is that some devices will crash if you do this wrong,
which is why we restricted it to root.  Hopefully all of those devices
are now gone, but I don't think you can count on it.

The "guaranteed safe" fields in the config space are already exported by
sysfs for all users to read, are they not sufficient?

thanks,

greg k-h
