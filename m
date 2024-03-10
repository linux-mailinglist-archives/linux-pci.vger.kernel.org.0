Return-Path: <linux-pci+bounces-4711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1354877802
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 19:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49149B20D13
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD11E863;
	Sun, 10 Mar 2024 18:34:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD32EAD8;
	Sun, 10 Mar 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095660; cv=none; b=qYd8lPQ2X9FRkW2920EHNzH5UUHAb5fAgUYbpHqwvTJc/sJy33WxGzECP24EpDB2IK4jMuif64Y/TMxYs1pHbbEswhkgWs8+xwR8c8ppB5ffp9quMxqhZIVs2AWayf2lUYvB84gX7rlVn24xsAt0PqvJ0Hp4Sohf5bn0efZGD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095660; c=relaxed/simple;
	bh=ujM31iBXHdBt4kaCQzBTvFa1bk670UqJUJyI7JLKO08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up84nERJJMo4o0esb/iWTPE8uxvy26iBwjdwNTTYhBAZS1YrfdC43tT31tAsrGH1eowUFdd864i6SHJjETVku9+YYTOcPu7UHTsfZV9jHhaiMpEemeuytz3ux8nK10oV8JyDGl6Jg862R1pTyhuF34gLH961+OIlcmpeQhA3Fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a17a739935so2183345eaf.1;
        Sun, 10 Mar 2024 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710095658; x=1710700458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HuVop9TXUF1sME+GPkklQ5nsaJvPNR91ikXjkm6UTI=;
        b=qlriZGVQmc97gNa/X5ROd39tUjVkT/v9rD/7KwSaybug49+398CjMGBcsMFuKiHu4e
         eSm25ZKOTiCLbXKI1HEpyxmkeDjoBLGwdOh3gsCsI7M4ReRZZXEa21AhK4exi46oYWul
         Dy4F1Tc7RnCmleyFqvZ7XVNu+o9pWZwa+iDdJCV/w8MeQDq5664CFsqDLbPhUS9EsN1t
         fj3WCMrJhfxc28J4WsImOHK2pZw5MXQON7+JjybXBvI4LXaLUyoEnLjq4fofO9UkZBwY
         MHX0lJ1kFXRzYP6UsLd9FbsRkYO1LhFkGYtitKMQlkVsZq4osC/gt/aEFR8s0rkR9xdP
         bpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx7LhlQ4pzVFSQgWZy/bPpyaqb7wGZX679hYYOp8yVHLAWGO9+Skzm9lo+AwJCxZzFHtzDTFbqoj1tAdFv07hNfE8Ii2VQHpxdKcDxcQ1CtGm8PkMION9qOgcT3kxyjWDNFsqs6vcY
X-Gm-Message-State: AOJu0YzUrI39EF0p15y3je62by3Sm7yuGvRWlLN8G+2+kuUPTiXj6eQp
	iMx3El7aDjThWgmqd4N2Nxggjxq8Bbr2c3PlEOItgkhuon0+KERF
X-Google-Smtp-Source: AGHT+IGWq3sjWNRWUuFd3bI7tiabau54smSS71nPzPxgI7GAzPVLZZHKLv+xsV4LRq35eDIfp7/nfA==
X-Received: by 2002:a05:6830:97:b0:6e5:2213:9619 with SMTP id a23-20020a056830009700b006e522139619mr3955706oto.12.1710095658286;
        Sun, 10 Mar 2024 11:34:18 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id k18-20020a6568d2000000b005dc491ccdcesm2349349pgt.14.2024.03.10.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:34:17 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:34:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
	nm@ti.com
Subject: Re: [PATCH v4] PCI: Cadence: Clear the ARI Capability Next Function
 Number of the last function
Message-ID: <20240310183416.GE2765217@rocinante>
References: <20231202085015.3048516-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202085015.3048516-1-s-vadapalli@ti.com>

Hello,

> Next Function Number field in ARI Capability Register for last function
> must be zero by default as per the PCIe specification, indicating there
> is no next higher number function but that's not happening in our case,
> so this patch clears the Next Function Number field for last function used.
> 
> Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Applied to controller/cadence, thank you!

[1/1] PCI: cadence: Clear the ARI Capability Next Function Number of the last function
      https://git.kernel.org/pci/pci/c/667a006d73fb

	Krzysztof

