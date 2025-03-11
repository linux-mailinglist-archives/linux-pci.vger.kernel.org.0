Return-Path: <linux-pci+bounces-23402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519DCA5B89A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 06:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70997A858A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 05:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D418E2A;
	Tue, 11 Mar 2025 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W10dhvY5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA0136A;
	Tue, 11 Mar 2025 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672006; cv=none; b=S38G3tkChlP484bJFC6gvR8bO7W8RSBIH7V3YA4CXy3QA7t5ZG4z8dkfbWHXIsTWwTH+3DU4sHANqJYfTP5JGmJ0kWd17M7F9pR2ZjE1JS1i+yBMKKppOCjywV1qYpy6hmX63T5BqCxgeOfmPYAEuuH7G+DT/Qtv3ogGCx6HLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672006; c=relaxed/simple;
	bh=3ULogyWb8Dngj6/Jr3OP3dgy5AOMuMHoSTh+ADiK7XQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FuufvzVXDdx2OTTD9Bn3y27GAkmA0PvbSP7muzy//6UgwchGD/0GBokAUixiVq3VnlcxWVT9hZhcR5PkthUU2kBFes3F1UVwpF2puCJ5zeEQ4xzUlr4LJ46qtczhkc9b+yMQHNy78TBGDGVOh4UZNv/Wr0k71vHavLhLOpvgMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W10dhvY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57D3C4CEE9;
	Tue, 11 Mar 2025 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741672005;
	bh=3ULogyWb8Dngj6/Jr3OP3dgy5AOMuMHoSTh+ADiK7XQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W10dhvY5+KQbrW0AQU2MJtzPo+ZZntSAgJS+tWjSKt7uKGwBsFdhd1P9sExi8966T
	 JTr769bWv9SMY8UffN44bDEovsZbe9aCgGdTqemZvgqNs7LZ9GuTAjize4IbItHthI
	 wzfZKAE0b2fIPUCj6FUzn6a/Enww+yHxDUah72lJYFS+zOS6zakad1TdJSAWLcxmIZ
	 MV/6JH4sKZkpZAl/82YHcaMHmvnZMszpxp7cF5Vj2fTVwocAnxfcFw9j2v9nTXFW/y
	 pB6vVWzh1N0c64YB8OxdzxnOWyqASUBeVgzxK7ojYxxQNn3qYvuV0RrK5xjgBBolOZ
	 8n3pQGxYzeyeA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexey Kardashevskiy <aik@amd.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Subject: Re: [PATCH v2 04/11] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
In-Reply-To: <174107247873.1288555.8934248700370548272.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107247873.1288555.8934248700370548272.stgit@dwillia2-xfh.jf.intel.com>
Date: Tue, 11 Mar 2025 11:16:38 +0530
Message-ID: <yq5aa59sglvl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

.....

> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u8 nr_link_ide, nr_ide_mem, nr_streams;
> +	u16 ide_cap;
> +	u32 val;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	/*
> +	 * Require endpoint IDE capability to be paired with IDE Root
> +	 * Port IDE capability.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_SEL_CFG)
> +		pdev->ide_cfg = 1;
> +
> +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> +		pdev->ide_tee_limit = 1;
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM_MASK, val);
> +
> +	nr_ide_mem = 0;
> +	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
> +			 CONFIG_PCI_IDE_STREAM_MAX);
> +	for (int i = 0; i < nr_streams; i++) {
> +		int offset = sel_ide_offset(nr_link_ide, i, nr_ide_mem);
> +		int nr_assoc;
> +		u32 val;
> +
> +		pci_read_config_dword(pdev, ide_cap + offset, &val);
> +
> +		/*
> +		 * Let's not entertain devices that do not have a
> +		 * constant number of address association blocks
> +		 */
> +		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM_MASK, val);
> +		if (i && (nr_assoc != nr_ide_mem)) {
> +			pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
> +			return;
> +		}
> +
> +		nr_ide_mem = nr_assoc;
>

What is the purpose of the loop? Should it use the minimum value to
ensure we select the lowest supported value for all selective IDE
stream? I assume that, in practice, the number of address association
register blocks will be the same for all selective streams?

                 nr_ide_mem = min(nr_ide_mem, nr_assoc);

> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}


-aneesh

