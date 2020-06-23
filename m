Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3F2050FC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbgFWLma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 07:42:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732485AbgFWLm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 07:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592912547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=mVDdDzj31CvPBNhZUfDPeljm/u7xus+LZ3Kd5RIBbeg=;
        b=eG0n9JqxAVS2uutqP2XF8hO8VXexPzsoEAeGXgRWgw6ACkvb4ckau+Ii6r/1XvLQqPZBvy
        nj5RPFHKyz3tGY0WnJZjF93M7CZ3jeb9HChxQ0NQBF8F2X/6Uvbtl6QoMmSugNPoYnIkm4
        YnltM/QdR+59q6UBC9MSwKFcD1IWxlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-o8d97G4YOZGFA1GDzZsiUQ-1; Tue, 23 Jun 2020 07:42:23 -0400
X-MC-Unique: o8d97G4YOZGFA1GDzZsiUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B798031C2;
        Tue, 23 Jun 2020 11:42:21 +0000 (UTC)
Received: from [10.10.112.224] (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B6B5C290;
        Tue, 23 Jun 2020 11:42:08 +0000 (UTC)
Subject: Re: [Patch v2 3/3] net: Restrict receive packets queuing to
 housekeeping CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
References: <20200622234510.240834-1-nitesh@redhat.com>
 <20200622234510.240834-4-nitesh@redhat.com>
 <20200623092312.GC4781@hirez.programming.kicks-ass.net>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <f67187a8-be5f-ea15-77b4-165dab2b51af@redhat.com>
Date:   Tue, 23 Jun 2020 07:42:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623092312.GC4781@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QmeVdi3u4bWeeqhM0VYP020GtIwgEgOXk"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QmeVdi3u4bWeeqhM0VYP020GtIwgEgOXk
Content-Type: multipart/mixed; boundary="6Vj1QAOw4bDqnRbT2GEr6u2jYNR4T1P00"

--6Vj1QAOw4bDqnRbT2GEr6u2jYNR4T1P00
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/23/20 5:23 AM, Peter Zijlstra wrote:
> On Mon, Jun 22, 2020 at 07:45:10PM -0400, Nitesh Narayan Lal wrote:
>> @@ -756,6 +757,13 @@ static ssize_t store_rps_map(struct netdev_rx_queue=
 *queue,
>>  =09=09return err;
>>  =09}
>> =20
>> +=09hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_WQ;
>> +=09cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
>> +=09if (cpumask_weight(mask) =3D=3D 0) {
> We have cpumask_empty() for that, which is a much more efficient way of
> testing the same.

Yes, right.
I will make this change.

>
>> +=09=09free_cpumask_var(mask);
>> +=09=09return -EINVAL;
>> +=09}
>> +
>>  =09map =3D kzalloc(max_t(unsigned int,
>>  =09=09=09    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
>>  =09=09      GFP_KERNEL);
>> --=20
>> 2.18.4
>>
--=20
Thanks
Nitesh


--6Vj1QAOw4bDqnRbT2GEr6u2jYNR4T1P00--

--QmeVdi3u4bWeeqhM0VYP020GtIwgEgOXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7x6o0ACgkQo4ZA3AYy
ozlCpRAAhk5YK0kFNJO35HoAS9sTo+p39qmZ8uhxx7XOGzbIq2+dJKzNtyHT3uQA
mDVkhhc2YmZ7inNJ6f4NMa6AFPSPefz2AGdjLOLLnxpQscVt1MlFMykCS2Oq2rTp
imOdpmOqF0ZOUVTpSgxRQ+ek7BDqQUHunm/YcWOqWggp8yEumj0Ne9m4/yxwn1TB
k0RI+3DsPl4Id/qfzXO3paCyBngXyRpfEVwsp4wqlscDhCxRnE9Ou4Fcs7jiGzZ+
Ct4W7RJZNQEgsm/rDC0+1ruSnC0QN0yw03R7mD7ZVSC5wcU3R4Cq25KmHk7cP2/x
ivHJl/+kpA0qonzd1eSbqrXOOc854PQxH/9xOS8eYoAap13kDg4VO4rErvVKINz8
idFKuWWztE/JHr5ws/+/ZNbrV+AUDod3KwgyQeQB0KlYe7Q7blZnWkUOwv4f1ckG
UyNiXlS1chVDBl8sUruTIb2adI6i3u/siDnNi0uOhJcaCQCi7pUUfUkhBNGOUwT1
vZnGnABeouO+RHCBiaFtj0y/HnhyFYj8pPNfA+af45m4sEpYcBFDPbIVoJO17yDv
ykTBI2s46CoFmBlnfTy6PuKyhnTdYGbvCBwSQpfm3KQFWu5O10O0rDu+zxy0jtnO
h3pM8nhooarIdrN2rnyVvvscChUqnJx+ORIKxmlTLfc1yws5uYI=
=VJ/U
-----END PGP SIGNATURE-----

--QmeVdi3u4bWeeqhM0VYP020GtIwgEgOXk--

