Return-Path: <linux-pci+bounces-34722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9473B356B7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C5B2A0098
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34952F8BF8;
	Tue, 26 Aug 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/V9QG96"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016D2877DA
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196669; cv=none; b=eGJ2MmMxUnQsASTzLWY3opOzujiHpDkHfktANn5rPO7AoLR6nG+er2bJo3cxsTzgVsgKCyFGiJnQj+SBEi2jKP0OwzLbnMT0tesm7pc6RPEC5Ut3y9OO8AvNfOZ/exXUIyI1i8qyQsW4y7+ZwDpzg9AKUjEKNDHJmWYz9c+d2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196669; c=relaxed/simple;
	bh=zkOhKSUhdYkMOEaqDdeq+hV7jrlqNbHyofVtEE1X+74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfT3P9Axje6mIvqw7J6xAfbI4FhnI1XP4+dDGU1SQ/uaQ/eqMxxvNWpVRRIDndKVp3eYCHQGPHiXrKTaBsuDI+6H6ZYKO/+3K8taR1JqhIjzhlOOPdQO/bV4Mk3WIqHLt4w0qh5uATiEwiDczAcX1NZt133lFvwCBLIkDlox4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/V9QG96; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77057266cb8so1706967b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 01:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196667; x=1756801467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVPH5Gl2Q97fpNbb5mZdeF+VpN5uCzs/BvvvIML5Rqo=;
        b=r/V9QG96KuMwkTogBTFK5on7rVRDUxUw8QoaJRTEl6NrRRstK+V7p7/y7xt/blbIOD
         RhfxRyhSJBD8De9hpMat3ZOmBSQzGJsrLuWiAzoAZVJqLMMIPIWl1KFCjqlOHEUP8x0a
         zAOWud0+IT9cfKLxX3KbuNyd8Ygtrf5EEdi5N12ASVGMfWFCj7lBpvg3Yq3S2bJAfluh
         3xAXDy0pCD9DDSuelt57b5bQLoJ6SOoJ/Qmb3uyQptxIadtu2PTr+a6iHxj1fGBK51KA
         MHMAylBB8ZiLzg3JTcJittD3+JJRIg7cUN3aCnlVgV7r5wSuM8bk3Xsjq63pb8V2oj5c
         /avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196667; x=1756801467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVPH5Gl2Q97fpNbb5mZdeF+VpN5uCzs/BvvvIML5Rqo=;
        b=Zp8fpPQspZvInwHNGLx2kuHg70ZX2BHPMZhft40iSlJEhP4h7272eMegK/NU+tW2dB
         ogkTe3JfdHe8XxTev3EJ285w+U46MfYv+Nbo+YM58XMSA9Sj7VZecso7cY362XSqPcCx
         5o/mBkc6MYiiMZ62o4fJRJpbkVigSlLBW729eho8qxQWDgX5U7a9XWlvuGSRYAz8srVI
         24nG7DXjaRZsGnwwixC1CtJMAdzFSwidkH17uUxEc25V9iRpeQ4dcKcTTvuDtBH13XpN
         bWsnJeQ4jNSigKqvPQ9GWnbUIBBmi3MPFIuiTLuK5aim9whKsAc8Fmsm2kfEcCa+0IHc
         PY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq7IOe/K+ZYjyiKQFiQTSzRfhbxFc/zvrG1Q7Dg1FhSIhs2DzGO75Fpl01ldHsbgamt9i9AfqDOvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWvuVucAMSPHBb3SgB0AAToU2YSfVT2pvRDtq70gfJ92sA32e
	te76Q/eho77r7+12ePxy/jAaLSOTByWL/kL9L5soYd8tzGS2zeGmUxE5joC69uGq3wU=
X-Gm-Gg: ASbGnctan49bQTGcANsXtCHC8+VFg2Pu5JSu6z6B2JlGik+/tWfF10By8r/eJwO2rJx
	ZCdXsc2XB6x/P0SL9OSWev7/ObMSuyjIuip+rVO7MdnTzXnV0TWREGUTMXWEgYQkU8h8ej/p7FY
	2RSsYtBSZXLUYhyoVerdOKay02bXqOjVhvoXZrjTVLpW2F567eQ8Z1c9tDyKwynpi3CWvazeyDq
	wtOtzPptyrI1votZ8LU+nrloLkLJVmoqnL+MBNsXrHUul+rX3e6nM8Kc85Huaz2hAN3A72b7Y7u
	XLngoaG5lV2t3pMovVrppncTRU3V5hXUKBVAmMl6A6hUVaGOHSFZF+Sye4Pln4jH6nSat8wPyQ1
	8rxH7+KlZRyj0wO5vXGvrWC0L
X-Google-Smtp-Source: AGHT+IEZHD4aC/mODzgvmtEKSdmKP/ZP99JsYLoYV/vczHAIOiPdaxjm/pWCet0LfwP2k78AerheMQ==
X-Received: by 2002:a17:903:24f:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-2462ef8e7c5mr179683875ad.55.1756196667512;
        Tue, 26 Aug 2025 01:24:27 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885ed51sm88411645ad.85.2025.08.26.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:24:26 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:54:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Message-ID: <20250826082424.nnma5oafc7axhep6@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
 <CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>
 <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
 <20250826060647.7eerg5blx3xho27p@vireshk-i7>
 <d8599b11-66dd-486b-89e4-52b82d90f04e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8599b11-66dd-486b-89e4-52b82d90f04e@samsung.com>

On 26-08-25, 09:26, Marek Szyprowski wrote:
> This doesn't help. I've stared a bit at that code and did some tests 
> and it looks that the issue is caused by _opp_table_find_key() returning 
> the last opp from opp_list without updating the *key and calling 
> opp_get() for it (happens when compare() returns false).

Ahh, right. So `compare()` may never return `true` and in that case we
returned the last OPP of the table earlier.

Thanks.

-- 
viresh

