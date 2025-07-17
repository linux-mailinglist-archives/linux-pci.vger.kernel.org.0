Return-Path: <linux-pci+bounces-32398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4CB08DFC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6747A7AF07C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965C2E4995;
	Thu, 17 Jul 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN8FmRrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA327281F;
	Thu, 17 Jul 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758299; cv=none; b=EkPFWntcEEZyk7IEHI0zjTVx2m7crenBMKAhh1aC9+YAk2QeBgTW80+1ZiDiVLFVqielefeyHfYbPSM5pSGLQ+ciU9irsFSVVTfBxOR6JNOUTTCYWNSop0Qljjf9ZfZmlR8ElcX7EeNq+9nU2y1OY53al8AeUZ8uKHFY+UiGIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758299; c=relaxed/simple;
	bh=ptH7dNBspgIP6UsKnSP/sRCJoEZvn2kCE+mTvSXMsi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kel+elrCnrm8iv+yRodpK2twfx1uGrWl2c981wVzZYPqWji8iL3fcq3KnPzLLh5OCK/oDkMa6A8VDNYq4mK5m65nP70pC3euvYUZslX2+j/iOngMniVnwUKfXw/obzmeWpnTCn1LTJTtbl0bPy0D1wG2cfy0ANG6D/LnlASWGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN8FmRrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C69C4CEE3;
	Thu, 17 Jul 2025 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758299;
	bh=ptH7dNBspgIP6UsKnSP/sRCJoEZvn2kCE+mTvSXMsi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN8FmRrAJahPQDvzq6wXUASrBSm9U8a7sStPNCPg2PzmRgWoRMOLlKSUfxQKHkOca
	 ACI2CYsu6n5evkETU8BI370l/55L7WoAP91aZ8pQ5iMPJNep0n8xD76FjS1ha9FZ8V
	 DZaDxW1NBnSgAsXtYnZFzY/07xYcwUzF6wXs21GVaovD6B4zTyXwWhCpgboVM7VyyW
	 OSVslg/RHqJhZAqPNhCCQdTpQL2o7M2RsrpRKoLVhS/YKzPa7vf+cRzSObl0vfm4NR
	 8hzIdts8NiAGGV/1H10n7JmLWXFL9m8aiPBvIiXtAtXufPxpLrfeOirmV8+Iu9ElQr
	 C4LL6pzIHki+g==
Date: Thu, 17 Jul 2025 15:18:14 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Toan Le <toan@os.amperecomputing.com>
Subject: Re: [PATCH v2 11/13] PCI: xgene-msi: Probe as a standard platform
 driver
Message-ID: <aHj4FstvO+MnnB0B@lpieralisi>
References: <20250708173404.1278635-12-maz@kernel.org>
 <9193ef71-72b6-4946-a830-14fbbc786658@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9193ef71-72b6-4946-a830-14fbbc786658@web.de>

On Thu, Jul 17, 2025 at 01:45:12PM +0200, Markus Elfring wrote:
> > Now that we have made the dependedncy between the PCI driver and
> …
> 
>                             dependency?

https://git.kernel.org/pci/pci/c/a435be2c3318

Thanks,
Lorenzo

