Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA277757B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjHJKKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHJKKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 06:10:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F9E0;
        Thu, 10 Aug 2023 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XPH3ccM1WntjRL018LDvln6t5cV6zUeBJ1hbOX8TkwM=;
        t=1691662212; x=1692871812; b=g4rd5c22FTavcsWQLb4P4tRfHLl4JjPPfZUSFqcyBhqbKFv
        kn+3zBvFueJ4kTaBqdisiWbNxuwJ1mKlvGxvxr4dV1nxngTL1fCGWyki2bsLPCi4l7lE8gBHApcY9
        W63sP56ib+4e7lLJf97qpQqotdPsKD7ny1Y3tfLTWdmGBgQeaYYQvSEyQvNzDhIYI8LyDFNwFEpCW
        Tack430EvrSHzNkOuqWqeaNXUoo9Q6mi0noNj/TkXkRRUANaHXsw7Dfbt53eqiqBGOuUnAUGyQUqI
        dL6AuJPl5vp4Z7RHfAVGh58d7C0GoDt9I6sOGnvrJ3WsdzFOOCU7wcHb55tLZ1qw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qU1zS-00GSLS-0z;
        Thu, 10 Aug 2023 11:29:58 +0200
Message-ID: <6f63b0f1764428d400fe512d33957a578629ff04.camel@sipsolutions.net>
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Thu, 10 Aug 2023 11:29:57 +0200
In-Reply-To: <cce342f1-55b9-49ba-81a9-cc9e83735ff9@rowland.harvard.edu>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
         <2023080940-overhand-fondly-7ef7@gregkh>
         <cce342f1-55b9-49ba-81a9-cc9e83735ff9@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2023-08-09 at 10:05 -0400, Alan Stern wrote:
> On Wed, Aug 09, 2023 at 02:16:48PM +0200, Greg KH wrote:
> > On Tue, Aug 08, 2023 at 08:44:48PM -0400, Alan Stern wrote:
> > > A mouse that uses a USB connection is called a "USB mouse" device (or
> > > "USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
> > > adapter that connects to the host computer via USB is a "USB wireless=
"
> > > device, not a "wireless USB" device.  (The latter term more properly
> > > refers to a defunct Wireless USB specification, which described a
> > > technology for sending USB protocol messages over an ultra wideband
> > > radio link.)
> > >=20
> > > Similarly for a WiFi adapter card that plugs into a PCIe slot: It is =
a
> > > "PCIe wireless" device, not a "wireless PCIe" device.
> > >=20
> > > Rephrase the text in the kernel source where the word ordering is
> > > wrong.
> > >=20
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >=20
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> Can you accept this patch, or should I ask Johannes Berg or Kalle Valo=
=20
> to merge it through the wireless subsystem?
>=20

Given that it touches pretty much only wireless drivers, I guess we
should take it? For -next, though, so since Kalle usually takes drivers
I'll wait for him to get back.

But the potential for conflicts seems low too, so I guess either way is
fine.

johannes
