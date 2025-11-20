Return-Path: <linux-pci+bounces-41810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53819C7544A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBF10344706
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16BC35CBA4;
	Thu, 20 Nov 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDkq4g3C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B135CB7B;
	Thu, 20 Nov 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654859; cv=none; b=jKlM7/ejuu5r/9yJySUe2rs4SfqNtnf8AifRfAn6LENzHj3l5fOqG+m/UUmbaTFF1s9nW7ejzF987hi+tEkGv7fwWBBJ+pKeKf/G4hB2/eSRvKAOWOw/KANQwGz2Dr+cG27yAESfNVHF4HVwPSwlJ0F8iErSbBoOqkBUNnH64Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654859; c=relaxed/simple;
	bh=cTp6RFHZT4tl9bZ+HgqWtI2GWf8IcutNO+Mm/3CeiHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdUX07vgygtFL1fnAevvB0YXm9QEtK4/SG5WIwlFD6JQquieMoMGYgm8Qfu2fQVIPPTlWGFjVqCL9ADUotXpeXNQDADkzCzDIVh7Or6P+ado4mXW8hBzDIt0I07pdUOYrFeylIW3TpJoyxZMcfDrrRO9c7fmY5/0daY2rUeNFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDkq4g3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB04C116D0;
	Thu, 20 Nov 2025 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763654858;
	bh=cTp6RFHZT4tl9bZ+HgqWtI2GWf8IcutNO+Mm/3CeiHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDkq4g3C2TDfixTR5SonavC32rmTIn53owXLZX/3gj3WmygliFOXeTuqIPQOCH0m2
	 IzJH90bFJhTEYMFO3tPia8hGX9yL0SGx+qqIQV6mxd/3fi+TcSFN06iOuKJFSZBSp+
	 u/5bHHRW8bv0OtlDKC/RvfHg0m3YQVgoHDraOgP/KUCEsRGzxgX1ndW8A7Hrs1CMPW
	 RFe79WNZkeMnJMfnybqrwVimHhccPpKW02zCBlId4Q6ci/httWRGMy2wn/vjCJx1Ms
	 BDLUsH6Wf8MFBpqhPhfSy9E0c7ExZ1VcTwaN9mpLrSGG92il7bHH2AhsxeRc9uR2Mf
	 YHX+cZuuOTCGQ==
Date: Thu, 20 Nov 2025 21:37:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe
 SSDs
Message-ID: <f7y3owzhrtoxry52zux6h7fxfun4ybol5ruy7q3nmjpgm2udbt@t62eunh75qts>
References: <20251120154601.116806-1-mani@kernel.org>
 <aR88DxZST5r9Va2S@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aR88DxZST5r9Va2S@wunner.de>

On Thu, Nov 20, 2025 at 05:04:31PM +0100, Lukas Wunner wrote:
> On Thu, Nov 20, 2025 at 09:16:01PM +0530, Manivannan Sadhasivam wrote:
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >  
> > +static void quirk_disable_aspm_l1(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM L1\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_L1);
> > +}
> 
> Shouldn't this be using pcie_aspm_remove_cap()?  Existing quirks
> were converted to this new helper with 30579eebba6a.
> 

Ah, I didn't notice that Bjorn's series got merged into mainline. Will rebase
and send v2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

