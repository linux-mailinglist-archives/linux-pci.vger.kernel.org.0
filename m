Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DA22BA32
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGWXXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 19:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgGWXXE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 19:23:04 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11DDF2080D;
        Thu, 23 Jul 2020 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595546583;
        bh=LpBa7WC+PmUuvju8pxnLc0G1tsZpO642XLjDjk2e2t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X6o9ceMGv+6QFquvn2TvPUVx/zu/mVWGEEU5pf4oh4Wgllo8B2E5tlVVO7LTPHkUY
         vz0BD9uuKTVDQ5v9CUpFPDMx+YAboz9sTAgKqWl9xkpr6EbsU/q4IJqYAvqDYb1TQX
         CRixz1EWv7+K81kyoOJtGumwMEuGHYTp0h0tF/YU=
Date:   Thu, 23 Jul 2020 18:23:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v13 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200723232301.GA1468407@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722104245.1060-1-shiju.jose@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 11:42:43AM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.
> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).
> 
> patch set
> 1. add a notifier chain for these non-standard/vendor-records
>    in the ghes driver.
> 
> 2. add a driver to handle HiSilicon HIP PCIe controller's errors.
>    
> Changes:
> 
> V13:
> 1. Following changes in the HIP PCIe error handling driver.
> 1.1 Add Bjorn's acked-by.
> 1.2. Address the comments and macros order Bjorn mentioned.
>      Fix the words in the commit.

This series is ill-formed:

  - Jul 22  5:39 Shiju Jose      [PATCH v13 0/2] ACPI / APEI: Add support to not
  - Jul 22  5:39 Shiju Jose      └─>[PATCH v13 1/2] ACPI / APEI: Add a notifier
  - Jul 22  5:42 Shiju Jose      [PATCH v13 0/2] ACPI / APEI: Add support to not
  - Jul 22  5:42 Shiju Jose      └─>[PATCH v13 2/2] PCI: hip: Add handling of Hi

Patches 1/2 and 2/2 never appear in the same thread.  Both should be
replies to 0/2.  And should be only *one* v13 0/2, not two :)

Bjorn
