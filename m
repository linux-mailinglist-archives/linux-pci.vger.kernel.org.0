Return-Path: <linux-pci+bounces-21907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29733A3DE80
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EE6188A92A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE162010E6;
	Thu, 20 Feb 2025 15:27:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17D1FDE35;
	Thu, 20 Feb 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065272; cv=none; b=YjhpHGFT8iXxKKyBO+/PtNQHTBc6axyHTR16Q4ZqiYhyR9AhMrKWRq2zr6gjtedGfPY9o3/Zb76+p1bcQo43nxyQEa6qeRFUczOA8bT1Zncd18qcJSkQRVJyMfTpxozv1Jr7PKty1mehgikM/e9eUamugqAEiU/yOkbsSCXC6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065272; c=relaxed/simple;
	bh=KGswvkIqG/8FWjEnabCRQkJO73Xpx/BMagFR70RGXgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+6xVs2Qd0mdLMOYguhQcuKZOfavhKTvyV7r8E2HCStoEMdTvDRlQN/Qz9io+dTShYWIvJkTlbcU42TdP9DVJxq1NBGoAXkac+iGxgkJpk0Y/Z+JnZZ0sDxWgHPS68TIBgUTk4JnJWiLSzhnTlHdQVkzXXx/sASJFCzkfQJ7r8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso1687262a91.1;
        Thu, 20 Feb 2025 07:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065270; x=1740670070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIQfSE0EI2Dxu23jjgqsNc/1C3k/ezRz6dk/fxTscZ0=;
        b=u/lSzIFOgohRNx83PWSthig0x2uo6K/tl+YL6SlPgGfGxPotondDrWiJGQeY9ta/3i
         sF82ezjpAT8+DFEAcIngdYkp/YD9zHgEyS35T4AGnz95N7KpzSfqtszohlzYlMoFW3FQ
         9d2J9cpG9XnHrmuBZutwXiEvp4k8d3ehZWJ9aOgEcdr/7dhv7P35IcXZsPwzu08G+wVZ
         ZFaF6oD8FO3xB8pN6qMLayN9CnNl71HS6BTJp7VBZlXPN9DN+GeMSaMp4pjbMR8X6Hc0
         BJltRX39gHJn8MitEXXsqh+woF/8HEw8WpCAY7W1JW/h/o1a8rAKG3Zsv7gq17JopbcO
         xZNA==
X-Forwarded-Encrypted: i=1; AJvYcCUP6r8eO3eKmeLef7cFoYAszFPNsY+Qh4QyZru8rjHSqsePcuWAPPS2S2R3BEns4/b270ZnmqoB6MVK@vger.kernel.org, AJvYcCW6r5XVvCtqAdyUYDETPl6PT258LjbMZDRMOGBWlohS2VIqrCkQqNoT0BtTIvnWOeDFTPWL4GSqonNQp8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYgIxKkQxZ7WbdvsGmAyaJXcDrpiOOXWa2AXl/1Eq94qEVVmM
	3v0Qn9k4cmfIMX983tzFj4wzPS9q7NxZkgA80C7XUpB5h0C00uit
X-Gm-Gg: ASbGnctjmgQrOIGiZWcXUG7zhuvAJHJOxvitdmsGaXMNomkFkT3LHQINsjdJhh1Fx+K
	JE3QvFsUNSoWzdhMaMNfepOLDPxsSf2OAOFIFNhOj572m2GOeL3vxTF1MJlx7HKXt7pbzWPEOM/
	ShmiwYOwrLY24DihEMn3ECouiPpMQjnEHBqMZNO2ykLaLrFbMF9bwtdq5QE4rSolRKWTI3Yl2D8
	iZx2Oxdqoq9tHyq24aLGlNszJVx/jXLxPq1Cc2YHyfoVjZA/uoA1bLvAbODgZOdOQkh54pwpuEb
	G8JQvxq2aahZJ4AfcK51HE66ba0pWUaynhpCQk4Ukec+oryL+w==
X-Google-Smtp-Source: AGHT+IHt5km9+jdGncPtkaresa3l6P2z7fy1FiddcxIvpdlML+Jrubp8HBKFMPY+knP4FO8RHlUnUw==
X-Received: by 2002:a17:90b:3886:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2fcb5a39f3bmr14293908a91.16.1740065270430;
        Thu, 20 Feb 2025 07:27:50 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98b4c52sm15980264a91.4.2025.02.20.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:27:49 -0800 (PST)
Date: Fri, 21 Feb 2025 00:27:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix double free Oops
Message-ID: <20250220152747.GA2510987@rocinante>
References: <20250124123043.96112-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124123043.96112-1-christian.bruel@foss.st.com>

Hello,

> Fixes an oops found while testing the stm32_pcie ep driver with handling
> of PERST# deassertion:
> 
> During EP initialization, pci_epf_test_alloc_space allocates all BARs,
> which are further freed if epc_set_bar fails (for instance, due to
> no free inbound window).
> 
> However, when pci_epc_set_bar fails, the error path:
>      pci_epc_set_bar -> pci_epf_free_space
> does not reset epf_test->reg[bar].
> 
> Then, if the host reboots, PERST# deassertion restarts the BAR allocation
> sequence with the same allocation failure (no free inbound window),
> creating a double free situation since epf_test->reg[bar] was deallocated
> and is still non-NULL.
> 
> Make sure that pci_epf_alloc_space/pci_epf_free_space are symmetric
> by resetting epf_test->reg[bar] when memory is deallocated.

Applied to endpoint, thank you!

	Krzysztof

