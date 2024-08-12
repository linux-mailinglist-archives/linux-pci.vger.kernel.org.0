Return-Path: <linux-pci+bounces-11600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72D94F676
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E59D28563E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32D18E05A;
	Mon, 12 Aug 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHRmiKp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765618A6CB;
	Mon, 12 Aug 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486426; cv=none; b=JlTIUMynAjkCUvOB6/9TIBmuj5G1KeI7F8xw9vWOPHMyX4IeThCMiYn0WASceMSQ7mE5rMDYkGDCoJMkJ5WvgyiI5X5GcnPFfJug3tLbxBnlZLPXjYZ2RjG/nGXIK1VOajLxtbNLMRH29NVwSuXgFAbRiI3IRi27RjocAb1MwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486426; c=relaxed/simple;
	bh=L2qxGeh22xt2d4Zby1AoPnqAgwBmaUtl4+N+AHbueLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V3FIA21Ay/8fWCAr8JJ5OehXA4xumkqUvob4YzPTQq58Ob1kNPb5EBvvPZ6YlfsVC7xSj8KMnaFWFR9jtrz+uNj7bdQGVzmlaFDT2dqU2w4v9hYpBPUPa7fB8X2/xfl1uTseoueTHgXRfQ9rlgh6DRWEPz/rrZkJLJanikm91fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHRmiKp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F59BC32782;
	Mon, 12 Aug 2024 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486426;
	bh=L2qxGeh22xt2d4Zby1AoPnqAgwBmaUtl4+N+AHbueLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EHRmiKp2MZ4xtI3cuYDmVwdXcPT4TsK3TcftXJxltApgz62sdUTE5NbSfdosKuL0J
	 bj+TCE9Ro+8ttrMswYQZ6UvmGYwf2vHHVbXRVgxPV6Uv+VPhoZVTK8uuIOaGzo5Q/c
	 UzH0Q4w1pccN7X8zZoCHMYE5pRv+jfFFTHBzPWBylB35b5+1fONnJntEDqay79qWQd
	 LjBgbejaGhvDQy+t7d0qPFRIWU7XiZENKul6m9V1YKYKANLt4BwkWYNXs39opjVr5h
	 RbcPaHIXTokGFlWWXUfHaePX9TtNGKI5DwCoV6oHU/NfimlyKIRUXUmaFncuVyWaDn
	 RQsBh8Tv1dLVQ==
Date: Mon, 12 Aug 2024 13:13:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for
 PCI native host bridge and endpoint drivers
Message-ID: <20240812181344.GA287613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812055707.6778-1-manivannan.sadhasivam@linaro.org>

On Mon, Aug 12, 2024 at 11:27:07AM +0530, Manivannan Sadhasivam wrote:
> I've been reviewing the native host bridge drivers for some time and would
> like to be listed as a Reviewer formally.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to for-linus for v6.11, thanks, Mani!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..3fb27f41515d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17616,6 +17616,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Krzysztof Wilczyński <kw@linux.com>
> +R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Rob Herring <robh@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 2.25.1
> 

