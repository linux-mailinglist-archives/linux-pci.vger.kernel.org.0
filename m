Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B963341B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 04:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiKVDnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 22:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiKVDnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 22:43:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A42A279;
        Mon, 21 Nov 2022 19:43:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so5060432pjs.5;
        Mon, 21 Nov 2022 19:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHTOm+Nj6YeoKmxS+LqwM2AhqfRTBI1UCNLdBaAMYYk=;
        b=OFE5vwKdvDHSfB3eFh0/xl3Fpv2f75QArXXfS/vqi8ET096gWlyMvFZhrS0md04S/J
         5KTv+enRiyE4SCGE4lbP8BXTnY0/dG+ez5zmjquewhGZQ/6bLxmvkzra5+fK0qIfyxRT
         CHJwSolAyM4rlwB770hCAPz1iWIHGGYkB73f+wEba4iMmr32lFkPmsB3RaiRlo4EA4PZ
         2zMGht/7IxqEVUId31li/Ln7DR+3dwf27OvUkfZ1YQVxuN+OBa9j/rd5Lwh2jrsFASIm
         mbgoYEsUd0OMz5jwnZ6XL1/Nlrn9X03zsvHjhZmudq/+D9shkT7bIBbTQynmITqGMOfB
         DYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTOm+Nj6YeoKmxS+LqwM2AhqfRTBI1UCNLdBaAMYYk=;
        b=zgQ3EGzMuXmQ+V4CREQUEM/FbNAep1aosm3OiHIQ5rSndo9vhVDQtk8mueX4hoE36x
         FqHr/PUckkvT7RYam0Xf8YorUH1s4F+o3Z7mXewr5DUMZ86uZ5p4mLBZfjkmdVzeadCs
         UOt5r1TU3EpBpTLpD/JwZ0Utk7twiYrb8hUT9xv+zNPIQlNHy17oT68TUDECP1GRFnCW
         nfj5DoURwRusMwkvz7wIO2RyAi7DVLUMJcgvGZDLQEpgQxgV0sUAj3QhGfCwkndZ0ASm
         GWFrjVuaormx5hjC95glbtvry5bxnScaYFrdvkPriTJpsY2NBn6pzbsZXB/H8rORx4Fl
         Y0mw==
X-Gm-Message-State: ANoB5pkI5IODIveF8vOP4pCJDRzWs84CiJTdABSBqdgrrCiWfrH3p1/g
        yUtIzFOEYSU4bv1JY17ZSGs=
X-Google-Smtp-Source: AA0mqf479fqewpCQOqaLwg3i0AWgkE7U+8cuCgMYefaRYsxCUZobpZyT1ibMe1lJTEowuySOupKrhw==
X-Received: by 2002:a17:90a:2ec5:b0:217:cdc4:afef with SMTP id h5-20020a17090a2ec500b00217cdc4afefmr30043330pjs.115.1669088603524;
        Mon, 21 Nov 2022 19:43:23 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b00186abb95bfdsm10591277pln.25.2022.11.21.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:43:22 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 87BE2103FB7; Tue, 22 Nov 2022 10:43:19 +0700 (WIB)
Date:   Tue, 22 Nov 2022 10:43:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Message-ID: <Y3xFV2IkUlRWPdCd@debian.me>
References: <20221121184100.0974cc35@canb.auug.org.au>
 <20221121101245.23544-1-bagasdotme@gmail.com>
 <Y3t83uo/TZzxc1nL@lx-t490>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nnb9qd/r+D/pydyJ"
Content-Disposition: inline
In-Reply-To: <Y3t83uo/TZzxc1nL@lx-t490>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Nnb9qd/r+D/pydyJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 02:27:58PM +0100, Ahmed S. Darwish wrote:
> Sorry for the trouble.
>=20
> While at it, can we please keep the alignment in the original patch?
> This is supposed to be pretty too for people who look at the C code
> (most of the actual readers).
>=20
> That is:
>=20
>  + *
>  + *            * %PCI_IRQ_MSIX     -  Allow trying MSI-X vector allocati=
ons
>  + *            * %PCI_IRQ_MSI      -  Allow trying MSI vector allocations
>  + *            * %PCI_IRQ_LEGACY   -  Allow trying legacy INTx interrupt=
s, if
>  + *              and only if @min_vecs =3D=3D 1
>  + *            * %PCI_IRQ_AFFINITY - Auto-manage IRQs affinity by spread=
ing
>  + *              the vectors around available CPUs
>=20

For the list above, no, since if the alignment is kept, like:

---- >8 ----

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index d48c21295a88c6..13f612bbbb29b2 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -143,14 +143,14 @@ EXPORT_SYMBOL(pci_disable_msix);
  * @max_vecs: maximum desired number of vectors
  * @flags:    One or more of:
  *
- *            * %PCI_IRQ_MSIX - Allow trying MSI-X vector allocations
- *            * %PCI_IRQ_MSI - Allow trying MSI vector allocations
+ *            * %PCI_IRQ_MSIX     - Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI      - Allow trying MSI vector allocations
  *
- *            * %PCI_IRQ_LEGACY - Allow trying legacy INTx interrupts, if
- *              and only if @min_vecs =3D=3D 1
+ *            * %PCI_IRQ_LEGACY   - Allow trying legacy INTx interrupts, if
+ *                                  and only if @min_vecs =3D=3D 1
  *
  *            * %PCI_IRQ_AFFINITY - Auto-manage IRQs affinity by spreading
- *              the vectors around available CPUs
+ *                                  the vectors around available CPUs
  *
  * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
  * vector allocation has a higher precedence over plain MSI, which has a
@@ -238,8 +238,8 @@ EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
  *       meanings, depending on interrupt mode:
  *
  *         * MSI-X - the index in the MSI-X vector table
- *         * MSI - the index of the enabled MSI vectors
- *         * INTx - must be 0
+ *         * MSI   - the index of the enabled MSI vectors
+ *         * INTx  - must be 0
  *
  * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
  */
@@ -262,8 +262,8 @@ EXPORT_SYMBOL(pci_irq_vector);
  *       meanings, depending on interrupt mode:
  *
  *         * MSI-X - the index in the MSI-X vector table
- *         * MSI - the index of the enabled MSI vectors
- *         * INTx - must be 0
+ *         * MSI   - the index of the enabled MSI vectors
+ *         * INTx  - must be 0
  *
  * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
  * the MSI(-X) vector was allocated without explicit affinity

, multi-line entries will be rendered as definition list instead. So, these
entries must have hanging indent of two spaces after bullet marker (*),
following alignment of first line of the entry.

Also, these entries must be separated from other entries by a line, otherwi=
se
the list will be broken (rendered inline).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Nnb9qd/r+D/pydyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3xFUAAKCRD2uYlJVVFO
o0aaAQD/5o5vTbgS/A6biu9BW0U7JS5wkLnxhDBGR0w9w3en2QEAuqbc8AP8ck7e
SNLAVf1ByC1E1PYFS7eVsRn214LuhgU=
=emhf
-----END PGP SIGNATURE-----

--Nnb9qd/r+D/pydyJ--
