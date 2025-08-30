Return-Path: <linux-pci+bounces-35180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA4B3CB29
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024CC1BA4129
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23624EF76;
	Sat, 30 Aug 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOAGJG3t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9719F13F;
	Sat, 30 Aug 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560080; cv=none; b=RubM8QA9nRY0VQ/tHP5Ir7DI5g9aZBRq8g2QgcRxGuvxFpYtdqS7NLwYYmTNygL0amWrAw6zh2lMuGf1GGgrINlWixcD2r15zVKiroULdPGxluBPmBwF3gPIQu20LKcSyGkhcXGOT/xK38nKqgPZMuEF6BR5Y4jIC8LmWOTCvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560080; c=relaxed/simple;
	bh=rfRQCUQ65MF3aZqkBC3mRwVD2hei2eLp4vK7ErtL+Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI3OkQkRMU6aFJlU0BSLvFUtOMfa+XSh1pZIT8RLyItQD3xHFkCQ5ixOcS9hxhzW02NSOhZVoQFCLojwRCR1/2+SIS6eIcLfUngEe9iJVsn4ajDntcOIPi3Q9r/NaDL+nmcfcfia/m6zC35dhW2cV4UGTrc1Bg7H9B5kPfYjIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOAGJG3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA960C4CEEB;
	Sat, 30 Aug 2025 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756560079;
	bh=rfRQCUQ65MF3aZqkBC3mRwVD2hei2eLp4vK7ErtL+Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOAGJG3tnj7AsruIW/K2HluG1Ywf2ZrIoZuUlmyyrO0bKspFo/3CyCw/AvLObwG78
	 CsQXr+hsH/+11DaVZ9kgGkVr74guUaOWmGHvW1QFmfuzcEJxy7IxSjMd5AwcDWD/K/
	 ZzfYRNewGXNttK3VWSTAMjKUb9D2dRyHwtrbupycVYHOg7AjrWCrHu2dFH1vIkf2gG
	 a6qChI/fKib0oegk9CIoCmOAlN7syZKWVyMwN4Y28al3rON06ZsAuUDDSFsYQdRZG7
	 +dLmuTnCE/HxMo2oJRey0OL1tNN+4RIrjuviO8n7lqwm1s2pobumrDEBfWArCMjXMp
	 CgkjUiG2fB2+g==
Date: Sat, 30 Aug 2025 18:51:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/15] PCI: Add Cix Technology Vendor and Device ID
Message-ID: <y62iiqee7w3ogttzaboulkyea2b4srbta424adgjcrflx4c7or@uq6en5nyctl3>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-12-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-12-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:35PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Nit: Use CIX everywhere.

- Mani

> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  include/linux/pci_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..24b04d085920 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2631,6 +2631,9 @@
>  
>  #define PCI_VENDOR_ID_CXL		0x1e98
>  
> +#define PCI_VENDOR_ID_CIX		0x1f6c
> +#define PCI_DEVICE_ID_CIX_SKY1		0x0001
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

