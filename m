Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8684B4F6C0B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiDFVEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 17:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiDFVEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 17:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4AE2BD6CB
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 12:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554ED61CD9
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 19:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F776C385A6;
        Wed,  6 Apr 2022 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649273851;
        bh=l5R8GEeIR9PLgGuqXw8/g/klP3j/9RmS14o3peddzpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rs/OUCF6rQGK2GYXaqf9rT3WPjT8sNV+1RDmphfu9lVokPD2rxvDbC9vBnRyZ08U/
         ylZeBF99KwS4vasW3IB/qm7Rg+32GW1JvZ4pp2wbs5Bcde3KeEO9TMP3GfcKhO61d+
         KctPm3K77Z9otopwFknqrYXaT9jrORGoE67pbAG0sMdsFukoGJEoFrKu0UU+KDoP5w
         /3VrpBk+aSBC4gxOKfqqqHwqfwYVOIzcZb1/PDysFr8hX+5w29zwTwn19ze0Wem3Ri
         FMivBAZDWJ4fQ6RaJmge3pvZpiJbsIlprwLtUYMaRa8QMOq1+kMtOguiPmYX0oXxB6
         smQb/yyp00VrQ==
Date:   Wed, 6 Apr 2022 20:37:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <Yk3r9uhIHmNumtxi@sirena.org.uk>
References: <20220405235315.GA101393@bhelgaas>
 <20220406185931.GA165754@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pon76QWk+O/KgpBj"
Content-Disposition: inline
In-Reply-To: <20220406185931.GA165754@bhelgaas>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--pon76QWk+O/KgpBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2022 at 01:59:31PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 05, 2022 at 06:53:17PM -0500, Bjorn Helgaas wrote:

> > Is there any way to get the contents of:

> >   /sys/firmware/acpi/tables/DSDT
> >   /sys/firmware/acpi/tables/SSDT*

> > from these Chromebooks?

> Is there hope for this, or should I look for another way to get this
> information?

I believe Guillaume is out of office this week.  Copying in Guenter as
well since he's on the ChromeOS team in case he can help or knows
someone who can.

--pon76QWk+O/KgpBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJN6/UACgkQJNaLcl1U
h9A/2wf9EZCwszAx9oDoAea/WhfBwgavxEc4DUKjqyxZWKlq2xAqadXA/GBQaV5g
n3fjYms7pOdd0KpvkMzI7yH33FskOXza/WsJJJ6ty1GE2YSlNhJ8Wpp4CUlyEIIH
z5eAjogxJn+6eHu7BuCjr1fA4R8DO0dApZmN15HrZp+p34DubByZdcJS2Kczwy9J
kPdiB9HD7H7Tu6Kxq87wBAXPBWvjAHAwFaK6AJNu7UHwN880qd6LAtkwxOQ7FuPb
XSdmP7IA1ieeMzMPF/iItrYcyaGdLV61D48w+uepXWfQrdB6nU7kBM4bwgaXwe2b
hIwx73OeUXrshHlQ9re+WDs4mWspuw==
=C2/a
-----END PGP SIGNATURE-----

--pon76QWk+O/KgpBj--
