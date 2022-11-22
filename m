Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35763341D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 04:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKVDoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 22:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKVDoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 22:44:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB327DD4;
        Mon, 21 Nov 2022 19:44:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b11so12181559pjp.2;
        Mon, 21 Nov 2022 19:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chBJoIneeN9Z4RMJrS8Lycetn6OQf11WHsxL8dcDAFE=;
        b=oyp3a1RtAAdbPPVHXlYLHZMxVQ2Sp6NIIX1TfxFRKqpJfJGaSBh3FsoP/jRWmm4Awl
         6+oJKuBepRLhs7y0TQk1S0S1Is7HlcyjGzcuPr72ZfLyWJS+NGUGV9vRNdazCzBBxpF3
         rxzvJCIBtB2kvNVmAZV7yNf2ajPmJAkbS63tjPqjEF0/OxKlOWnmGrJCjDtimg2vLrOc
         PxQAIzieH43gGq/ltmj0WZCDld1oUtQInQSu+IF2yHe31BDvdZExWZmEWmRsR7UcF6ba
         ZR7x+eHshr1aXbEQheM94xEPrQmLkN6e0LDvRhdPdI+u9hqN9YldEMUzwhD7Z99IHvzn
         Qxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chBJoIneeN9Z4RMJrS8Lycetn6OQf11WHsxL8dcDAFE=;
        b=u0IGNUtRwp6y2IWRYKnDPKvI947FPtbAh2XRA2qMCw/NcwnnUUopD2ZQghGD5LrDtW
         eyJl3bRzSIbnfIcF308W/2/Uhj1IgD7dd6uBmixy+aIfaA/CzLP0pvdJdAwpP/q7RbIF
         mayXTQbbev69l/bswAcqhlv7DFCOb3vbPV4zpshjycvhsUSwGj5BfhHGuqSZ5OYA/sJN
         wZwI3X1p+j3c4Mlr70L3xRUqlsVHbbXLaaFhoi654IXVuKdoEbSd+idZdY2u0EdBcUIZ
         5KOhVH/hiHS8jDM0h+EShuk1FgWdhuUmsHE9GHd1cPgT3wDfwVQbeELoZamdEHZ5nSgT
         hfaA==
X-Gm-Message-State: ANoB5pnV3m0bMofY+dRK/IWytchwuGc+SzQo+QolTG3fY1ORR7YGcgiW
        C5RP6A4NmvgFvnyG0sjm/oI=
X-Google-Smtp-Source: AA0mqf5Gkd7eesgmVIJhrTkXOwFE7HtWCYi/ucT3nK9yGx7IZgpJ4YxaxPMROWKA2BiZDzRb6t1VMg==
X-Received: by 2002:a17:903:2798:b0:174:a0e6:428 with SMTP id jw24-20020a170903279800b00174a0e60428mr2922436plb.124.1669088662062;
        Mon, 21 Nov 2022 19:44:22 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id 34-20020a631362000000b004597e92f99dsm8112297pgt.66.2022.11.21.19.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:44:21 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id C3DD3104367; Tue, 22 Nov 2022 10:44:18 +0700 (WIB)
Date:   Tue, 22 Nov 2022 10:44:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Message-ID: <Y3xFkgq5rdUxB52A@debian.me>
References: <20221121101245.23544-1-bagasdotme@gmail.com>
 <20221121123402.GA100653@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KOiqcXEw1ghCFvXq"
Content-Disposition: inline
In-Reply-To: <20221121123402.GA100653@bhelgaas>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KOiqcXEw1ghCFvXq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 06:34:02AM -0600, Bjorn Helgaas wrote:
> Hi Bagas,
>=20
> If you have opportunity, please update the subject line to remove
> "api: " to match previous history:
>=20
>   PCI/MSI: Correct 'can_mask' test in msi_add_msi_desc()
>   PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
>   PCI/MSI: Prevent UAF in error path
>   PCI/MSI: Unbreak pci_irq_get_affinity()
>   PCI/MSI: Use msi_on_each_desc()
>   PCI/MSI: Let core code free MSI descriptors
>   PCI/MSI: Use msi_add_msi_desc()
>   PCI/MSI: Protect MSI operations
>   PCI/MSI: Simplify pci_irq_get_affinity()
>   ...

OK, thanks.

--=20
An old man doll... just what I always wanted! - Clara

--KOiqcXEw1ghCFvXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3xFkgAKCRD2uYlJVVFO
o2llAP9ZBJAmpL/AqwbDZTww5lllPicU+rFVAXTwHz+sarT9LgEAwrgZdxx0NZKl
dgZqVkDglPY5ehLBbm2P3DxA/ZaUXAA=
=9bY8
-----END PGP SIGNATURE-----

--KOiqcXEw1ghCFvXq--
