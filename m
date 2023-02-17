Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D3769A8CB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBQKCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 05:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBQKB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 05:01:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED216627D1;
        Fri, 17 Feb 2023 02:01:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJ6g04zMVz687Rd;
        Fri, 17 Feb 2023 17:57:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 10:01:54 +0000
Date:   Fri, 17 Feb 2023 10:01:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
Message-ID: <20230217100156.000039b9@Huawei.com>
In-Reply-To: <20230216102616.GA13347@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <4834ceab1c3e00d3ec957e6c8beb13ddaa9877a2.1676043318.git.lukas@wunner.de>
        <20230214113311.00000825@Huawei.com>
        <20230216102616.GA13347@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Feb 2023 11:26:16 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Feb 14, 2023 at 11:33:11AM +0000, Jonathan Cameron wrote:
> > On Fri, 10 Feb 2023 21:25:04 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > If the length in the CDAT header is larger than the concatenation of the
> > > header and all table entries, then the CDAT exposed to user space
> > > contains trailing null bytes.
> > > 
> > > Not every consumer may be able to handle that.  Per Postel's robustness
> > > principle, "be liberal in what you accept" and silently reduce the
> > > cached length to avoid exposing those null bytes.  
> [...]
> > Fair enough. I'd argue that we are papering over broken hardware if
> > we hit these conditions, so given we aren't aware of any (I hope)
> > not sure this is stable material.  Argument in favor of stable being
> > that if we do get broken hardware we don't want an ABI change when
> > we paper over the garbage... hmm.  
> 
> Type 0 is assigned for DSMAS structures.  So user space might believe
> there's an additional DSMAS in the CDAT.  It *could* detect that the
> length is bogus (it is 0 but should be 24), but what if it doesn't
> check that?  It seems way too dangerous to leave this loophole open,
> hence the stable designation.
Ok

> 
> Thanks,
> 
> Lukas
> 
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -582,6 +582,9 @@ static int cxl_cdat_read_table(struct device *dev,
> > >  		}
> > >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> > >  
> > > +	/* Length in CDAT header may exceed concatenation of CDAT entries */
> > > +	cdat->length -= length;
> > > +
> > >  	return 0;
> > >  }
> > >    

