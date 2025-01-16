Return-Path: <linux-pci+bounces-19986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17582A13F19
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FE73A1800
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F222ACEB;
	Thu, 16 Jan 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PS7jHmJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F981E47A5;
	Thu, 16 Jan 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044335; cv=none; b=YI7Gj9d1cQSk4cZjcvsr9QRZvEFzFUPx94h+QDPtkzTFjp92R2X/y8CeE/5Mbo+dcDLS25QWGVr6st0jFUeYBj9cuDdJan6HiR0P1j+os9KOKE06Stb3jP09u+PPLsoN68SMUNErgFXH7gGKjOlI27CoaPVeKjvEOtQMigIAL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044335; c=relaxed/simple;
	bh=UPzmhNPcISlwpf+nYQWlTcH49RPS6VRulaGCccAz1e8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uIB7mg3jdM7mrR0sWSo16icWVAhKN3Y0W0A2QZXQ1bmvvI3TjWUs9BBeN3ob+fFQh3uG+eI8j5prhSQ/6kA7bZk5StTpe2qWGxeT2VD3wn53REu/w+vJPVeiV+03y5IkzHsl/bWErTyh9gf+lH3caVmflHH3xMNyWGpaS7Ofpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PS7jHmJ2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737044334; x=1768580334;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UPzmhNPcISlwpf+nYQWlTcH49RPS6VRulaGCccAz1e8=;
  b=PS7jHmJ2W/cg6iPwj2hUH6aIIonG3R2W2jJAgTZJGE2H7sN/YB2qBVRf
   kwBIm+nwdTd3M3hcxPEbg4/EqhoCXhn8Rrkl7TSOcsynDvuTQrBvwzMCF
   RYaEMpp3snrWtXBBHn1zBOMCQAv8iT/A2Uds4AkylsBM6wfBVmJ3jq/uW
   lIqzQlZb3dy8sVI3uoffbSJVcOGiLsr3faqz0EMg4JPyHS+bQoJLL5QM6
   CesU0+uWYd2a6Hxtt96P0D5d+tHmqyNMyNcfjPHjdQfmhtVinbmLUivE9
   VgOMeQL6dKcDNbvyIpCf6+E4PSSwWjfGGaTX++2u/Uqd0HLrEWRbbz0BI
   A==;
X-CSE-ConnectionGUID: trBBDLe/SpS/6hyy1Z+jMg==
X-CSE-MsgGUID: JRSdOSGASrC7mLMuqLwjJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48444394"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48444394"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:18:53 -0800
X-CSE-ConnectionGUID: lf6InI33Tk+fHW8DI/pMVw==
X-CSE-MsgGUID: Psc2HZD5RzmAlVHwaAmUAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106076705"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.116])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:18:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Jan 2025 18:18:47 +0200 (EET)
To: "Colin King (gmail)" <colin.i.king@gmail.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: PCI: Add TLP Prefix reading to pcie_read_tlp_log()
In-Reply-To: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
Message-ID: <de2a07a1-ea99-20d7-69c5-8fdf2f432750@linux.intel.com>
References: <a2f75da3-7065-4592-aa64-5e3590ce5f91@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1807185795-1737044327=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1807185795-1737044327=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 Jan 2025, Colin King (gmail) wrote:

> Hi,
>=20
> Static analysis shows there is a potential issue in the following commit:
>=20
> commit 00048c2d5f113bb4e82a0a30dfc4ee12590b81f5
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Tue Jan 14 19:08:39 2025 +0200
>=20
>     PCI: Add TLP Prefix reading to pcie_read_tlp_log()
>=20
>=20
> The issue is described as follows:
>=20
> unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
> {
>         return PCIE_STD_NUM_TLP_HEADERLOG +
>                (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
>                dev->eetlp_prefix_max : 0;
> }
>=20
>=20
> static analysis is warning that the left hand size of the ? operator is a=
lways
> true and so dev->eetlp_prefix_max is always being returned and the 0 is n=
ever
> returned (dead code).
>=20
> I suspect the expected behaviour is as follows:
>=20
>         return PCIE_STD_NUM_TLP_HEADERLOG +
>                ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
>                dev->eetlp_prefix_max : 0);
>=20
> ..I'm reluctant to send a fix in case this is not the original intention.

Your fix looks correct, it should have the parenthesis due to operator=20
precedence rules. The intention is to calculate 4 DWs + optionally n E-E=20
TLP prefixes.

--=20
 i.

--8323328-1807185795-1737044327=:933--

