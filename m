Return-Path: <linux-pci+bounces-34612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCDB3216F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B43AA8308
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D427CB04;
	Fri, 22 Aug 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6S4ns3I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1993235355;
	Fri, 22 Aug 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883250; cv=none; b=kSMsiGvKXnnXw6COcPJBXzfETWOkrw9q43Om6cfnVh2h/s1Si/gKcfqBBrDCnN/81Xrbq8gESEcDBzJnRS6jJXfY3uT7cL9sb3IfUyo41HjAmxv5iVQqzoFqh3/tEOW95MAVr6HOwp0Lcxmq64Io7AZfbYZtBTfjCz2+ZaOfH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883250; c=relaxed/simple;
	bh=OnWyIqS1IwZagUDq5QHd0lxIlcBzULMwktA4A6aD7Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iXf7Datjl6I7J1lc/sSyhTH0SU6pq6sAscG6ZxpGqmv8Sa9onT4PopWfbzodVVz0+FJ5921Hrd6K1uoenWv5vqTtx0wKeNoLRHqiT2UuPVIB6LSD+FKmVypo6Aks3OTWXPOmWMwmd8gKI2rH86V3SR3FXOphUn3Yt7mbPbRPHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6S4ns3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5224AC4CEED;
	Fri, 22 Aug 2025 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883249;
	bh=OnWyIqS1IwZagUDq5QHd0lxIlcBzULMwktA4A6aD7Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g6S4ns3IMeuZvHVo4dNEQgx9QjTJ13jY9bQQPvAWsQLXQW8eCTt0QlQu7DrWkhkPy
	 R7iG2Uj+v+gZV1wSXidZgHkhER+ZZhzNC4ogRde5oG9Zq7jM7cZVV3fta/a/DkExQl
	 YqJeAce7lPxkLbfRydUdqoamvl60ng2ScbsmXjQdrKNAK862DOmLeC8kLF9nDlddoj
	 OLE9/urHUi0sNlTES/WtQl99dfh0Vp7WkngSPhR8u9yWpWzNkw76cCv+1p9r9w/jeg
	 vF8nlTSa7rC/ZaoRPFAJfSgeCe5dsHoSYX8cU4EPabopJhfSaz52jOotbxFK+GDQ8z
	 zsLj0Xn55whXQ==
Date: Fri, 22 Aug 2025 12:20:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mahesh@linux.ibm.com,
	oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, linmiaohe@huawei.com,
	shiju.jose@huawei.com, adam.c.preble@intel.com, lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com, dan.j.williams@intel.com,
	feiting.wanyan@intel.com, yudong.wang@intel.com,
	chao.p.peng@intel.com, qingshun.wang@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 1/2] PCI/AER: Clear UNCOR_STATUS bits that might be
 ANFE
Message-ID: <20250822172047.GA689409@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620025857.206647-2-zhenzhong.duan@intel.com>

On Thu, Jun 20, 2024 at 10:58:56AM +0800, Zhenzhong Duan wrote:
> In some cases the detector of a Non-Fatal Error(NFE) is not the most
> appropriate agent to determine the type of the error. For example,
> when software performs a configuration read from a non-existent
> device or Function, completer will send an ERR_NONFATAL Message.
> On some platforms, ERR_NONFATAL results in a System Error, which
> breaks normal software probing.
> 
> Advisory Non-Fatal Error(ANFE) is a special case that can be used
> in above scenario. It is predominantly determined by the role of the
> detecting agent (Requester, Completer, or Receiver) and the specific
> error. In such cases, an agent with AER signals the NFE (if enabled)
> by sending an ERR_COR Message as an advisory to software, instead of
> sending ERR_NONFATAL.
> 
> When processing an ANFE, ideally both correctable error(CE) status and
> uncorrectable error(UE) status should be cleared. However, there is no
> way to fully identify the UE associated with ANFE. Even worse, Non-Fatal
> Error(NFE) may set the same UE status bit as ANFE. Treating an ANFE as
> NFE will reproduce above mentioned issue, i.e., breaking software probing;
> treating NFE as ANFE will make us ignore some UEs which need active
> recover operation. To avoid clearing UEs that are not ANFE by accident,
> the most conservative route is taken here: If any of the NFE Detected
> bits is set in Device Status, do not touch UE status, they should be
> cleared later by the UE handler. Otherwise, a specific set of UEs that
> may be raised as ANFE according to the PCIe specification will be cleared
> if their corresponding severity is Non-Fatal.
> 
> To achieve above purpose, cache UNCOR_STATUS bits that might be ANFE
> in aer_err_info.anfe_status and clean them in pci_aer_handle_error().
> aer_err_info.anfe_status will also be used to print ANFE related bits
> in following patch.
> 
> For instance, previously, when the kernel receives an ANFE with Poisoned
> TLP in OS native AER mode, only the status of CE will be reported and
> cleared:
> 
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
> 
> If the kernel receives a Malformed TLP after that, two UEs will be
> reported, which is unexpected. The Malformed TLP Header is lost since
> the previous ANFE gated the TLP header logs:
> 
>   PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00041000/00180020
>      [12] TLP                    (First)
>      [18] MalfTLP
> 
> To handle this case properly, calculate potential ANFE related status bits
> and save in aer_err_info. Use this information to determine the status bits
> that need to be cleared.
> 
> Now, for the previous scenario, both CE status and related UE status will
> be cleared after ANFE:
> 
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
> 
>   PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00040000/00180020
>      [18] MalfTLP                    (First)
> 
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This no longer applies cleanly; would you mind rebasing it to pci/main
(v6.17-rc1)?  There have been recent AER changes; if they affect the
dmesg text, could you update that as well?

> +static void anfe_get_uc_status(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	u32 uncor_mask, uncor_status, anfe_status;
> +	u16 device_status;
> +	int aer = dev->aer_cap;
> +
> +	/*
> +	 * To avoid race between device status read and error status register read,
> +	 * cache uncorrectable error status before checking for NFE in device status
> +	 * register.

I can't tell for sure from the patch, but if this doesn't fit in 80
columns, can you rewrap it so it matches the rest of the file?

> +	 */
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor_status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &uncor_mask);
> +	/*
> +	 * According to PCIe Base Specification Revision 6.1 Section 6.2.3.2.4,
> +	 * if an UNCOR error is raised as Advisory Non-Fatal error, it will
> +	 * match the following conditions:
> +	 *	a. The severity of the error is Non-Fatal.
> +	 *	b. The error is one of the following:
> +	 *		1. Poisoned TLP           (Section 6.2.3.2.4.3)
> +	 *		2. Completion Timeout     (Section 6.2.3.2.4.4)
> +	 *		3. Completer Abort        (Section 6.2.3.2.4.1)
> +	 *		4. Unexpected Completion  (Section 6.2.3.2.4.5)
> +	 *		5. Unsupported Request    (Section 6.2.3.2.4.1)
> +	 */

Could you update the citation to PCIe 7.0, please?

Bjorn

