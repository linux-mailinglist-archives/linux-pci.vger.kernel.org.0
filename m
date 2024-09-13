Return-Path: <linux-pci+bounces-13199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933F978B86
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 00:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3431C21C51
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE841494DC;
	Fri, 13 Sep 2024 22:50:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D6154445;
	Fri, 13 Sep 2024 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267815; cv=none; b=t3CObVRNJn5cMxi1YE6Q/AS0i4hzPlLhJ/nv3bxUG08L/Zu76XYpmBniQt+mfBc06W0mRN0Pvk3PPdViLmsRH4vYsk6RRrVakUfR+Tzj2aRczM09RbmZfuSyY0Mop3BxCFGxwXXzrit/qtcEw7d90YMxC9V5cTZz3u6SfeS2nyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267815; c=relaxed/simple;
	bh=BevrF8SgjjRd77j0GBZgS3VX7WlurAfPUXilHnHlaXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owVxGskWiqXiPx4j9eVGltiOthejN2cdveJXsrpAxoxFZuyEYVgG+V2CzM7hlBpahRfcQgOEzNJSlhVG0m6bkHfRFEsA1m2dMwuIQAHZv57NbaW7ja17eyBORJjEfidWRSYwEQQAZKCmj9xgcTRSuXTijL2gM6WvJ4q8EDi3WrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fee6435a34so24907545ad.0;
        Fri, 13 Sep 2024 15:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726267813; x=1726872613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeVr/F9IwEGPItot/SdDopQkw2JOChhVgPaKPs2cgG0=;
        b=Bqttk8dFPRW/pgtz/KwTYruJX0goJysmWTSoTxVb3GFhVLHUSXEJtZUFYqE1qUzmVx
         tZ+wCYU2Faf7sVXYb1eKIVls6FLpy0snMNwiW4aG4qcpG0iHEHlmVZwb22d2knsgQPPB
         aZ9T40nfsh7fx5Di4qZLGK6pLPO/TzfxNprHnNwl0KZeycHhgabWF5BWvdy9kU28H785
         NzvmmVbbFl4l3VH1+xflLJqnzmcHD6vsDCuY+7MKIt48bMVIEyM2VpOg9xSKPh86SrLQ
         mMPkkrGMHnDmHQLODI6QTHc4FOwsj/66v2v8nEXhAHKLNK6d0J+Bv67M+XPJnZe6yuej
         n76A==
X-Forwarded-Encrypted: i=1; AJvYcCUW9X/UQ8ReuKLpFSdMikz501dayP1MUhLdbmGr2StkXiMIZGpCHIXhoPVgwYI5eR0vNR/Z22gLf0da@vger.kernel.org, AJvYcCVwUpz+Rq3h9hyFcvjOuhbSQFp19IKsfWdrf+nRUTGLVAlGSHu6JDlmfrGAex1q9L5oJUgQtn2Ov9oV+iE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7y/ZsfpHyeyWIzIf1rVn0laJKXZysAXnyepY0HsvsDT/hFz2
	VfcYZMl0+QzxBZd1CP0kvLoOif2S7fKv5hTdlxtAnPtZ7Ah2V7m7
X-Google-Smtp-Source: AGHT+IH3vi4CMBHspHsCLDAesqNJunhj4tEws7u/oADf15WCUG8c2nogiv77B5/urtDxZRCHbR86zQ==
X-Received: by 2002:a17:903:181:b0:206:91e7:ba98 with SMTP id d9443c01a7336-2076e428284mr133970145ad.50.1726267813129;
        Fri, 13 Sep 2024 15:50:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794767c4esm1149455ad.306.2024.09.13.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:50:12 -0700 (PDT)
Date: Sat, 14 Sep 2024 07:50:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: Pass domain number explicitly to
 pci_bus_release_domain_nr() API
Message-ID: <20240913225011.GC635227@rocinante>
References: <20240912053025.25314-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912053025.25314-1-manivannan.sadhasivam@linaro.org>

Hello,

> pci_bus_release_domain_nr() API is supposed to free the domain number
> allocated by pci_bus_find_domain_nr(). Most of the callers of
> pci_bus_find_domain_nr(), store the domain number in pci_bus::domain_nr.
> 
> So pci_bus_release_domain_nr() implicitly frees the domain number by
> dereferencing 'struct pci_bus'. But one of the callers of this API, PCI
> endpoint subsystem doesn't have 'struct pci_bus', so it only passes NULL.
> Due to this, the API will end up dereferencing the NULL pointer.
> 
> To fix this issue, let's just pass the domain number explicitly to this
> API. Since 'struct pci_bus' is not used for any other purposes in this API
> other than extracting the domain number, it makes sense to pass the domain
> number directly.

Applied to controller/qcom, thank you!

[1/1] PCI: Pass domain number to pci_bus_release_domain_nr() explicitly
      https://git.kernel.org/pci/pci/c/0cca961a0261

	Krzysztof

