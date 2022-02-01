Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE34A5A7D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiBAKt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:49:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4590 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiBAKt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 05:49:26 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp1mh0wMMz67xMM;
        Tue,  1 Feb 2022 18:45:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:49:24 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 10:49:24 +0000
Date:   Tue, 1 Feb 2022 10:49:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 11/40] cxl/core/port: Clarify decoder creation
Message-ID: <20220201104922.000022ad@Huawei.com>
In-Reply-To: <164366463014.111117.9714595404002687111.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298417755.3018233.850001481653928773.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164366463014.111117.9714595404002687111.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Mon, 31 Jan 2022 13:33:13 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Add wrappers for the creation of decoder objects at the root level and
> switch level, and keep the core helper private to cxl/core/port.c. Root
> decoders are static descriptors conveyed from platform firmware (e.g.
> ACPI CFMWS). Switch decoders are CXL standard decoders enumerated via
> the HDM decoder capability structure. The base address for the HDM
> decoder capability structure may be conveyed either by PCIe or platform
> firmware (ACPI CEDT.CHBS).
> 
> Additionally, the kdoc descriptions for these helpers and their
> dependencies is updated.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: fixup changelog, clarify kdoc]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

