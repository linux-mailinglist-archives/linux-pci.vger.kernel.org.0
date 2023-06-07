Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73CA72569F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 09:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjFGH62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 03:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjFGH61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 03:58:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C8C8E;
        Wed,  7 Jun 2023 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=axps5vikobkT1mRFE9fglAhCSO+MMypFTxN72eeUtO0=;
        t=1686124705; x=1687334305; b=kMfyNLOfrR5GeXbEHt9nEXTdQvySSOfXW53hCo+aMiOCKFZ
        VjaTOmJclP54w5xMxgHhnKHy6ts2JJewj1niaIPBQ8SOsMuDz8mbFEMpgeBciSkaI2sT1FploU07s
        y398ttaaB2g1e8t0THF45Y05YWT4icEApqNyb7P9i2xcbEa2geG6Ub1ZuwtLiQ1hQZB5aDgp+lqab
        oujC9r3HMmF9HviLoM6bB9XDBgRFFkes0+9c2LuFWqkPYsUOY/MdpxwjmBJyv29ikkAyd4KTIXL/m
        nlWw1iby6ECx8WfgFsOv8G/zBljBBagagaXrRSXpkSbv9mjrWHElYcSYIrr/JhUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6o3i-00GSjD-27;
        Wed, 07 Jun 2023 09:58:22 +0200
Message-ID: <c2b6599182b2f543da2d5fee17dce4b3a094535a.camel@sipsolutions.net>
Subject: Re: [PATCH v2] PCI/PM: enable runtime PM later during device
 scanning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 07 Jun 2023 09:58:21 +0200
In-Reply-To: <20230607074939.GA17700@wunner.de>
References: <20230605121621.4259f1be6cd2.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
         <20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
         <20230607074939.GA17700@wunner.de>
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

On Wed, 2023-06-07 at 09:49 +0200, Lukas Wunner wrote:
> On Mon, Jun 05, 2023 at 08:35:45PM +0200, Johannes Berg wrote:
> > @@ -3139,6 +3139,7 @@ void pci_pm_init(struct pci_dev *dev)
> >  	u16 pmc;
> > =20
> >  	pm_runtime_forbid(&dev->dev);
> > +	pm_runtime_get_noresume(&dev->dev);
> >  	pm_runtime_set_active(&dev->dev);
> >  	pm_runtime_enable(&dev->dev);
> >  	device_enable_async_suspend(&dev->dev);
> > @@ -335,9 +336,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	int retval;
> > =20
> >  	/*
> > -	 * Can not put in pci_device_add yet because resources
> > -	 * are not assigned yet for some devices.
> > +	 * Allow runtime PM only here, since otherwise we may
> > +	 * try to suspend a device that isn't fully configured
> > +	 * yet, which causes problems.
> >  	 */
> > +	pm_runtime_put_noidle(&dev->dev);
> > +
> >  	pcibios_bus_add_device(dev);
> >  	pci_fixup_device(pci_fixup_final, dev);
> >  	pci_create_sysfs_dev_files(dev);
>=20
> There seem to be many different callers that end up in pci_pm_init()
> and pci_bus_add_device().
>=20
> Is it guaranteed that the two functions are always called in order?
> Do callers exist which only invoke the former but not the latter or
> vice-versa?  Can it happen that a caller of the former errors out,
> so the latter is never called, leading to a runtime PM ref imbalance?

I did ask myself that too, and honestly, I'm not entirely sure - need
somebody more familiar to really understand that, I think.

Most places elsewhere _do_ call both, and it feels like you have to call
both if you want to do something with the device.

However there are a few places that seem to call the first part and then
remove the device again immediately after. That also seems harmless
though.

> It would be easier to ascertain correctness if you could find a
> function at a higher level which (indirectly) calls both pci_pm_init()
> and pci_bus_add_device() so that you can acquire and release the
> runtimw PM ref in that single function.
>=20

Unfortunately, there isn't such a place, since the scanning is done by
various bus walks.

johannes
