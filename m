Return-Path: <linux-pci+bounces-41089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D4C575C2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 13:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F04E413D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9952D879F;
	Thu, 13 Nov 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa/pLGu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967227B4E8
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036360; cv=none; b=q7X28P8r/+Lk9VIBITbQUs5fzVka8KyJ6GdK/ZOkKWDAGCCXPx48sov2qH/PMhyTYu2mOkFIhtsKofThxdAdQxe7Ggv8ZuC0ztRQ4wNr1OHQVMnHibYFHT4iUrBRmML/j8v2GNu/L997FkOfxwpbulLd7Tv78Db3CagChiVxDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036360; c=relaxed/simple;
	bh=J156Jh1yX97Hwdc9m/Mt7PtzhyeBBXEPt3uL4puyrk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QyvldPl6WUD+PcUAacWWd102i7xotde/DtZAod3dU75lXQLeI1MW6DaUzszRsxdQsnnUM33AFuJqNzvLP/Dies57XDRLT5EgIKTKh1vh8+HrXzs1IpQxFVsJlJ/Vtw0onK/e646sIdey8FmSTdeTsVFdG3adx7naouKaRyrqoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa/pLGu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338FC4CEFB;
	Thu, 13 Nov 2025 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763036360;
	bh=J156Jh1yX97Hwdc9m/Mt7PtzhyeBBXEPt3uL4puyrk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Fa/pLGu/YqD3DaD9F8EHiKAR6zObHbsCUk/icsWu/S9X3zkO2QqvqbY+z/v70K0iq
	 sLGyBx94lA2cb3zWP705yPCieGOcuUmadAvpGhd0fMQhMeWTYX9/aqvE+HW7m9dsxz
	 XxsoynzWFJzFb5CKP0OuInMdKPsp3KMF4s6RMsGcLJ4ZM9oE54pAJdw02fDOmyvc7f
	 yT+Uc82zk+kxD9XOSZzZszLn7TuxF404vbBdfvInM0PosXMxcV+Rto8aDuEvo0CyFH
	 P0BtBr75gr+q91MI7UtDT3BrenZRlh7LbJtK7Gerf/1CeBM8N6/bTbuWx2INprDJYz
	 /X+nsDKFpw8AA==
Date: Thu, 13 Nov 2025 06:19:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
Message-ID: <20251113121918.GA2274369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d45ecfb-e566-4166-9bdd-4dcbd036e659@rock-chips.com>

On Thu, Nov 13, 2025 at 09:47:30AM +0800, Shawn Lin wrote:
> 在 2025/11/13 星期四 8:59, Bjorn Helgaas 写道:
> > On Wed, Nov 12, 2025 at 10:58:39AM +0800, Shawn Lin wrote:
> > > This Wi-Fi advertises the L0s and L1 capabilities but actually
> > > it doesn't support them. This's comfirmed by Hisilicon team in
> > > actual productization.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > Applied to pci/for-linus, planning for v6.18.
> 
> Thanks Bjorn. By checking the for-linus branch, I found an error.
> 
> This patch is based on linux-next, but if it's for v6.18, I think we
> need to use quirk_disable_aspm_l0s_l1 instead of
> quirk_disable_aspm_l0s_l1_cap.

Sigh, yep, sorry about that.  Fixed.

