Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3B10D78B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfK2O6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 09:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfK2O6w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 09:58:52 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F572070B;
        Fri, 29 Nov 2019 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575039531;
        bh=sXa4biqXFrdIASdos+I8wNXn3kPutmv7T3yShrfLJYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ePCl2vGvwf25XknBMUXShUiD5Dm4gh3ukeu0fzByCh5QCk/bltf7zbb8Y+Kdq9OAV
         eo6vGyjzZYCm0U+IqCYpqz2xzBLm+69qzeilJwbmFzvclzsbO9HQdqj+MWW0lzBgp7
         rRFyv8u0ARhObnGiEDlkaH5i8p67GSUaklhu2EPI=
Date:   Fri, 29 Nov 2019 08:58:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ranshalit@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
Message-ID: <20191129145849.GA203450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-205701-41252@https.bugzilla.kernel.org/>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=205701
> ...
> 
> Using Intel Xeon computer with linux kernel 4.18.0 centos8.
> Trying to access RAM (with DMA) using FPGA  fails in this computer.
> 
> 1. I tried to add intel_iommu=off - it did not help.
> 
> 2. Installing windows on same PC - FPGA can access RAM using DMA without
> issues.
> 
> 3. using another PC (Intel Duo) with same linux and OS - FPGA access works.  
> 
> FPGA access the RAM using a physical address provided by a kernel module which
> allocates physical continuous memory in PC. (the module works perfectly with
> Intel Duo on exactly same OS and kernel).

Hi, thanks for the report!  Can you please attach the complete dmesg
and "sudo lspci -vv" output for the working and non-working v4.18
kernels to the bugzilla?

Then please try to reproduce the problem on the current v5.4 kernel
and attach the v5.4 dmesg log.  If v5.4 fails, we'll have to debug it.
If v5.4 works, figure out what fixed it (by comparing dmesg logs or by
bisection) and backport it to v4.18.

Bjorn
