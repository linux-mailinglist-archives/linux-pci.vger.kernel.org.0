Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8F6D23AA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjCaPKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjCaPKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 11:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37806A74;
        Fri, 31 Mar 2023 08:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44601B8306A;
        Fri, 31 Mar 2023 15:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEA6C4339B;
        Fri, 31 Mar 2023 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275413;
        bh=w1OhyLtdA+PjJV84MZFPETN/oXonzdgzgHgWJaORuCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NNUUrmBLPk6iC+75Ae4RVNFSH7JKbWQ2PdfPmst98WIVuhTZZ9y67n44i1wxUdktE
         9UZiX7Zz+IMvEHeX4ZW3vuw0VleOJ5D4sjMfmDX3eZxgbVkQFgJtSf2YwNmo27TP2S
         D87Rp8prctYT/DmE1gWqe2SxHzlxeGAZYO0SdyyFm6u1Bgy/VbLSrYcSOmg08dmVcr
         FK0zGk9YPz6ZUW+XuoJ5JEojXHiEmsiH9G9gaseKwt9bEkE0P+9qAy9LGznNVaa4YC
         OISgQaErAaY8iZ/otAuWa98fTnPVTb09vI0c/Gro/l0r3ntKsE0ylvnKtdiApLkr5M
         /sCo+RazC9X7w==
Date:   Fri, 31 Mar 2023 10:10:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230331151012.GA3225386@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f5c023-910a-f88f-e7c4-c5a1c3c3ac0e@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 11:46:45PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/30/23 8:45 AM, Bjorn Helgaas wrote:

> > This sounds like a plausible assumption.  But is there actually spec
> > language that says EDR notification is not allowed in the AER native
> > case (when OS owns the AER Capability)?  I looked but didn't find
> > anything.
> 
> In the PCIe firmware specification v3.3, table "Table 4-6: Interpretation of
> the _OSC Control Field, Returned Value", field "PCI Express Downstream Port
> Containment configuration control", it explains that the firmware can use
> EDR notification only when OS DPC control is not requested or denied by
> firmware.

I'm sure that's the intent, but I don't see that restriction in the
spec.  Here's what I'm looking at, which doesn't directly restrict
generation of EDR notifications:

  If control of this feature was requested and denied, or was not
  requested, firmware is responsible for initializing Downstream Port
  Containment Extended Capability Structures per firmware policy.
  Further, [the OS is permitted to write several registers while
  processing an EDR notification]

> > Actually I do have one idea: in the firmware-first case, firmware
> > collects all the status information, clears it, and then passes the
> > status on to the OS.  In this case we don't need to clear the status
> > registers in handle_error_source(), pcie_do_recovery(), etc.
> 
> So the idea is to get the error info in a particular format using
> something like _DSM call?

No, that's not what I'm thinking at all.  I definitely would not want
to add a new _DSM, which would add yet another case the OS has to
handle.

In the firmware-first case, the firmware collects the error status and
clears it before handing the info off to the OS error handling path.

In the native case, the OS should be able to collect the error status
and clear it before starting the OS error handling path.  Same
register accesses, should be indistinguishable from the device point
of view, it's just that the register accesses would be done by the OS
instead of by firmware.

Bjorn
