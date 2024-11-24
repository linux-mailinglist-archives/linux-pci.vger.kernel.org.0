Return-Path: <linux-pci+bounces-17245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C845D9D6D5B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567EDB20FA4
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FFA14AD2D;
	Sun, 24 Nov 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH2EVsJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EC33987;
	Sun, 24 Nov 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732442201; cv=none; b=kwbDud8E3L+z6QKR7pP6CUS8Z4nV1Dz0hVjkrIuXdUdnPCAsjOjZc6mFvJt3xZUR0o7puv/ODHEVSZgTEP1aUFSynQH3ycZUV5fuy2U4zFRIhrCnotq7umpp+inMaBwAyllKAE/3Lgj18gNrpSvgU52CamspP7QBTfWb0UFEvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732442201; c=relaxed/simple;
	bh=FtzR8QfDziwOhvMSs+hEciy3op5O9l9NexN6HGEXINU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pB+wtr2zqrULM2+voyZ0HVo6EG/J63TVJqAId7CJujzak4pD63BOREZjEX/e+R9uCKU4c2Mku+PMfOMQNudfZAmGHCcxLypoo0CEmLhzXQcHt7H4VdNETujYt0dVfOQ55u8+RA+cDcRior674kCYuwlysFn1gxYXYu5CsBdK6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH2EVsJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0F0C4CECC;
	Sun, 24 Nov 2024 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732442200;
	bh=FtzR8QfDziwOhvMSs+hEciy3op5O9l9NexN6HGEXINU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CH2EVsJ+3DLtocLj3hzQF/BkwbSDoPw4qXznAW/a864sb3SRocV79ZZbt1Yu9x7FR
	 +dBb4hhB3CiyRtE3NeDbzbNEEXNClNvsX1p3dzmutxrSiWLyhqb7tLFIHiG5Ix6y6W
	 4WMEp7m5SVg/A8enQyqS7y6EBbzi8gzXQJvD2HgVv8wWFbpXdUHJZ7UqfqsLuz5H9z
	 OCMVgS91Y3FaQWsFa6fKdlY6tt/iDZnWP8c8aAcoP6SB6T2Ztc5ppQC3HQS/aG5uSs
	 Wslv6kOxZ5GF/SrhoJ7uiZtMqTV0KECJ/j1jDDHcjY1u2fAGVLxVY3EdKhJQZLtmzU
	 SgYRe8X9bDGnw==
Date: Sun, 24 Nov 2024 10:56:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Li <Frank.Li@nxp.com>
CC: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_2/6=5D_PCI=3A_endpoint=3A_Add_RC-to-EP?=
 =?US-ASCII?Q?_doorbell_support_using_platform_MSI_controller?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241124071100.ts34jbnosiipnx2x@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com> <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com> <20241124071100.ts34jbnosiipnx2x@thinkpad>
Message-ID: <113B93C0-8384-431A-BE4D-AA98B67C342A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24 November 2024 08:11:00 CET, Manivannan Sadhasivam <manivannan=2Esadh=
asivam@linaro=2Eorg> wrote:
>On Sat, Nov 16, 2024 at 09:40:42AM -0500, Frank Li wrote:
>> +static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf =
*epf)
>> +{
>> +	struct device *dev =3D epc->dev=2Eparent;
>> +	u16 num_db =3D epf->num_db;
>> +	int i =3D 0;
>> +	int ret;
>> +
>> +	guard(mutex)(&epc->lock);
>> +
>> +	ret =3D platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_=
write_msi_msg);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your =
DTS\n");
>
>No need to mention 'msi-parent'=2E Just 'Failed to allocate MSI' is enoug=
h=2E

If you look at the existing pcie_ep device tree nodes for all SoCs, you wi=
ll see that it is very rare to see an EP node which specifies msi-parent=2E

I guess that makes sense, since before this series, AFAICT, msi-parent was=
 completely unused, so there was no need for an EP node to specify it=2E

I'm okay to change the error print as you suggested, but in that case I re=
ally think that we should add a comment above the check, something suggesti=
ve like:

/*
 * The pcie_ep DT node has to specify
 * 'msi-parent' for EP doorbell support to work=2E
 * Right now only GIC ITS is supported=2E
 * If you have GIC ITS and reached this print,
 * perhaps you are missing 'msi-parent' in DT?
 */
if (ret) {
        dev_err(dev, "Failed to allocate MSI\n");
        return -ENODEV;
}


Kind regards,
Niklas

