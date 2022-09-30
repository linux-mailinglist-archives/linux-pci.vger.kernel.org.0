Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACC5F0EAC
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 17:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiI3PSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiI3PSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 11:18:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA6154441;
        Fri, 30 Sep 2022 08:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B50CB82931;
        Fri, 30 Sep 2022 15:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E71C433D6;
        Fri, 30 Sep 2022 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664551099;
        bh=lphfuvlsH6sE0H3f45v7Cv4NwoQlGiRcaOg+b9x0qE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UL5g8L4yUFuamegJLArG3AD24pyQ04fdDW/rNrfpsuqkWcp8bHKV89Rx73GxbvGh4
         Ht9J6uP+e3S3BqsxofzQ8qdlbN/NEu9Ld269RNcn61Aldwua/86HSx07omMm76hx/W
         GCjmImtztAfS69AlnckzbTNRJkNJTXgLnfV2XNdC5lEuXUdO6VFWxJEb3WUQqYFPb1
         UZBXlzpChRDQJGf5VfQS5tiCr90f5ZmJWCCFvOr4F/5sRcpZIGQgVBGZ8R3GTMjWua
         lnegaJySK8KakdojzsAFx/lc69P5QGTSAt4EuZGl2dZd0k9bZMgkbc3EIS9Kxj6dKd
         mwJOLm2K7Ranw==
Date:   Fri, 30 Sep 2022 10:18:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Make SUNIX serial card acceptable latency
 unlimited
Message-ID: <20220930151817.GA1973184@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930091050.193096-1-chris.chiu@canonical.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 05:10:50PM +0800, Chris Chiu wrote:
> SUNIX serial card advertise L1 acceptable L0S exit latency to be
> < 2us, L1 < 32us, but the link capability shows they're unlimited.
> 
> It fails the latency check and prohibits the ASPM L1 from being
> enabled. The L1 acceptable latency quirk fixes the issue.

Hi Chris, help me understand what's going on here.

The "Endpoint L1 Acceptable Latency" field in Device Capabilities is
described like this (PCIe r6.0, sec 7.5.3.3):

  This field indicates the acceptable latency that an Endpoint can
  withstand due to the transition from L1 state to the L0 state. It is
  essentially an indirect measure of the Endpoint’s internal
  buffering.

  Power management software uses the reported L1 Acceptable Latency
  number to compare against the L1 Exit Latencies reported (see below)
  by all components comprising the data path from this Endpoint to the
  Root Complex Root Port to determine whether ASPM L1 entry can be
  used with no loss of performance.

The "L1 Exit Latency" in Link Capabilities:

  This field indicates the L1 Exit Latency for the given PCI Express
  Link. The value reported indicates the length of time this Port
  requires to complete transition from ASPM L1 to L0.

Apparently the SUNIX device advertises in Dev Cap that it can tolerate
a maximum of 32us of L1 Exit Latency for the entire path from the
SUNIX device to the Root Port, and in Link Cap that the SUNIX device
itself may take more than 64us to exit L1.

If that's accurate, then we should not enable L1 for that device
because using L1 may cause buffer overflows, e.g., dropped characters.

Per 03038d84ace7 ("PCI/ASPM: Make Intel DG2 L1 acceptable latency
unlimited"), the existing users of aspm_l1_acceptable_latency() are
graphics devices where I assume there would be little data coming from
the device and buffering would not be an issue.

It doesn't seem plausible to me that a serial device, where there is a
continuous stream of incoming data, could tolerate an *unlimited* exit
latency.

I could certainly believe that Link Cap advertises "> 64us" of L1 Exit
Latency when it really should advertise "< 32us" or something.  But I
don't know how we could be confident in the correct value without
knowledge of the device design.

Bjorn

> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4944798e75b5..e1663e43846e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5955,4 +5955,5 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, aspm_l1_acceptable_latency);
>  #endif
> -- 
> 2.25.1
> 
