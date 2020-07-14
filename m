Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54F621FEF6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 22:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGNUzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 16:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGNUzC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 16:55:02 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51F320658;
        Tue, 14 Jul 2020 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594760102;
        bh=qUHG7xsDVMn181LWIecIif+rbF1WE2qZXli7OymdPyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Av8M6x96MEPV22zoyhesMNcJhZQOwl3Vxujn3a0iJRQunonWX+6AZJi58+XPj3jCx
         DK7xdf9H4mYV8abKnqa8rMaVverB7vx3hU/Je0kgxO3YyrcVmBnQd43eAf7HkGjX5G
         JGgQ+6LCieL/GFopxvxA1WJX96nXDb1u0kBfSU6A=
Date:   Tue, 14 Jul 2020 15:55:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v12 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Message-ID: <20200714205500.GA418237@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713140901.853-2-shiju.jose@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 03:09:00PM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.

Does the spec really connect "firmware-first" and CPER records?  Are
there non-firmware-first CPER records?

This sentence suggests that firmware-first CPER records are identified
by GUID, and that there are non-firmware-first CPER records that might
not be identified by GUID.

I suspect this would be better as simply:

  CPER records are identified by a Notification Type GUID.

(Or maybe it's a Section Type GUID?)

> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).
> 
> Add a notifier chain for these non-standard/vendor-records. Callers
> must identify their type of records by GUID.
> 
> Record data is copied to memory from the ghes_estatus_pool to allow
> us to keep it until after the notifier has run.
