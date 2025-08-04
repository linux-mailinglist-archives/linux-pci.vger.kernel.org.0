Return-Path: <linux-pci+bounces-33346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3DBB19BA8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865391691BE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486D22AE65;
	Mon,  4 Aug 2025 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F93+omvJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F021CA04;
	Mon,  4 Aug 2025 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289459; cv=none; b=XHKgalt3PcyJcWasEMEr9GfwfCvDZWIKfY8HVoiJoSUHUw32/uCNvjJfXgkswRY9/64+JmOS4U+EgHc6U/mGp1BycBumjFm2m7cpalpi5Q3J+aFCSWZkRTvIGjHWDfn3d+K1eQ7fIfPHP1651BwSWBJj+J6sGqw02Ws+LF/5E+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289459; c=relaxed/simple;
	bh=TvtCydpyP+2SRqXbmOoGwrTxbWE+LSTytKIAEhbyUbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ef7jPxolmlQT+AwJwqHGno3EBtFGJgCsuDA8i0j5+itxn5qS5WbHJ5lxTCHXZ5quPG5TmY31rjN5ieFvJiXnMbGBux/YKR9VUcov2zEPIdToHIjXJkww2Q8yBZw9AtgVzBXntsK57QRs6Qcd3LCrH/KWH1gjUVIpZUj2ywHXGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F93+omvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9172CC4CEE7;
	Mon,  4 Aug 2025 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754289457;
	bh=TvtCydpyP+2SRqXbmOoGwrTxbWE+LSTytKIAEhbyUbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F93+omvJ3lMAguvUh/zkgrZ1bWn27qcBW1Ejscm63WvcTsIFj5+jdY+Uq6k39qimq
	 gNr3EtUfq8J2liZ6cx0jRr4QqHGuZApPNntmZt7xEXZPA0XL43ktJTPpSfDcSy3duz
	 r2U16oMApx6NbxAEe/4UVDhtJH/F9YviOF26ZTkt9pxz0Bjv4lhAKUcl/bkQU/GB2X
	 yR/WfXphakKrVcQSFxf+R/uqnHZ4Ih7FGXK7V12gnsjuGwZjwkortGfd2Ft04v4R8c
	 OPMtutDZg/+AT5byBS0Unty7S4vNKh5HQgF9VgzKuwNies8N9TDkFppFRkDUw0Sj4K
	 SazAOCa9mrzAA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
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
In-Reply-To: <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
 <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
Date: Mon, 04 Aug 2025 12:07:29 +0530
Message-ID: <yq5aqzxr8udy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arto Merilainen <amerilainen@nvidia.com> writes:

> On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:
>
>> +	for (int i =3D 0; i < interface_report->mmio_range_count; i++, mmio_ra=
nge++) {
>> +
>> +		/*FIXME!! units in 4K size*/
>> +		range_id =3D FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->ran=
ge_attributes);
>> +
>> +		/* no secure interrupts */
>> +		if (msix_tbl_bar !=3D -1 && range_id =3D=3D msix_tbl_bar) {
>> +			pr_info("Skipping misx table\n");
>> +			continue;
>> +		}
>> +
>> +		if (msix_pba_bar !=3D -1 && range_id =3D=3D msix_pba_bar) {
>> +			pr_info("Skipping misx pba\n");
>> +			continue;
>> +		}
>> +
>
>
> MSI-X and PBA can be placed to a BAR that has other registers as well.=20
> While the PCIe specification recommends BAR-level isolation for MSI-X=20
> structures, it is not mandated. It is enough to have sufficient=20
> isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs=20
> altogether may leave registers unintentionally mapped via unprotected=20
> IPA when they should have been mapped via protected IPA.
>
> Instead of skipping the whole BAR, would it make sense to determine
> where the MSI-X related regions reside, and skip validation only from=20
> these regions?
>

Yes, that was added because at one point the FVP model was including the
MSI-X table and PBA regions in the interface report.

If I understand correctly, we shouldn't expect to see those regions in
the report unless secure interrupts are supported. The BAR-based
skipping was added as a workaround to handle the FVP issue.

I believe we can drop that workaround now=E2=80=94if those regions are
incorrectly present, the below validation logic should catch and
reject them appropriately. Does that sound reasonable?

		/* No secure interrupts, we should not find this set, ignore for now. */
		if (FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attribut=
es) ||
		    FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes)) {
			pci_info(pdev, "Skipping MSIX (%ld/%ld) range [%d] #%d %d pages, %llx..%=
llx\n",
				 FIELD_GET(TSM_INTF_REPORT_MMIO_MSIX_TABLE, mmio_range->range_attribute=
s),
				 FIELD_GET(TSM_INTF_REPORT_MMIO_PBA, mmio_range->range_attributes),
				 i, range_id, mmio_range->num_pages, r->start, r->end);
			continue;
		}


-aneesh

