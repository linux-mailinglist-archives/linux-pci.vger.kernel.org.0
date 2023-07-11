Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0674F427
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjGKP63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKP63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 11:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFFD9B;
        Tue, 11 Jul 2023 08:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7FA6155D;
        Tue, 11 Jul 2023 15:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB401C433C8;
        Tue, 11 Jul 2023 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689091107;
        bh=7ZyyZ+HNOyEHI8v32fmj/vgPfWXG3mAXzwQ3E7RgbdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RmVAgD6gKUakQGIrMNlss3vwYPnWy+eopA3xDIAATo2eZqd3m1EIcSKGYnArYY/FM
         yCFDIhsfoIJMmOl5HinJTOM0vLclfnaxRWXtos7P5SGI/wvRfxJkf3+sYymET4CFvr
         bz4V/Xepd0Mklqq5yMjy+NCnnoPDqiCceiH5LZ7DOnEp3qFY9C2jAL73xlYvXkfV/x
         aJXkG3H5dB5rdSPLu5LhyN7x3ksKtVLPgnVsug5qPZmxZGiTQtsY8Vnrohm3HfRKyX
         3Z8qt9j2ozptJr1sKYbs6g/9//rZWG+3wzmZLpmNWwnmixThnDj7VDxZMhYsh8spQT
         6wQXlCYc42Q6A==
Date:   Tue, 11 Jul 2023 16:58:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/13] PCI: Define Intel PCI IDs and use them in drivers
Message-ID: <a0625422-9b1f-468f-a282-71290a159bda@sirena.org.uk>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <bc2484ba-3bb2-7d74-fcd1-55c9ec253b9c@linux.intel.com>
 <46d612f4-24a4-4493-aa9f-0ace5225a38b@sirena.org.uk>
 <87jzv6h2ui.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hidcHY8UvSTgc8PO"
Content-Disposition: inline
In-Reply-To: <87jzv6h2ui.wl-tiwai@suse.de>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hidcHY8UvSTgc8PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 05:42:13PM +0200, Takashi Iwai wrote:

> I can do it if both Bjorn and Mark agree (after all patches get
> reviewed and no objection comes up).

Fine by me, I acked on the basis that it probably makes more sense in
someone else's tree.

--hidcHY8UvSTgc8PO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStfB0ACgkQJNaLcl1U
h9BDwgf9FjGinq0r7SNgU7oSMxseTqJ+zHDQWJiDbeBxmWjolKQjDP7TRc07bYqS
qig9TsVEDjJR37T4+DPcJ/C2WXkM8y1Q0XciErCQu2Oh3nRiGj+xsIihqn5TBghj
k+lbwY/WZHTHdkeTUfy1RW+LdLlYQ63kHTChZIMw75iWTn9LG4ih0efiQ/NaZEBL
8a6DhGQgn+9ed8rl0yloh77a2j63JUjFTZ+inGGgGUHuVE51XrFEm6UBQbsbWPiU
SeZ5NDoRmem+0ZgUbMMLlkEuUUXFv8tmfN39t9/b3h4w2WNZ4fd5uAoHmQldaChB
YRPg6NVf4Rs/JlhP8P1I/QXfFMt1Tw==
=ikb8
-----END PGP SIGNATURE-----

--hidcHY8UvSTgc8PO--
