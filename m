Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517A048D4F4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiAMJZQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 13 Jan 2022 04:25:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4410 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiAMJZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 04:25:15 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JZJqL0WmWz67Ybb;
        Thu, 13 Jan 2022 17:22:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 10:25:12 +0100
Received: from localhost (10.47.73.102) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 09:25:11 +0000
Date:   Thu, 13 Jan 2022 09:25:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Zayd Qumsieh <zaydq@rivosinc.com>
CC:     <alison.schofield@intel.com>, <ben.widawsky@intel.com>,
        <cbrowy@avery-design.com>, <dan.j.williams@intel.com>,
        <f.fangjian@huawei.com>, <helgaas@kernel.org>,
        <ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <vishal.l.verma@intel.com>, Dylan Reid <dylan@rivosinc.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
Message-ID: <20220113092512.000011d6@Huawei.com>
In-Reply-To: <CAAJ9+9ct3+N0LyH+9N03ZQYUZnF23LFAyWFcnNK4bD7SvaohrQ@mail.gmail.com>
References: <CAAJ9+9fq1=EcOaSoo3oD_5QjYNAv6PPDjKS+gC9o7XDp2p1XpQ@mail.gmail.com>
        <CAAJ9+9ct3+N0LyH+9N03ZQYUZnF23LFAyWFcnNK4bD7SvaohrQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.73.102]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Jan 2022 14:16:18 -0800
Zayd Qumsieh <zaydq@rivosinc.com> wrote:

> Hello all,
> 
> Due to issues with vger.kernel.org marking HTML emails as spam, I'll
> be resending the email in plain text:
> 
> 
> 
> Hello all, First off, thanks for your work on implementing PCI Data
> Object Exchange in QEMU and Linux.
> 
> 1. Are these patches still being worked on? If not, I’ll try to get
> them rebased and finished.
> 
> 2. Are there any notes not mentioned in the emails you feel are
> important to know about?
> 
> 3. I'm particularly interested in the testing framework - the emails
> mention that a lot of testing has been done through QEMU but how can I
> carry out these tests on my own? What tools did you use?
> 
> Thanks,
> 
> Zayd

https://lore.kernel.org/all/20211105235056.3711389-1-ira.weiny@intel.com/
Is the latest version of this.  For basic testing Ben's qemu branch should
work for you. 
https://gitlab.com/bwidawsk/qemu/-/commits/cxl-2.0v4/

Note there are some big questions over the approach used for integrating
this with the PCI subsystem (auxiliary bus vs library) which I'm not sure
we've reached a conclusion on yet.

One minor thing on the wish list is lspci support to at least identify the
presence of a DOE.  I have patches for that and will send out fairly soon
once I've cleared a backlog of other stuff.

My main focus right now is on resolving some of the opens around the
QEMU support for CXL emul in general, but I haven't touched the DOE stuff
beyond rebasing.  *fingers crossed* I should have an updated qemu tree
out sometime in next week or so.

Thanks,

Jonathan
