Return-Path: <linux-pci+bounces-23436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D0A5C455
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C9F3A7AA9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6F25DAE8;
	Tue, 11 Mar 2025 15:00:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309B25DAE7;
	Tue, 11 Mar 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705205; cv=none; b=AxqrXvNdQQUtuLt+RsmaHwH52ibiy49JNouK89kv6WIv0NmxxbBlJcpdrp94ux/SYXopJSO7uqR6MJH4v12V8Yp+BkuSMRu+HaukDY7QlJKfgMO0krzeJ5O/XQIVl99TSLvU3BNCRbMVPd2UaJRsNGYZAnC/jWqeKXjdk3i1vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705205; c=relaxed/simple;
	bh=5PJkwwYfGL4NbJsE8apZ0H1rlDQsfGXPYywEs5a7dgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbHDEK9m9Xwq9N4o1+WteyXg+HOz3d5+XFzNA6YdALqtHqdUEP9YuS5/fJ4F3jK94mVmETyxyffrWajjL62M9eihnj5C/vFfxxhv+Csj7oTDXNSHdb3lWyJLBwuXC67ue7OVZGlUoYia0lXS1o1Vnk+EUAZ3to/HjqtU9QuZtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22401f4d35aso99883015ad.2;
        Tue, 11 Mar 2025 08:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705203; x=1742310003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaJ8SLFG93FwYkFp7sfKg4X+KPodbWjwHYeXqqA9L2w=;
        b=FFoNtEiwGDLcjBi3pKplT3KGrBuVaYywRABFEKQcnpb/oRicGBtN/F5+BsTM2+AGAq
         q85c+riylkGI1yoSR0Ut/6CyOXaB9HRSg7ofHzVEgKBluTUcKmNs+7gyX1ZrthlzC2Oi
         v2Irl/q3OCRcd4Di0tR+hBeOlO2PZ/Zn3PA6JmKuG6QXzg/JQBsM01Kf5q1Ux4ccNveF
         XcVxwrGd/Q8S1L2xEX11Vx0sL9MEGS06Ss9Ytcow4IqLU3s5uUzqsZWkkRHjILFLzOZ3
         oOOQu38NnMD/LbJUNQka3FOYy3vzgxBjIx1CBi3/IOSAiEiVSwaNFBATY/F2MeRJzd73
         h1pA==
X-Forwarded-Encrypted: i=1; AJvYcCVEzkJi4jGb/FUgw9qK/VUzc++Zi2BqTaNcDlMgUwYX248KH9JLylKi8CA4rSu1Ftix7YyCEwmsbgV8OGA=@vger.kernel.org, AJvYcCXVxUtxs3k3Sa+RwtAIPX4k6yBrAidjy6k4LM14sZqbX+qVGIOa7AVKJVpLz+szIpGtVLe7+iQL@vger.kernel.org, AJvYcCXWZ1zPziW2e5qiyOargm4i33YeTcr951JBAlQal5mEXNrPfGmP9fPcTwU7COzo/KHnMnu1T+riJhj3@vger.kernel.org, AJvYcCXhxjevKAo0yDcAHYyrlmOzl2HAH3dUUrs/iywgT6YZ22SkNYUwBHNQSEkWkP9lb0hHUxcqcJl/3NNNaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CxHK8DVigpg8QYCc98TJXpCpmQudIgSBVuzz1jsRThFzZtJt
	IvD6/Ll2HBPumXyN39oxdQdr8nzsrQmCUCq68uMfXaUMqAS71hK1
X-Gm-Gg: ASbGncsKcrLvqhLnWVyoJSrU7dG1vBYR5dbjMPt3JiBaM5cngveBfJ7MiEjCdRbEtxN
	5WiTNt42T7wTsDA88FP7Tql6oVvQ6Ouud43hLqGw6PfQS6LH2ExnxvovvjUPWjewQFnkGeR0/RP
	sZwtJCQieIu/otZcNTfBW0cy7ecAcCKabZo5IPftdKZadRKGd49JZntfSSxu5ukb1ObYWrxSvLT
	br050e4JNF5SvXeoleu2uGMXPHZcWGiJkdQyvA/frtnRSQ1v0E1bFif8KXX6ZTH7Q2kDF468mWY
	0oZwJVTd5euVIN03C6zZeTf1UXBgaQHDPLfcsi3z4MR8kRgqYUkVU0DVYUsONvAi9wvovt/L3Zc
	LMjt2d/OvOuK7uw==
X-Google-Smtp-Source: AGHT+IGDF17bVy+X8PD1CLxyryITaYKCJ8HP+TmrU6K1QilfB9RwZjOgz3kvEQi1n6fSoKOwqa28aQ==
X-Received: by 2002:a05:6a00:cc4:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-736eb7ffa52mr5264312b3a.14.1741705201877;
        Tue, 11 Mar 2025 08:00:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736e3f9d4f0sm3313957b3a.145.2025.03.11.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:00:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 00:00:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311150000.GB1381004@rocinante>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305132018.2260771-1-s-vadapalli@ti.com>

Hello,

> Commit under Fixes assigned the value of 'linkdown_irq_regfield' for the
> J784S4 SoC as 'LINK_DOWN' which corresponds to BIT(1). However, according
> to the Technical Reference Manual and Register Documentation for the J784S4
> SoC [0], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1" which is __NOT__
> the field for the link-state interrupt. Instead, it is BIT(10) of the
> "PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds to the link-state
> field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".
> 
> Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> already reuse this macro since it accurately represents the link-state
> field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.
> 
> [0]: https://www.ti.com/lit/zip/spruj52

Applied to controller/j721e, thank you!

	Krzysztof

