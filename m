Return-Path: <linux-pci+bounces-35330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CBB408A8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9141B624FB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4149279DDD;
	Tue,  2 Sep 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzJcHukk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFA1DE2A0;
	Tue,  2 Sep 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826021; cv=none; b=Y7xDI0kNHdOrP2IxQHITgaTWDO7ahKdjmx/8qSRFiLLN+LdijXv59rw1gbDn2ZIXUfWw9A5f+GDAEOSH4BC7PKt0aOW5hebZIylTbEv/RQnKT1mEr/cg3fik3BOsslN/7eztzyrxn7NQrnHSOrTDSTDB/CI4bzV3RUhyr3yVEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826021; c=relaxed/simple;
	bh=HXGTvga+Rkz8JZnkpZvHAshovD8aQsM3iEO3r5KelSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g6xH2ru+ShFZ+Td/GpTNPxIEd2aOCZKbps24luCwlj5WHniIhCnHGem7UAHd/r6c/IhI26IPgQNY8/JXrLzekX3lZ4Qc62beEUKqaGvS9wXX3YZuSv8Y4HW+OEi/eLBmr8mczYamHHgYROEff+O+rhgxUQqrF0if0otM686IOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzJcHukk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C81C4CEED;
	Tue,  2 Sep 2025 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756826021;
	bh=HXGTvga+Rkz8JZnkpZvHAshovD8aQsM3iEO3r5KelSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VzJcHukkjHN5GcWLpZe0SV/Gi/s2T3cxMmzDe1u8tBt0R5gQyVoY3Z07qLI7aYOQO
	 0WL9bIp+b4YKROHjQGZzq+6sPRdWxdgTYXbtjuVaOPaR5vVnEVZ7XM0B1HVkd2Sore
	 bLPh92PbGLjL7svj2Nsg1NYO4q73KXSre65g4Zmjqm95M1VHrVlWO1RbtL+rSkF3B6
	 C09XjwJMnIC/oFF0ktv4UZ4/GPcGY81A6PezZu+ZsyziXTzxfPHvqWpGmPzfwb2gre
	 PPfK/58SMQvzd4ESFP5qmVrrnGAga9e8D/Zhj3uL0o4VOASbeZ1d2ajkvtbV/LrMkE
	 1JPitdRKKe8oQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aik@amd.com, gregkh@linuxfoundation.org,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
Date: Tue, 02 Sep 2025 20:43:32 +0530
Message-ID: <yq5a1poo3n1f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

....
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> + * @dsm: PCI Device Security Manager for link operations on @pdev
> + * @ops: Link Confidentiality or Device Function Security operations
> + *
> + * This structure is wrapped by low level TSM driver data and returned by
> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
> + *
> + * For link operations it serves to cache the association between a Device
> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
> + * That can be "self", for assigning function0 of a TEE I/O device, a
> + * sub-function (SR-IOV virtual function, or non-function0
> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
> + * DSM).
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +	struct pci_dev *dsm;
>

struct pci_dev *dsm_dev? 


> +	const struct pci_tsm_ops *ops;
> +};
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> + * @base: generic core "tsm" context
> + * @lock: mutual exclustion for pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm base;
>

struct pci_tsm base_tsm ?

> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};
> +


Both the above will help when we have names likes

dsm->pci.base.pdev; vs dsm->pci.base_tsm.pdev;

and tsm->dsm vs tsm->dsm_dev


-aneesh

