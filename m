Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD58284ABA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFLRj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFLRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 07:17:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E246C061755;
        Tue,  6 Oct 2020 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y5m31Jm4T6cxiH6YgJIR0SdaPuTbsAFwmzS70apwdoc=; b=aR/3vGTycj3gDIEHUhoDI7dSYF
        2XqIipqUioe7bjiT1QNmG9zAx455etKR5V6RN3BxBGnVwGHdp73+iHWD+a9/3bEDRXWuOg+/HHlFD
        R2MJ3q4s6rqMDY60GjszSrrpUE4qRk6XFZIRtjudrCe4Km+aJ+M7FZqRgRNANTXFUgUnn5JZ1D50G
        kvcj3F4v/O9W9uYM0R1wGrEBBogwgu7ygKcymS/FxBt+Reh9yfjS/jdxQpYxWXo8UXPP0d4vOCtxT
        FV4OAYCkUJOFA80HO6v/OUOZX2EiOR06OAO9EhwQGnH8SybkXAjfQnnyp37BzRWSHjHc23ehFD+vz
        BiEqXRTA==;
Received: from 54-240-197-232.amazon.com ([54.240.197.232] helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPkyG-0003jW-6D; Tue, 06 Oct 2020 11:17:28 +0000
Message-ID: <077f3399e68fca343c06d1016fd6816fb6a59712.camel@infradead.org>
Subject: Re: irq_build_affinity_masks() allocates improper affinity if
 num_possible_cpus() > num_present_cpus()?
From:   David Woodhouse <dwmw2@infradead.org>
To:     Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Tue, 06 Oct 2020 12:17:25 +0100
In-Reply-To: <65ba8a8b86201d8906313fbacc4fb711b9b423af.camel@infradead.org>
References: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
         <65ba8a8b86201d8906313fbacc4fb711b9b423af.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-eOZbIDUpVlr9V1DcroP0"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-eOZbIDUpVlr9V1DcroP0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-06 at 09:37 +0100, David Woodhouse wrote:
> On Tue, 2020-10-06 at 06:47 +0000, Dexuan Cui wrote:
> > Hi all,
> > I'm running a single-CPU Linux VM on Hyper-V. The Linux kernel is v5.9-=
rc7
> > and I have CONFIG_NR_CPUS=3D256.
> >=20
> > The Hyper-V Host (Version 17763-10.0-1-0.1457) provides a guest firmwar=
e,
> > which always reports 128 Local APIC entries in the ACPI MADT table. Her=
e
> > only the first Local APIC entry's "Processor Enabled" is 1 since this
> > Linux VM is configured to have only 1 CPU. This means: in the Linux ker=
nel,
> > the "cpu_present_mask" and " cpu_online_mask " have only 1 CPU (i.e. CP=
U0),
> > while the "cpu_possible_mask" has 128 CPUs, and the "nr_cpu_ids" is 128=
.
> >=20
> > I pass through an MSI-X-capable PCI device to the Linux VM (which has
> > only 1 virtual CPU), and the below code does *not* report any error
> > (i.e. pci_alloc_irq_vectors_affinity() returns 2, and request_irq()
> > returns 0), but the code does not work: the second MSI-X interrupt is n=
ot
> > happening while the first interrupt does work fine.
> >=20
> > int nr_irqs =3D 2;
> > int i, nvec, irq;
> >=20
> > nvec =3D pci_alloc_irq_vectors_affinity(pdev, nr_irqs, nr_irqs,
> >                 PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, NULL);
> >=20
> > for (i =3D 0; i < nvec; i++) {
> >         irq =3D pci_irq_vector(pdev, i);
> >         err =3D request_irq(irq, test_intr, 0, "test_intr", &intr_cxt[i=
]);
> > }
> >=20
> > It turns out that pci_alloc_irq_vectors_affinity() -> ... ->
> > irq_create_affinity_masks() allocates an improper affinity for the seco=
nd
> > interrupt. The below printk() shows that the second interrupt's affinit=
y is
> > 1-64, but only CPU0 is present in the system! As a result, later,
> > request_irq() -> ... -> irq_startup() -> __irq_startup_managed() return=
s
> > IRQ_STARTUP_ABORT because cpumask_any_and(aff, cpu_online_mask) is=20
> > empty (i.e. >=3D nr_cpu_ids), and irq_startup() *silently* fails (i.e. =
"return 0;"),
> > since __irq_startup() is only called for IRQ_STARTUP_MANAGED and
> > IRQ_STARTUP_NORMAL.
> >=20
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -484,6 +484,9 @@ struct irq_affinity_desc *
> >         for (i =3D affd->pre_vectors; i < nvecs - affd->post_vectors; i=
++)
> >                 masks[i].is_managed =3D 1;
> >=20
> > +       for (i =3D 0; i < nvecs; i++)
> > +               printk("i=3D%d, affi =3D %*pbl\n", i,
> > +                      cpumask_pr_args(&masks[i].mask));
> >         return masks;
> >  }
> >=20
> > [   43.770477] i=3D0, affi =3D 0,65-127
> > [   43.770484] i=3D1, affi =3D 1-64
> >=20
> > Though here the issue happens to a Linux VM on Hyper-V, I think the sam=
e
> > issue can also happen to a physical machine, if the physical machine al=
so
> > uses a lot of static MADT entries, of which only the entries of the pre=
sent
> > CPUs are marked to be "Processor Enabled =3D=3D 1".
> >=20
> > I think pci_alloc_irq_vectors_affinity() -> __pci_enable_msix_range() -=
>
> > irq_calc_affinity_vectors() -> cpumask_weight(cpu_possible_mask) should
> > use cpu_present_mask rather than cpu_possible_mask (), so here
> > irq_calc_affinity_vectors() would return 1, and
> > __pci_enable_msix_range() would immediately return -ENOSPC to avoid a
> > *silent* failure.
> >=20
> > However, git-log shows that this 2018 commit intentionally changed the
> > cpu_present_mask to cpu_possible_mask:
> > 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
> >=20
> > so I'm not sure whether (and how?) we should address the *silent* failu=
re.
> >=20
> > BTW, here I use a single-CPU VM to simplify the discussion. Actually,
> > if the VM has n CPUs, with the above usage of
> > pci_alloc_irq_vectors_affinity() (which might seem incorrect, but my po=
int is
> > that it's really not good to have a silent failure, which makes it a lo=
t more=20
> > difficult to figure out what goes wrong), it looks only the first n MSI=
-X interrupts
> > can work, and the (n+1)'th MSI-X interrupt can not work due to the allo=
cated
> > improper affinity.
> >=20
> > According to my tests, if we need n+1 MSI-X interrupts in such a VM tha=
t
> > has n CPUs, it looks we have 2 options (the second should be better):
> >=20
> > 1. Do not use the PCI_IRQ_AFFINITY flag, i.e.
> >         pci_alloc_irq_vectors_affinity(pdev, n+1, n+1, PCI_IRQ_MSIX, NU=
LL);
> >=20
> > 2. Use the PCI_IRQ_AFFINITY flag, and pass a struct irq_affinity affd,
> > which tells the API that we don't care about the first interrupt's affi=
nity:
> >=20
> >         struct irq_affinity affd =3D {
> >                 .pre_vectors =3D 1,
> > 				...
> >         };
> >=20
> >         pci_alloc_irq_vectors_affinity(pdev, n+1, n+1,
> >                 PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
> >=20
> > PS, irq_create_affinity_masks() is complicated. Let me know if you're
> > interested to know how it allocates the invalid affinity "1-64" for the
> > second MSI-X interrupt.
>=20
> Go on. It'll save me a cup of coffee or two...
>=20
> > PS2, the latest Hyper-V provides only one ACPI MADT entry to a 1-CPU VM=
,
> > so the issue described above can not reproduce there.
>=20
> It seems fairly easy to reproduce in qemu with -smp 1,maxcpus=3D128 and a
> virtio-blk drive, having commented out the 'desc->pre_vectors++' around
> line 130 of virtio_pci_common.c so that it does actually spread them.
>=20
> [    0.836252] i=3D0, affi =3D 0,65-127
> [    0.836672] i=3D1, affi =3D 1-64
> [    0.837905] virtio_blk virtio1: [vda] 41943040 512-byte logical blocks=
 (21.5 GB/20.0 GiB)
> [    0.839080] vda: detected capacity change from 0 to 21474836480
>=20
> In my build I had to add 'nox2apic' because I think I actually already
> fixed this for the x2apic + no-irq-remapping case with the max_affinity
> patch series=C2=B9. But mostly by accident.
>=20
>=20
> =C2=B9 https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/head=
s/irqaffinity

Is it fixed by=20
https://git.infradead.org/users/dwmw2/linux.git/commitdiff/41cfe6d54e5?


---
 kernel/irq/affinity.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6d7dbcf91061..00aa0ba6b32a 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -364,12 +364,17 @@ static int irq_build_affinity_masks(unsigned int star=
tvec, unsigned int numvecs,
 		cpumask_copy(npresmsk, cpu_present_mask);
=20
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, cpu_present_mask,
-					 nmsk, masks);
-	if (ret < 0)
-		goto fail_build_affinity;
-	nr_present =3D ret;
+	while (nr_present < numvecs) {
+		curvec =3D firstvec + nr_present;
+		ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
+						 node_to_cpumask, npresmsk,
+						 nmsk, masks);
+		if (ret < 0)
+			goto fail_build_affinity;
+		if (!ret)
+			break;
+		nr_present +=3D ret;
+	}
=20
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
--=20
2.17.1



--=-eOZbIDUpVlr9V1DcroP0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAx
MDA2MTExNzI1WjAvBgkqhkiG9w0BCQQxIgQgCRZxgmxX8iUKhUAtbdifh1DBSjL4YrzGAHM8eeqE
nUYwgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAELIhK/PoK8DklpXKwr2QpccEScd///FRy6Ei8lYDQm+LTb8OhOtRVAakEahlBqJ
hXB5PNugpFSWsnJvglUB/r69STkaIVT82+uV49we7R29Rw2PunaeSLJo37N+dS4kNXQOs60DObKz
gcZxj/PjzxP0YWmUBVR4ZhLr4AtfcoUR0+vMD9IZk1CsH75Ro47Msffjmfq278msiZbcFf2MVrIF
QNPT4VLAZWHCuo3GUS617jW++2Xu3y239GzjeXwuLuhRWkgnRYF2xO0tLUmtoS9OG0vSBgX6f5ck
ysS2z7cxlQig9DoqxordiIY6MTT23r1s9oDboKybtZu7kZniGwIAAAAAAAA=


--=-eOZbIDUpVlr9V1DcroP0--

