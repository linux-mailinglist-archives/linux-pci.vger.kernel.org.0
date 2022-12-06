Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939D6449FF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiLFRLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 12:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLFRLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 12:11:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC53E2FA7E
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 09:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77162617A2
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 17:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91190C43470;
        Tue,  6 Dec 2022 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670346675;
        bh=acVFhdBjhDeBcDfQenjzAfdtvy9axWF7peOFBqE57cI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aTpHmcnpBsE2REvFuHnRWS8IAU4wd9BZ4UsQf46joSOlyp6CP0Ywjkqv4lvl5fjYb
         wHggzC4WxeHBjaLSqhzSXpDSRkcxv5sESoWjK+m54CxcTKZEh6SWhGIwnltKYXpwqp
         M1y3Fr6ZfjoX9Duwp3B74kl4z+xyIiGLODdLSueufH+iimJ0ceSimAE/2BtlP/lqGA
         LgK7ooh9aGwrb/A1o8dHm9khRWzauZUyXJNzrmTWZsIl8mz9fae00PAXL0Plv5gW8M
         uTxnaHp3oR5QavuS0iHLcDOLkB47GqPEKeucQretu+4Cav/gsYVF9EWxupFduHfWeE
         TLJZSwDHzYaWQ==
Date:   Tue, 6 Dec 2022 11:11:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Message-ID: <20221206171114.GA1356056@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Tue, Nov 29, 2022 at 08:35:55AM +0100, Lukas Wunner wrote:
> Add DPC Software Trigger as a reset method to be used for silicon
> validation among other things:
> 
>   # echo dpc_sw_trigger > reset_method
>   # echo 1 > reset
> 
> After validating DPC, the default reset_method(s) may be reinstated:
> 
>   # echo default > reset_method
> 
> Writing the DPC Control Register requires that control was granted by
> firmware, so expose the reset_method only if DPC is native.  (And AER,
> which must always be granted or denied in unison per PCI Firmware Spec
> r3.3 table 4-5.)
> 
> The reset attribute in sysfs is meant to reset a single PCI Function,
> but DPC resets the entire hierarchy below the parent.  So only expose
> the reset method on PCI Functions without siblings or children.
> Checking for that may happen both *before* the PCI Function has been
> added to the bus list (via pci_device_add() -> pci_init_capabilities())
> and *after* (via reset_method_store()), hence differentiate between
> those two cases on reset probing.
> 
> It would be useful for silicon validation to have a separate sysfs
> attribute for PCI bridges to reset their downstream hierarchy.  Prepare
> for introduction of such an attribute by adding separate functions
> pci_dpc_sw_trigger() (to reset the hierarchy below a bridge) and
> pci_dpc_sw_trigger_parent() (to reset a single PCI Function), where the
> latter calls the former to trigger DPC on the parent bridge.

Does this add functionality above what the "bus" method (Secondary Bus
Reset) provides?  If it's effectively the same as SBR, I'm not sure
it's worth complicating the user interface just to support silicon
validation.

Bjorn
