Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC945445AF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiFII1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiFII1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 04:27:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594BF14D7AD;
        Thu,  9 Jun 2022 01:27:43 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJcXs124Jz6892X;
        Thu,  9 Jun 2022 16:22:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 10:27:40 +0200
Received: from localhost (10.81.202.195) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 09:27:39 +0100
Date:   Thu, 9 Jun 2022 09:27:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 6/9] cxl/port: Read CDAT table
Message-ID: <20220609092738.00007553@Huawei.com>
In-Reply-To: <YqESPug9duS6BMfQ@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
        <20220605005049.2155874-7-ira.weiny@intel.com>
        <20220606181541.ysb3zqdpe5cuk4e6@bwidawsk-mobl5>
        <YqESPug9duS6BMfQ@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.195]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 8 Jun 2022 14:27:14 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Mon, Jun 06, 2022 at 11:15:41AM -0700, Ben Widawsky wrote:
> > On 22-06-04 17:50:46, ira.weiny@intel.com wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >   
> 

[snip]

> >   
> > > +
> > > +		entry = cdat_response_pl + 1;
> > > +		entry_dw = task.rv / sizeof(u32);
> > > +		/* Skip Header */
> > > +		entry_dw -= 1;
> > > +		entry_dw = min(length / 4, entry_dw);
> > > +		memcpy(data, entry, entry_dw * sizeof(u32));
> > > +		length -= entry_dw * sizeof(u32);
> > > +		data += entry_dw;
> > > +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);  
> > 
> > [0] looks suspicious...  
> 
> Actually I have to claim ignorance on this one.  I've carried this from
> Jonathan's original patches.  I'm not as worried about the [0] as that is just
> the first dword.  But I'm confused as to this entry handle now.
> 
> Jonathan?  Help?

Looks right to me.  The entryhandle is a field in the upper 16 bits of the
first dword defined in Read Entry Response table in the CXL spec and also
used in the request of the next entry (which is more or less a CDAT structure)
Two magic values.
0 -  CDAT header (request only - can't be returned)
0xFFFF - No more entries.

As we are reading the whole table, we write 0 to first request and from there
on use the value returned in the response for the next request until we see
0xFFFF and stop.

Note IIRC the meaning of entry handle was clarified in a CXL 2.0 errata as
was a bit ambiguous in the original spec (we had two QEMU implementations
briefly and they did different things :)

Jonathan


> 
> >   
> > > +
> > > +	} while (entry_handle != 0xFFFF);
> > > +
> > > +	return rc;
> > > +}
> > > +


