Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAC777578
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjHJKKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjHJKKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 06:10:11 -0400
X-Greylist: delayed 2409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 03:10:10 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307910DC;
        Thu, 10 Aug 2023 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8neubkRu2JPUdcYQhqm9no6TfC620DYjRXVwVqlWGkU=;
        t=1691662210; x=1692871810; b=rMm5/YEu8mGtARDbMBZSSuvsXrvGfHCLgeggppK0+o3YcQD
        PKqlWZvecGJwl9YCanpZR7lGEUU/qkRT5S+JDVQHsiuW1jIvi6jeh2NNnNAyQpf3DsOexMHHNuXDB
        CAyOoaYvAV5cX0W3TGWyzyZD7tePdSJImYQ7aDZPyhGhWg3jw6pLgPkopGuFxpMLvL5SY5iYtl5OD
        9o+GzjcOVOMXRdwlBfXpGQ4EgMNHj4s3RWBJe8ueIgoKobSmNnKq4k8qtku74aOtmbLyLsmY2glWu
        uDVW37e6U28vnboHGkpzTgev/7xUmDLUcsM6ff1Wt00PBLO3ooxgpoPyRYlxVvpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qU22J-00GSW0-06;
        Thu, 10 Aug 2023 11:32:55 +0200
Message-ID: <c5c6d4f8e5151f8bc962dce39d776ab4bbaccb58.camel@sipsolutions.net>
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Thu, 10 Aug 2023 11:32:53 +0200
In-Reply-To: <2023081059-omen-hence-c554@gregkh>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
         <2023080940-overhand-fondly-7ef7@gregkh>
         <cce342f1-55b9-49ba-81a9-cc9e83735ff9@rowland.harvard.edu>
         <6f63b0f1764428d400fe512d33957a578629ff04.camel@sipsolutions.net>
         <2023081059-omen-hence-c554@gregkh>
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

On Thu, 2023-08-10 at 11:31 +0200, Greg KH wrote:
> On Thu, Aug 10, 2023 at 11:29:57AM +0200, Johannes Berg wrote:
> > On Wed, 2023-08-09 at 10:05 -0400, Alan Stern wrote:
> > > On Wed, Aug 09, 2023 at 02:16:48PM +0200, Greg KH wrote:
> > > > On Tue, Aug 08, 2023 at 08:44:48PM -0400, Alan Stern wrote:
> > > > > A mouse that uses a USB connection is called a "USB mouse" device=
 (or
> > > > > "USB mouse" for short), not a "mouse USB" device.  By analogy, a =
WiFi
> > > > > adapter that connects to the host computer via USB is a "USB wire=
less"
> > > > > device, not a "wireless USB" device.  (The latter term more prope=
rly
> > > > > refers to a defunct Wireless USB specification, which described a
> > > > > technology for sending USB protocol messages over an ultra wideba=
nd
> > > > > radio link.)
> > > > >=20
> > > > > Similarly for a WiFi adapter card that plugs into a PCIe slot: It=
 is a
> > > > > "PCIe wireless" device, not a "wireless PCIe" device.
> > > > >=20
> > > > > Rephrase the text in the kernel source where the word ordering is
> > > > > wrong.
> > > > >=20
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > >=20
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >=20
> > > Can you accept this patch, or should I ask Johannes Berg or Kalle Val=
o=20
> > > to merge it through the wireless subsystem?
> > >=20
> >=20
> > Given that it touches pretty much only wireless drivers, I guess we
> > should take it? For -next, though, so since Kalle usually takes drivers
> > I'll wait for him to get back.
> >=20
> > But the potential for conflicts seems low too, so I guess either way is
> > fine.
>=20
> I provided my reviewed-by as I assumed it would go through the wireless
> or networking tree.  Otherwise, yes, I can take it, your choice.

We'll just take it, seems easier. The staging/eeepc is probably even
less likely to conflict.

johannes
