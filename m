Return-Path: <linux-pci+bounces-26256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F7A93F9B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 23:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A189176400
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49023ED60;
	Fri, 18 Apr 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAt8s6q8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949921171F;
	Fri, 18 Apr 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013465; cv=none; b=M3hcx/XInXyZdgrQQHCz0jYxjZCu+Xtw3m2nrCeJOQPYXIgf2Dt+eiEpa3WVY79QB5ohwb9X3e6TNi8inGxd04vN3hjCX3DApLO/nyh/QITDUR2Sg3mdlDL5bSVeW325kBoynoTTUmVFrGMVfiUG5k5k9ffW069HwCw3zcHQjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013465; c=relaxed/simple;
	bh=I43zadsF7HoUT8QXRm4KqApyiSQe/nvR1/eYcX7/V8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WvaMi7sHp6ETB0t0bXzshu57BRXNYs666g5NBJO7zNaFUchbfKvPhXTkqNKDoPZw7b7KBwV8n4Fd00G2QUBB5o2+JIwo2orsewy6AG2zkYkl13VmaYIy07cnG1F7MKT84RUffcqnkEUBC9VH/OhnhRelIKTgIfj5kffC7dHRVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAt8s6q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F1C4CEE2;
	Fri, 18 Apr 2025 21:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745013464;
	bh=I43zadsF7HoUT8QXRm4KqApyiSQe/nvR1/eYcX7/V8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bAt8s6q8KRAhLJ1foBdESypZk0XWBl3bFO7Tano35upJqhrO07bEZqi8TspSrbJbN
	 KeR49CiYzQ/Edk3TmB8NiALIWiHgG312jwv1uxbjieFDYtE9xxTuWRqE3pRzBiKIOp
	 wyz7DXmb6qqAyUebegq4X+GF0grdvoWSNO9niu+85t7emowNS0VLNltGNxG7ujuOk9
	 nfoSNwQ4Z1DEylKPIZ31fOfxr+nOPm9EtB/LsYit/XI/5wHlMnIH1yXT9rtG4zsb5s
	 BMZDLRsNAuxumRbGEfbDAO84FeAiqosTq+As3Y3RowPpCplEn//M2vBzqyAsZvi+29
	 DxiOnFDna4BMQ==
Date: Fri, 18 Apr 2025 16:57:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Move Manivannan Sadhasivam as PCI Native
 host bridge and endpoint maintainer
Message-ID: <20250418215742.GA178777@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418094905.9983-1-manivannan.sadhasivam@linaro.org>

On Fri, Apr 18, 2025 at 03:19:02PM +0530, Manivannan Sadhasivam wrote:
> I'm currently maintaining the PCI endpoint subsystem and reviewing the
> native host bridge and endpoint drivers. However, this affects my endpoint
> maintainership role since I cannot merge endpoint patches that depend on
> the controller drivers (which is more common). Moreover, the controller
> driver patches would also benefit from a helping hand in maintaining them.
> 
> So I'd like to step up to maintain the native host bridge and endpoint
> drivers together with the endpoint subsystem.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/for-linus for v6.15, thanks!  I appreciate your help in
looking after these.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce2b64f4568d..ed035c9b3a61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18631,7 +18631,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Krzysztof Wilczyński <kw@linux.com>
> -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Rob Herring <robh@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 2.43.0
> 

