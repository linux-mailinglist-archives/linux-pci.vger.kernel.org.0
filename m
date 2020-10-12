Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9B28BF24
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgJLRmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389562AbgJLRmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602524539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=r8ZR23OKyyZkpfqhU+dFjrZ6JKwGpXMD6kRwOnkbsEU=;
        b=dBsOL43PDAUfx2Pfewn1TiTMWGaDI+1ud4yxo5IxXLdAGENpKfUqXfiQzVdD68DsUKbZIr
        nZY/Gisj+tu8DYybf1+eTxd4lhH52uj95HYhYnXVpdnJON4s8SSYfOvBdHri5Puc97rthB
        4Eajleq/AuWC5IozycUXuKXwaBWOe64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-FS6StQM4NdW27_bi1tew-w-1; Mon, 12 Oct 2020 13:42:14 -0400
X-MC-Unique: FS6StQM4NdW27_bi1tew-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E22E180F186;
        Mon, 12 Oct 2020 17:42:13 +0000 (UTC)
Received: from [10.10.116.246] (ovpn-116-246.rdu2.redhat.com [10.10.116.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B87B6EF59;
        Mon, 12 Oct 2020 17:42:12 +0000 (UTC)
Subject: Re: PCI, isolcpus, and irq affinity
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <a23436f1-1d87-999f-e8fe-a9dd2f50f779@redhat.com>
Date:   Mon, 12 Oct 2020 13:42:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012165839.GA3732859@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nitesh@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MaJAC7c47IgYkkRTfjhpwEgxbf5hUPD6V"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MaJAC7c47IgYkkRTfjhpwEgxbf5hUPD6V
Content-Type: multipart/mixed; boundary="rqW7QCfBLATHiRUavwbNUyQ7NFh3HNrrr"

--rqW7QCfBLATHiRUavwbNUyQ7NFh3HNrrr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 10/12/20 12:58 PM, Bjorn Helgaas wrote:
> [+cc Christoph, Thomas, Nitesh]
>
> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>> I've got a linux system running the RT kernel with threaded irqs.=C2=A0 =
On
>> startup we affine the various irq threads to the housekeeping CPUs, but =
I
>> recently hit a scenario where after some days of uptime we ended up with=
 a
>> number of NVME irq threads affined to application cores instead (not goo=
d
>> when we're trying to run low-latency applications).
> pci_alloc_irq_vectors_affinity() basically just passes affinity
> information through to kernel/irq/affinity.c, and the PCI core doesn't
> change affinity after that.
>
>> Looking at the code, it appears that the NVME driver can in some scenari=
os
>> end up calling pci_alloc_irq_vectors_affinity() after initial system
>> startup, which seems to determine CPU affinity without any regard for th=
ings
>> like "isolcpus" or "cset shield".
>>
>> There seem to be other reports of similar issues:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
>>
>> It looks like some SCSI drivers and virtio_pci_common.c will also call
>> pci_alloc_irq_vectors_affinity(), though I'm not sure if they would ever=
 do
>> it after system startup.
>>
>> How does it make sense for the PCI subsystem to affine interrupts to CPU=
s
>> which have explicitly been designated as "isolated"?
> This recent thread may be useful:
>
>   https://lore.kernel.org/linux-pci/20200928183529.471328-1-nitesh@redhat=
.com/
>
> It contains a patch to "Limit pci_alloc_irq_vectors() to housekeeping
> CPUs".  I'm not sure that patch summary is 100% accurate because IIUC
> that particular patch only reduces the *number* of vectors allocated
> and does not actually *limit* them to housekeeping CPUs.

That is correct the above-mentioned patch is just to reduce the number of
vectors.

Based on the problem that has been described here, I think the issue could
be the usage of cpu_online_mask/cpu_possible_mask while creating the
affinity mask or while distributing the jobs. What we should be doing in
these cases is to basically use the housekeeping_cpumask instead.

A few months back similar issue has been fixed for cpumask_local_spread
and some other sub-systems [1].

[1] https://lore.kernel.org/lkml/20200625223443.2684-1-nitesh@redhat.com/

--=20
Nitesh



--rqW7QCfBLATHiRUavwbNUyQ7NFh3HNrrr--

--MaJAC7c47IgYkkRTfjhpwEgxbf5hUPD6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl+ElXMACgkQo4ZA3AYy
ozm6pA//Rf/OmO3IFCzF/UNjGgaNdf5tNyN6iPoU76O0sOCEnlde11rmnu7R2X0d
uLo0gF+yqmuq1HyBDUyp9EjQ6AEu8JBzkmAJWVZnwktEwbtaCF4ZYc2XThp5rRR0
wARqZHn8yua0kmZGQaCA/EmvEYtMlB1Z2aIP948E1bS4lcLl1m+khuUx+DbEBywL
OiWMDTblSJ+RVnSbPaCNdYvCtKsD5xoU4H/5RT9CsPirbzcaF9bteq2xAEXcUjow
fQIc5bMJEcNb6QuVDodAfBh7qMTZyV2bqJg361zVz1ixYHiTbxseqmqKa95UrDXF
vnabob8XCNC1zfcPAGaSMb3r2VA830OSJorz4MyYrSHW0rIOxchhzCcAstPT/ByF
cwGK3ub5wVD9jm0gKVGucYwERFA4r1+/ekEnSrWDGmnS+B1BaxQCluOJuHx6E7kh
IChSASx7h9uD3zPAVHKIJfEm0kQN91ZPvfpqLYBXMohqqwLFpW/BfGfFxGGu3V4a
OurV3pWSNL6Icu9xza6K1zJp8BECpmQ1fmdMR2mxxQ/U+OJ1b85Ml8sC7bmvRiWP
vq+iyy5vsQU2JQO/UXvuFSjfffDhQz1xYGq9/7dcyULN07dYp2rXsPUYDoXMklfT
yre/iTMrEsTCqmRfpbvQhaH1ClJEjRIfdnNLoG1PsNV4ZpT5F0E=
=Rliz
-----END PGP SIGNATURE-----

--MaJAC7c47IgYkkRTfjhpwEgxbf5hUPD6V--

