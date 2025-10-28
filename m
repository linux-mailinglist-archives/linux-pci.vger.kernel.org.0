Return-Path: <linux-pci+bounces-39501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74942C133D3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 08:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF5F1A63477
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D726F467;
	Tue, 28 Oct 2025 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzwFJfSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FF2BE7CD
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635220; cv=none; b=YqF/7W2XL+vbp05LkgGjQb0mHx21JMMiayRzAlVK7j7Aevd78gqa5GxZzV4IdZXib36Qc27ItJo+D4c/V2hGwDu9beo+HdggWbS5REeLTN1pWdGjkWEc0Igwo6Sh20CYcGCTk3lz2s5I3V9Q06V7QXaSsJdesLq4oiz/+TjzCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635220; c=relaxed/simple;
	bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLFOIRWw4bPyEQbSZUE+wdzW/+BIOsY/4v4Oy+E8gcXW/q13C1roRHcc3YwvADUXRWhjczNnRWvMM1qhqRRlyrALwg13lZI/j7k2MFvSNwM/eo7h4h9HVXzmF1AeYs7MQOFOSEnlk05iufBdxeKGAZk5pVovkFEqaYrDDufNhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzwFJfSV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso8561165a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761635217; x=1762240017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
        b=kzwFJfSVlUIRSBkvPFV9cszKPEb5MmzumJf8w0+XB3pXNnxZv/a41B52lnt0FtfbyN
         F0jiWYoilHFD+EALeQxuTk9V1f8EpBHo0zbFKa4wuhUJ7sBjffc5ifCcXzuAq7K+eBlL
         CSjIQD+pKxpQimtjkX6h76APknIU7CohXlMemLCNc589+VSIAigrnVCtfRWopcSvSwBK
         skiPnUu5I+OvjuRuc4jNBjIWraXPw6UNpSnAXjpH+ze4mWrGFMP1F2wAWpGonz31Xhv8
         lGtwpyiBo63SfG5W2QAKj388T5jKkfbnqSXlIemloVX/us5My5X5u4+vFw7kwhYMNJMa
         BzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635217; x=1762240017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5PmlZtWzHHZKGgXjshm44Mpf/Tt3lSzAseSYL5jpRs=;
        b=SgDKKWaCvwByXfFqebE72GL7cMkbUk0tvAZ67F3w7UaMomIaQe3odQPZHkp4p/vCdj
         eoS2A78dwXbN7HvqFTkPH8c3dBwx9Y6xjS3QvjfzvssYpaBkufWSZFXnPrBKFWhFiWsC
         RYz8CAxNbZiD67uirvb+xB7dFlGf1vPgUBDgnT/1U3HS/FA1KZzGuzEattKu4AODhwYL
         QqBbb4RmvrULsaXwY2IxxXZxOKZW+AwxLAbOq/kTTDH2LITa98OYWpuq3Di0gtgh7Xt9
         jH/M/F+lFG2KxzCFW7bTpPHs6u/b0bUbotlKnuQjgxbb/koV9S0dDpZH1bOZcXzxuVvx
         Co6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2b0P+VtwB8qYNBZMi8KGkQCDZg/GrEonNG7WpymRapHfO1VrG+LtfkC1bnMdPJm84oSkU1zFlLiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJSW0VCLhDgAYPiyyc3P7XGMSTJ2iUjl97j2+21xix/JVgG8V
	LNkf26ZAyKE38o+ys2jqGiCSzJFuMVeA3Z5ih2/449BwW3AGpfCJt05+O80LWZPZDZsU2c/LEXk
	Yq6TfBRYRcO8HALcIVjJS47mGUwctVu8=
X-Gm-Gg: ASbGncs5701aF/vtTDOGycRAXdBgwpcAWtvee6ZPHeOvWrR2o/51zR0Mx7zzlNjMcTB
	UmDhnReeD/AI8vSqCTBlPld/psiaGD6vdbRIkUHZFMBz3UKY6lqQVdvU9iLM12Y9mnkUS8tEGhA
	RDotHUYOYUrbSFPZiczntz0pYwcVm1tsxiJ16T2zK+9BnDcyy2lMgDf+AjuIYmOtaAfYuG8qG3Z
	S7P09aOgzTOmsYb7C3jGHsJxXpMNJIUwSE8kziC7tCFFVsZjmiOdrqgisg=
X-Google-Smtp-Source: AGHT+IFqdZ7449/+gCSESKkn4OY2k6KiWRXks4E+V02E2uPaH6yPU4wF8iJFvFXAm8oiIsJdQKeuKoRJ7jR1cSg+eCI=
X-Received: by 2002:a05:6402:5208:b0:63c:45da:2878 with SMTP id
 4fb4d7f45d1cf-63ed8262ceemr2111325a12.25.1761635216475; Tue, 28 Oct 2025
 00:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027090310.38999-1-linux.amoon@gmail.com> <20251027090310.38999-3-linux.amoon@gmail.com>
 <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
In-Reply-To: <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 28 Oct 2025 12:36:39 +0530
X-Gm-Features: AWmQ_bnM6F6BzTGQqX_h0Uqm5Thyd0JbiSKKhO1nlm1lVvxcnt-IMVp2PL8CDLw
Message-ID: <CANAwSgT43rsi+DxaMF3T-gsVoAAGSSDEL6s+TE2yZ+q+W3bRsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: j721e: Use inline reset GPIO assignment and
 drop local variable
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thanks for your review comments.

On Mon, 27 Oct 2025 at 19:13, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > The result of devm_gpiod_get_optional() is now assigned directly
> > assigned to pcie->reset_gpio. This removes a superfluous local gpiod
> > variable, improving code readability and compactness. The functionality
> > remains unchanged, but the code is now more streamlined
>
> Would a corresponding imperative wording become helpful for an improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc3#n94
>
Assign the result of devm_gpiod_get_optional() directly to pcie->reset_gpio.
This removes a superfluous local variable, improving code clarity without
altering the driver's behavior.

Is this ok with you?
> Regards,
> Markus
Thanks
-Anand

