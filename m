Return-Path: <linux-pci+bounces-35865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65890B52828
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F274872B1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 05:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321123A994;
	Thu, 11 Sep 2025 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFT6pShU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FB329F29;
	Thu, 11 Sep 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757568840; cv=none; b=TDUrFH6HTFo9UIFRNV6a5S4znpTNv7K6b7B6yL5yirWf34r5i4/AFbMn9lMD7xB4vMHLadJRmyc5cEF1Ti2OYjFcQjsUDHQUwPTejFHef0XTOAqcH2JZ9hAHl5NjJM+9su0gxlJSfSFe3ryCq69RhwdJDGpEcxhAIfQgUhsxP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757568840; c=relaxed/simple;
	bh=5vWUqhvI4pD7PEFK16VOGInaekHB8D/PZdNkUx+vkzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m0IVGX4z25AZcOI7+so2E6uaFFAbEkQHwlJI4p8fhiG4rsM1umOH7EhFHmM3+HhXp7YF1Izxro0rqB5jeAGO0koAOwBQ3JvYnb06IxwYYP1T7JzB1P8EzvM2G8FIxSoVi09VIkqPUwx21hUiZZEm/oB+sp/Zz25vTuPp3ut3XAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFT6pShU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA597C4CEF1;
	Thu, 11 Sep 2025 05:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757568839;
	bh=5vWUqhvI4pD7PEFK16VOGInaekHB8D/PZdNkUx+vkzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BFT6pShUwC2LHdJj1bD7Cyqj0kBjdg10vsYiOhwd6YIqPHY3x0Rc2grk5Z0mCaj+f
	 YlhZPsqmbVhb0043ePmfWFOwoN0s0k87pK/mSg5cTOHHNNT28CP80SL2mvi6JY0a8D
	 PfVl0GorQ+dqp1v/FWOX1UYd4I0ZEMl5StDZov0SMkhhbdD+0P0/Q+DrOUA8QWi62a
	 4fLqaBHMgfAZ1FF6eRyFmLr9DIEOpe7mnO5crtxbdZfabRTuLmEvJyWngMtuPmnRpU
	 wONyDWq5cbRtqpCSVp9cYV4ZtkAgTLDZIPevlQxwTqVHdbYJhZxdLFEQA/3YMExDfO
	 +T+cHRoziMnPA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Arto Merilainen <amerilainen@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
In-Reply-To: <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
 <c3291a06-1154-4c89-a77b-73e2a3ef61ee@nvidia.com>
Date: Thu, 11 Sep 2025 11:03:50 +0530
Message-ID: <yq5ay0ql364h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arto Merilainen <amerilainen@nvidia.com> writes:

> On 31.7.2025 14.39, Arto Merilainen wrote:
>> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
>>=20
>>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < interface_report->mmio_range_=
count; i++,=20
>>> mmio_range++) {
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*FIXME!! units in 4K size*/
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_id =3D FIELD_GET(TSM_=
INTF_REPORT_MMIO_RANGE_ID,=20
>>> mmio_range->range_attributes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no secure interrupts */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msix_tbl_bar !=3D -1 &&=
 range_id =3D=3D msix_tbl_bar) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
info("Skipping misx table\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msix_pba_bar !=3D -1 &&=
 range_id =3D=3D msix_pba_bar) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
info("Skipping misx pba\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>=20
>>=20
>> MSI-X and PBA can be placed to a BAR that has other registers as well.=20
>> While the PCIe specification recommends BAR-level isolation for MSI-X=20
>> structures, it is not mandated. It is enough to have sufficient=20
>> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs=20
>> altogether may leave registers unintentionally mapped via unprotected=20
>> IPA when they should have been mapped via protected IPA.
>>=20
>> Instead of skipping the whole BAR, would it make sense to determine
>> where the MSI-X related regions reside, and skip validation only from=20
>> these regions?
>
> I re-reviewed my suggestion, and what I proposed here seems wrong.=20
> However, I think there is a different more generic problem related to=20
> the MSI-X table, PBA and non-TEE ranges.
>
> If a BAR is sparse (e.g., it has TEE pages and the MSI-X table, PBA or=20
> non-TEE areas), the TDISP interface report may contain multiple ranges=20
> with the same range_id (/BAR id). In case a BAR contains some registers=20
> in low addresses, the MSI-X table and other registers after the MSI-X=20
> table, the interface report is expected to have two ranges for the same=20
> BAR with different "first 4k page" and "size" fields.
>
> This creates a tricky problem given that RSI_VDEV_VALIDATE_MAPPING=20
> requires both the ipa_base and pa_base which should correspond to the=20
> same location. In above scenario, the PA of the first range would=20
> correspond to the BAR base whereas the second range would correspond to=20
> a location residing after the MSI-X table.
>
> Assuming that the report contains obfuscated (but linear) physical=20
> addresses, it would be possible to create heuristics for this case.=20
> However, the fundamental problem is that none of the "first 4k page"=20
> fields in the ranges is guaranteed to correspond to the base of any BAR:=
=20
> Consider a case where the MSI-X table is in the beginning of a BAR and=20
> it is followed by a single TEE range. If the MSI-X is not locked, the=20
> "first 4k page" field will not correspond to the beginning of the BAR.=20
> If the realm naiviely reads the ipa_base using pci_resouce_n() and=20
> corresponding pa_base from the interface report, the addresses won't=20
> match and the validation will fail.
>
> It seems that interpreting the interface report cannot be done without=20
> knowledge of the device's register layout. Therefore, I don't think the=20
> ranges can be validated/remapped automatically without involving the=20
> device driver, but there should be APIs for reading the interface=20
> report, and for requesting making specific ranges protected.
>

But we need to validate the interface report before accepting the device,
and the device driver is only loaded after the device has been accepted.

Can we assume that only the MSI-X table and PBA ranges may be missing
from the interface report, while all other non-secure regions are
reported as NON-TEE ranges?

If so, we could retrieve the MSI-X guest real address details from
config space and map the beginning of the BAR correctly.

Dan / Yilun =E2=80=94 how is this handled in Intel TDX?

From what I can see, the AMD patches appear to encounter the same issue.

-aneesh

