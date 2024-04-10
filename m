Return-Path: <linux-pci+bounces-6052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4789FE86
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76EF1C215B6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC617BB1A;
	Wed, 10 Apr 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlJJ3J4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A44178CEE;
	Wed, 10 Apr 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770167; cv=none; b=LeQThXHn/NfWSrKj77ZRhFQWbYqtlF067naUA3cBfsKXla5v1jjddUm4lVFIV3ODiWfFFLOgZhXfKZJdIihIXJJvsR3zm8vhfaY2vp1TWVi62MIIRPfz2K796+NfZv4m3AdPLkq0ERVbIiw1c6MpJNcPCs7rGFtD6Ll1kXVS2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770167; c=relaxed/simple;
	bh=kKy/KkBjkWZbvlopf+v401WCCnoGXIliP5F7ZNV9yIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMIFrk2cj07xgSPsJCllgb+oATNC5RbQL4dqQDJxGLMQqiNe5GreNUPRCpv9q86xKcS62iNd9jSG60ss5QfYdPA4Kg6CWrquc6XUh0t4tNCLex4YgO8HROSIT2+nGcsoqCXIMTQNBDwyXVOpny+1689K5Gv+6xhJXKTs7ipXTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlJJ3J4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A734CC433C7;
	Wed, 10 Apr 2024 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770166;
	bh=kKy/KkBjkWZbvlopf+v401WCCnoGXIliP5F7ZNV9yIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlJJ3J4HT50hadj+1d/lz0xRzTzb5GeCtya2+Cc8lcfxz9pWNZXQ3zT5vdi6NAbeU
	 Gz+t0h+fPb6sIhdXIBQMKgAix6DnLgS3R2KPwaBLYs3wzebhyXjsuw0MtxcVyo0Hq0
	 9LwEb7x024/I86PfKizx7SLRp3WmyFHI2ix5zJgIGSb+6dPkEHKlScKPbapMO8S2jM
	 8BBfe0OIYPunXnX3MkNInb7lFsVMuMMow6wMLlzdQTgmRYR9G9RQkSK3Z8jgRhICVM
	 G0nwpufPRxE0mPi5WDSh2EpyUHVTIynzAkavDyfTMu/9IzcsXCrKFjxQ2E53roj0SM
	 TJgMR9Z18HhOg==
Date: Wed, 10 Apr 2024 12:29:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: matthew.gerlach@linux.intel.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240410172924.GA622917-robh@kernel.org>
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
 <2ece9ac2-899c-4185-b0f3-8ab939afc1e5@linaro.org>
 <alpine.DEB.2.22.394.2404081309050.381257@sj-4150-psse-sw-opae-dev2>
 <d079bf4d-ebfe-4d98-b718-0c545aabbd30@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d079bf4d-ebfe-4d98-b718-0c545aabbd30@linaro.org>

On Tue, Apr 09, 2024 at 08:29:07AM +0200, Krzysztof Kozlowski wrote:
> On 08/04/2024 22:34, matthew.gerlach@linux.intel.com wrote:
> >>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> >>> new file mode 100644
> >>> index 000000000000..999dcda05f55
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> >>> @@ -0,0 +1,106 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +# Copyright (C) 2024, Intel Corporation
> >>
> >> This is derivative of previous work, which is easily visible by doing
> >> the same mistakes in DTS as they were before.
> > 
> > This is definitely derivative of previous work, and I want to fix the 
> > DTS mistakes too.
> > 
> >>
> >> You now added fresh copyrights ignoring all previous work, even though
> >> you copied it. I don't agree.
> >>
> >> If you want to ignore previous copyrights, then at least don't copy
> >> existing code... although even that would not be sufficient.
> > 
> > Ignoring previous copyrights was not my intent. There is no copyright 
> > statement in the original text version of the device tree bindings. Should 
> > that lack of copyright statement carry forward?
> 
> All the authors are copyright holders automatically, at least in some or
> maybe most jurisdictions. You do not need to add copyright label for
> material to be copyrighted. That's why you are not allowed to relicense
> the work for example, without other authors' agreement.

The only thing I see as missing is some years. All the authors were 
Altera which is now Intel, so Intel is the sole copyright holder. 
Whether is says 2015 contributions were Altera or Intel is probably 
immaterial.  There were also contributions by Google (Bjorn), but those 
were purely editorial.

Rob

