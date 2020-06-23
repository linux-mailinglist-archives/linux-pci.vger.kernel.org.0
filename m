Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA79D20467D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 03:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgFWBEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 21:04:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732375AbgFWBEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 21:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592874240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=PSLVw1c74FGzSg/eD1RAeoW5Fyv9SLqM77zmBqHWgtw=;
        b=i54ivMi+fmBav8UZI8J3WrMmT3EnOGrJ5JTpc3SvWyVbbgeQXagPTHOQXIqTNsJaQIdqM3
        yM5WFRPYtsLh047XJ2Y8C2GWn2Jacc91k+E1A9sZtbnFMo8XLkV19FEqIuGwCJ9GQ1/CN7
        DWj81hv5EPaAi8FRZm4plMGXU2RUNlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-A9EiLY2ENAqtenCVZD0oZw-1; Mon, 22 Jun 2020 21:03:44 -0400
X-MC-Unique: A9EiLY2ENAqtenCVZD0oZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A5FA0C16;
        Tue, 23 Jun 2020 01:03:40 +0000 (UTC)
Received: from [10.10.115.32] (ovpn-115-32.rdu2.redhat.com [10.10.115.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 094E4A293B;
        Tue, 23 Jun 2020 01:03:33 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Preventing job distribution to isolated CPUs
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com
References: <20200622234510.240834-1-nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <ee91031f-7483-07fd-38cb-06ee1636659f@redhat.com>
Date:   Mon, 22 Jun 2020 21:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622234510.240834-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZfG3yedVejGZG4N3NJ8gTWT8b4ULGYFTq"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZfG3yedVejGZG4N3NJ8gTWT8b4ULGYFTq
Content-Type: multipart/mixed; boundary="vSWoBjqxNKBsRy7P56HWQdk0OY5nlQ1c2"

--vSWoBjqxNKBsRy7P56HWQdk0OY5nlQ1c2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/22/20 7:45 PM, Nitesh Narayan Lal wrote:
>                                                                          =
 =20
> Testing                                                                  =
 =20
> =3D=3D=3D=3D=3D=3D=3D                                                    =
               =20
> * Patch 1:                                                               =
 =20
>   Fix for cpumask_local_spread() is tested by creating VFs, loading      =
 =20
>   iavf module and by adding a tracepoint to confirm that only housekeepin=
g=20
>   CPUs are picked when an appropriate profile is set up and all remaining=
 =20
>   CPUs when no CPU isolation is configured.                              =
 =20
>                                                                          =
 =20
> * Patch 2:                                                               =
 =20
>   To test the PCI fix, I hotplugged a virtio-net-pci from qemu console   =
 =20
>   and forced its addition to a specific node to trigger the code path tha=
t=20
>   includes the proposed fix and verified that only housekeeping CPUs     =
 =20
>   are included via tracepoint.                                           =
 =20
>                                                                          =
 =20
> * Patch 3:                                                               =
 =20
>   To test the fix in store_rps_map(), I tried configuring an isolated    =
 =20
>   CPU by writing to /sys/class/net/en*/queues/rx*/rps_cpus which         =
 =20
>   resulted in 'write error: Invalid argument' error. For the case        =
 =20
>   where a non-isolated CPU is writing in rps_cpus the above operation    =
 =20
>   succeeded without any error.                                           =
 =20
>                                                                          =
 =20
>                                                                          =
 =20
> Changes from v1:                                                         =
 =20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                            =
                               =20
> - Included the suggestions made by Bjorn Helgaas in the commit messages. =
  =20
> - Included the 'Reviewed-by' and 'Acked-by' received for Patch-2.        =
 =20
>                                                                          =
 =20
> [1] https://patchwork.ozlabs.org/project/netdev/patch/51102eebe62336c6a4e=
584c7a503553b9f90e01c.camel@marvell.com/
>                                                                          =
 =20
> Alex Belits (3):                                                         =
 =20
>   lib: Restrict cpumask_local_spread to houskeeping CPUs                 =
 =20
>   PCI: Restrict probe functions to housekeeping CPUs                     =
 =20
>   net: Restrict receive packets queuing to housekeeping CPUs             =
 =20
>                                                                          =
 =20
>  drivers/pci/pci-driver.c |  5 ++++-                                     =
 =20
>  lib/cpumask.c            | 43 +++++++++++++++++++++++-----------------  =
 =20
>  net/core/net-sysfs.c     | 10 +++++++++-                                =
 =20
>  3 files changed, 38 insertions(+), 20 deletions(-)                      =
 =20
>                                                                          =
 =20
> --
>

Hi,

It seems that the cover email got messed up while I was sending the patches=
.
I am putting my intended cover-email below for now. I can send a v3 with pr=
oper
cover-email if needed. The reason, I am not sending it right now, is that i=
f I
get some comments in=C2=A0my patches I will prefer including them as well i=
n my
v3 posting.


"
This patch-set is originated from one of the patches that have been
posted earlier as a part of "Task_isolation" mode [1] patch series
by Alex Belits <abelits@marvell.com>. There are only a couple of
changes that I am proposing in this patch-set compared to what Alex
has posted earlier.


Context
=3D=3D=3D=3D=3D=3D=3D
On a broad level, all three patches that are included in this patch
set are meant to improve the driver/library to respect isolated
CPUs by not pinning any job on it. Not doing so could impact
the latency values in RT use-cases.


Patches
=3D=3D=3D=3D=3D=3D=3D
* Patch1:
=C2=A0 The first patch is meant to make cpumask_local_spread()
=C2=A0 aware of the isolated CPUs. It ensures that the CPUs that
=C2=A0 are returned by this API only includes housekeeping CPUs.

* Patch2:
=C2=A0 This patch ensures that a probe function that is called
=C2=A0 using work_on_cpu() doesn't run any task on an isolated CPU.

* Patch3:
=C2=A0 This patch makes store_rps_map() aware of the isolated
=C2=A0 CPUs so that rps don't queue any jobs on an isolated CPU.


Proposed Changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
To fix the above-mentioned issues Alex has used housekeeping_cpumask().
The only changes that I am proposing here are:
- Removing the dependency on CONFIG_TASK_ISOLATION that was proposed by
=C2=A0 Alex. As it should be safe to rely on housekeeping_cpumask()
=C2=A0 even when we don't have any isolated CPUs and we want
=C2=A0 to fall back to using all available CPUs in any of the above scenari=
os.
- Using both HK_FLAG_DOMAIN and HK_FLAG_WQ in all three patches, this is
=C2=A0 because we would want the above fixes not only when we have isolcpus=
 but
=C2=A0 also with something like systemd's CPU affinity.


Testing
=3D=3D=3D=3D=3D=3D=3D
* Patch 1:
=C2=A0 Fix for cpumask_local_spread() is tested by creating VFs, loading
=C2=A0 iavf module and by adding a tracepoint to confirm that only housekee=
ping
=C2=A0 CPUs are picked when an appropriate profile is set up and all remain=
ing
=C2=A0 CPUs when no CPU isolation is configured.

* Patch 2:
=C2=A0 To test the PCI fix, I hotplugged a virtio-net-pci from qemu console
=C2=A0 and forced its addition to a specific node to trigger the code path =
that
=C2=A0 includes the proposed fix and verified that only housekeeping CPUs
=C2=A0 are included via tracepoint.

* Patch 3:
=C2=A0 To test the fix in store_rps_map(), I tried configuring an isolated
=C2=A0 CPU by writing to /sys/class/net/en*/queues/rx*/rps_cpus which
=C2=A0 resulted in 'write error: Invalid argument' error. For the case
=C2=A0 where a non-isolated CPU is writing in rps_cpus the above operation
=C2=A0 succeeded without any error.


Changes from v1: [2]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Included the suggestions made by Bjorn Helgaas in the commit message.
- Included the 'Reviewed-by' and 'Acked-by' received for Patch-2.

[1]
https://patchwork.ozlabs.org/project/netdev/patch/51102eebe62336c6a4e584c7a=
503553b9f90e01c.camel@marvell.com/
[2]
https://patchwork.ozlabs.org/project/linux-pci/cover/20200610161226.424337-=
1-nitesh@redhat.com/

Alex Belits (3):
=C2=A0 lib: Restrict cpumask_local_spread to houskeeping CPUs
=C2=A0 PCI: Restrict probe functions to housekeeping CPUs
=C2=A0 net: Restrict receive packets queuing to housekeeping CPUs

=C2=A0drivers/pci/pci-driver.c |=C2=A0 5 ++++-
=C2=A0lib/cpumask.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 43 +++++++++++++++++++++++-----------------
=C2=A0net/core/net-sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++++-
=C2=A03 files changed, 38 insertions(+), 20 deletions(-)

--=20
"

--=20
Thanks
Nitesh


--vSWoBjqxNKBsRy7P56HWQdk0OY5nlQ1c2--

--ZfG3yedVejGZG4N3NJ8gTWT8b4ULGYFTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7xVOAACgkQo4ZA3AYy
oznX7w//anxNLebRv7BCbERZ5hvAFx/lvc5fWn8hRE6+5Ru2pzaFzR15DoStLHBP
lKEnifPxr5+rgxBeSFmjQ6v8LioSLufY1VQTYgKtt7XLfzHjj1tveh4zwLsuO3bQ
o9Iy36dxLqTFVTuTH6FOJVfZBkAn2Lk9KmRjq/oBQmh4b3L4nqlFsM7CvQLFabJw
edcqadnmDvp0FcuSdgCiQAldc8ivIRuKP4oaqJY0R9JbmWfHAnQvPdlN9T+280bn
YALQ34EW/CLE+hLAISc0OAVhgi2iXfsIsmJ3HBklm3mu+SjNWlFXLdzZD8VszP8v
lDOWtkngBBBN2gIIqFe6z7CwkKQMLvNM75ZKwSRk9OPBaFsiN/GFepXkTCXn9+4t
NZHdVQRFF4cHpalQlMOGG8JI2uf32sjfgtutaeONzunJ2VcX9Ui6u/xIQoh7bTKa
rdUZtnp1R9EhvmBIxiK7Nv73sSmJnMPM4zyZusErseCBBk8k/E+37hVjF9Lhle/+
HlQeHgrghuIAfmyek2PVdw2qIFic9av/2qz8pV9A9JhJxaMEp1UnTrIe0qhPBwQc
yD5pyM3uXYwcTcm4S8jvjN0o7gaqCynE5df2RI7/kNn3W/l8D2bYsoVN69H936dC
xpivmz0aUT8U/OOTSOgkwcKF/Lu8hXcLMnFXX5DbWuIONDV64Xc=
=4W4a
-----END PGP SIGNATURE-----

--ZfG3yedVejGZG4N3NJ8gTWT8b4ULGYFTq--

