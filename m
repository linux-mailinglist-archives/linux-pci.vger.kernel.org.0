Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0FA705050
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEPOPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjEPOPH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 10:15:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBC6E85;
        Tue, 16 May 2023 07:15:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so5951007b3a.0;
        Tue, 16 May 2023 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684246505; x=1686838505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Alx4r0aar3zIInvSYgRnPVJwOWq1H/zXlc1OuInK7Cs=;
        b=Wjc/lQ+Tw57nKz6pQH3IfjqMr9dO8VhAZNvyhZaooYuL1mHcQzyyOX/JpD9p+1lFyk
         tkJk3B/6I/4M80xDDhM2arf7NqvKM4ANppGtrlY9bg36wRjaThty+JLw0V+UM5jcXH2n
         S/sbzvGbbcATpe7Cg6amo2WJ1WfTlYkDBmqH5n26AYH7SQexpiCEIWDgsft3OLRehtdP
         a3tjGiMyBTmDn+4+JBPuT0YV5dxEW4GBXGnhXo/HIRSjDm8mPvjmWByWO4bAX/GvXaGg
         2BnIxtafWi1F95PyCK60EwZpbWPmTKLgd5dAfIxF061MJGtsfm+ERHB/nC9fsuZD2dkY
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246505; x=1686838505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Alx4r0aar3zIInvSYgRnPVJwOWq1H/zXlc1OuInK7Cs=;
        b=GmKlJ/11EWjGUetHzPtIK7KlL2JV1eBg6vpk8fqpQ8KvGjgXvPfkkl2EXfzm68RXDs
         0qwE8BeHN36hgSk2mSkhLQOD+Z8n2pXnCG4udne8HPJUQDv87tOZERMcD73fI2AZ+L0W
         G8G1xTdOHfkC5CaCSl6Tj4R9AvygR42hhcs+o/GQkcDCiBiTE/zfy+oZsk3KMFAMstGg
         iYey8BozRWagyjIbbvRG9usSslupdexrrSjL2xJvlfTdhqdxnU9rXEm8KsJ7ZzSnIdYI
         dOgo2syKgNFdMYexNIlHKJFGWUlZR6EXPE8nOpYhPfv0CpZDWye+O0/3gc4BMjHkcF+F
         mCpw==
X-Gm-Message-State: AC+VfDx04yKfEaOVgh8s4QFtaPmCBqJW+96pHxZBUlIcgrT2zwEhDbaX
        sGOwI/2HWzksaKdDibMBZ/Q=
X-Google-Smtp-Source: ACHHUZ4JDejRYofnysy2u4vG7LTphPKtRcw2RPCnHZ1MkwjL1Lh+gw67lM200t5K6kln93tcewd1Ug==
X-Received: by 2002:a05:6a20:7494:b0:102:19b9:25c7 with SMTP id p20-20020a056a20749400b0010219b925c7mr25274346pzd.6.1684246505338;
        Tue, 16 May 2023 07:15:05 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id p38-20020a631e66000000b0052c766b2f52sm13669054pgm.4.2023.05.16.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 07:15:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2BA8F1069B3; Tue, 16 May 2023 21:15:00 +0700 (WIB)
Date:   Tue, 16 May 2023 21:14:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pengyu Ma <mapengyu@gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
Message-ID: <ZGOP4wd3ZFkGb31e@debian.me>
References: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swGwUbbeTl4fTlQh"
Content-Disposition: inline
In-Reply-To: <20221226153048.1208359-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--swGwUbbeTl4fTlQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2022 at 11:30:31PM +0800, Kai-Heng Feng wrote:
> We are seeing igc ethernet device on Thunderbolt dock stops working
> after S3 resume because of AER error, or even make S3 resume freeze:
> pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d=
=2E0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=3DCorrected, type=3DTrans=
action Layer, (Receiver ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=3D00008000/=
00002000
> pcieport 0000:00:1d.0:    [15] HeaderOF
> pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error receiv=
ed: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=3DUncorrected (Non-Fatal)=
, type=3DTransaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=3D00100000/=
00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 0000=
0000
> pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> pcieport 0000:04:01.0: PCIe Bus Error: severity=3DUncorrected (Non-Fatal)=
, type=3DTransaction Layer, (Requester ID)
> pcieport 0000:04:01.0:   device [8086:1136] error status/mask=3D00300000/=
00000000
> pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> pcieport 0000:04:01.0:    [21] ACSViol
> pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 0000=
0000
> thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
>=20
> This supposedly should be fixed by commit c01163dbd1b8 ("PCI/PM: Always d=
isable
> PTM for all devices during suspend"), but somehow it doesn't work for
> this case.
>=20
> By dumping the PCI_PTM_CTRL register on resume, it turns out PTM is
> already flipped on by either the Thunderbolt dock firmware or the host
> BIOS. Writing 0 to PCI_PTM_CTRL yields the same result.
>=20
> Windows is however not affected by this issue, by using WinDbg's !pci
> command, it shows that AER is not enabled for devices connected via
> Thunderbolt port, and that's the reason why Windows doesn't exhibit the
> issue.
>=20
> So turn a blind eye on external Thunderbolt devices like Windows does by
> disabling AER.
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D216850
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Hi,

I noticed a similar regression on bugzilla [1] where I asked the
reporter to test your patch, and his regression still occured. For
full details, see bugzilla.

Thanks.

Reported-by: Pengyu Ma <mapengyu@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217446 [1]

--=20
An old man doll... just what I always wanted! - Clara

--swGwUbbeTl4fTlQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGOP3AAKCRD2uYlJVVFO
o55WAQDiz4AxHaMzxpfSq/YrLOTQ/UbRNX9S9CPp4N3fJWDYewD/bJqyDv6mWPX/
qgKDqtaJs5+6j6Frsnkqel2RqU6dbg4=
=IdSW
-----END PGP SIGNATURE-----

--swGwUbbeTl4fTlQh--
