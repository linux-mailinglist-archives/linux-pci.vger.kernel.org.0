Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FD733C0A
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 00:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjFPWBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjFPWBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 18:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379D297E;
        Fri, 16 Jun 2023 15:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F9A61F51;
        Fri, 16 Jun 2023 22:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7494C433C8;
        Fri, 16 Jun 2023 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686952888;
        bh=lor+9CzJuJ16UAG83X/TrSjJxGuaeIWyzZ4JuzMH5fQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lZPkTGzs39ZHNiZkaoRWItQiE0QwvxE957VSI9JWquQq4mV90qHPQptOpsBAx+lze
         xfiHf2HcLRwfopB8TRTD6qhV4NHGBjs+mtLNFejEWYk0sl6RIxowOwbXT8GJzlivg8
         wpw+MI/FVXVsuxy1n3sqLrOSjqD4HsBX/hbU20KB0vepY8onDtXm4vyrajS0dcR8Ub
         th22LqZDDA1LOI55A6huIW9/QZ9MeQc6sptqeKTvTdZON67TGfxJdxH+QJH1tGssol
         +Whion7zGtqqG5VJbz9TjDVzpYXZ/t8hvrEUMtynD+jz9KQw69B6w3xNw4N7TxLMAP
         naFyJtKNzxD4w==
Date:   Fri, 16 Jun 2023 17:01:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Message-ID: <20230616220125.GA1555182@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> enabled for that device. However, when the device is plugged preboot,
> ASPM is enabled by default.
> 
> The disparity happens because BIOS doesn't have the ability to program
> ASPM on hotplugged devices.
> 
> So enable ASPM by default for external connected PCIe devices so ASPM
> settings are consitent between preboot and hotplugged.
> 
> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:07:04.0:    [ 7] BadDLLP
> 
> The root cause is still unclear, but quite likely because the I225 on
> the dock supports PTM, where ASPM timing is precalculated for the PTM.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557

I know you said this isn't clear yet, but I don't see a connection
between ASPM being enabled and PTM.  If anything, *disabling* ASPM
should be safer if there's a timing issue.  

I assume the ASPM timing you refer to is the LTR snoop/no snoop
latency, since that's the only timing difference I see in the lspci
output in bugzilla?

I don't see any PTM differences there.

Bjorn
