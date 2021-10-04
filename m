Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC0420718
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJDIOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 04:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhJDIOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 04:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633335184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jhd7OCRxNEDwqPIqJkCKn7zgxcgAxTP1VUtMdDFCHtI=;
        b=M/CoeH17FQcM4W4IJVFBueGP8edPzk9RkDvHem+UAgsVY4GCfFu8wl0O/gqteQJqQMmkFj
        h/xcWrk91WFR3U8daj/APoYs3r4LdBWapIqaQ/n+N4nmKRvq2TajMdT4s1qLDfCdUHczCb
        JVEI6orlwRfd7hpQIm8ZhKD1Vu8NWlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-J9LpLyzIM4mE7HeEaCjZMg-1; Mon, 04 Oct 2021 04:13:00 -0400
X-MC-Unique: J9LpLyzIM4mE7HeEaCjZMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45991100CCD5;
        Mon,  4 Oct 2021 08:12:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC7F75DEFB;
        Mon,  4 Oct 2021 08:12:58 +0000 (UTC)
Date:   Mon, 4 Oct 2021 09:12:57 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, oren@nvidia.com,
        linux-pci@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH v2 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <YVq3iYaWGwPm5IJv@stefanha-x1.localdomain>
References: <20211003091344.718-1-mgurtovoy@nvidia.com>
 <20211003091344.718-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="amH8vhhIjD2i2fX9"
Content-Disposition: inline
In-Reply-To: <20211003091344.718-2-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--amH8vhhIjD2i2fX9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 03, 2021 at 12:13:44PM +0300, Max Gurtovoy wrote:
> Use the proper macro instead of hard-coded (-1) value.
>=20
> Suggested-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--amH8vhhIjD2i2fX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFat4cACgkQnKSrs4Gr
c8hJ4wf9GcRK8XZiWv922sRtrFwXiKXZZUdZlX0c9sOkNLALtbAjvM7g1GfcAjfm
0uAAo6FYpUoDp64ToDc8V3O5nFsWrA2142I4WmiRx/4bbPMTSLvgwLoDRGUd6sAY
BacsHNGjDDALdg0OkVAI+epGNiT36D4J40c7Qrc0UD5FMZm/RI+pntvixd2alugL
AYKH9k+0T6tKAX9vMXul7bwuSfn3vclTzOjds6RFh05gjo+1KT8lRIVShhUKbTq6
Yo69Ft+OK2sRbXZBJ1tFcjjcMeI/rA6PdcOdbq31VYM5KqW3agADNvAfKrVb++fL
/tJNG1/MJzvdhw2DnReH13VL0pSp6Q==
=FKzd
-----END PGP SIGNATURE-----

--amH8vhhIjD2i2fX9--

