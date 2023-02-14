Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B862696469
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBNNR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 08:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjBNNR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 08:17:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C95244B6;
        Tue, 14 Feb 2023 05:17:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGMCy2GFpz6J9nV;
        Tue, 14 Feb 2023 21:16:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 13:17:54 +0000
Date:   Tue, 14 Feb 2023 13:17:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <bhelgaas@google.com>,
        <robert.moore@intel.com>
Subject: Re: [PATCH 04/18] cxl: Add common helpers for cdat parsing
Message-ID: <20230214131753.000041c8@Huawei.com>
In-Reply-To: <20230211101833.GA12138@wunner.de>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571659666.587790.1381783105886436293.stgit@djiang5-mobl3.local>
        <20230209115803.00002778@Huawei.com>
        <3c69a080-de0c-3244-cc44-0a187230d203@intel.com>
        <20230211101833.GA12138@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Sat, 11 Feb 2023 11:18:33 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Feb 09, 2023 at 03:57:32PM -0700, Dave Jiang wrote:
> > On 2/9/23 4:58 AM, Jonathan Cameron wrote:  
> > > On Mon, 06 Feb 2023 13:49:58 -0700 Dave Jiang <dave.jiang@intel.com> wrote:  
> > > > Add helper functions to parse the CDAT table and provide a callback to
> > > > parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
> > > > parsing. The code is patterned after the ACPI table parsing helpers.  
> [...]
> > > Are these all worthwhile given the resulting function name is longer
> > > than accessing it directly.  If aim is to move the details of the
> > > struct cdat_subtable_entry away from being exposed at caller, then
> > > fair enough, but if that is the plan I'd expect to see something about
> > > that in the patch description.
> > > 
> > > Feels like some premature abstraction, but I don't feel particularly
> > > strongly about this.  
> > 
> > I'll drop them. The code was adapted from ACPI table parsing code. But we
> > can simplify for our usages.  
> 
> Yes just iterating over the CDAT entries and directly calling the
> appropriate parser function for the entry seems more straightforward.
> 
> 
> > > Random musing follows...
> > > We could add a variable length element to that struct
> > > definition and the magic to associate that with the length parameter
> > > and get range protection if relevant hardening is turned on.
> > > 
> > > Structure definition comes (I think) from scripts in acpica so
> > > would need to push such changes into acpica and I'm not sure
> > > they will be keen even though it would be good for the kernel
> > > to have the protections.  
> [...]
> > I see what you are saying. But I'm not sure how easily we can do this for
> > the CDAT table due to endieness. Is this what you had in mind?
> > 
> > From:
> > struct cdat_entry_header {
> > 	u8 type;
> > 	u8 reserved;
> > 	__le16 length;
> > } __packed;
> > 
> > To:
> > struct cdat_entry_header {
> > 	u8 type;
> > 	u8 reserved;
> > 	__le16 length;
> > 	DECLARE_BOUNDED_ARRAY(u8, body, le16_to_cpu(length));
> > } __packed;  
> 
> I think this is backwards.  I'd suggest creating a struct for each
> CDAT entry which includes the header.  The kernel switched to
> -std=gnu11 a while ago, so you should be able to use an unnamed field
> for the header:
> 
> struct cdat_dsmas {
> 	struct cdat_entry_header;
> 	u8 dsmad_handle;
> 	u8 flags;
> 	u8 reserved[2];
> 	__le64 dpa_base;
> 	__le64 dpa_length;
> }

This is indeed better given we always know the type before accessing.

The above trick might be useful for any code that treats it as
generic entries though a straight forwards check might be easier
and is already present in Lukas' latest code.

> 
> Note that in my commit "cxl/pci: Handle truncated CDAT entries",
> I'm only verifying that the number of bytes received via DOE
> matches the length field in the cdat_entry_header.  I do not
> verify in cxl_cdat_read_table() whether that length is correct
> for the specific CDAT structure.  I think that's the job of
> the function parsing that particular structure type.
> 
> In other words, at the top of your DSMAS parsing function,
> you need to check:
> 
> 	struct cdat_dsmas dsmas;
> 
> 	if (dsmas->length != sizeof(*dsmas)) {
> 		dev_err(...);
> 		return -EINVAL;
> 	}
> 
> 
> Note how the check is simplified by the header being part of
> struct cdat_dsmas.  If the header wasn't part of struct cdat_dsmas,
> an addition would be needed here.
> 
> Thanks,
> 
> Lukas
> 

