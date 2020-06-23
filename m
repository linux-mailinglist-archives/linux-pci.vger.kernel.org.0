Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1C205348
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgFWNTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 09:19:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732602AbgFWNTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 09:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592918342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Wm7934vy90ysEQUEwWEJMP2bPmnPH5zr0UpywfuvKWA=;
        b=YmzB9RKbf/8u/VMu4nRzy9+lEA3Nr0UQer6QlcKhoatsvc2f0awdNZPv3Sr3a4FJOve3XF
        UcbKGdKQmVyZnTeeEZ6X0jMF9H5lzyyRv3Tu01qHI6V9DkfA4usFum+YvCTMmCOzxWtwWs
        oUlObeLEVNkS4msQmxm9lFRTFO+xAqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365--v0K_m57M4ubZSdoCoXFqQ-1; Tue, 23 Jun 2020 09:18:58 -0400
X-MC-Unique: -v0K_m57M4ubZSdoCoXFqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29F1192297A;
        Tue, 23 Jun 2020 13:18:53 +0000 (UTC)
Received: from [10.10.112.224] (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D72890324;
        Tue, 23 Jun 2020 13:18:41 +0000 (UTC)
Subject: Re: [Patch v2 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
References: <20200622234510.240834-1-nitesh@redhat.com>
 <20200622234510.240834-2-nitesh@redhat.com>
 <20200623092139.GB4781@hirez.programming.kicks-ass.net>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <9b499cd8-e311-db5b-4261-0b3f355c8c89@redhat.com>
Date:   Tue, 23 Jun 2020 09:18:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623092139.GB4781@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KxFdHc4nNsmoEb5Z4JeJrTYFF0IbAnbWV"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KxFdHc4nNsmoEb5Z4JeJrTYFF0IbAnbWV
Content-Type: multipart/mixed; boundary="N3pPay3VTB8ZxfMV0HMF98bVzXhPUIWGC"

--N3pPay3VTB8ZxfMV0HMF98bVzXhPUIWGC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/23/20 5:21 AM, Peter Zijlstra wrote:
> On Mon, Jun 22, 2020 at 07:45:08PM -0400, Nitesh Narayan Lal wrote:
>> From: Alex Belits <abelits@marvell.com>
>>
>> The current implementation of cpumask_local_spread() does not respect th=
e
>> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
>> it will return it to the caller for pinning of its IRQ threads. Having
>> these unwanted IRQ threads on an isolated CPU adds up to a latency
>> overhead.
>>
>> Restrict the CPUs that are returned for spreading IRQs only to the
>> available housekeeping CPUs.
>>
>> Signed-off-by: Alex Belits <abelits@marvell.com>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  lib/cpumask.c | 43 +++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/lib/cpumask.c b/lib/cpumask.c
>> index fb22fb266f93..cc4311a8c079 100644
>> --- a/lib/cpumask.c
>> +++ b/lib/cpumask.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/export.h>
>>  #include <linux/memblock.h>
>>  #include <linux/numa.h>
>> +#include <linux/sched/isolation.h>
>> =20
>>  /**
>>   * cpumask_next - get the next cpu in a cpumask
>> @@ -205,28 +206,34 @@ void __init free_bootmem_cpumask_var(cpumask_var_t=
 mask)
>>   */
>>  unsigned int cpumask_local_spread(unsigned int i, int node)
>>  {
>> -=09int cpu;
>> +=09int cpu, m, n, hk_flags;
>> +=09const struct cpumask *mask;
>> =20
>> +=09hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_WQ;
>> +=09mask =3D housekeeping_cpumask(hk_flags);
>> +=09m =3D cpumask_weight(mask);
>>  =09/* Wrap: we always want a cpu. */
>> -=09i %=3D num_online_cpus();
>> +=09n =3D i % m;
>> +=09while (m-- > 0) {
> I are confuzled. What do we need this outer loop for?
>
> Why isn't something like:
>
> =09i %=3D cpumask_weight(mask);
>
> good enough? That voids having to touch the test.

Makes sense.
Thanks

> Still when you're there, at the very least you can fix the horrible
> style:

Sure.

>
>
>> +=09=09if (node =3D=3D NUMA_NO_NODE) {
>> +=09=09=09for_each_cpu(cpu, mask)
>> +=09=09=09=09if (n-- =3D=3D 0)
>> +=09=09=09=09=09return cpu;
> { }
>
>> +=09=09} else {
>> +=09=09=09/* NUMA first. */
>> +=09=09=09for_each_cpu_and(cpu, cpumask_of_node(node), mask)
>> +=09=09=09=09if (n-- =3D=3D 0)
>> +=09=09=09=09=09return cpu;
> { }
>
>> =20
>> +=09=09=09for_each_cpu(cpu, mask) {
>> +=09=09=09=09/* Skip NUMA nodes, done above. */
>> +=09=09=09=09if (cpumask_test_cpu(cpu,
>> +=09=09=09=09=09=09     cpumask_of_node(node)))
>> +=09=09=09=09=09continue;
> No linebreak please.
>
>> =20
>> +=09=09=09=09if (n-- =3D=3D 0)
>> +=09=09=09=09=09return cpu;
>> +=09=09=09}
>>  =09=09}
>>  =09}
>>  =09BUG();
>> --=20
>> 2.18.4
>>
--=20
Nitesh


--N3pPay3VTB8ZxfMV0HMF98bVzXhPUIWGC--

--KxFdHc4nNsmoEb5Z4JeJrTYFF0IbAnbWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7yAS0ACgkQo4ZA3AYy
ozm9TxAA03qyAclOLwN/ogLAtS/TkuXdENI8mJXEgyHAzUM7UH7eToCmwP5UYQ2t
YF3+hLB2b3PZYZptdnXUkDIrAPO9Em++YLTBNYdglNsI3jGZ6vPKvRh1tOmpIlk6
gano9vSHSyRqq0RqsnYRrweENT0JPXTGC7tDrXT4RIFLA7tbG677b7WUNCChpSpu
93Bf1upf4WVVoRbiPVt/a/TdPiKv6gLQz2GHfqHNfJ1OMfbBrdDEKssP3MXpV0Bq
QEvZXtUTzp+O16L3mVjai+sx2U0PxQAuyrD+bnAIRzsI8Xz8isBc3YoQ/RvQM5og
iIaUofFgNhJ8LpJxUJnWkFHz9dwFnhuy7c57RstPM2KZqdMrc9b0lGi10dOqUQRA
nyktu1w8NYtfaOSk+QMBcdJky7scRBiJ5orjpt43eM3Rb9T9k6krYirhZj+WeIpG
ZiBOPo7llQpv2T4g9KgtEPSdLaTapW74GiRq5OiAjj3SpqAhT+eut7XelwlFIjTo
NAf1Gl50A+pYPZWEIjb1OSrsrFN3eXPqvLmf7B8w5F2yIz1c7rn5Q5LEts6JtWJd
4taXA/9eWy/vq/inBVveWYyqvg47YKGqbohKTsUi4kUpLx5TFYbNSgUydUsKxeH3
zVdxV/l68gRxy/c/cN7Cu3VH9NwZXQ3rkOeKsuV15OVk8GuBMws=
=Cu5B
-----END PGP SIGNATURE-----

--KxFdHc4nNsmoEb5Z4JeJrTYFF0IbAnbWV--

