Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7673BDDF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFWRfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFWRfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 13:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01EA270A;
        Fri, 23 Jun 2023 10:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2B761ADB;
        Fri, 23 Jun 2023 17:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B518C433C0;
        Fri, 23 Jun 2023 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687541702;
        bh=OSQAdJDD/PqkHqlskdQSJTtP3Muh5NfOtrK/Fza6rn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GP1+yny7uFargymk1h7IkSW5Tzxe3VeIax5woNbWq9RDSzRgdhTPYvC3n1PcljlQD
         8LWiGFrWWFylyEeOsH6x70LWRCARh4Wfdj1vEKC1Nw7pnfq7as6atg0dEFztCumxRK
         brmwZNLCfKkPvpvH9zeNtVZpMOtbaYXSTnL2NfJgHBsCHKBgDRrdiWn4mzK/50BELZ
         cTAadG23aBys9txSdlBqq8ALfB6k+k8lXgCL+rnoWSiRqw0fRRPBlkSgwgPdfOE8FS
         fJCpClz/ETV/jDEXN/vgeqtwtRI9Exqe4PSCl65hfkNtt5s/gaIF8qXfqUTSrku6QJ
         4S+boHdwARjXA==
Date:   Fri, 23 Jun 2023 12:35:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Message-ID: <20230623173500.GA180070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e5d343-848c-02c7-2deb-917d1b93ce8c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 21, 2023 at 05:52:52PM -0500, Limonciello, Mario wrote:
> On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
> > > Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
> > > an OperationRegion unless `_REG` has been called.
> > > ...

> > > It is reported that ASMedia PCIe GPIO controllers fail
> > > functional tests after the system has returning from suspend (S3
> > > or s2idle). This is because the BIOS checks whether the OSPM has
> > > called the `_REG` method to determine whether it can interact
> > > with the OperationRegion assigned to the device as part of the
> > > other AML called for the device.

> I double checked a BIOS debug log which shows ACPI calls
> to confirm and didn't see a single _REG call for any device
> before this patch across a boot/suspend/resume cycle.

Sorry to follow up on this again.

The commit log says these GPIO controllers fail functional tests after
returning from suspend.  Do those functional tests pass *before*
suspend?  If so, why?

Without this patch, we *never* call _REG, so the fact that calling
_REG when we return the device to D0 while resuming fixes something
suggests that it might have been broken even before the suspend.

Bjorn

