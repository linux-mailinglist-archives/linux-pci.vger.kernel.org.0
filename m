Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1A64A5AA0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiBAKw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:52:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4591 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiBAKw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:52:57 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp1qj6zX4z67QKq;
        Tue,  1 Feb 2022 18:48:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:52:55 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 10:52:54 +0000
Date:   Tue, 1 Feb 2022 10:52:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
Message-ID: <20220201105253.00002f23@Huawei.com>
In-Reply-To: <164367209095.208169.1171673319121271280.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164367209095.208169.1171673319121271280.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jan 2022 15:35:18 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Lockdep reports:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.16.0-rc1+ #142 Tainted: G           OE
>  ------------------------------------------------------
>  cxl/1220 is trying to acquire lock:
>  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> 
>  but task is already holding lock:
>  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> 
> ...where cxl_remove_ep() is a helper that wants to delete ports while
> holding a lock on the host device for that port. That sets up a lockdep
> violation whereby target_list_show() can not rely holding the decoder's
> device lock while walking the target_list. Switch to a dedicated seqlock
> for this purpose.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

