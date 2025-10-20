Return-Path: <linux-pci+bounces-38767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A4BF219E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 153604FA71B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4626A088;
	Mon, 20 Oct 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUhV9gRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9026A0C7
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973932; cv=none; b=CgHbDpgWGAq3C6qFSW/3wW8Ng6Sqgx6019Mfu6kUG3W4TDloaXYQeknEM8YybuKoDtIRQ4gjrRgDP+59JV4XO2Bk++reCQZ6rYBLqXmHlaneMSH0ooCDKPz8b4byCpGwA39pYZmpy32DOQhXxYgI0wgnyhkPQMdTfmeKgWcULR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973932; c=relaxed/simple;
	bh=18mpGiI+om3OE7kjPWuVpgEvn4Rq4kDIfZpfksoHEhw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VxpbERtOVvg1zmwMBuuwzUdKS584Kq/goBX03M8VJcluMVIoIcIh6j+ygwt9g/dgF56xJH819mOuvDvxdu69VF/5pssmBtL3L0eSY2UnJIAcs9/WleaD160iJaRlve6e3AayAv9JseVU4Mll5cbNmbF/8D1T1YgXIn45OfiDf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUhV9gRm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760973930; x=1792509930;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=18mpGiI+om3OE7kjPWuVpgEvn4Rq4kDIfZpfksoHEhw=;
  b=FUhV9gRmmjuYgv5wRA+9q1pW0MzRdf6DH/fdrTvn1BDbeH06/niKPZ9u
   sKDRq56edgYhSZplrcsjkIt44Mwq3AwXjf1jYvG1BfbjyTK1J8Rp7FLDx
   IQS9Hmzzlll1eECgPVZW+hAMIE1njaAjUXu3kSo9rPZ0HYhA5UBcWW7jK
   a3wpkXCmWgKxsZbLCgbEfKe5EKB5I3Jh640YtbAtn2sBBnUrw8QdS1nUl
   SluKPMjq1rF2O1XNLha+uNr4KqT3ohBRRiRgnsp/YDIkfW2WCe1HMIz9t
   YVQKuJ9dNnFS4RAxOMqOt9rOaMq4TTTQhpZQBnvsBZYAyAhcEHqDRKvNj
   A==;
X-CSE-ConnectionGUID: Uahz95wbTsyRgU1ApRVAWA==
X-CSE-MsgGUID: Y7d+FqMiRFKsogOXehKqxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63130683"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63130683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:25:29 -0700
X-CSE-ConnectionGUID: EGK3hb6ZQGqcqM64h5YkTQ==
X-CSE-MsgGUID: mGuTEZPQRsamIxHHMsy/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="220504385"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:25:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 18:25:23 +0300 (EEST)
To: weipengliang <weipengliang@xiaomi.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Avoid restore error L1ss cap.data to parent
 downstream PCIe port
In-Reply-To: <20251020023658.2294-1-weipengliang@xiaomi.com>
Message-ID: <aecefbfa-6500-8390-1d5f-e9454b57219e@linux.intel.com>
References: <20251020023658.2294-1-weipengliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Oct 2025, weipengliang wrote:

> The function pci_restore_aspm_l1ss_state will restore L1ss cap.data

Please add () after any function name. You can ten remove "The function" 
as it's obvious (or at least place "function" word after its name if you 
want to still write "The xx() function").

> in the upstream resume flow, to both downstream & upstream port.
> When the upstream port is suspended and the suspend flow is interrupted,
> the downstream port has not been suspended yet, so the L1ss cap.data is
> not correct.

What interrupts it, where? Both upstream and downstream port L1SS config 
are saved in the upstream port's pci_save_aspm_l1ss_state() so if upstream 
port is already suspended, why wasn't the downstream port's L1SS saved?

> Expectially the first Suspend/Reusme flow, the downstrem

Resume

downstream

> L1ss cap.data will be initialize to zero.
> When the Suspend/Resume flow is interrupted the time between

Please don't use "Suspend/Resume flow" like this. Both are not 
interrupted.

> upstream port has suspended but the downstream port hasn't,
> it will restore zero to the downstream port in the
> upstream port Resume flow.

This seems to repeat what was said in the earlier sentence, what is the 
difference or should the duplicate be removed?

The structure too here needs improvements. Please first state the issue, 
then explain the solution.

> Signed-off-by: weipengliang <weipengliang@xiaomi.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7cc8281e7011..173e0eb10b0d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -97,6 +97,9 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  	if (!pdev->l1ss || !parent->l1ss)
>  		return;
>  
> +	if (!parent->state_saved)

There disconnection from the changelog's text to this check.

This is pci_save_aspm_l1ss_state(), not restore.

I'm also not convinced parent->state_saved is a robust indicator of what 
has been saved as ASPM config is saved at a different time than when rest 
of ->state_saved is set. We were bitten by this difference in timing 
earlier.

Not directly related to this patch, perhaps dev->state_saved = true; in 
pci_save_state() should be moved as the last line before return to avoid 
claiming state is saved before it truly is 100% saved.

> +		return;
> +
>  	/*
>  	 * Save L1 substate configuration. The ASPM L0s/L1 configuration
>  	 * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
> 

-- 
 i.


