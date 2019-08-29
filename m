Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE09A2A9D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfH2XSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 19:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfH2XSk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Aug 2019 19:18:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C2721670;
        Thu, 29 Aug 2019 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567120719;
        bh=AH5ObS311XGO7RKzoWI2/U/YlNrE6TQMsHRmMBUDIv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIOpA2Oa8YGYXtDJ4MbC2lmRCETIDlVUrQYTE3YiuS9ERORcq9MNpe1b9m6oT3m1w
         26n+KmbiYTb/sVRa4ZMpnyXpimlWXP2KM7xmNON91E6HOb8yclGyrzgbU1Dx1cgV35
         zYn8Ee727w3B2X9VxuzmVMU6dM8aEYYyHGM525LY=
Date:   Thu, 29 Aug 2019 18:18:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     gregkh@linuxfoundation.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH v3 2/2] PCI/AER: Split the AER stats into multiple sysfs
 attributes
Message-ID: <20190829231837.GA18204@google.com>
References: <20190827062309.GA30987@kroah.com>
 <20190827222145.32642-1-rajatja@google.com>
 <20190827222145.32642-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827222145.32642-2-rajatja@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajat,

On Tue, Aug 27, 2019 at 03:21:45PM -0700, Rajat Jain wrote:
> Split the AER stats into multiple sysfs atributes. Note that
> this changes the ABI of the AER stats, but hopefully, there
> aren't active users that need to change. This is how the AERs
> are being exposed now:
> 
> localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats # ls -l

Possible s/aer_stats/aer/ to make the path shorter?

> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit0_RxErr
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit12_Timeout
> -r--r--r--. 1 root root 4096 Aug 20 16:35 correctable_bit13_NonFatalErr
> ...

> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit0_Undefined
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit12_TLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 fatal_bit13_FCP
> ...
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit0_Undefined
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit12_TLP
> -r--r--r--. 1 root root 4096 Aug 20 16:35 nonfatal_bit13_FCP
> ...

The AER registers are named "Correctable Error Status" and
"Uncorrectable Error Status".  Fatal & nonfatal errors are both
reported in the Uncorrectable Error Status register; the distinction
comes from the Uncorrectable Error Severity register.

E.g., there's only one bit in the Uncorrectable Error Status register
for "Poisoned TLB Received" ("bit12_TLP" above), and it's fatal or
nonfatal depending on the Error Severity setting.

So I propose that you expose "correctable" files and "uncorrectable"
files instead of "correctable", "fatal", and "nonfatal".  Then if you
need the severity information you could add a new file for
"uncorrectable severity".

IIUC these files are counts of how many errors have been logged.
Maybe add "_count" at the end?  I think that would be more informative
than the "bitN" part, although it's not completely obvious how to map
some of these (TLP, FCP, DLP, SDES) to the spec; maybe they could be
expanded?

> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_cor
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_fatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_device_err_nonfatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_cor
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_fatal
> -r--r--r--. 1 root root 4096 Aug 20 16:35 total_rootport_err_nonfatal
> localhost /sys/devices/pci0000:00/0000:00:1c.0/aer_stats #
> 
> Each file is has a single counter value. Single file containing all

s/is has/contains/

Bjorn
