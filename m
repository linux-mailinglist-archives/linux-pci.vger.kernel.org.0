Return-Path: <linux-pci+bounces-9213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA7915B88
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E611F2282F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3E10A19;
	Tue, 25 Jun 2024 01:14:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB015AF6;
	Tue, 25 Jun 2024 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278098; cv=none; b=kZ3AChF5XYiiGsAkARt6MP0YOc+9Kag+X6WBU4eqIOxyNf0ZUeKY+I5mt77brfj1fGX4rdimLU2Gf/Pucw8sO6Uoqk+rbMrV/xRhlZkicm5dFEodRwqO5ZBpD2ouAS4WOdgLiuE+jZ3/74p3uI7iXZKnsfAq6Ge11J/QNk0IBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278098; c=relaxed/simple;
	bh=eV0yzaFqlIC8vZu0Zx3OR7xNW0La5ndN7NeSp+FsvTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uktlwh5BH4K/pMGOn1HbCNBtsksXqdGcgV05oSJQ5wzAFvOcf/KcxuqOHbz4FFe8ir+D02Ul7xSynv17dYGbhkKOQDjMU7V/CSKpMlBui9Imbt4zH2k5w0wx6zjK3L0vi0pZuFPDYkDXZ9A1A4ZjANgctPnJvylEAxCcQDt3V+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa2ea1c443so15661445ad.0;
        Mon, 24 Jun 2024 18:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278096; x=1719882896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58+IK4nz8S7JUb3W06qCngcSuzQ69kddYUFOVpCLfY8=;
        b=ZnL3CXBbuSH0Tepf/BpiYI8NgAgDJaNpdkCcSEMZh0gz/bIr68yqPFMCByVTc0+wAs
         4vlSQ+kqxakZ2xzXgZTR8k4eRdKlb3HjjIzcYXjvVM0kbIe712FxM6uLN/j7Glz2dEIh
         Io3ZpJ5RcUazTNw4dfhFOw98sEA1HCBdWhJd9Fdd6a7QeRxeg8h5n+tMPBF+uXW4Qvpx
         sIMVoDDA4hxBCvaI5fotW502F54F2j17+8tlpPa5I7vMEQQnSJlKbNLu+jsXJgecOykT
         oWLu0Ej8UKStDk2ow2LTYQ372yYlcdHycpUifQ5kAqVxqknwV0K8XT9oF+BQeJhc2/Ql
         HYYw==
X-Forwarded-Encrypted: i=1; AJvYcCXPMD0Zyd4vT/QO0Oy1JcZNyCfqCC221eYrrOwvmhvJOvdOGnmUjUA4gO1DzL3lBnyKKYGtm4Xz2QrkUiCIn6ba63OP0nQcj7MuGEopnXx4JGQb6Im+xpPGOZNPBoejToiNJ809FapVYtLX34t/7ro/xhKJHXOHgegFl5GLhL3hXnyRjg==
X-Gm-Message-State: AOJu0YyfRLbefWK9jFz3zawSmZ7687AN0NRxOM78lqwAPsrTn+u5cGin
	w2lSFfawNSfT9TMHicR/WYC2Gtse5Ddq1HuFe/ajNRRCNWM8cQt6
X-Google-Smtp-Source: AGHT+IFSxNNpL4rNjWmswcHmrpd1agEl7SBJjG/npPx3p9kTghopQIoFmVYxjUiv0CqGXjDen0tZCA==
X-Received: by 2002:a17:902:d4d2:b0:1f7:3a4:f66f with SMTP id d9443c01a7336-1fa23ef7c2cmr71053545ad.43.1719278096395;
        Mon, 24 Jun 2024 18:14:56 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9f1e2fe37sm66296225ad.69.2024.06.24.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 18:14:55 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:14:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: bhelgaas@google.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Fix ranges property to
 avoid overlapping of bridge register and 32-bit BAR addresses
Message-ID: <20240625011454.GA431470@rocinante>
References: <20240624111022.133780-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624111022.133780-1-thippesw@amd.com>

Hello,

> The current configuration had non-prefetchable memory overlapping with
> bridge registers by 64KB from base address. This patch fixes the 'ranges'
> property in the device tree by adjusting the non-prefetchable memory
> addresses beyond the 64KB mark to prevent conflicts. 

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: xilinx-cpm: Fix overlapping of bridge register and 32-bit BAR addresses
      https://git.kernel.org/pci/pci/c/f55aed050631

	Krzysztof

