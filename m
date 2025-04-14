Return-Path: <linux-pci+bounces-25892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D3A88FFC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 01:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980F3AFC1B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534E1F3FC0;
	Mon, 14 Apr 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4nsliAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712E1E5211
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672568; cv=none; b=bZxK4dauE0EOKnL3/t8J9buinGWTGHHEQfYX2rnfK0Od2oI17RcxOnYKT5/TpQ/Z3aX16HXMxU0h0Ykoz8EM6w+9yAVTpPePrzK4bW8j1UnfHE/35MQbjJBf/pJHF0QZfOg59aOS0tVcRURqkL4gl+llKWNpSdX2tQ8InDssBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672568; c=relaxed/simple;
	bh=7RJL7GBBV5nZmJ0yS9Gm6NjRypVsJlXMTCKHtHSWBRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElZt3I+KlNuFibFCjaj8ULclvjXnho4VcY8ws6HWRKQktLlci4R8UZOi3WsQzwDw4zywj9HJRyN3Ldfazvc7T4ieFXGdlhA4OkPgXrALdSBmM1r/9u/11aSxYT3OU40a401em5dCxNJLXuqf4z8pD6HlwfBmTtTiHpWHf1UlZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U4nsliAQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22403cbb47fso52007385ad.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744672567; x=1745277367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RJL7GBBV5nZmJ0yS9Gm6NjRypVsJlXMTCKHtHSWBRg=;
        b=U4nsliAQMyUp0LtxoaNU5XCSEeZwZrNj4/NeL3nMPsVrZ2GLYMw8pXJz8oaOr2ZaHB
         BHzjW+OUjK/O83PFlYi9sDSr/lxsoICZB6bVAz7skK23xi0lFDbcPRcagW03HZwwDXc5
         wzgCg7zcZ/PJrUVs6Nm6/NDlb2bbp2deTUoD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672567; x=1745277367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RJL7GBBV5nZmJ0yS9Gm6NjRypVsJlXMTCKHtHSWBRg=;
        b=bpuZG1cnLJfljMB4uIdzXapZ8DyNqpjNkTTc2nRCFTzLAWa3oenbwSLI+vcbZ7Z5uL
         HLOXcIhaMHYQ2yuswBaTBazQ9SsmWS9WY0nmLIhAhtu4Pkxl/nZ67TE38A0o8V9/Nkqy
         WCO9SdhypPOcFmZ2QIc71hb7jTzj7UocOTFb/NMT9QNyUSFWP2GewPjIjsNzDW4IZG+l
         YmgK3X565MdKVkDS/7LqO1V+zIJzO1XMoqoGo7a4i+dLaqXO1LGratMJ8+rCdPS1sDBI
         Dt8gLUQ5w4xK2pTpHuLh9zg5rggTDS7NS3/AWI/G0w5mfne8K+G7YEygOJEkwykJO4Hs
         ohsg==
X-Forwarded-Encrypted: i=1; AJvYcCUz68AIFWLg2gNcmcz1KBvmRYaFzhWGxWvpQoPnD5+mM2YH/BdA7lHSlcBvuDeUAZXdixa7zGs0qEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyji1heaOWSfbzHwCU0C3edDQiKaMM6otQw84BTKVsuaJ4FgTTX
	6EMOLoP+cEmKn7j9YQwDiF+ZnKNUSZ1XO8YVXsl3PuxzNWSe0sq0PZ2AoDJamw==
X-Gm-Gg: ASbGncsphZas0ZxPVEJgv2X2XMBqqKYT3hkItntyj45EYV3qjybHUXRJq6NrJ2dpgop
	kjMPELXAOhsthOEvzvU6GcSXKsJC7oDAKp88+Ng5ZJZ1drfSGb/e8hkUuUaqCUHehAyio+GRZr6
	nzH4cevWcj4ilPHdS1wppVW0kALWDyYYnKr9NTpDbFAZv079HFte3jJXNPNuRfxeX8oBSwlVFDG
	KMq7VGve/SYPR/SXOAv2NjPfQNNv3ffFmkAjglxet72BRZvNHEZRM9lPMP+UxhmCeypb4Wg+0TT
	dGb576ogxPzVLK6OzkH66iMV4y4aBmfGcI294ojqPHbT9eGyGIdZLrd/gHpOl1QCnynhNmi9PFS
	YJQ==
X-Google-Smtp-Source: AGHT+IHXVC2msS9Lv6MHRlDHgQ+8UmqZCQExOC+5nUPQFdZj1WNEowXz+rxUvsT8W2cEg963akZYUQ==
X-Received: by 2002:a17:902:f64e:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22bea4c76acmr213874215ad.29.1744672566799;
        Mon, 14 Apr 2025 16:16:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cfd0:cb73:1c0:728a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd21e1f66sm7163929b3a.84.2025.04.14.16.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 16:16:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:16:04 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dmitry.baryshkov@linaro.org, Tsai Sung-Fu <danielsftsai@google.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <Z_2XNM6FdRIvDx38@google.com>
References: <Z_WAKDjIeOjlghVs@google.com>
 <Z_WUgPMNzFAftLeE@google.com>
 <uivlbxghkynwpmzenyr2b3xk4uxeuqf6dow6ao4mptcnzygrw7@ylfqavr3ry44>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uivlbxghkynwpmzenyr2b3xk4uxeuqf6dow6ao4mptcnzygrw7@ylfqavr3ry44>

On Mon, Apr 14, 2025 at 04:37:23PM +0530, Manivannan Sadhasivam wrote:
> If you look into brcm_pcie_add_bus(), they are ignoring the return value of
> brcm_pcie_start_link() precisely for the reason I explained in the previous
> thread. However, they do check for it in brcm_pcie_resume_noirq() which looks
> like a bug as the controller will fail to resume from system suspend if no
> devices are connected.

Ah, I think I was actually looking more at brcm_pcie_resume_noirq(), and
didn't notice that their add_bus() callback ignored errors.

But I think pcie-brcmstb.c still handles things that pwrctrl does not,
and I'm interested in those things. I'll reply more to your other
response, where there's more details.

Thanks,
Brian

