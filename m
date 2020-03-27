Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9A195992
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgC0PHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 11:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgC0PHM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Mar 2020 11:07:12 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E892072F;
        Fri, 27 Mar 2020 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585321632;
        bh=sIGXOYmpWblR0yL4lyxVPLJLSUNHUp9A2R6LtZEKFvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SBt7nDY8srmcxCDoWQfHq6tZpV06ldg+rg7SLnBn5oO/Ykxr7Fs6HJUayX8ElMdPH
         HbSA6icHJl5Q1MfxyU3tL3P1CgpyIE8PqGyf00RF84e4UJzkJYQS/Iil3eP7InLpkC
         GTRlklgQK4sTXsVISrZBZefbjfvVTzVvPVQtuIPg=
Date:   Fri, 27 Mar 2020 10:07:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v6 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200327150710.GA31821@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325164223.650-1-shiju.jose@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 04:42:21PM +0000, Shiju Jose wrote:
> Presently the vendor drivers are unable to do the recovery for the
> vendor specific recoverable HW errors, reported to the APEI driver
> in the vendor defined sections, because APEI driver does not support
> reporting the same to the vendor drivers.
> 
> This patch set
> 1. add an interface to the APEI driver to enable the vendor
> drivers to register the event handling functions for the corresponding
> vendor specific HW errors and report the error to the vendor driver.
> 
> 2. add driver to handle HiSilicon hip08 PCIe controller's errors
>    which is an example application of the above APEI interface.
> 
> Changes:
> 
> V6:
> 1. Fix few changes in the patch subject line suggested by Bjorn Helgaas.

I think it will save everybody a little work if you can wait a day or
two so you can address more comments at once.  You posted v6 only
about three hours after v5, which isn't enough time for people to
respond to v5.

I'm not going to even look at v6 because it doesn't address some of my
v5 comments.  Please wait a few days before v7 to see if Rafael has
any thoughts on where the error driver should live.

Bjorn
