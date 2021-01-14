Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4862F69A0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 19:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhANSdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 13:33:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2352 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhANSdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 13:33:41 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGtB600Ldz67bhq;
        Fri, 15 Jan 2021 02:29:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 14 Jan 2021 19:32:57 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 18:32:57 +0000
Date:   Thu, 14 Jan 2021 18:32:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 14/16] cxl/mem: Use CEL for enabling commands
Message-ID: <20210114183217.0000154c@Huawei.com>
In-Reply-To: <20210114181340.fgybdchzfxiiqwhr@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-16-ben.widawsky@intel.com>
        <20210114180211.00007852@Huawei.com>
        <20210114181340.fgybdchzfxiiqwhr@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jan 2021 10:13:40 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-01-14 18:02:11, Jonathan Cameron wrote:
> > On Mon, 11 Jan 2021 14:51:19 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> > > The CEL is one of two types of logs, the other being vendor specific.
> > > They are distinguished in hardware/spec via UUID. The CEL is immediately
> > > useful for 2 things:
> > > 1. Determine which optional commands are supported by the CXL device.
> > > 2. Enumerate any vendor specific commands
> > > 
> > > The CEL can be used by the driver to determine which commands are
> > > available in the hardware (though it isn't, yet). That set of commands
> > > might itself be a subset of commands which are available to be used via
> > > CXL_MEM_SEND_COMMAND IOCTL.
> > > 
> > > Prior to this, all commands that the driver exposed were explicitly
> > > enabled. After this, only those commands that are found in the CEL are
> > > enabled.
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > 
> > This patch made me wonder if the model for the command in quite right.
> > I think it would end up simpler with a pair of payload pointers for send
> > and receive (that can be equal when it makes sense).
> > 
> > A few other things inline.
> > 
> > Jonathan  
> 
> I'll address the others separately, but could you elaborate on this? I'm not
> sure I follow your meaning.

Further down in the review..
"
The fact that you end up bypassing the payload transfer stuff in mbox_cmd
rather suggests it's not a particularly good model.  + it keeps confusing
me.

While the hardware uses a single region for the payload, there is nothing
saying the code has to work that way.   Why not have separate payload_in and
payload_out pointers?  Occasionally you might set them to the same buffer, but
elsewhere you could avoid the direct memcpy()s you are doing around the
send_cmd(). 

"

Jonathan


> 
> [snip]
> 
> 

