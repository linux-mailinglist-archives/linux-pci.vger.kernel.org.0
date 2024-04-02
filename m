Return-Path: <linux-pci+bounces-5517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF738894B09
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 08:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6B7282CC2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 06:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA8182D4;
	Tue,  2 Apr 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQkARcJk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6318050
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037727; cv=none; b=Js2X+j9BEdsOVxWzICmBKGjG+QKoJbHMJS0JdNLjcveHaKO7qr9d7jk+1vJrGULSpNVRIHgIFiY2qSp2I+QqVqx2QPr6MjJGlgFilGibJb8n3RJW8m3O/13d9U7QuuRzCrnSwJ98FULHp9xQ9Nx88LRJ17TWcxIKNnXOgE3cMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037727; c=relaxed/simple;
	bh=EZ7Tqo7UTGR0nuXtZvOwSsONYxTeiw8Y1skKOcWnaac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrsZDK+QCrQzJRqAmpxClULhBEqFZl/b8SrzWk7F7Va59/hncWuCPGIr+XDtFvgY23wHUljYUSQ9AFjCbA4mocsbxOg5H6UMIi6bTnDbU5R812NDKfYRKNPuz0b8DgKfSPevqqo0J/ijJhv79mlIitA9TeFD0zayOtsqYIypMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQkARcJk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3818864b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712037725; x=1712642525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWlujnh/UGREdcoJra5OBi+g0ocKuYapnQiOQEGk2r0=;
        b=rQkARcJkisEh0mhyqSZ7pLUrOJNW0Y5DDWWi+G5VxELaeDIFupXbm4PvZK8iwqAqip
         TuHS1kjCnaz5vQGm/DAEdzq2HJV7grFvrfAnoosVU8ZyOQqwckg2JfTOtREH6qN1AA4G
         0pf8VxBpFTmAXN5P7pnTSPziv7hTIchEkLmAVWEg8qsvQVip6YL1/e5jhFbiioo4rmfy
         dgTZi/jkkEwiQ0ut7j1pCgOgFJnZPVWmM4uCCqaVwd3Qv3eTdDzjs8xYIa7y2xlG7nXb
         0tH3NViWzrgwFUrxlzTpqDZSa8y+kbVuvwf8VcqBtyq18PE/Q/FKc4tl1dhpsxdOHVUS
         6xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037725; x=1712642525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWlujnh/UGREdcoJra5OBi+g0ocKuYapnQiOQEGk2r0=;
        b=jZtt4SQ0HmuUxbrsIr9OTVsIeqEffSdNQP9p6A66aXtlKmtXlBr0bzmthlroU7CLYC
         W8zJHOO3coGUOBgpTDwYsQgLNlb2uonP8kAFv+daZtWD35QxtnQkcQO3vH8glMwic7x4
         66VALUCN0RIoQyoJZTWa10doBQXrMfpxjGAmpBS+rtJEubz1JWLYnDEGcl/LxMuTwb1I
         EmP5CsrZjC6kymtd5fwK4hp/xIQqDQMbwDPgzGOZ8bTnX9GIV9rfJKDtqxQtdUMSGWiL
         djEHFoSuYfd5+OX0QKs7O22070mzCnOrxluSok3VeCr5sSk1Ibo/dC7mW/qrsHw52HV6
         eNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDfVSxwi6lbjvN73LpkdIqZkbpMC/KeQsEZ1ad80/X5LFVE+eQr08abcVUjyGaNA3AiosFyT9NhSO3tmKqvyYPevvAXKOJHKjz
X-Gm-Message-State: AOJu0Yw0K5do8wJjCPKammllNETTTMxZTO6gwEMEQaDlYTlcCyla+8gi
	Fjt930Fni8jw/XY6fkh+DHXFK9l+qhQPak+I9MGuxMmkE2U66W559/u876kAfQ==
X-Google-Smtp-Source: AGHT+IEeY+bN8XZ6/697eZkIqE6Ld9gP5i46gSe5yu2qA3FvpRYE1YeXdblDII2YS6cwnxqeioQnpQ==
X-Received: by 2002:a05:6a00:a83:b0:6ea:f444:341b with SMTP id b3-20020a056a000a8300b006eaf444341bmr10034781pfl.1.1712037725080;
        Mon, 01 Apr 2024 23:02:05 -0700 (PDT)
Received: from thinkpad ([2406:7400:92:96cc:b954:3c38:e709:b65f])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b006ead0ade02fsm8912427pfb.29.2024.04.01.23.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:02:04 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:31:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: Use the correct sleep function in
 wait_for_link
Message-ID: <20240402060159.GA7183@thinkpad>
References: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>

On Wed, Mar 27, 2024 at 07:24:49PM +0100, Konrad Dybcio wrote:
> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Tested on Qualcomm SC8280XP CRD
> ---
> Changes in v2:
> - Rename the define
> - Sleep for 90ms (the lower boundary) instead of 100
> - Link to v1: https://lore.kernel.org/r/20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..62915e4b2ebd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		if (dw_pcie_link_up(pci))
>  			break;
>  
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(LINK_WAIT_SLEEP_MS);
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..b17e8ff54f55 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,8 +63,7 @@
>  
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000
> +#define LINK_WAIT_SLEEP_MS		90
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> 
> ---
> base-commit: 26074e1be23143b2388cacb36166766c235feb7c
> change-id: 20240215-topic-pci_sleep-368108a1fb6f
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

