Return-Path: <linux-pci+bounces-440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9BE804474
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 03:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE21F212E0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3252112;
	Tue,  5 Dec 2023 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Qe7PBpLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD68107;
	Mon,  4 Dec 2023 18:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1701741993;
	bh=PVO+9wWo6qr4JNuSbUNdvryTDg0uALwlRcXUD0FYi5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qe7PBpLN30VLmmGHSk24LtK1Wlb+pWnz7GaTC+B5PVcEpVv+FcO/OKO6IYRYlxXMW
	 S1w5i4fJXN3dMAGSqC0mA6U6iSwHYsppoLj8IIdapnWg+1CxN/r4mY+XEofQD3xLeN
	 0o/wzmTQPK50vAHNxFU7ejXBLUhKKBtRmxNKaAqWMRL0ZPVW616jGyqBCGBQvH+8S3
	 rEFsAlg9tO5aDXNqo1BLhQDB871+paTPvtiqNJw72mVrJDHDFRfU94X5GAlizlBzp2
	 4p1OS/JWnB+mgiEEV48ADMAEL/STPwN3jNphO46qchvmvYLN6I1GoFWtlpa1P+lN0D
	 r6GGsJbLqOtHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkkRX3Fwbz4wd0;
	Tue,  5 Dec 2023 13:06:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, James
 Smart <james.smart@broadcom.com>, Dick Kennedy
 <dick.kennedy@broadcom.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/6] x86: Use PCI_HEADER_TYPE_* instead of literals
In-Reply-To: <20231201225609.GA534714@bhelgaas>
References: <20231201225609.GA534714@bhelgaas>
Date: Tue, 05 Dec 2023 13:06:29 +1100
Message-ID: <874jgxflne.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> writes:
> [+cc scsi, powerpc folks]
>
> On Fri, Dec 01, 2023 at 02:44:47PM -0600, Bjorn Helgaas wrote:
>> On Fri, Nov 24, 2023 at 11:09:13AM +0200, Ilpo J=C3=A4rvinen wrote:
>> > Replace 0x7f and 0x80 literals with PCI_HEADER_TYPE_* defines.
>> >=20
>> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>=20
>> Applied entire series on the PCI "enumeration" branch for v6.8,
>> thanks!
>>=20
>> If anybody wants to take pieces separately, let me know and I'll drop
>> from PCI.
>
> OK, b4 picked up the entire series but I was only cc'd on this first
> patch, so I missed the responses about EDAC, xtensa, bcma already
> being applied elsewhere.
>
> So I kept these in the PCI tree:
>
>   420ac76610d7 ("scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal")
>   3773343dd890 ("powerpc/fsl-pci: Use PCI_HEADER_TYPE_MASK instead of lit=
eral")
>   197e0da1f1a3 ("x86/pci: Use PCI_HEADER_TYPE_* instead of literals")
>
> and dropped the others.
>
> x86, SCSI, powerpc folks, if you want to take these instead, let me
> know and I'll drop them.

Nah that's fine, you keep them.

cheers

