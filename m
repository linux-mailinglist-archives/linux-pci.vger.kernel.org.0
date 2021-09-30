Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F241DD7F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhI3Pcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 11:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343921AbhI3Pcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 11:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633015871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yt/zlKqP93kTWPAGGVE5ziZ1VrokRFvfUstwd3NI9zg=;
        b=bN1jePBxjpiT0rY9w5TkZEh6hdmh30y7VMTyP20gC8AYx2frU67MqEt9w84HxBYif/xQss
        Hy9PRUSgulY4JVDyawMZ/cBZEFSy+YzSyQtrGGAwmClc4HrLjDYuptT2YQoNDRM1HGMtWw
        C2pODaCWchCc1KF6f4vDmXhQasgM5iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-MFKAeSR1MhGImMNrtei-zA-1; Thu, 30 Sep 2021 11:31:07 -0400
X-MC-Unique: MFKAeSR1MhGImMNrtei-zA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6595CDF8A0;
        Thu, 30 Sep 2021 15:31:06 +0000 (UTC)
Received: from localhost (unknown [10.39.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2AA5BAE5;
        Thu, 30 Sep 2021 15:31:05 +0000 (UTC)
Date:   Thu, 30 Sep 2021 16:30:59 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, oren@nvidia.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] driver core: use NUMA_NO_NODE during
 device_initialize
Message-ID: <YVXYMzRpVTCu9AyV@stefanha-x1.localdomain>
References: <20210930142556.9999-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TC6Mln2Z2suHGcTr"
Content-Disposition: inline
In-Reply-To: <20210930142556.9999-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TC6Mln2Z2suHGcTr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2021 at 05:25:56PM +0300, Max Gurtovoy wrote:
> Don't use (-1) constant for setting initial device node. Instead, use
> the generic NUMA_NO_NODE definition to indicate that "no node id
> specified".
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TC6Mln2Z2suHGcTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFV2DMACgkQnKSrs4Gr
c8iA3Af8DLUJv7Sz46AwfS2FQMmVB+UV5KwvOwRxFTBdeG4h+ol4hc5W6VSeXIRP
NLPasJQAciJdzVPnKTnQwtZ6txeKgqxUhBlfneiHk3jw2nfnGSac2IGkP35paH1r
J7Nhif//6Oun8CEK9pIJ7vVwucun/W6varooxgwBdx/oUnncDnIvC71I8O/KXbC3
yhf+AqrkFMK40r/y0Bp3Gu9aqm6iugw7ze+vJT2cxDu2mgP9CDtGFJDMmPwlKbhV
4GBmyiLlMMIXDNwcJO17BzVGeRVJdbGATOyjYGFXEX3Awpa5v4SzLZSPrRYKeNc4
HEriHC6DzMIdzA4xsoSd33ZHq0ZyXg==
=J/SX
-----END PGP SIGNATURE-----

--TC6Mln2Z2suHGcTr--

