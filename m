Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D573D1FC14C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgFPWDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:03:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54569 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725941AbgFPWDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 18:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592345007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=179/O+Gj2T/owujrlYK05PW2qLQMzW+DiLauyFCpz1E=;
        b=ZdaVVSwkAtUth3Q+B6DuUg770L2S6nxQ//n+1NKyGUE0+ZzV3ceM5N90owZlJ8P/eBTuNq
        mSln07l/i4yRuwPMh9ME6xiz+v21yAe6AvLJ9pcgwk23+oH/Rv3+oYjmwsyAniwIHYjM+6
        nZAaxQZIRbcSxVq30T4y0ZM3byQ5ATI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-yZhtNT2UOcmaErfowbtUgQ-1; Tue, 16 Jun 2020 18:03:24 -0400
X-MC-Unique: yZhtNT2UOcmaErfowbtUgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E7281185F80;
        Tue, 16 Jun 2020 22:03:21 +0000 (UTC)
Received: from [10.10.115.60] (ovpn-115-60.rdu2.redhat.com [10.10.115.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F49F19C71;
        Tue, 16 Jun 2020 22:03:15 +0000 (UTC)
Subject: Re: [Patch v1 2/3] PCI: prevent work_on_cpu's probe to execute on
 isolated CPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20200616200550.GA1977307@bjorn-Precision-5520>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <562ce033-50d6-37f0-57a6-de3dd6623c5c@redhat.com>
Date:   Tue, 16 Jun 2020 18:03:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200616200550.GA1977307@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TikH615OqJx41Kmp5An4NsWelc8YGhUkI"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TikH615OqJx41Kmp5An4NsWelc8YGhUkI
Content-Type: multipart/mixed; boundary="clSCwzyDv6w1QWfvmFaBFsmGNYlveeYbF"

--clSCwzyDv6w1QWfvmFaBFsmGNYlveeYbF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/16/20 4:05 PM, Bjorn Helgaas wrote:
> "git log --oneline drivers/pci/pci-driver.c" tells you that the
> subject should be something like:
>
>   PCI: Restrict probe functions to housekeeping CPUs
>
> On Wed, Jun 10, 2020 at 12:12:25PM -0400, Nitesh Narayan Lal wrote:
>> From: Alex Belits <abelits@marvell.com>
>>
>> pci_call_probe() prevents the nesting of work_on_cpu()
>> for a scenario where a VF device is probed from work_on_cpu()
>> of the Physical device.
>> This patch replaces the cpumask used in pci_call_probe()
>> from all online CPUs to only housekeeping CPUs. This is to
>> ensure that there are no additional latency overheads
>> caused due to the pinning of jobs on isolated CPUs.
> s/Physical/PF/ (since you used "VF" earlier, this should match that)
>
> s/This patch replaces/Replace the/
>
> Please rewrap this to fill a 75 column line (so it doesn't overflow 80
> columns when "git log" adds 4 spaces).
>
> This should be two paragraphs; add a blank line between them.

Thanks for pointing these out.
I will correct it in the next posting before that I will wait for any comme=
nts
on other patches.

>
>> Signed-off-by: Alex Belits <abelits@marvell.com>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>> ---
>>  drivers/pci/pci-driver.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index da6510af1221..449466f71040 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/string.h>
>>  #include <linux/slab.h>
>>  #include <linux/sched.h>
>> +#include <linux/sched/isolation.h>
>>  #include <linux/cpu.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/suspend.h>
>> @@ -333,6 +334,7 @@ static int pci_call_probe(struct pci_driver *drv, st=
ruct pci_dev *dev,
>>  =09=09=09  const struct pci_device_id *id)
>>  {
>>  =09int error, node, cpu;
>> +=09int hk_flags =3D HK_FLAG_DOMAIN | HK_FLAG_WQ;
>>  =09struct drv_dev_and_id ddi =3D { drv, dev, id };
>> =20
>>  =09/*
>> @@ -353,7 +355,8 @@ static int pci_call_probe(struct pci_driver *drv, st=
ruct pci_dev *dev,
>>  =09    pci_physfn_is_probed(dev))
>>  =09=09cpu =3D nr_cpu_ids;
>>  =09else
>> -=09=09cpu =3D cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
>> +=09=09cpu =3D cpumask_any_and(cpumask_of_node(node),
>> +=09=09=09=09      housekeeping_cpumask(hk_flags));
>> =20
>>  =09if (cpu < nr_cpu_ids)
>>  =09=09error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
>> --=20
>> 2.18.4
>>
--=20
Nitesh


--clSCwzyDv6w1QWfvmFaBFsmGNYlveeYbF--

--TikH615OqJx41Kmp5An4NsWelc8YGhUkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7pQaIACgkQo4ZA3AYy
ozkxhg/+LrMpZ+rn+W7mB4Kzbrm9LYhNcWFhCEot0q/xqJ5Q6ZGUM0QVdWUFLN6m
H3HxEnJjYGz9EZt6aR7lZ7Cvt2G9v8Oe59uMgxUeMIFEMix9pwP8q3MqQf6817wB
Sr99pjLDDu2JHzpl4nJoSzihiSTEtFo0mKOiblCxsfizg++veXfKzNSzLB6tE6x0
xbmB0tkqLryaKyq3oEOdXdZNY7BBLm4MTiQ7tzjXnhGjlxqkDxyNv8QaljHMCJgK
W4w4duohpUFvB4E/UeQf3E11jQ0ZIDAAXxEBgof1megt3m5km0m656VtVwvPD8EK
E721jvryk2V70bZr7HbJ3V4Qr4fvhVp9n5UFOs3K5xiU6OccVZx/CJ8lXi0lUYY9
bB1b++6DgvMa8FjViMmWQf81eYzYFNU/Z69p7C+e2dKsaYbzXC4GM3I+xPQ2sVUv
gNia95nSNkn109FqVwLet6I4no1qX4CsguJf+cIJjK7enCFstSmq9GGkKhXIO2oC
KSPV5LNgUcxh+0gXriROW3/S0hBKJsAxzBLZVEUSeSsGenIE++K+sstNi7lvqAcq
9zTttyAJewdEqHeqzfSU7qXKp9sXxyxfqeqbqInseP6YRH/CmXSdaE+QHtQ60rhD
Nr96GBudhJyRdq8N1mLB33z42KqcvhaFy+LKqyLMEWafWn6iBdE=
=0Qnl
-----END PGP SIGNATURE-----

--TikH615OqJx41Kmp5An4NsWelc8YGhUkI--

