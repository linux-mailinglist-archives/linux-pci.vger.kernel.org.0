Return-Path: <linux-pci+bounces-28122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71BABDF12
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500D1884E72
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC92210785;
	Tue, 20 May 2025 15:30:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FD17CA17;
	Tue, 20 May 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755045; cv=none; b=IxFTheQ/SBwkXwcEiJ35QJPl3FZyY/WyPhOftoe7VTxqfsygbxOjFrhNxT21YjqR4MGj//74bx4N6HG/9zFOAwK21/8y/K4WTS/KjCEERfeZBlkI6zt81tX76faBWfzOMqfNXjxDMywcjKnRg65EjqTaDpA1XgwAjX+OBRecOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755045; c=relaxed/simple;
	bh=/M0Tgs9QxYpIk8o+T30VylDWJ5zWp/G8POnHSWgeHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb8tZo76CFg9iM/yobEWdKM/6yQ1xxxYQO9lbAxGQog9OxTbq9BbJA1khMFMnCyiYD9XWf71JUJm4+9sw6RN2a9MCcyPVeunWw+PaYH2aH5cHFghZcuJnuKjw7EevLyrNzxfg9QOOyAvXVwDF+WLKA2YfTGwuPoeyUB1KNCXd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742af84818cso3368462b3a.1;
        Tue, 20 May 2025 08:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755043; x=1748359843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDY53oX8mGxS1FXJLkELY04Q+1YWHFFn/d1fBAtNG2o=;
        b=ZakIT3Uh/nvWLBCVos26gSk4jPTym7qyPO9IR7NtnHBuwY1ccoqCtCmq2zGd0Itki0
         LHGbaSKiuB1dmh56t+1V9meEAq2a8bJ3L+2Aob2m/1/ix3sE4laXrAK7at1S//qTQe+j
         azX1bjWnYziFboyOZIY/hMkASMZowuTpSa66hFJUxo6lRlu3AYyS4NqvmNpHvgEAtvYO
         1hrNGpMG+ftKvl655zwBKwFp1/ozz9cr8JT3Y3Xm4BwtYPXvmIQZhBjvU+vpYi+DGVu+
         ANDw7nSeTrdlY4PmhIsyRSgwfMUN7mMCdPtikL/OnMTGUKIGHXOlHfA3MsxiGhK2pHR7
         N6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUCk29LFGQolMrSxyoBH2hlqpuekrWoW8Kefh65Ss/n0PMCevwqXeXpFml1BMGc8VOk54bZRfALo1iE@vger.kernel.org, AJvYcCXLW654xgaRIeJTloKu10ccMoy6YHR1WpjMipGI3qwl2OuCudI27J7bR7dMCAeKX7VrkN5FOf+td5BCcJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv55YDIko0tm7IWrrPedpBmlpNYou35HQt47Jp7Sq8imsV1qqb
	S/nvZ2CRJdndT0/LjI6ub868Bj06Ef3e2GbiOYvXxEXXTrcc0PaZYqLb
X-Gm-Gg: ASbGncv3yOgvhf8uyWCwIJuTwYbX5ekBKUlV8EPDvH5r7NT3E970flupzBfDIk/d4/q
	tJfXN54dE/tbdKWbr3CbN/LNimqC9+vjAixRgF3dBF0iAbd5A0Ps6YHEc8ozwMnfJBDB6XaqmEf
	uajU/fG6EAdh/u181C9lWg07xh5J67DDQxj7jihQYXkMp2XULMNXxtPB4PmrAZsgyjHYs94Bfzl
	54ZLvuQOmEtTZDebC7/qhk36HM4PQc3zGO9pUiOXfwX9c0vI7l3gADqS7mDLI4IRNQa5ii4OLm3
	oONlbmQBCiUwAlutQf9ubHrTl4aZIF/sVcmneSHy8i3Tu7c1vCT+uX9tRLm9Q41Q2beIQjxkDmc
	HptCcHca8vw==
X-Google-Smtp-Source: AGHT+IHlDh9zNNHwGu5UolfhpnNtJWPRM7nlX5pxDjlVvzkOzQaXX8J5nK8S0wfEjuyJxNw5gUOYBQ==
X-Received: by 2002:a05:6a20:430f:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-216219fffa7mr28791725637.37.1747755043344;
        Tue, 20 May 2025 08:30:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf6dc3csm8086989a12.24.2025.05.20.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:30:42 -0700 (PDT)
Date: Wed, 21 May 2025 00:30:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
Message-ID: <20250520153041.GB2622460@rocinante>
References: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>
 <20250516132016.GA2390647@rocinante>
 <9dd35654-e6eb-a531-457c-93ddc5ff371d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd35654-e6eb-a531-457c-93ddc5ff371d@linux.intel.com>

Hello,

[...]
> You can check my track record on discovering e.g. real concurrency issues
> recently so I hope you can give a bit slack on a few trivial patches here
> and there ;-).

We love your work!  The unparalleled attention to details, especially. :)

On the topic of trivial patches...  There has been a debate within the
community at large about trivial patches, per:

  https://lore.kernel.org/all/YIGXzB0CyRtGfqfE@zeniv-ca.linux.org.uk/t/

Lot of opinions there...  Ultimately, most of the time things are up to
the maintainers, as per usual.

Thank you again for all your work!  Much appreciated!

	Krzysztof

