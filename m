Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61D8392D8C
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhE0MHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:07:20 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42717 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhE0MHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:07:17 -0400
Received: by mail-pl1-f179.google.com with SMTP id v13so2224164ple.9;
        Thu, 27 May 2021 05:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPiMEwGlMbValClUSlx6NzlbN5+iiX4yU0EKTF230x0=;
        b=pT9gOuNC6izptvwsqIv8ZiEah+pFgewb0fZxJ1sOzA6YQEBxZqKXT+DY630mVEhaWU
         kH73SI3/m9tNClsH+JE+mEQELJls7Z1IF9pExEA6xeDaRglt3OPCLpWILl3m+385gKYk
         XHXuCLTRd5tWzJHVtOlRfcZ9pc3el9tX8QgR21VoM8C9bOLu60AE61N4KZ+MP6RaKmuE
         x6J/VtAqka30xmvrMYzjqlPED/CeQWWvPRM9LNOCKAuuxAYzH2NflwwJtXO8G30kydct
         KsKs3oHLuTb6MYHpbbgvvGo8lAR55Wpnj4NwEN/c/gwD4Kh93eYFUyuNgr5cX5Kulfbr
         wpxw==
X-Gm-Message-State: AOAM532LSQAjtJyAb7aAqKIzcgOd19ga52jnZ0vY5UJ2CSCJvBmw9iaH
        G6usDmL19t5lU3VAozm59cM=
X-Google-Smtp-Source: ABdhPJyq4o82UeSB/VMcI2HzJRqIKhAhsKPTexGNNjmDEjXXMkumsNeSiYwS1PfP5p1QerPuXbAhgw==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr3367014pji.85.1622117143281;
        Thu, 27 May 2021 05:05:43 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e23sm1888250pfl.84.2021.05.27.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:05:42 -0700 (PDT)
Date:   Thu, 27 May 2021 14:05:31 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 4/5] PCI: tegra: Don't allow suspend when Tegra
 PCIe is in EP mode
Message-ID: <20210527120531.GB213718@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
 <20210527115246.20509-5-omp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527115246.20509-5-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prakash

[...]
> @@ -2276,6 +2276,11 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
[...]
> +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed");
> +		return -EPERM;
> +	}

Would the -EINVAL be more appropriate here?  It seem more appropriate
when something is an invalid operation, rather than access to the
resource being denied (or something along these lines), what do you
think?

	Krzysztof
