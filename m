Return-Path: <linux-pci+bounces-19882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589AA122C3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A25160866
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4120CCD1;
	Wed, 15 Jan 2025 11:38:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397741E98F4;
	Wed, 15 Jan 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941102; cv=none; b=Yt237Uy2ej0qrKDMaaOH4vfX2k5XkDRwdiTflQJxB+LALbYO91DXtH2swAHsinaj5SKa5vYV4LqQw51vz3jaJvBU+r6YLKfOGWmvIHmtnEMDBxF/4Zz+KCHgaGheFIB8+LHQyed19eKTSruyXIRI4v9bXEIA88zA0t5/GSNJ/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941102; c=relaxed/simple;
	bh=iM99rn2iVPC5Vi/SE7y14KyWHheOH8RKJRNQhQG8zPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5hClHt3IzZ804274/OKH0QbaAl2E4CNh52xv5pRsMkS3/YNkfK9XkfmlWNXgQ3ABkJT6LXAfBa0nSSGKDXEKZIKjEkHU7t3fgCcsfG6e8MLBCjLmJDHH/vVFuovMofh8d2oejlGBlKO+EhFp6qeWya9uej5fbmThcCXZyiMqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166022c5caso103085505ad.2;
        Wed, 15 Jan 2025 03:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941100; x=1737545900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yObtCYTyS+eH2VsWOaS8ygoiRNvMh6x4WMqXu7RO7qs=;
        b=YhYnqV08XvIh4JIlk5iO6rWwurQ+bMn4MIRA9NjgG41+EZ+tfuBwSM13147bQac5DX
         EMKJol7XvuDfxW20SNbp98V6vemR2Ign5uFA2Hx0CF2AWC2tcQ1DSOUbzUlW/LJqv24F
         HkWcL0EwmIiiYbaPUo+NmIW2LyudSnn/1KHA8Inf55/nocD6+aJWy4KizhtJxHrnePln
         nULJjE21xZ8Ep53vxAo6GwS5S5VLH6rXMOXKz2EZa9BFNDahSEnnLiSp2Pw66vOKGUqk
         fzpPR1JhzysPolOoiWTJPUZZ1NmxGCmMD/K9KOyFByTM+Tj/6fyw9kQMWc61l5I3BVx1
         LosQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCPVqZGb+TlhNblLTRjHwOfikZgSbriOgunn2LuXLdqqTCldSTFj7AnkaCJUSZhUm0fjYHm5BV4loY@vger.kernel.org, AJvYcCUfNJNJaDsWa/x813mhc07NxMz8+ORBdCM4lLVVKfgQA2Ug4W8PIHrokoXzF/uXReKMkCca/T9aqs00sJ9X@vger.kernel.org, AJvYcCVw90LwSMZRuBh7LKb5+BALX14aLH3k3x6I6xfwbA4nKLIqka3tmMnbX9F+rzNoAnLm8wyYB7pWc5EX@vger.kernel.org, AJvYcCWXRY7bIP3QoknMHqRDPMz7d7MUq4tsVY39ZeZ/oRl3xQR5bcoQ4Wt+Tt/XJkB17f6N/vCy8mVSEtIzrUvGlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/ldXSKhsvISCjHMTpsojk7XG+8vwsNlou8BVuKBC728oHUgi
	m4xq5Jfb/5DaeKFRMui7zHEc7UiXSS1ROO54r/AAxe7In8OfQ8KwuoLlNaFy
X-Gm-Gg: ASbGncvKBqchCGEDoM4dMuorhtzrpz8YxLO6bDBTm5U9eb0my/9eFyLakLp2izvh/o9
	Mb7mAmBIFx9DHo/5IpQY7YnU9O78kBMk09yge9040f+7Auc/P/kwU8/jK5z6bs1z9ui7O9ZjDz1
	DE79vTXgxnKL+3FRCt1BSNupeFFcX3XD5V5oDpqnCwUA7dp0CNrVOZQ3Gwjt0raXsKXddDR6X/J
	s2AGyfRsHluzWLttUJbm2Y8ziOksunpOd2LLy0DKrRUL9M9itTNXOtrNCBPaRejST2QLUyXGPiQ
	GXmwVDwErQ13Xfo=
X-Google-Smtp-Source: AGHT+IEcdFb5dU4BMohRNVDTKw9QFYRtiS+kD1Qk8n+hawpZuIlHV5YgyxsF/gZsw+0wIwlq6EXHaQ==
X-Received: by 2002:a05:6a20:c887:b0:1e0:dc7b:4ee9 with SMTP id adf61e73a8af0-1e88cf7ba69mr46271498637.8.1736941100514;
        Wed, 15 Jan 2025 03:38:20 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405484bbsm8980275b3a.31.2025.01.15.03.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:38:20 -0800 (PST)
Date: Wed, 15 Jan 2025 20:38:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom: Document the IPQ5424 PCIe
 controller
Message-ID: <20250115113817.GO4176564@rocinante>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-2-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213134950.234946-2-quic_mmanikan@quicinc.com>

Hello,

> Document the PCIe controller on the IPQ5424 platform using the
> IPQ9574 bindings as a fallback, since the PCIe on the IPQ5424
> is similar to IPQ9574.

Applied to dt-bindings for v6.14, thank you!

	Krzysztof

