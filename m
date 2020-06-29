Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824DF20D4E0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgF2TMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:12:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730838AbgF2TMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2020 15:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=2I8i4906CXXg1A/o4TrQNEB3h9t71guIcAqgVgTX6sI=;
        b=XvIz5/m2ZkO0bJdnMI2vFmOgm+mXzp57tLJ2fKzl6twaPZOZ5soa1qRaA5iG2vfey/H2uU
        H4n4QVZB5kt/rbfRl9PoLi5B0CYUhgg04uqXtXL1y1R5c8zcAMqEeeRlRr9mvPLUNrphKT
        D62carbgwhkqMnW0VGk54WxJ6HhgUb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-CsF-sNg8Mpqy4vHHowxOYA-1; Mon, 29 Jun 2020 12:11:35 -0400
X-MC-Unique: CsF-sNg8Mpqy4vHHowxOYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41856107ACCD;
        Mon, 29 Jun 2020 16:11:33 +0000 (UTC)
Received: from [10.10.115.36] (ovpn-115-36.rdu2.redhat.com [10.10.115.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D36F370915;
        Mon, 29 Jun 2020 16:11:26 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        peterz@infradead.org
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
Cc:     frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <8054aff1-544d-80de-456f-c3e244233419@redhat.com>
Date:   Mon, 29 Jun 2020 12:11:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200625223443.2684-2-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xlmtqOwRCb4MdvNC2mYBAmRR0u6DBPGGO"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xlmtqOwRCb4MdvNC2mYBAmRR0u6DBPGGO
Content-Type: multipart/mixed; boundary="wxBsS927gl5basYQvvUQMAtiupkOEYS0K"

--wxBsS927gl5basYQvvUQMAtiupkOEYS0K
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/25/20 6:34 PM, Nitesh Narayan Lal wrote:
> From: Alex Belits <abelits@marvell.com>
>
> The current implementation of cpumask_local_spread() does not respect the
> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
> it will return it to the caller for pinning of its IRQ threads. Having
> these unwanted IRQ threads on an isolated CPU adds up to a latency
> overhead.
>
> Restrict the CPUs that are returned for spreading IRQs only to the
> available housekeeping CPUs.
>
> Signed-off-by: Alex Belits <abelits@marvell.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

Hi Peter,

I just realized that Yuqi jin's patch [1] that modifies cpumask_local_sprea=
d is
lying in linux-next.
Should I do a re-post by re-basing the patches on the top of linux-next?

[1]
https://lore.kernel.org/lkml/1582768688-2314-1-git-send-email-zhangshaokun@=
hisilicon.com/

> ---
>  lib/cpumask.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index fb22fb266f93..85da6ab4fbb5 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -6,6 +6,7 @@
>  #include <linux/export.h>
>  #include <linux/memblock.h>
>  #include <linux/numa.h>
> +#include <linux/sched/isolation.h>
> =20
>  /**
>   * cpumask_next - get the next cpu in a cpumask
> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t =
mask)
>   */
>  unsigned int cpumask_local_spread(unsigned int i, int node)
>  {
> -=09int cpu;
> +=09int cpu, hk_flags;
> +=09const struct cpumask *mask;
> =20
> +=09hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> +=09mask =3D housekeeping_cpumask(hk_flags);
>  =09/* Wrap: we always want a cpu. */
> -=09i %=3D num_online_cpus();
> +=09i %=3D cpumask_weight(mask);
> =20
>  =09if (node =3D=3D NUMA_NO_NODE) {
> -=09=09for_each_cpu(cpu, cpu_online_mask)
> +=09=09for_each_cpu(cpu, mask) {
>  =09=09=09if (i-- =3D=3D 0)
>  =09=09=09=09return cpu;
> +=09=09}
>  =09} else {
>  =09=09/* NUMA first. */
> -=09=09for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
> +=09=09for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
>  =09=09=09if (i-- =3D=3D 0)
>  =09=09=09=09return cpu;
> +=09=09}
> =20
> -=09=09for_each_cpu(cpu, cpu_online_mask) {
> +=09=09for_each_cpu(cpu, mask) {
>  =09=09=09/* Skip NUMA nodes, done above. */
>  =09=09=09if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>  =09=09=09=09continue;
--=20
Nitesh


--wxBsS927gl5basYQvvUQMAtiupkOEYS0K--

--xlmtqOwRCb4MdvNC2mYBAmRR0u6DBPGGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl76Eq0ACgkQo4ZA3AYy
ozlGrxAAwtBCOD016SDyWpkyw3cQv9ppTmQbals77UoxptOQxhMEyKvPfNwpkwFy
BsxSXE8oNvmaVYqLVUgR1+oE/U0rfDS0SapaXDfFu6hhvOrjCZDGNu+biYhmliXe
1mTg0KMSMhSY5WovN6WebXLb3fePlycXc5/lajpIH43z2SinMcZrFtNsyt+zvQ8A
Jy7yJ+5N6yHXu5XfL9/kJU+WNOH8cygGKajtGMjeHvSpKFBLa6bI1QAl5OzfVYcQ
9Py7U0XSwkXCgyDrbJ6xz5UeRkPd8MMp68Nb7h3WQLgSPo3rqhNtGIPcT6O0rZ80
pJc2idbuNSmKC+gQ0vqslXDi5Btj7jP+0S6+96MPsaFlGCbGSbaY9hSM1D3r4+5a
wygMxSZeeH0I7QJWKxWNIaBFBWZAz/oc7ApBZK+PKQEQM0OuAf+Rjfp8ww/OGYhP
MvMb/67y+H62Rc/CvVxjmOb7eInCfmN4EXCcKxGfWxXGZCy0l06Ab7SegNG+/Zjj
Z4AwWLE2DSItXaQQs9veUkwY0Ylh0kWIAdL30aG38xQAqWciIZRWFqHhud5e1rcY
8ftRKMz0LRy6JlON/WQ+CBYAnH5lw4UrQR8gSkIur+na18G3cKItIjQZzxjNUCzU
LWwQIBNZLNeLjnOWa31UmDOXseXs24L+ulc/Ayj+jepu+Z4aUSc=
=U5vU
-----END PGP SIGNATURE-----

--xlmtqOwRCb4MdvNC2mYBAmRR0u6DBPGGO--

