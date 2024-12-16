Return-Path: <linux-pci+bounces-18479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F19F29CF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633141886166
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B351C54A5;
	Mon, 16 Dec 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkfYUpBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD8192B70
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329037; cv=none; b=kq5kwBxpuff6DE83O2mES1UM5g0SmZBWT3KzueLjSfqLzLU4Lsp1e3SXG6LybR4TG3CP7Ko5izU82NLVktgiXcsgEatvVfHbl8j1/zmf4U/7b4mDah0YH0yeyCM1bsHzqQniJTjTm8mCica+dWH0hcDZn4xr8nV5S3UHTju6amU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329037; c=relaxed/simple;
	bh=yOIMDtITdjwU8dGlUR5f1kxRPPSJQcdRUFbDxwRHrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+oha7+bFSAIlN+tjmbhXCN6as+jj3w8XnQtdahRvMCadi9zL4x5vRd8ODbu2RsF/Sv9nCEOYTRGnG4vAe4rI4PDCapOmJiDbO/LUlH8VLbReQuRmKL46BQM0GSkVKpfOQIQbyY0Zlfr9PkqtrQDe/ddBrNwyF3UrYpJZj2gUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkfYUpBq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7273967f2f0so3819583b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 22:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734329035; x=1734933835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8l56HNoVKCWoq3UFQbYWo8NhPQGEBKhUZs3vIB/kw4s=;
        b=gkfYUpBqvyEiXJARbueaiqOtQ6w/MIK9IUxJduIfjPEbNcd+YnqmTgjTbIJwNJTRBf
         Ilc7AAd4WuZ0oid+ofouRJ/0Op10+R5UuS9d4fV9oguvaZ7I4SZL+IyAkJkeTaTS7Haa
         Rge5w27OiYdJRnAVffmoER6TFQq+dGqZw/Kg12pRRqQ19n3pZcL+B4biRbP4bg0/oDua
         CUNPmDGMZiQy3aQjQvIM4KCX3/T6E+99r62UVpQTp4OUPXGS0Zmk135ImWd74dgRDbkt
         3B1lB4pdnhDKUFjk9kkZQZaBlftvJBNPUTzOzwost+Zlm3n48+rP4ZewRGNeclihIH/a
         xV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329035; x=1734933835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8l56HNoVKCWoq3UFQbYWo8NhPQGEBKhUZs3vIB/kw4s=;
        b=bf+ig9RM4xgpDNjEn+2+/+OLMeYTN8JdW0Inugf1oTk/At+3rYlm9UIjOcp1fBgA1y
         m2evrGBlsqxJDJW5ndjHgANBwy7v/BGjcxRhp4ml9QAEEQJmHKezFgmMcu6uCK6MjYtU
         2MElAYTpTKBqrzxTeMqErU83v6tdRbBKrSitL5uz89RfO3Tfv6TZfH5ifGzEeZt38NiJ
         +OiakmdqBt2onu7F69vT8YQXToPDkW0RdqOnobu4C2EPI4m01xw6pjGXw7jZhootsPnY
         VpY0Ou/xD1cofmPcEBJWzLupICTCRGx48wSwqDQLZY0ituSENbRq2b4F3AR3BJh5kcNE
         uMsA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKNCvKa4SJotm+yL76QuLHD4v14iihuywcfDAPhcf8Xw1kKv++9Gl8trSijJituilWGmj63SzcuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DSVq8OYZKAGq4DA7UdBDHjpCrGpZpgkvXwqkqocnftGyhBVA
	XKQGsh7YeDH8qL9Lpetj43vtBhAUFyS5tbM4tt7hPGqYjK2IcE4CGop9Uvsbxw==
X-Gm-Gg: ASbGncuh+tnTutXR6faePSU/2X+I626NQMXg4KlXGGDl7BwAgpn8Of0H/WOleWiud+0
	JDu2JO3LNAoTZGU5C3jOlkIzkJVfCAQz/LUOLtJbcnJOvwIp7zWgj6r20QbsqDX5sUkUc7F6uGt
	diZFEolfyw2ABGY+k35iIUuJkqgRQCPr7X/PIRi0ddZu3wh8EftiZ+gLeraG5k5dLqlWobeFzBl
	w1bOJrEIC81jXG9EJo1t7zj6ACsf1i0jLmw8B76LHAy1rnFGSOULUXrRXge5fpRqCc=
X-Google-Smtp-Source: AGHT+IE89dTdzc53pbTNLiYWQP76UGO9avKXTxiixxWoLDIUfwYBcA6Og+5vQuX+VCSfds7qpcJuug==
X-Received: by 2002:a05:6a00:17a1:b0:725:e05a:c975 with SMTP id d2e1a72fcca58-7290c264e09mr16165494b3a.19.1734329035071;
        Sun, 15 Dec 2024 22:03:55 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5664sm3936114b3a.73.2024.12.15.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 22:03:54 -0800 (PST)
Date: Mon, 16 Dec 2024 11:33:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20241216060337.cvhwvdzt34ocg2uf@thinkpad>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <Z1qsIREtdeR38fF6@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1qsIREtdeR38fF6@ryzen>

On Thu, Dec 12, 2024 at 10:25:53AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Dec 11, 2024 at 01:31:01PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series carries forward the effort to add Kselftest for PCI Endpoint
> > Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> > based on another patch that fixes the return values of IOCTLs in
> > pci_endpoint_test driver and did many cleanups. Since the resulting work
> > modified the initial version substantially, I took over the authorship.
> > 
> > This series also incorporates the review comment by Shuah Khan [2] to move the
> > existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> > migrating to Kselftest framework. I made sure that the tests are executable in
> > each commit and updated documentation accordingly.
> > 
> > NOTE: Patch 1 is strictly not related to this series, but necessary to execute
> > Kselftests with Qualcomm Endpoint devices. So this can be merged separately.
> 
> Having to write a big NOTE is usually a hint that you should just have done
> things differently :)
> 
> If you need to respin this series, I strongly suggest that you send the
> Qcom fix separately. It is totally independent, and should be merged ASAP.
> 

Even though it is an independent fix, it is needed to get Kselftests (also the
legacy ones) passing without failures. That's why I kept it as patch 1.
Otherwise, someone may test it and report failures.

> As you know, this series conflicts with:
> https://lore.kernel.org/linux-pci/20241116032045.2574168-2-cassel@kernel.org/
> 
> I don't see any reason why the above patch has not been merged yet,
> but it would be really nice if the above could be picked up first,
> so this series could also add a kselftest testcase for the above.
> 

I was hoping that Greg would pick misc driver changes, but looking at the git
log of this driver I got to know that the changes were picked by PCI folks only.

@kw: Could you please pick the patch from Niklas?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

