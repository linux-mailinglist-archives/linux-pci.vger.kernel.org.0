Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64C67EF4F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 21:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjA0UK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjA0UKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 15:10:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3A22034;
        Fri, 27 Jan 2023 12:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D37B9B8214D;
        Fri, 27 Jan 2023 20:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5231CC433EF;
        Fri, 27 Jan 2023 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674850203;
        bh=+kQYAR4DnIoAHGIlstzSyI6Kn7zlVSLWw9Dib/2viHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RQftt4IWKOF2E9LYAvviqI/empPNam8AnEQt83ed62K4YYxJFJvGcWu4Pdq/P0KO4
         lISra+xBWZvolUo5YwQeWqZgkEmgTOpJxXXNOBSdRlvxcsb01Jp5afNbPFbGXbDUok
         riY5gM71gxUps4ZabPxkmEn47QNK1J7XdcFxyRhVS2HVxW/dXoVCibwDDegPSeYQsZ
         pN85EHZIwJXCqdvzxGtsFTZtuFWk+PGJQNUalXptL696FTQs33V4bM/hE6HbEBCw5M
         //6wuhE5SIwAsG378VPM4RZd++UbY6uZYV0strudAtrUfNoPB+iyfY0eP+lndwWXM/
         H9ZXnye4rY9UQ==
Date:   Fri, 27 Jan 2023 14:10:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, kai.heng.feng@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
Message-ID: <20230127201001.GA1412182@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125133830.20620-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 07:08:30PM +0530, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery System.
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> This patch addresses that issue by updating the saved configuration state
> of the device with the latest info whenever there is a change w.r.t ASPM
> policy.

Please use blank lines between paragraphs.  Inferring "new paragraph"
from "last line was shorter than usual" is error-prone and hard to
read.

Omit "this patch" (that part is obvious) and use imperative mood:

  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.0#n94
