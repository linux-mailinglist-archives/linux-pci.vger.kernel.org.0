Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2721011D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgGAAsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 20:48:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbgGAAsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 20:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593564487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=dvDHRkh74hlCyN4JG6BjLU/8tyJT+WTRoBdybg+m61E=;
        b=Suzgb1SMdCdPs4C0h/NqeQw3RV/YkRA9Bjcrxvj3LNKTjQ5/AMQXcR43wim1/g64bg22cr
        AupIldhNHZdbveLseFbCZt1fLrN4uy1zEY8UL8YnhaqKx1LQEa+cH9AeB3XR44bmKJ/vXd
        fq0l42k4PMCFrPW/c/NI0m49dolr9aU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-fCRvAmRaNlCHjxL5js87fw-1; Tue, 30 Jun 2020 20:48:02 -0400
X-MC-Unique: fCRvAmRaNlCHjxL5js87fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBDE680183C;
        Wed,  1 Jul 2020 00:47:58 +0000 (UTC)
Received: from [10.10.115.161] (ovpn-115-161.rdu2.redhat.com [10.10.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA1C05DC1E;
        Wed,  1 Jul 2020 00:47:40 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <8054aff1-544d-80de-456f-c3e244233419@redhat.com>
 <20200630173244.eef158fb09dca3cc1e2e63b1@linux-foundation.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <efd99d48-39c7-be65-039d-524e63a80ed1@redhat.com>
Date:   Tue, 30 Jun 2020 20:47:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630173244.eef158fb09dca3cc1e2e63b1@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nitesh@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zv9Bvlc42mHfmwj43hiP5sXCCb7PHKzlV"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zv9Bvlc42mHfmwj43hiP5sXCCb7PHKzlV
Content-Type: multipart/mixed; boundary="Qnd1YrjHmRMYY6RES2I1WNMyjD7Cc2lJq"

--Qnd1YrjHmRMYY6RES2I1WNMyjD7Cc2lJq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/30/20 8:32 PM, Andrew Morton wrote:
> On Mon, 29 Jun 2020 12:11:25 -0400 Nitesh Narayan Lal <nitesh@redhat.com>=
 wrote:
>
>> On 6/25/20 6:34 PM, Nitesh Narayan Lal wrote:
>>> From: Alex Belits <abelits@marvell.com>
>>>
>>> The current implementation of cpumask_local_spread() does not respect t=
he
>>> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task=
,
>>> it will return it to the caller for pinning of its IRQ threads. Having
>>> these unwanted IRQ threads on an isolated CPU adds up to a latency
>>> overhead.
>>>
>>> Restrict the CPUs that are returned for spreading IRQs only to the
>>> available housekeeping CPUs.
>>>
>>> Signed-off-by: Alex Belits <abelits@marvell.com>
>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> Hi Peter,
>>
>> I just realized that Yuqi jin's patch [1] that modifies cpumask_local_sp=
read is
>> lying in linux-next.
>> Should I do a re-post by re-basing the patches on the top of linux-next?
>>
>> [1]
>> https://lore.kernel.org/lkml/1582768688-2314-1-git-send-email-zhangshaok=
un@hisilicon.com/
> This patch has had some review difficulties and has been pending for
> quite some time.  I suggest you base your work on mainline and that we
> ask Yuqi jin to rebase on that, if I don't feel confident doing it,
>

I see, in that case, it should be fine to go ahead with this patch-set as I
already based this on top of the latest master before posting.

--=20
Thanks
Nitesh


--Qnd1YrjHmRMYY6RES2I1WNMyjD7Cc2lJq--

--zv9Bvlc42mHfmwj43hiP5sXCCb7PHKzlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl773SUACgkQo4ZA3AYy
ozmgBBAAwiPIg76Omt8HLuEybfddkAgiS1i2lAre/Gv09LNzWlpHR3GbgJ3xzcR+
GUjYxajdn/j7QUSwtjLebNC5j7tqEZ6GNMdKrJY90nDNuxf5FFsAjs9lARV1nmyD
HKXnM21ov8bjT3hpVtCmGcq0xncKMUDkBp75MbBxlKO8PKY2OGTBQspR144Z02j+
7e8jRLAe2SKs8H6/cQzqsGLX7ohwUp6+IjQFoWhM3h4oiYMmwbSjO1N+WNLa3c9r
q8Yhp3w6RQYS0/jYcqvzdHQ1TNO2HwO5E5TvDiNubDpEpkH6SAgMJ8AlxyQ3s+7F
Awuy5fvPAQv5cu2p+l9uC1WPrVE5L9m+ubKlgjwQCFPFqqP9j2HTsnbI+3V+35c2
zf9gSaqR20neMOsZ1NdkfxDCYJChL/ZkoaFNyeFGLftI2WsFy82Ql/+DExhbvkft
236Ty6QpGdGIDmTO8EljEIhqcQZap3aowX4sVnckUKE3GBJesr3c+FPGkNsPPf/c
9+B2mJ6xHKWCsUTKaHtG/9sWmNLwuhK0wHdbnlCtQHN95sbdqBOQohZUZIlbx888
kPwPF0V0w6e/s05yg/uZynHthpo7S1MU+ee2gxnUQUJJDPg6fEJvF5PtgmCJpEuq
2+5pWisjHn7VWh57YQXRKD7iOqeNFjDrxvDgWYGU2ySyTTmP3DU=
=4kni
-----END PGP SIGNATURE-----

--zv9Bvlc42mHfmwj43hiP5sXCCb7PHKzlV--

