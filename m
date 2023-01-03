Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A665C735
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbjACTQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbjACTPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:15:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1A13F3E;
        Tue,  3 Jan 2023 11:14:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24357B80FEE;
        Tue,  3 Jan 2023 19:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7F3C433EF;
        Tue,  3 Jan 2023 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672773259;
        bh=N7ivNyN5VHZFUOKbQyORtcjA8BMgy+b684iiJd7PPSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dngi/WyCrOY2KGRTUf8TvHZdV0rakljdaE//Cillu5tPz2ToFWupNzRFMO4yo6u46
         8j8pIeiGmcQoP+w+LtfwW1jdN6gl4vPp7ITE7J+ddxCFjkTBh5dVWlDB94cxD2J8fM
         9hJbwkKlT9DPwlC7vkD4n8WHF3hIE+ST0G05gfnVnPZiRyVRoIw5FgVtv+JD+uJgaH
         M8DodmOHRajphU+quYr09cfTNb6VAphaMKmfXZ789dF72V5T6lZvXiVQqgwkb33uy3
         qMO3m3yyV4i9ZvhR7AEFBvaxoS0EXdFcO/dI8Up3djZ4OkbmkkwH5WqAfgXrhlaWkz
         pIx7HX82+Y+/A==
Date:   Tue, 3 Jan 2023 13:14:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Neftin, Sasha" <sasha.neftin@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Frederick Zhang <frederick888@tsundere.moe>
Subject: Re: [PATCH] PCI/AER: Rate limit the reporting of the correctable
 errors
Message-ID: <20230103191418.GA1011392@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103165548.570377-1-rajat.khandelwal@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Paul, Sasha, Leon, Frederick]

(Please cc folks who have commented on previous versions of your
patch.)

On Tue, Jan 03, 2023 at 10:25:48PM +0530, Rajat Khandelwal wrote:
> There are many instances where correctable errors tend to inundate
> the message buffer. We observe such instances during thunderbolt PCIe
> tunneling.
> 
> It's true that they are mitigated by the hardware and are non-fatal
> but we shouldn't be spamming the logs with such correctable errors as it
> confuses other kernel developers less familiar with PCI errors, support
> staff, and users who happen to look at the logs, hence rate limit them.

I want a better understanding of why we have so many errors before
rate-limiting everybody.

> A typical example log inside an HP TBT4 dock:
> [54912.661142] pcieport 0000:00:07.0: AER: Multiple Corrected error received: 0000:2b:00.0
> [54912.661194] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [54912.661203] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001100/00002000
> [54912.661211] igc 0000:2b:00.0:    [ 8] Rollover
> [54912.661219] igc 0000:2b:00.0:    [12] Timeout
> [54982.838760] pcieport 0000:00:07.0: AER: Corrected error received: 0000:2b:00.0
> [54982.838798] igc 0000:2b:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=00001000/00002000
> [54982.838817] igc 0000:2b:00.0:    [12] Timeout

Please remove the timestamps; they don't contribute to understanding
the problem.

> This gets repeated continuously, thus inundating the buffer.

Did you verify that we actually clear the Correctable Error Status
register?

https://bugzilla.kernel.org/show_bug.cgi?id=216863 looks like a
similar issue.  The issue Frederick is seeing happens when resuming
from sleep.  Is there some event that triggers the correctable errors
you see?

Bjorn
