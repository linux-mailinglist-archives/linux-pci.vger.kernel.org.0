Return-Path: <linux-pci+bounces-22723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A1A4B417
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B047A51A3
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715921C8FB5;
	Sun,  2 Mar 2025 18:33:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AB192B84;
	Sun,  2 Mar 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740940435; cv=none; b=X++vvQQ802B8Fj6pnhCdvQEFz4O5WzlwFT/RE8jhj/Qv6QNiZ42XZgRznFXXU2YeO43ggIoILHUg/7tggQH2I46tDNTMMq4ALesDMI5CsO7LClE4SW4rSylAerAQr82IJucRsMFYmS2B7f+2mJeovlWNf3S3fWBzI+KM9qOIy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740940435; c=relaxed/simple;
	bh=Iarv2jNCOut6VEhOawNBIhN6SW8ZEQmOf3JJE9Gq8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiJREA7PgHD6voyPLQurw5Xh1leeL2ScXNsfUtumqE32rfeARerJFXjkwnrcs+t71JSYI5TwIVZijwxrjXseKo3K+6s6qKcgPaOl1mMkpSJSbvfwk6rdasy3Tces7G5IShn3hyMUHyUGTkg1jaSX8ENzjg4Gc2UJ3YRNp22ODFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223480ea43aso92523535ad.1;
        Sun, 02 Mar 2025 10:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940433; x=1741545233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Yh9rplRggc5FxJ1RIvi4crO+++OZizbZK7ALVaIzps=;
        b=lmqj8hh3e1UoHtFNHbEShdJqSKhRp1YJz1ZrfGy6JjLC+oh18YaB1Qus3AxxfNPCMU
         KZcaJOKWscBXknJb5ynfnsXbhNCXpSxawR4qC/W8SRCGqreU+/T44G+9SWuvThnVV/vD
         msCWJRvoqqHzn1xbczIIaHGpqW6yfy1pgvL2PfEBkwMznPM8c06xfM/f7HJzvwjX8PcF
         qwXuVbyfMeOc6dwr895dmpLl8PaHfKA3ch7q7mkAwzzwnJnL23Kp8p35VU6MJA1lnUQ4
         TNMK8vmw6obAIVqbslLepHzDDZFGECBaIWvXNRAigvsuYw4keQSQrJoj/IrPaf7j66KM
         YfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUc2iaZHeAMTHYUFl+dfTL1+kmIrhhyyxmyp5kx8r8q629+xXFJt6deRU2sRTUm7NCHqEFQBSCZhR5dENFc@vger.kernel.org, AJvYcCVGLW9RPWF3cBmWHpzOCQE077h1bKgZ/8nCZDoZ/pp6Y0KgqapkcEIAXvt7t6ZFQ/BivZemOYxDEUsA@vger.kernel.org, AJvYcCWuLLRw3ZsA14lCJ0Coc0T579vo53hbtnKGBf6xNf15X6Ek4zO0ynBJENkWRocS6nZUjsIn4zMUTeHb@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFsbDXTflIyA/h6eUp+nTaE0BJIubv3XcmGfZpM5uTuDHzTj7
	pZFvrlYgUYI0wGs/Ny4nDPVTNSVmiJ6YacBPK/XxiKr2en2PyZsR
X-Gm-Gg: ASbGncu3/mYshkAdrTBZL4Cv0xmX8GplQg0sZILoH7GhuPXI8k9oPnRomc8IhAdLf2G
	0hktKiPqg7fhhs+RMQR5uj75LGJ5N6LLDlOaOD17DhyyAwa6VGSpcNt5nw8NsnrRC5dxtBzOb0p
	V393XKtjMVj+p8qPzwZhVPBbT3AmlCSS4ctWPnD2f/yWW0gtasO56aik8eDmmYXqnpDJ74EIWSa
	mCyFK8RewDPKnVmaaoa/GiW4xwszxh0oVhAD4Em4QwILEhAL8fpVZhG4JHtwZVo5E5Knm6tpxfN
	XFJBn0fCp1qCLmDrHem0Ofug2VzCVbPXs/HrqzEpJN8XRwTOoBBdtE3uSVbK2gDXjUmTEHo2Q5w
	TsKc=
X-Google-Smtp-Source: AGHT+IG4xlsabfC3ueoNUtYFxno9MpU1Nic1e92boNt4POmPhSK1me9MOsW0k4qITZedwQCtc6SBJQ==
X-Received: by 2002:a05:6a20:2588:b0:1ee:c598:7a93 with SMTP id adf61e73a8af0-1f2f4e4e608mr16937275637.42.1740940433018;
        Sun, 02 Mar 2025 10:33:53 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7de19d71sm6662123a12.19.2025.03.02.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:33:52 -0800 (PST)
Date: Mon, 3 Mar 2025 03:33:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v15 0/3] Add support for AMD MDB IP as Root Port
Message-ID: <20250302183350.GB3374376@rocinante>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228093351.923615-1-thippeswamy.havalige@amd.com>

Hello,

> This series of patch add support for AMD MDB IP as Root Port.
> 
> The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
> As Root Port it supports MSI and legacy interrupts.

Applied to controller/amd-mdb, thank you!

	Krzysztof

