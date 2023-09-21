Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7217AA3BC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjIUVzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIUVzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 17:55:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF59268B;
        Thu, 21 Sep 2023 14:52:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F141C433C7;
        Thu, 21 Sep 2023 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695333163;
        bh=NTAFR578UzDwqvs2i4ooBKtvlj/FAAfa/TDohcND/ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tSv58fX4rgoT5MYYQHvquhnl4/cItfTC3vQVAoiE1T5bpAWTEyRuvbOL2+SfjX1To
         ym7q3ByyPsVAzzX3Jw1JOr42zULob1th/6f5I8bvMb0d8/MxiaGUGMyjH5KDt/wza2
         Y17f+v22fwxB/qdzyqkg027OFSixhJuTZQgFNOGK3j9kc396bMtRILz291YtClj+RZ
         TFhyHC84ztlKulj3Gw8GFhX/x8XmAtvf/ItwSLYDK2evIVNr4w10qV4aQb3ZIknvNo
         XXeoh1ZwMnf3jc2N2HkjkFUvQGSRE4kJs8QLvA5n/Oj3vjpEfN9lNE9eHd8M/GL2nZ
         FfHdGGCbxWnuQ==
Date:   Thu, 21 Sep 2023 16:52:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, Linux PCI <linux-pci@vger.kernel.org>,
        mahesh@linux.ibm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        bhelgaas@google.com, "james.morse@arm.com" <james.morse@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Message-ID: <20230921215241.GA337765@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84b6d17-7fe9-222a-c874-798af4d9faea@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 08:10:19PM +0800, Shuai Xue wrote:
> On 2023/9/21 07:02, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 05:39:58PM +0800, Shuai Xue wrote:
> ...

> > I guess your point is that for CPER_SEV_FATAL errors, the APEI/GHES
> > path always panics but the native path never does, and that maybe both
> > paths should work the same way?
> 
> Yes, exactly. Both OS native and APEI/GHES firmware first are notifications
> used to handles PCIe AER errors, and IMHO, they should ideally work in the
> same way.

I agree, that would be nice, but the whole point of the APEI/GHES
functionality is vendor value-add, so I'm not sure we can achieve that
ideal.

> ...
> As a result, AER driver only does recovery for non-fatal PCIe error.

This is only true for the APEI/GHES path, right?  For *native* AER
handling, we attempt recovery for both fatal and non-fatal errors.

> > It doesn't seem like the native path should always panic.  If we can
> > tell that data was corrupted, we may want to panic, but otherwise I
> > don't think we should crash the entire system even if some device is
> > permanently broken.
> 
> Got it. But how can we tell if the data is corrupted with OS native?

I naively expect that by PCIe protocol, corrupted DLLPs or TLPs
detected by CRC, sequence number errors, etc, would be discarded
before corrupting memory, so I doubt we'd get an uncorrectable error
that means "sorry, I just corrupted your data."

But DPC is advertised as "avoiding the potential spread of any data
corruption," so there must be some mechanisms of corruption, and since
DPC is triggered by either ERR_FATAL or ERR_NONFATAL, I guess maybe
the errors could tell us something.  I'm going to quit speculating
because I obviously don't know enough about this area.

> >> However, I have changed my mind on this issue as I encounter a case where
> >> a error propagation is detected due to fatal DLLP (Data Link Protocol
> >> Error) error. A DLLP error occurred in the Compute node, causing the
> >> node to panic because `struct acpi_hest_generic_status::error_severity` was
> >> set as CPER_SEV_FATAL. However, data corruption was still detected in the
> >> storage node by CRC.
> > 
> > The only mention of Data Link Protocol Error that looks relevant is
> > PCIe r6.0, sec 3.6.2.2, which basically says a DLLP with an unexpected
> > Sequence Number should be discarded:
> > 
> >   For Ack and Nak DLLPs, the following steps are followed (see Figure
> >   3-21):
> > 
> >     - If the Sequence Number specified by the AckNak_Seq_Num does not
> >       correspond to an unacknowledged TLP, or to the value in
> >       ACKD_SEQ, the DLLP is discarded
> > 
> >       - This is a Data Link Protocol Error, which is a reported error
> > 	associated with the Port (see Section 6.2).
> > 
> > So data from that DLLP should not have made it to memory, although of
> > course the DMA may not have been completed.  But it sounds like you
> > did see corrupted data written to memory?
> 
> The storage node use RDMA to directly access remote compute node.
> And a error detected by CRC in the storage node. So I suspect yes.

When doing the CRC, can you distinguish between corrupted data and
data that was not written because a DMA was only partially completed?

> ...
> I tried to inject Data Link Protocol Error on some platform. The mechanism
> behind is that rootport controls the sequence number of the specific TLPs
> and ACK/NAK DLLPs. Data Link Protocol Error will be detected at the Rx side
> of ACK/NAK DLLPs.
> 
> In such case, NIC and NVMe recovered on fatal and non-fatal DLLP
> errors.

I'm guessing this error injection directly writes the AER status bit,
which would probably only test the reporting (sending an ERR_FATAL
message), AER interrupt generation, firmware or OS interrupt handling,
etc.

It probably would not actually generate a DLLP with a bad sequence
number, so it probably does not test the hardware behavior of
discarding the DLLP if the sequence number is bad.  Just my guess
though.

> ...
> My point is that how kernel could recover from non-fatal and fatal
> errors in firmware first without DPC? If CPER_SEV_FATAL is used to
> report fatal PCIe error, kernel will panic in APEI/GHES driver.

The platform decides whether to use CPER_SEV_FATAL, so we can't change
that.  We *could* change whether Linux panics when the platform says
an error is CPER_SEV_FATAL.  That happens in drivers/acpi, so it's
really up to Rafael.

Personally I would want to hear from vendors who use the APEI/GHES
path.  Poking around the web for logs that mention HEST and related
things, it looks like at least Dell, HP, and Lenovo use it.  And there
are drivers/acpi/apei commits from nxp.com, alibaba.com, amd.com,
arm.com huawei.com, etc., so some of them probably care, too.

Bjorn
