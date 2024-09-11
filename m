Return-Path: <linux-pci+bounces-13034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBC9754CC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC86283032
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD2191F8C;
	Wed, 11 Sep 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfHZXbz0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17755E53;
	Wed, 11 Sep 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062846; cv=none; b=Mke1lyAIchyd/SFvHe2oh2ZOUh/1u2NW22Gn1O+uMLmdSFs/XewF7INT2Y94ZxJLstr6OFlmqZEnWIr4wRrjNS8ikNKNnwFbBUdOPXcmFqtNzKNIdRKXbEVxRiqWmLNd5Fl7hxcaX6/cwBscaqi+5NTXZz+u++zbtE0OsxA13zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062846; c=relaxed/simple;
	bh=hi9bcrL50Bbj1h7ICrEusQzlzx/6v1gBjLN2Tfg118A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QE7Nqskn8SrXJviVpqwLEuNR781sIxcvO1MeS+K6msAZXGwLbGuT2/o5Dv6zky8+Muq4LwmNCngkZosGhv7gfhUdfJV+4hU/Zi2dr1B1EvAKO2VDik1CTsecjArPKgJoDRJYr5wPYje+IPDBdoYh2OI7kLGf9bK678rbS9TOa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfHZXbz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C01C4CEC0;
	Wed, 11 Sep 2024 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062846;
	bh=hi9bcrL50Bbj1h7ICrEusQzlzx/6v1gBjLN2Tfg118A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EfHZXbz0aKb9nrDKI18QymvW2tLnc3Ps7zk4Qg/uXrqM883s3CbM0hCgK97ZdoI6q
	 I+j5GoaXRp+JXWrRoYWaxTUwduATWzjSkunA17k+rdoyzjtphl+Zgez0P1KkeFFJIS
	 XYFf06YRlKrTGaFEcDc01UKhSN3DI2qVNWeVJoqSXE6drSqMIb5FQrdUMpGYGh6TSM
	 CHynkUVA8bDJ8lrtmADDkxqNmKY+VzT5/PFngS22tvXSLOQblqLgsWjqd4w0M82m8h
	 vwnUDVD6WcrEqZujYG1Wb6+gd3UKteXPi00DPgVpGj12JpfHeeW+c1frk2Bh7YZMMA
	 WBtZJP7W+kgrw==
Date: Wed, 11 Sep 2024 08:54:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: Remove unused BILLION macro
Message-ID: <20240911135404.GA629961@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911060401.9230-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 11, 2024 at 02:04:01PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The macro BILLION is never referenced in the code.
> Just remove it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Applied to pci/tools for v6.12, thanks!

> ---
>  tools/pci/pcitest.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 441b54234635..470258009ddc 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -16,8 +16,6 @@
>  
>  #include <linux/pcitest.h>
>  
> -#define BILLION 1E9
> -
>  static char *result[] = { "NOT OKAY", "OKAY" };
>  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
>  
> -- 
> 2.33.0
> 
> 
> 

