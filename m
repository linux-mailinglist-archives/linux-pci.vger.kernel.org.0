Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDD8392DBE
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhE0MOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:14:55 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34532 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhE0MOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:14:54 -0400
Received: by mail-pf1-f182.google.com with SMTP id q25so446120pfn.1;
        Thu, 27 May 2021 05:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hp+Uy7UVKG2i4DKsG6eZskROxgnGGiFzGKlG97gaaTY=;
        b=AiIKST4JmhQzcRY2fhfNDd/ps8dT9SdwmagRYHKHoV8KZQHCgDRARqZ9rF7Mh+cHoj
         F/VhyrgLeYubzpwEEqQCkDEda8X2ddhsomOcrL6jtk5rYWr1ibO9gE2AXQnOqnHzAwqn
         sYBl9h7Vpd/hKutz7vB6rHdC28N6IaX73IdDb5sgRf/g+l+7YqGmHgfhZ6350HK4ov4T
         hgG5loa8WA1tlvaRpbQNjpVTPHfm4Voyo+ZgIVDjsZ31G7WyDgLrtCohMBGw7xrp5M3b
         lFSVDVFQhu25mfeY7UHTSMNMKVSbLCOfFAiFCwVY/ctprLYDMuNnpPlfI/A15HNECbwk
         DJ0Q==
X-Gm-Message-State: AOAM531uXCCfYMcfIPybLLUFmSctjmyLy7hjfNqo/WlQh4rhmw95YtQv
        wwWRLGexsq7ocmuCrdsCUNg=
X-Google-Smtp-Source: ABdhPJzB28t814SgXj5tmGrrEwAQwUL5MPndC9/+sOTzEgPSfjZDYWZh79wNAEMuzStikwuubILejw==
X-Received: by 2002:a65:6a4f:: with SMTP id o15mr3415028pgu.399.1622117601772;
        Thu, 27 May 2021 05:13:21 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g72sm1840414pfb.33.2021.05.27.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:13:21 -0700 (PDT)
Date:   Thu, 27 May 2021 14:13:10 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 3/5] PCI: tegra: Disable interrupts before
 entering L2
Message-ID: <20210527121310.GC213718@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527115246.20509-4-omp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527115246.20509-4-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prakash,

> Tegra194 implements suspend_noirq() hook and during the system suspend, the link
> is taken to L2 state after PME_Turn_off handshake and if it doesn't go into L2,
> PERST# is asserted. It is observed that with some of the endpoints (Ex:- Marvell
> SATA controller), the link doesn't go into L2 state and asserting PERST# results
> in Surprise Link Down error and the corresponding AER interrupt is also raised.
> Since the system is in noirq phase, this interrupt is not served. Both PME and
> AER interrupts are served by the same wire interrupt in Tegra194, and since the
> PCIe sub-system enables wake capability for PME interrupt, having a pending AER
> interrupt is treated as PME wake interrupt by the system and prevents the system
> going into the suspend state. To address this issue, the interrupts are disabled
> before taking the link into L2 state as the interrupts are not expected anyway
> from the controller afterward.

This commit could use some formatting, perhaps splitting it into few
paragraphs and also I believe your line length could use some
adjustment.  Having said that, I am not sure if the whole detailed
account of the problem is required to be included here in the commit
message.

> +	/*
> +	 * PCIe controller exits from L2 only if reset is applied, so
> +	 * controller doesn't handle interrupts. But in cases where
> +	 * L2 entry fails, PERST# is asserted which can trigger surprise
> +	 * link down AER. However this function call happens in
> +	 * suspend_noirq(), so AER interrupt will not be processed.
> +	 * Disable all interrupts to avoid such a scenario.
> +	 */
[...]

This code comment added below makes for a better commit message that the
commit message above - clear, concise and straight to the point of why
this was added.

	Krzysztof
