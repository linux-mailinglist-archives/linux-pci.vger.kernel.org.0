Return-Path: <linux-pci+bounces-21904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54CA3DD52
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCA1746F8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498EE1CB332;
	Thu, 20 Feb 2025 14:51:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E418A6CF;
	Thu, 20 Feb 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063092; cv=none; b=XRH8nbjM4Gb5k914Z3TfWyrxxgbm1mSrc6m1Ez8Kv3gnDAuDLi3wToOcrzDSfemluee5UxA7cXhQCbw/Zv2ddY4/iXFm7BDyEM6e06qBTQLP2uokUEI6qWskva6nuCk8PvHZstc/z0aZEuo1Yu3DAO4aqn4TUIm6iM4qqJ1c2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063092; c=relaxed/simple;
	bh=YigPOSx0FrxVDFzK4Q5gUpQLHMc9FWJmNy+x9rZcy94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1HvVP45BjL3PouMohT8IUq0M8hWf43qXMRaFIkO+cHHhMVkmQCN5u8waVCWHJ8joLMfLF86O9v2ZSeWyuBFqQtlcqgElOvU9kAJxJGLnfrMRF72PqCAZ/ZYBpzlFYOLjictt+7NHuwpgqMfNf3WvNw/Gij4z30gmBy6WZI+oP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22104c4de96so17209485ad.3;
        Thu, 20 Feb 2025 06:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063090; x=1740667890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jy3mQRgRVU2vUxlwRfGBxBzH68yyELG5OxStWqTTWqQ=;
        b=mcS5WmzyCfyANynMotcxPcxkPoRp8SXjaW51q8I59x0V338jxIpL7my9gK/MrN4IhN
         qBbgFkOwD9vs28kLiVDdzYrMslNWYuVHxV2jJoLPcv5yXlNw1wF1W4YikEUpOlTgozTp
         a4NZXOAwx68gOXu5qbtJpWqJOZcsTIS701RReVIcOQJKohO4yAJaWOB0u+fUSTlpDsF9
         yGdKYmqD3Lu/5qMWGXA2Jq1FZAGgT+gkZQc2zeveCQAcnLAOsItSsiJsEVa8fSEmP/YR
         eC+1AM1QlaR12grquJS8qXxvS3VnRID37Wh1WidDSMVEAsPhyqQAub4XpBkXDGmmCSRK
         fNUA==
X-Forwarded-Encrypted: i=1; AJvYcCXeer2dCdaNBewVPXRSGbgHAoLffWHeo3MTQt1if/C+xOdhDrIqK5fjuBhdZmaBHkweUaYW4rg4dMn7a7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6ZC2T9mQ6pWfIq6mahMzdXOzxy4NrD1TWtb0LJRSZmxvI5zv
	r6tamyeyAxK2NUy+v0kOwNx8UEgizmB/Ek3guXajRXAce6TN3Gkb
X-Gm-Gg: ASbGncu1Od9DulAQ2+Wi1QBiov1a8CqoJDuxmhbX84CSsge02CeM44iYSus94nOku5f
	Hs4hz4FuqzIDiMGrchplj5ETPnraW7lgfDAajKQ+C+wA4wBbVjnFYJg+aJwxEt7R9EXH7xew3S4
	kAsxtgOqbEd9T7lmt91x5g4BEa7IEBe58v4fjxPoReLN7Xuz+NgolwjvGY/mqI9nCDaQ17eG/+H
	V+3dnJFTBt8o0h4bqLsaUoNpGg+3gUt0fjCpoFVA3H+DrC101mVPt23q4WbgFUIav2zObsN7rV3
	PF77w20HzOR0ujXT3G1JaOE0a88wmsn5fctgPw9pZIyyHucoEQ==
X-Google-Smtp-Source: AGHT+IEQvdJF7vSBVcv1qxen8l5KSJTg9fuwK9R95HWCV8z1yT8iLSfyq53xyqcofBz+BzQGYlcC/Q==
X-Received: by 2002:a05:6a20:cd8f:b0:1ee:e0ad:e6e9 with SMTP id adf61e73a8af0-1eee0ade943mr8776240637.14.1740063090006;
        Thu, 20 Feb 2025 06:51:30 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73284a7401dsm7194066b3a.134.2025.02.20.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:51:29 -0800 (PST)
Date: Thu, 20 Feb 2025 23:51:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250220145127.GC1777078@rocinante>
References: <20250218080830.ufw3IgyX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080830.ufw3IgyX@linutronix.de>

Hello,

> The access to the PCI config space via pci_ops::read and pci_ops::write
> is a low-level hardware access. The functions can be accessed with
> disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
> raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
> PREEMPT_RT can not be acquired with disabled interrupts.
> The vmd_dev::cfg_lock is accessed in the same context as the pci_lock.
> 
> Make vmd_dev::cfg_lock a raw_spinlock_t.

Applied to controller/vmd, thank you!

	Krzysztof

