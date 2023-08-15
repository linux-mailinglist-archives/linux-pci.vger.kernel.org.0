Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F477D154
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjHORtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbjHORtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 13:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B21BCC;
        Tue, 15 Aug 2023 10:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6883865462;
        Tue, 15 Aug 2023 17:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4EC433C7;
        Tue, 15 Aug 2023 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121783;
        bh=vENtrbyvbr57KOdBcWWu7mgYK7vmBKZyiaF/cHz+85Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=He2qDjdiqELmH/bMcpvsqeSkqg7u3XUQHTXNM5QwNBZRH3A6WtvAAwviqWhVhJ580
         G8eAdcZ/Fup8V8Yoje+2YO5n5zIXI5pRXPvC0mHzpGXxR5m1Zb5CNUWwU/W1m7f2+B
         Hx1BkwX6vqdZ/W6y6Frzxt7RnHJWv6d0hWXAr8CywwhnVw/CzXzf786hNDh2OBLyBv
         5CA5L+gDN296l67kfk8w3zCYgp0IWT5oNNfFCx7JBAI3jWbD17oBZKqtMG7gaUvjza
         sJmZbebPb6MDXlfZglGHzn9OZzTqtUwFWFxr6n/bKMkXuqDJAyAGaMQ03OraXon4ol
         hEoMxCzqwn/AQ==
Date:   Tue, 15 Aug 2023 12:49:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     deloptes <emanoil.kotsev@deloptes.org>
Cc:     linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT
 SAS
Message-ID: <20230815174942.GA211975@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ubedo7$151n$1@ciao.gmane.io>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 01:35:35AM +0200, deloptes wrote:
> Bjorn Helgaas wrote:
> 
> > I don't know why that would be.  Are there any hints in the dmesg log?
> > Can you collect the complete dmesg log with the old drives and again
> > with the new SSDs so we can compare them?  I assume you have good
> > cables?  I assume the same cables worked at 3.0 Gb/s with the old
> > drives.
> > 
> > I would *expect* that SATA r3.3 would be completely backwards
> > compatible, so since mptsas worked just fine at 3.0 Gb/s with the old
> > SATA r3.0 drives, it should also work just fine at 3.0 Gb/s with the
> > new SATA r3.3 drives.  But I have no actual knowledge about that.
> 
> Thank you for your answer. I am also confused and couldn't think of any
> meaningful reason. This is why I allowed myself to bother you.
> 
> I did not change anything - wiring or such. The server has 12 disk bays on
> the front. Old disks were pulled out and new disks were inserted into the
> bays.
> 
> You (probably much knowable in this matters than me) also assume negotiation
> should result in 3.0Gb/s. And if I understand correctly it should be not a
> driver issue.
> 
> The only difference I could find out for now is that Rev3.3 introduced PWDIS
> on Pin 3. To check if the cables provide wiring on P3 I should disassemble
> the server, but I can do this in September :/ and it is a lot of effort.
> 
> I am attaching a portion of the log and dmesg with the relevant information.
> I see that ASPM is disabled by default (could it be related to P3?).

ASPM is a PCIe feature that applies to the PCIe Links between 00:02.0
and 01:00.0 (the first 1068E) and 00:15.0 and 08:00.0 (the second
1068E).

PWDIS is a feature on the SATA cables between the SAS1068E adapters
and the SSDs.

PWDIS/P3 should not be related to ASPM.  I assume you're referring to
the "disabling ASPM on pre-1.1 PCIe device" message.  That should
happen with both the old r3.0 HDDs and the new r3.3 SSDs.

I wish I had some good ideas for you, but I don't know anything about
the SATA side.  I googled for "1068 ssd sata 1.5 gb/s" and found a few
hints about system firmware, LSI firmware, etc, but nothing concrete.

I think some controllers have a BIOS setup user interface; have you
poked around in there?

Bjorn
