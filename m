Return-Path: <linux-pci+bounces-15894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF719BA828
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 22:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8327281BD7
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E11885BB;
	Sun,  3 Nov 2024 21:01:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646801632D6;
	Sun,  3 Nov 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667708; cv=none; b=hY4OZ2UiXr1DeMwSFfXIuP1FTyUv5G6zj0FrBRVZbzhcjpwct0leIGwbkl9FqAKsaZjqp/8/BRAJFTxzf4hODMv/321Ubz+t0CmpihI6fdprRODmVexsZr++oFFSRSOFpTelzg7u2oe1m6Sxeb4CsDM+hx2B5IOqhXjcuG6WWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667708; c=relaxed/simple;
	bh=oDP5IETt83QMPngZVYNu2LdHHh1WGhWIe9/kyX2rz8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcGXlSMnn1E4E7hLAwRkkEKXmXcrlMZJq0C5pQhp6StBPHwgnczXqn4R43RgWrOSq88Vx3AwsKqjJ2r2eaSj1OPYGNMr7YjJfrgFfH7pQX4xxGrRtZlr5E42TmOh5srYuGVllB6WcywAiPR3wQyS2Lyb6IMpX6H2OqYd8N/bY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf6eea3c0so27219135ad.0;
        Sun, 03 Nov 2024 13:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667707; x=1731272507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y30sdZvKe4JgHeXVdVJmVDKp4byT62Ma5mkRcbshZw=;
        b=oWM81uKgxLmosmWvmZ2PKt8P+fwX2araIFjHwbRTbVLTQKj1C/zJ5Orupt00ScQYFk
         2orKj+JOJwcbxCrUx+PwnJw3bLn1YJrFAhnJoay8skr31BUpClp/JRoBETcHQS6iQneV
         tmtunG+GGtSACByrO1vlAzI0Yv12Htr/6OA6FMTXwEpaKN0k3iUvW2PVYQsNfJq4YAtz
         kTX/G2P3XL9VOzrOI0fvvT9PJhkzYdHWaRBhGVDCL0ORdVrl1W7hIsvio3QSs7IgZVwQ
         1+5ig/z1TnoH2+4/L0TVJ8tayQcqTo5xn6Swj/zgT8oS2Jz7/mEBGF2vkpwKMVBVQA2a
         V0/g==
X-Forwarded-Encrypted: i=1; AJvYcCW1RVXMlVNuEJqT7XY74+Uf6cTHZX66qLp9YKqQGIsDjjVePYMWENEUr2FyTwsbpN3twilLdR6/JXYiudmY@vger.kernel.org, AJvYcCWkU7ySZw/uT8rZ2zTFGxW8MSCc6QvFDV9cdbqC3DTReM609xJPEwC6aRSuwgTgEKFHQu7yNy5ttghZYSe+Ag==@vger.kernel.org, AJvYcCX5D/WhpdE593zg7Z0axAZXebhusZ72di/rZyi46MjMQV07/uzUnhy7x9ZMNqGS1KtGcQL8mTroMVX1@vger.kernel.org, AJvYcCXpaBVK1Wd7bqafvjjX2oPoIjuZG9p2xiJGnf1ZX6JUzlMwPPyrO3BiywKcDHs0fJqwFRcJwd6fMh5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTUgEEn50tkfkvz9ZADdsOK2ZGkeZmvezAZT3GNT0hJaMlIRO
	7qy9PaDcayJTaySEv+v3I2wunIpNDqfF7sNNsIhYAxPj5g6G69DV
X-Google-Smtp-Source: AGHT+IGtOoutOOg5Ad1c3AW1mhSjipR6pKw9jokJtDrUDVBQcebhluoeYbn1D4QnorKXm8oj7TBGaw==
X-Received: by 2002:a17:903:244d:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-210c69e1c8emr395815305ad.28.1730667706370;
        Sun, 03 Nov 2024 13:01:46 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da9841bsm6149780a91.8.2024.11.03.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:01:45 -0800 (PST)
Date: Mon, 4 Nov 2024 06:01:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 0/4] Add PCIe support for IPQ9574
Message-ID: <20241103210144.GJ237624@rocinante>
References: <20240801054803.3015572-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801054803.3015572-1-quic_srichara@quicinc.com>

> This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
> PCIe2, PCIe3) found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host and PCIe2 & PCIe3 are 2-lane Gen3 host.

Applied to controller/qcom, thank you!

[01/02] dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller
        https://git.kernel.org/pci/pci/c/e0662dae178d

[02/02] PCI: qcom: Add support for IPQ9574
        https://git.kernel.org/pci/pci/c/a63b74f2e35b

	Krzysztof

