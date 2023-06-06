Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397C37238DD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjFFHW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbjFFHW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 03:22:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85016118;
        Tue,  6 Jun 2023 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lukvM++GAOnz292P3XNo5CThWaSgbcPVUM1tK0UdEWA=;
        t=1686036144; x=1687245744; b=pgaC+XTjCcO9zLd69xnBTnhrQOyJmrt+A/Td2/Vem+0cZ6l
        La0PSgh6gj7Gx82kzrJuiCcVcjuKRlbmOIZgHkH7glzb9Md7jgfOXTkIppGysY4T7vXkLbKg8naJG
        VSEmO+e5O+cSekhFgYLmuMlhAVEYLqeDaqXiKPvr7CE+0fwh81x2cHdH6qYWQtujXJ83xbP2MUA1v
        hWcJ8An7dojZmdAYNLNqATFcFKcwZ8s6Btn8u0pbUYSwvDKBMWkU3TK0IRYGl8zKvVCUY8E6U57vC
        e3+ZLRpgKSYp8BL6O6XHGWG6M1bvxLsLFA4ienFBO437kyg4ABerKjYoM22dA2Rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6R1I-00FR5a-33;
        Tue, 06 Jun 2023 09:22:21 +0200
Message-ID: <3d734a1a20ed2e895a0a7177f3789c72e26e7fd5.camel@sipsolutions.net>
Subject: Re: [PATCH v2] PCI/PM: enable runtime PM later during device
 scanning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 06 Jun 2023 09:22:19 +0200
In-Reply-To: <20230605205017.GA23596@wunner.de>
References: <20230605121621.4259f1be6cd2.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
         <20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
         <20230605205017.GA23596@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-06-05 at 22:50 +0200, Lukas Wunner wrote:
> On Mon, Jun 05, 2023 at 08:35:45PM +0200, Johannes Berg wrote:
> > v2: use pm_runtime_get_noresume()/pm_runtime_put_noidle()
> >     instead as advised by Rafael
>=20
> You've changed the code but seemingly did not update the commit
> message and code comment.
>=20

Yeah. I actually _considered_ that, but didn't feel it was really any
different (or let's say wrong) now.

That said, I probably don't understand the lingo around runtime PM well
enough, and am more or less conflating "runtime PM" and "runtime
suspend" in my head, which is still not allowed, and indeed that's the
whole point of the patch.

>   Technically you're not "allowing"
> runtime PM, you just stop keeping the device runtime active.
>=20
> A more fitting subject might thus be:
>=20
> PCI/PM: Keep devices runtime active during enumeration

*shrug*

Like I said, terminology I'm not familiar with. I guess I can change it,
or if anyone ends up committing it as is (rather than treating it as an
extended bug report) they can :-)

> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1278,6 +1278,9 @@ static int pci_pm_runtime_suspend(struct device *=
dev)
> >  	pci_power_t prev =3D pci_dev->current_state;
> >  	int error;
> > =20
> > +	if (WARN_ON(!pci_dev_is_added(pci_dev)))
> > +		return -EBUSY;
> > +
>=20
> If this can't happen (as the commit message says), why warn?

The code here causes quite some trouble if it _does_ happen and it was
incredibly tricky to debug.

johannes
