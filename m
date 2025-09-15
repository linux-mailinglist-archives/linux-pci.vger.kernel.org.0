Return-Path: <linux-pci+bounces-36181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FBB581D4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D247A3ACC80
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033521FF44;
	Mon, 15 Sep 2025 16:18:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39B2A1BA
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953097; cv=none; b=MmhNW4kNOhuwhtrUCkHYfF0GnJGeGNgW+wJGRZqB4OZD35RYRW7DB/MR4M3i3cGpha8aMJydRRKrTeJt13RykXD7+fiWxEYgl1B24T+s1yqOyira4z/xpK/Q5SF6sctgmy+nKAuxrpvN0UjMjCAl09cIbIPl8eyEesMGSxrJJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953097; c=relaxed/simple;
	bh=wCz/AenI5uA2gCey+sA7IT9jqagqqj1cCp9mevvbQfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRB5UT6UmtKGT9NfoYPUa40yUsC11Pxgeik+4BIoB84cIo+6bM84+3F3A7Rc874ktK0LRB9tdJPsYpgZqO1AbItweThCVOP3nGMzyIV/535IRPHEhJCiLlTTuDBl9+Cam9TjKbr8x6oaMCNbrNoogc/Xkzm3C898dLdUCJSS8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQVXY1wcNz6GD9V;
	Tue, 16 Sep 2025 00:16:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DCA78140137;
	Tue, 16 Sep 2025 00:18:12 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 18:18:12 +0200
Date: Mon, 15 Sep 2025 17:18:10 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250915171810.00003212@huawei.com>
In-Reply-To: <20250827035126.1356683-3-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
	<20250827035126.1356683-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:51:18 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Some very very trivial things inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..05ab8c18b768
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,92 @@

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
> +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);
> +	else
> +		nr_link_ide = 0;
> +
> +	nr_ide_mem = 0;
> +	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
> +			 CONFIG_PCI_IDE_STREAM_MAX);
> +	for (u8 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +		int nr_assoc;
> +		u32 val;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +
> +		/*
> +		 * Let's not entertain streams that do not have a
> +		 * constant number of address association blocks
constant fits on the line above and I can't immediately see a reason to wrap early.

> +		 */
> +		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM, val);
> +		if (i && (nr_assoc != nr_ide_mem)) {
> +			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
> +			nr_streams = i;
> +			break;
> +		}
> +
> +		nr_ide_mem = nr_assoc;
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f5b17745de60..911d6db5c224 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h


> +
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		0x00
> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)

This one is a field so one more space needed




