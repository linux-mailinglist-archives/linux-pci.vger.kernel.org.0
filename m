Return-Path: <linux-pci+bounces-9538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F024091E9A8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E84B1C22102
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23616F857;
	Mon,  1 Jul 2024 20:34:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2816DEAD;
	Mon,  1 Jul 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866072; cv=none; b=pQYj3Nc58ssQlXSWBCM/xIcMod+ZpyxSEiPneTvF9oe8rA5/Rueyf9qoX2blmYrxA8p2Macoe/cRgdMt7HCg0jnkJ2mFvhy0oU44U+qEe6GBGwXrCZAi2IYDex1doo0LyEtvHYjLVCo80QqjDt89+3LjEreng5avHHk1wMCcbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866072; c=relaxed/simple;
	bh=Wo6jYVKWt1XsfvW2kocRWwhdmJB1ArOA1W+ONgrcPUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeeTpVpQJILQUzP8XTq2bj4s3TzkB1JvVEK2tV5f5TRQfKECpXl0W35j7W6V+nx6Ao86LmhMck87rKc7Gcjqk+2HqUGMh5AOohZVbEfJR5ycEK6n5YtHcAUGs5gZEnDFfMmevC4roNwNlYV+cCsxeYqXiQxN6DK3qJQuc2JMEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c70c08d98fso2550204a91.0;
        Mon, 01 Jul 2024 13:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866070; x=1720470870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/VCLG0XE9tYQ4KowekIVt6Vm28X9Pkg8zs7uMqPhA=;
        b=soUasothld5V2uHGgPoIj2iqlw0/Q+DCUqFzx5jEVmpe63GPOMThtkKEOwu9bDv7lY
         RirFesaJtGIgKQH92sc+xO17XsauDA2u2l4J4D5VR51abyfM05E+9hCPkLxJv1ZbTGcW
         milM76ROyabOEwPuo0g3lxqE4FjjdLt9+JOOnLLhX9qL4Gqk12IrwAEAu6xE1t+lskX/
         3BTLDTnBbkXNdwrjuxkbnLy8gvMM3BJcmAUfBw6+KzON6x7NDUqynpfVf3Aa1fTYMdUf
         /JhF3vxOqj+y+9YymRLY2SJpUS+3sO3wcxCYX4hsMldwaiuwahyGezfkwle9YCFBjkIu
         N61g==
X-Forwarded-Encrypted: i=1; AJvYcCWwMbzTSPzfxlKzZU4OBMNcdbA1E4PMtB9vig428cxx5vVxTmGub+cugLXcVbd4f91sB91rX8mnZO7OLDHeJU/BCwINaxvO69NqwhnpPWgGebvI0gn11KQZgU2h4aP5u0V6qeTWw6+tsNuwYbhwZH3CMENddM3JH4KVDjG6BblLbWAOky0RH6H0
X-Gm-Message-State: AOJu0YyHAQQtLp4z+HKVws6AherE0Hu4mwqopaNF5kAgf47SOkMCGexz
	xkQZFyqclxCsC+huz/Rer1sPjGNutBHY6GENW84zjxmxQONOD0Z5
X-Google-Smtp-Source: AGHT+IH37dM54+qflq0oEXeW4Muag9hwYXpu9YtpKLmCGG+T0D5FT3KmTqCArx3LOlD6TcYfx9xJMw==
X-Received: by 2002:a17:90a:d70b:b0:2c2:d8d7:bf65 with SMTP id 98e67ed59e1d1-2c93d6d72famr5079101a91.7.1719866070429;
        Mon, 01 Jul 2024 13:34:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce425bdsm7306981a91.14.2024.07.01.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:34:30 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:34:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: fix a couple error handling bugs
Message-ID: <20240701203428.GA412915@rocinante>
References: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>

Hello,

> Two small error error handling and cleanup patches.  The first one fixes
> an incorrect error message printed on success.  The other one fixes some
> cleanup.  Which is probably not required because PCI code is generally
> required for a functioning system...

Applied to endpoint, thank you!

[01/02] PCI: endpoint: Clean up error handling in vpci_scan_bus()
        https://git.kernel.org/pci/pci/c/72705e5b5957

[02/02] PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()
        https://git.kernel.org/pci/pci/c/05214340e133

	Krzysztof

