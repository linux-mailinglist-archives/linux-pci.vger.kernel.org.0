Return-Path: <linux-pci+bounces-26325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28050A94C88
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 08:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F747A8117
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9A2571D0;
	Mon, 21 Apr 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldpBKxtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACA1DE2A4;
	Mon, 21 Apr 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216415; cv=none; b=GCrDNPsXUFekSpEeEqLtdjZTL5Uo/RXDJCNf+FF2R57wJstsBPmQjuQuSV241ukadBPfGjpl6Ir9MU/ZzWjv/TrgzIV2T0opjEZF2762CpIxxnB2F91HBBV6+W1BKSM5NMdLir7ODnBbGY+LBTs26sZIFc2+lOnT6bokieb1jO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216415; c=relaxed/simple;
	bh=P8Lp9HnNGaVkQwCZPxe5Q4hbGi0/3Ys00P2QGKzDXVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNjLtwr7k9/1G64iqOVsVorOM66CiszFqD+JCtjpELl3yrnioKO6nhV/kyBxwP9Ajtcg3Ts4RK6OS8uTq7O797ywyCtJ2YoXTT1BjY7Kslny3qT7gFuixnJ52uPSGMGUbLRHNrneq1CooNvzDYeyLMBZQ9ClxGTdZ+R4n4mkxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldpBKxtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E188AC4CEEC;
	Mon, 21 Apr 2025 06:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745216413;
	bh=P8Lp9HnNGaVkQwCZPxe5Q4hbGi0/3Ys00P2QGKzDXVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ldpBKxtrY5KGFegdASwEO+Xasku5arIFyuti65pbJkIDXqw77r5f751/B0HATRWnX
	 /mlM1O2VDSAbXndsj/GjG0ft44KVNlPYBiGzmpNhEluCJgoQPMFSg1LxUOyPpjTftU
	 /nbOSb/lacZHuNbNIoDdlNMUSITG19xdYYElWcCIDWO6Rgr4w6x69qyIEbG4nADfif
	 ZmLHrkK9AmgdXRAsx0gnWg12RWonqyBXXtG0w0n5MgzePrdzBzP1mtFniQTos7eMTt
	 ui0v/EzN7htbc5eLImgYPeaAxjMeeMZz7HLDTTsIsTNMRwsZNW7C80lkmUippjXhoj
	 Ij2vLKJ/dyU1w==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
In-Reply-To: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
Date: Mon, 21 Apr 2025 11:43:58 +0530
Message-ID: <yq5a7c3edot5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
>
....

> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream reg=
isters
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner =
Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings =3D to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
>

This and the similar offset caclulation below needs the EXT_CAP_ID_IDE offs=
et=20

modified   drivers/pci/ide.c
@@ -10,11 +10,13 @@
 #include <linux/bitfield.h>
 #include "pci.h"
=20
-static int sel_ide_offset(int nr_link_ide, int stream_index, int nr_ide_me=
m)
+static int sel_ide_offset(struct pci_dev *pdev, int nr_link_ide,
+			  int stream_index, int nr_ide_mem)
 {
 	int offset;
=20
-	offset =3D PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
+	offset =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	offset +=3D PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
=20
 	/*
 	 * Assume a constant number of address association resources per
@@ -66,7 +68,7 @@ void pci_ide_init(struct pci_dev *pdev)
 	nr_streams =3D min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
 			 CONFIG_PCI_IDE_STREAM_MAX);
 	for (int i =3D 0; i < nr_streams; i++) {
-		int offset =3D sel_ide_offset(nr_link_ide, i, nr_ide_mem);
+		int offset =3D sel_ide_offset(pdev, nr_link_ide, i, nr_ide_mem);
 		int nr_assoc;
 		u32 val;
=20
@@ -352,8 +354,7 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct =
pci_ide *ide)
=20
 	if (!settings)
 		return;
-
-	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+	pos =3D sel_ide_offset(pdev, pdev->nr_link_ide, settings->stream_index,
 			     pdev->nr_ide_mem);
=20
 	val =3D FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
@@ -381,7 +382,7 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, stru=
ct pci_ide *ide)
 	if (!settings)
 		return;
=20
-	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+	pos =3D sel_ide_offset(pdev, pdev->nr_link_ide, settings->stream_index,
 			     pdev->nr_ide_mem);
=20
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
@@ -406,7 +407,7 @@ void pci_ide_stream_enable(struct pci_dev *pdev, struct=
 pci_ide *ide)
 	if (!settings)
 		return;
=20
-	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+	pos =3D sel_ide_offset(pdev, pdev->nr_link_ide, settings->stream_index,
 			     pdev->nr_ide_mem);
=20
 	val =3D FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
@@ -434,7 +435,7 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struc=
t pci_ide *ide)
 	if (!settings)
 		return;
=20
-	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
+	pos =3D sel_ide_offset(pdev, pdev->nr_link_ide, settings->stream_index,
 			     pdev->nr_ide_mem);
=20
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);



> +
> +	val =3D FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val =3D PREP_PCI_IDE_SEL_RID_2(settings->rid_start, ide_domain(pdev));
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
>

....

> +/**
> + * pci_ide_stream_enable() - after setup, enable the stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner =
Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control Re=
gister.
> + */
> +void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings =3D to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
> +
>
> +	val =3D FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
>

Does enabling pdev->ide_tee_limit here will prevent a device from operating=
=20
as expected before we get to TDISP RUN state?=20

TEE-Limited Stream =E2=80=93 When Set, requires that, for Requests, only th=
ose that have the T bit Set are
permitted to be associated with this Stream


> +	      FIELD_PREP(PCI_IDE_SEL_CTL_EN, 1);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> +
> +/**
> + * pci_ide_stream_disable() - disable the given stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner =
Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings =3D to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos =3D sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
>

here

> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);


-aneesh

