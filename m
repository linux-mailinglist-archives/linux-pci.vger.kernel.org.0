Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC07A8FAF
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITXDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 19:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjITXDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 19:03:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BD0A3;
        Wed, 20 Sep 2023 16:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AF1C433C8;
        Wed, 20 Sep 2023 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695250979;
        bh=Zk4ujfkFmSNtiTgBEOrvD7R3EsDa5uPjHsUOQXft7vY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E9/5vRGEsGzKegCu2DninNk52ODyzPtj9qhHx85u3mWzdAHeA20G5Mp9dW87NblaK
         0cXnTww3yriMw6vJ6QHjgIqZNNwpNp5HVHGc7ErMbTIyFmFjiClXWC4rm+BRLxKaQi
         uu+rfqrd3XpBh9nygaet6ZX/g8SLibnfgi+1K3Ap5W6nK12o3lcxVgXuau0iM8tMgp
         3ixA4xKV6Njt1tRobAyf1FGa79OZDdERK0D0s6VU6OM768Ulb6sTbaONRuBJMOWOs8
         XPca1/1qBBbCKo78mCbwspK2EqcAKTKRJ13vU8wmPtkvW9apmyCt2hkaOYbb9apZeW
         ii2dsu1p0GLGg==
Date:   Wed, 20 Sep 2023 18:02:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, mahesh@linux.ibm.com,
        bhelgaas@google.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        gregkh@linuxfoundation.org,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Message-ID: <20230920230257.GA280837@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e486db16-d36d-9e14-4f10-dc755c0ef97d@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 05:39:58PM +0800, Shuai Xue wrote:
> Hi, all folks,
> 
> Error reporting and recovery are one of the important features of PCIe, and
> the kernel has been supporting them since version 2.6, 17 years ago.
> I am very curious about the expected behavior of the software.
> I first recap the error classification and then list my questions bellow it.
> 
> ## Recap: Error classification
> 
> - Fatal Errors
> 
> Fatal errors are uncorrectable error conditions which render the particular
> Link and related hardware unreliable. For Fatal errors, a reset of the
> components on the Link may be required to return to reliable operation.
> Platform handling of Fatal errors, and any efforts to limit the effects of
> these errors, is platform implementation specific. (PCIe 6.0.1, sec
> 6.2.2.2.1 Fatal Errors).
> 
> - Non-Fatal Errors
> 
> Non-fatal errors are uncorrectable errors which cause a particular
> transaction to be unreliable but the Link is otherwise fully functional.
> Isolating Non-fatal from Fatal errors provides Requester/Receiver logic in
> a device or system management software the opportunity to recover from the
> error without resetting the components on the Link and disturbing other
> transactions in progress. Devices not associated with the transaction in
> error are not impacted by the error.  (PCIe 6.0.1, sec 6.2.2.2.1 Non-Fatal
> Errors).
> 
> ## What the kernel do?
> 
> The Linux kernel supports both the OS native and firmware first modes in
> AER and DPC drivers. The error recovery API is defined in `struct
> pci_error_handlers`, and the recovery process is performed in several
> stages in pcie_do_recovery(). One main difference in handling PCIe errors
> is that the kernel only resets the link when a fatal error is detected.
> 
> ## Questions
> 
> 1. Should kernel panic when fatal errors occur without AER recovery?
> 
> IMHO, the answer is NO. The AER driver handles both fatal and
> non-fatal errors, and I have not found any panic changes in the
> recovery path in OS native mode.
> 
> As far as I know, on many X86 platforms, struct
> `acpi_hest_generic_status::error_severity` is set as CPER_SEV_FATAL
> in firmware first mode. As a result, kernel will panic immediately
> in ghes_proc() when fatal AER errors occur, and there is no chance
> to handle the error and perform recovery in AER driver.

UEFI r2.10, sec N.2.1,, defines CPER_SEV_FATAL, and platform firmware
decides which Error Severity to put in the error record.  I don't see
anything in UEFI about how the OS should handle fatal errors.

ACPI r6.5, sec 18.1, says on fatal uncorrected error, the system
should be restarted to prevent propagation of the error.  For
CPER_SEV_FATAL errors, it looks like ghes_proc() panics even before
trying AER recovery.

I guess your point is that for CPER_SEV_FATAL errors, the APEI/GHES
path always panics but the native path never does, and that maybe both
paths should work the same way?

It would be nice if they worked the same, but I suspect that vendors
may rely on the fact that CPER_SEV_FATAL forces a restart/panic as
part of their system integrity story.

It doesn't seem like the native path should always panic.  If we can
tell that data was corrupted, we may want to panic, but otherwise I
don't think we should crash the entire system even if some device is
permanently broken.

> For fatal and non-fatal errors, struct
> `acpi_hest_generic_status::error_severity` should as
> CPER_SEV_RECOVERABLE, and struct
> `acpi_hest_generic_data::error_severity` should reflect its real
> severity. Then, the kernel is equivalent to handling PCIe errors in
> Firmware first mode as it does in OS native mode.  Please correct me
> if I am wrong.

I don't know enough to comment on how Error Severity should be used in
the Generic Error Status Block vs the Generic Error Data Entry.

> However, I have changed my mind on this issue as I encounter a case where
> a error propagation is detected due to fatal DLLP (Data Link Protocol
> Error) error. A DLLP error occurred in the Compute node, causing the
> node to panic because `struct acpi_hest_generic_status::error_severity` was
> set as CPER_SEV_FATAL. However, data corruption was still detected in the
> storage node by CRC.

The only mention of Data Link Protocol Error that looks relevant is
PCIe r6.0, sec 3.6.2.2, which basically says a DLLP with an unexpected
Sequence Number should be discarded:

  For Ack and Nak DLLPs, the following steps are followed (see Figure
  3-21):

    - If the Sequence Number specified by the AckNak_Seq_Num does not
      correspond to an unacknowledged TLP, or to the value in
      ACKD_SEQ, the DLLP is discarded

      - This is a Data Link Protocol Error, which is a reported error
	associated with the Port (see Section 6.2).

So data from that DLLP should not have made it to memory, although of
course the DMA may not have been completed.  But it sounds like you
did see corrupted data written to memory?

I assume it is not reproducible and we have no reason to think the
receiver of the DLLP has a design defect, e.g., it reported the error
but failed to drop the DLLP?

> 2. Should kernel panic when AER recovery failed?
> 
> This question is actually a TODO that was added when the AER driver was
> first upstreamed 17 years ago, and it is still relevant today. The kernel
> does not proactively panic regardless of the error types occurring in OS
> native mode. The DLLP error propagation case indicates that the kernel
> might should panic when recovery failed?

I'm not a hardware engineer, but I'm not yet convinced that a Data
Link Protocol Error should cause a panic because sec 3.6.2.2 suggests
that this error should not cause data corruption.  Certainly willing
to be proved wrong!

> 3. Should DPC be enabled by default to contain fatal and non-fatal error?
> 
> According to the PCIe specification, DPC halts PCIe traffic below a
> Downstream Port after an unmasked uncorrectable error is detected at or
> below the Port, avoiding the potential spread of any data corruption.
> 
> The kernel configures DPC to be triggered only on ERR_FATAL. Literally
> speaking, only fatal error have the potential spread of any data
> corruption?

Sec 6.2.2.2 talks about fatal vs non-fatal but only in terms of
whether the error affects a particular transaction (non-fatal) or
everything related to a Link (fatal).  Unless there's more detail
elsewhere, I would assume either could corrupt data.

> In addition, the AER Severity is programable by the
> Uncorrectable Error Severity Register (Offset 0Ch in PCIe AER cap). If a
> default fatal error, e.g. DLLP, set as non-fatal, DPC will not be
> triggered.

Sec 6.2.7 and 7.8.4.4 suggest the Data Link Protocol Error should be
a fatal error by default.

I don't think Linux changes PCI_ERR_UNC_DLP (unless there's an _HPX or
similar method), so I would expect it to be set as fatal.

Bjorn

> [1] https://github.com/torvalds/linux/commit/6c2b374d74857e892080ee726184ec1d15e7d4e4#diff-fea64904d30501b59d2e948189bbedc476fc270ed4c15e4ae29d7f0efd06771aR438
