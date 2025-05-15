Return-Path: <linux-pci+bounces-27814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FEFAB8DD5
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B718B1BC4463
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2631D54EF;
	Thu, 15 May 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lwSUTHmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9721A316D
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330439; cv=none; b=lprb2d+2Xd/5SHD0xdwbbC5Ut+/LVi5qtM7p/vNu3c92pbn4+KTiuOQLknC5qADkw1ZfZ75WwYQYIEoKIaqc87Sh5/XjJLHAyeNuZll7+/Tw20uLqWfzKUdlGlxRvQyy4UufeLHWmZGesVTlmUpWEH7bJvH/yGYsaWH84JrPvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330439; c=relaxed/simple;
	bh=QjbIKsNwQsilQSTCPC4ogvIhRicdIGCGqSshCNWSc6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJoggMAgoHB3hlqyx3JIxmkwhMO49ghA2tZ9pLElkJS9VoQvb6Lk8pV0V0zdeIS4FdbjRTjOEIwjqN8LpMu+LRLXjaF1tYLbpg3eWWE/WNOVMkz7jx+UzONrIxWMpbSIbIULdcrEOzbEHkJHAG6qRv6wcO+mz9ey/GBe5tYsYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lwSUTHmW; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1747330426; x=1747589626;
	bh=eMncJgSExIrvYrm15fzLzbqOrXbXjQptW5tx6rKcD4I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lwSUTHmW6N+zQ/NW38uEV4P2MhL9KZS6+XrPKUKG8pmscbGxrmYDdsy2E0QY8a8Ad
	 zloyMRqwi+ZGpgGamuodFCt08pt3kP283lyMkowlmMRZ9P+VvrktpmXv0RH+uLvAsU
	 wUvljNwbqcP63kKVn37ILqzR0+CvoqA15NtAL8e02fFMSa6s+ktCv+p2X1RWDmtEVD
	 XB20eYvxdMpxkjw9aRr01z+UBrcIkciJ58GM0EyF7smzzjw82G9nckk4VOH641apED
	 WAuY/jVLa6qONkh1L0hjvaks7bvTrPkltGZfvRbG43IN7w/DOY69vaUo0vXaY+dYzA
	 emqthYKG/HHQQ==
Date: Thu, 15 May 2025 17:33:41 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <fCMPjWu_crgW5GkH4DJd17WBjnCAsb363N9N_h6ld1i8NqNNGR9PTpQWAO9-kwv4DUL6um48dwP0GJ8GmdL4uQf-WniBepwuxTEhjmbBnug=@proton.me>
In-Reply-To: <aCNSBqWM-HM2vX7K@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org> <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7> <aCNSBqWM-HM2vX7K@ryzen>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 83d36aa26181c4d7b2012c55407c6d5d0302af1c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,

On Tuesday, May 13th, 2025 at 4:07 PM, Niklas Cassel <cassel@kernel.org> wr=
ote:

> Hello Mani,
>=20
> On Tue, May 13, 2025 at 11:53:29AM +0100, Manivannan Sadhasivam wrote:
>=20
> > This wait time is a grey area in the spec tbh. If the Readiness Notific=
ation
> > (RN) is not supported, then the spec suggests waiting 1s for the device=
 to
> > become 'configuration ready'. That's why we have the 1s delay in dwc dr=
iver.
> >=20
> > Also, it has the below in r6.0, sec 6.6.1:
> >=20
> > `* On the completion of Link Training (entering the DL_Active state, se=
e =C2=A7 Section 3.2 ), a component must be able to receive and process TLP=
s and DLLPs. * Following exit from a Conventional Reset of a device, within=
 1.0 s the device must be able to receive a Configuration Request and retur=
n a Successful Completion if the Request is valid. This period is independe=
nt of how quickly Link training completes. If Readiness Notifications mecha=
nisms are used (see =C2=A7 Section 6.22 .), this period may be shorter.`
> >=20
> > As per the first note, once link training is completed, the device shou=
ld be
> > ready to accept configuration requests from the host. So no delay shoul=
d be
> > required.
> >=20
> > But the second note says that the 1s delay is independent of how quickl=
y the
> > link training completes. This essentially contradicts with the above po=
int.
> >=20
> > So I think it is not required to add delay after completing the LTSSM, =
unless
> > someone sees any issue.
>=20
>=20
> If you look at the commit message in patch 1/2, the whole reason for this
> series is that someone has seen an issue :)
>=20
> While I personally haven't seen any issue, the user reporting that commit
> ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect
> Link Up") regressed his system so that it can no longer mount rootfs
> (which is on a PLEXTOR PX-256M8PeGN NVMe SSD) clearly has seen an issue.
>=20
> It is possible that his device is not following the spec.
> I simply compared the code before and after ec9fd499b9c6, to try to
> figure out why it was actually working before, and came up with this,
> which made his device functional again.
>=20
> Perhaps we should add a comment above the sleep that says that this
> should strictly not be needed as per the spec?
> (And also add the same comment in the (single) controller driver in
> mainline which already does an msleep(PCIE_T_RRS_READY_MS).)

I am the one experiencing the issue with my Orange PI 3B (RK3566, 8 GB RAM)=
 and a PLEXTOR PX-256M8PeGN NVMe SSD.=20

I first detected the problem while upgrading from 6.13.8 to 6.14.3, that my=
 system cannot find the NVME SSD which contains the rootfs. After reverting=
 the two patches:

- ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect =
Link Up")
- 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up=
 IRQ")

my system booted fine again.=20
After that I tested the patches sent by Niklas in this thread, which fixed =
the issue, so I sent Tested-by.

I did another test Today with 6.15.0-rc6, which in itself does not find my =
SSD. Niklas asked me to test with these=20

- revert ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can =
detect Link Up")
- revert 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_=
link_up IRQ")
- apply the following patch:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/con=
troller/dwc/pcie-designware.c
index b3615d125942..5dee689ecd95 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -692,7 +692,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
                if (dw_pcie_link_up(pci))
                        break;

-               msleep(LINK_WAIT_SLEEP_MS);
+               usleep_range(100, 200);
        }

        if (retries >=3D LINK_WAIT_MAX_RETRIES) {


which restores the original behaviour to wait for link-up, then shorten the=
 time. This resulted again a non booting system, this time with "Phy link n=
ever came up" error message.
So please allow to fix the regression that is already in 6.14.x. I now so f=
ar only I have reported this, but we cannot be sure how many SSDs have this=
 timing issue. Most users use older, distribution packaged kernels, so othe=
rs will face this later.

Bye,

Laszlo Fiat

>=20
>=20
> Kind regards,
> Niklas

