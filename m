Return-Path: <linux-pci+bounces-17979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE99EA631
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 04:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE1166E8C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43E1A23AC;
	Tue, 10 Dec 2024 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3CE7NTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E92AEFE;
	Tue, 10 Dec 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800146; cv=none; b=H92elp1B+Im2JENN8xvGWIObwsK9QgT4iuKI2OtiPbMa1xQIrliGhtZWQy/VtRYisGVe+nZLdv1SXd53Tz6ip7W+dIbG5fm9O1KXTIucXSlcZjTQiSmjbVE6D1np7vl+HXBgYPp5EK6iwoIofd2FvYBA7HfxgTObCF2IqezTs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800146; c=relaxed/simple;
	bh=fRBFQhB6QMKXvrtlcZeTgwu2qXuKjOlUlZoDsmJzRGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RArrFY/WfQWtGIHn2xUCHph7oKvliGrv6k4Y4G9xycCDkszoiNYWaf403VI+84P8RRYq9IhzvLcEpD5f+2/fh405BaJgxvDfpucrik0UsP74gbpleogbx+9AaKL97tYooQTdCL1PxixNirPkO1i2SH2q3tuW6UJz0EDZyRfALx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3CE7NTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61FC4CEDE;
	Tue, 10 Dec 2024 03:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733800145;
	bh=fRBFQhB6QMKXvrtlcZeTgwu2qXuKjOlUlZoDsmJzRGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u3CE7NTzC7PAIt9sg8bMNz65KwxdJTXDcO/QfymQ2sw2WIh7E7EysPfdwcvbvWNMH
	 XR+dHtGANAFD6tJ5bKZmZ4hevRVvypWgXB9Zm9tL57rEB6njd5biV1kGgTM7sstjY9
	 /4GwKQY4pwR4PdSXYTY52D2r2ectoP5TRhuaEZLIfFGtx8TQj2xEsjB2aPE/+VB50i
	 8kCLLs1RogH1mg3/bNvE/zPEhZMWb2DmDKxFC9+7KWKtb/Rpq2rloXYH5Ce3qSZTSp
	 XXjubVgrcO/aERGUYFzlNd0/Q0UbZ703ICoYpdzs46OycFxnF0y/WDIGofeqJxZ/aR
	 gpT+e7CsSvF6A==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
In-Reply-To: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
Date: Tue, 10 Dec 2024 08:38:57 +0530
Message-ID: <yq5a34iw1bg6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Dan,

> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */

Should this be

#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	((((x) >> 16) & 0xff) + 1) /* Selective IDE Streams */

We do loop as below in ide.c

	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
		if (i == 0) {
			pci_read_config_dword(pdev, sel_ide_cap, &val);
			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);

-aneesh

