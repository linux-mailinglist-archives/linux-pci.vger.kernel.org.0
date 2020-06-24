Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0D207D93
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390587AbgFXUiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 16:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729833AbgFXUiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593031098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AJacYQYN9KrR0hhUi0MsZK3xsIa8c3Bs9l77KzZyfmE=;
        b=dwWfhmeLHXsxC3ANzRzx4XQPBb+7yAzn+e/0r3n26OBpVjvkPAAUAOhdBt8a83PF6ZNmzz
        AMAVhrKim0Zqql728At7KpO3afqBWqYP4ATKD0h1fZq2jvilN/xqfw4dNOqinInQbJpDQ8
        FFT9/LRCf7l/mMDCRe5v51dnLnc/3ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-X4OcAEx1MzaPbnuH4X_Zrw-1; Wed, 24 Jun 2020 16:38:14 -0400
X-MC-Unique: X4OcAEx1MzaPbnuH4X_Zrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BE518A822D;
        Wed, 24 Jun 2020 20:37:56 +0000 (UTC)
Received: from [10.10.115.152] (ovpn-115-152.rdu2.redhat.com [10.10.115.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3594A7FE8B;
        Wed, 24 Jun 2020 20:37:50 +0000 (UTC)
Subject: Re: [Patch v3 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mtosatti@redhat.com, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
References: <20200623192331.215557-1-nitesh@redhat.com>
 <20200623192331.215557-2-nitesh@redhat.com> <20200624121352.GA28020@lenoir>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <5f7e7591-35d1-e96f-0520-da9f2d185e74@redhat.com>
Date:   Wed, 24 Jun 2020 16:37:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624121352.GA28020@lenoir>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="USJzxp3ZPIBAIVX19xVkwyhh3LQfRVg9B"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--USJzxp3ZPIBAIVX19xVkwyhh3LQfRVg9B
Content-Type: multipart/mixed; boundary="XYGh4mOHZTffgEUfgohr23czxkZDawAP6"

--XYGh4mOHZTffgEUfgohr23czxkZDawAP6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/24/20 8:13 AM, Frederic Weisbecker wrote:
> On Tue, Jun 23, 2020 at 03:23:29PM -0400, Nitesh Narayan Lal wrote:
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
>>  lib/cpumask.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/cpumask.c b/lib/cpumask.c
>> index fb22fb266f93..d73104995981 100644
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
>> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t=
 mask)
>>   */
>>  unsigned int cpumask_local_spread(unsigned int i, int node)
>>  {
>> -=09int cpu;
>> +=09int cpu, hk_flags;
>> +=09const struct cpumask *mask;
>> =20
>> +=09hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_WQ;
> This should be HK_FLAG_MANAGED_IRQ instead of HK_FLAG_WQ since this
> function seem to be used mostly to select CPUs to affine managed IRQs.

IIRC then there are drivers such as ixgbe that use cpumask_local_spread whi=
le
affining NORMAL IRQs as well.
But I can recheck that.

> In the end the cpumask you pass to IRQ core will be filtered throughout
> HK_FLAG_MANAGED_IRQ anyway so better select an appropriate one in the
> first place to avoid an empty cpumask intersection.
>
> Now even if cpumask_local_spread() is currently mostly used to select
> managed irq targets, the name and role of the function don't refer to tha=
t.
> Probably cpumask_local_spread() should take HK_ flag in parameter so that
> it can correctly handle future users?
>
> That being said, I plan to merge HK_FLAG_RCU, HK_FLAG_MISC, HK_FLAG_SCHED=
,
> HK_FLAG_WQ and HK_FLAG_TIMER into HK_FLAG_UNBOUND since it doesn't make s=
ense
> to divide them all.

That would be nice.

>  And the actual flag used inside cpumask_local_spread()
> could end up being HK_FLAG_DOMAIN | HK_FLAG_UNBOUND. So probably you don'=
t
> need to worry about that and just change the HK_FLAG_WQ in your patch
> with HK_FLAG_MANAGED_IRQ.
>
> Thanks.
>
--=20
Thanks
Nitesh


--XYGh4mOHZTffgEUfgohr23czxkZDawAP6--

--USJzxp3ZPIBAIVX19xVkwyhh3LQfRVg9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7zuZwACgkQo4ZA3AYy
ozngnhAAr4RcCTsJBmGYA/OWf3RTsbgG5p9a/Zax1nwcZFgp4/CtO+cKuKADFsR+
4sAKmm8RZqR1AgtDYmjjHW0Q3Wnaw2MEqT++6dA78rLWBLRbCPRSbWuvMSDWhI3t
hvAycnhORD7ir/8hWCmjbZdQEP3bAAZH+k3hVrliwpumH4cghv1DLUyq5Jqq1RHo
JV8UYjvIuJTb2On1TTxiNuNRGOyJAqwtwCmYlprtGmhSsqD/NnKaMUiP7QfizKnu
DpFVmb5l+A0fKjKqwtlFqbRWDkPxoYNikvmR1PPnPLYLZhbsKV/9m+INfXIROGX5
HTxIiRS4dxWgh1YpBQbRAPjRD1lGtdGEhuMBk5C2MjKR1i+dVDJL3LTiOWeweegA
i02uAuerc4t+HawKP4owXbslPJnR+oRGOJvrNunc1YjxFW6fwoI7hrlpDYM2W3rz
sLbUZgs6ALqFAzW/Z2GPupeyLjqEIn6HjfMIDZFKD80MXhugqa6FykTkh69KMh0/
fH6Tcom4akdM9uOy3w86gNwCrzwkNUfd8L84KfBGyk42+SJuc0iygoy5ZcIqifAx
rYJRmAuWo4J2BP0OX1Fwk6vLZA031YIAOm2z+OauoQw3JMh8db8NEQVBavAQnqP2
nbHl3A1Qxnm2LK3uUtKXcOC3we/Pr8o5mHGUQjy35DTo7MqoYG8=
=h0MQ
-----END PGP SIGNATURE-----

--USJzxp3ZPIBAIVX19xVkwyhh3LQfRVg9B--

