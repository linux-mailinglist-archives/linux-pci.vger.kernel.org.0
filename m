Return-Path: <linux-pci+bounces-24676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB98A70456
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74883A8C8C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D089A25A62E;
	Tue, 25 Mar 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="c+fhiXdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108625A631
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914427; cv=none; b=SSaezP95fEUMxAp5MUyzX4yLOFOp8V79tJauvqx7obT1LaYhFBaT2JGoIV8OXw0SXGyvVhFGAK5mfyi4/2fY6otx6heQUQnzKUcqvzapMsrqK/T77/h1tFFenvltnRPM9DKb5PyOhoPDYX4fY+Qviw3FIzW5bbktvo0sa9fZ0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914427; c=relaxed/simple;
	bh=1sM5l4Le9uZaYWmJvDCU8/tUWoePiEbJJ8FpsxGPQHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAUrh8FfrtiBzP8HtyY0Xw77q73ZNBhTOrW14MCK+WLBojkeu6yxqlpMJHv+AdNLbeJD4yuKAgCyF6wtN2ySuggoxaKpCdjAXiQ3WThyCBHr5z/pu3OBJrYb+fOVvyH7FmfshjXszOBAeOTW7LG/d+cKJpcJHBlKFM25e+LkUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=c+fhiXdo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso10464301a91.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742914425; x=1743519225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TdkDS/vMk5p1AZv8W+AgQj6RaWYMpbzjtCmMRhYEbI=;
        b=c+fhiXdoVvykfu7MlS9X+itas6WJclx71D0tUzBqIpP4q+OXrzEjZUNQR7kFIdfFjb
         lM7FJVOPbNU8Sp7llOUUbJ92w8e2h8+Qxs3A5NkLMyT470VhVL6Ggn2q3U2wLOtCzQs8
         cKtZlOqOz3D+7+Rw2ES22wkODhcNmtY33GILg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914425; x=1743519225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TdkDS/vMk5p1AZv8W+AgQj6RaWYMpbzjtCmMRhYEbI=;
        b=qocY7cvV0Q4NOxx9ri6f1xfhQaQTric3bOuZBKqmgzXhMY9Da99kpS6kxWgKuHkWf1
         wq1aBJS7mQdHF0DaorSPRhHzDSLJbX7Qtg4lhzp0nGFys4K0f5L9ANJx9bkGewH0Py+r
         tFjixbWwy59BOEx0LX88YgMJSlrkqTTzW8TTt31uYUsKf2LTIf/qHT/pzMluOvPkMZYA
         rOYYi/d+KhKetaAHoBQR4AZgUmiqoOyZHYmVPeSqIYXD1edsNXeGVQG4WcRMrnQFCe1B
         pzB3LYt0lJXT/kx5/G99w8xxBdZam2wgrueUf0g5V3YdcIA2yfk86dqOWKlrxrvCLHmh
         g5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUAnLO6/4ff+IJjs8V5ZAZFCtU6JikAkxh2JXPctorjgBr/TSI1FXcxF+qrzOe64uBfI5+2HLJdInA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRf4rYzf23wX3FfojFRe4HDiCADdXRgjd2Ol1lzg3SLN/ufN1Z
	MVeVyz2M3cbfpbYZuZ1nfrYSWHOi91FqUpTf67+0Cl+BEaXDLh3bnboIt4e9bzY=
X-Gm-Gg: ASbGncvY4Y/Nx2G2l49M3T5n4N2O5xUwQs3vGgdUOuTPAaUnDozjZ40R3k0kBLYDgUw
	stf4rJvuDAaUbNJDbXuq9PwhjMyOtpeDVu8uUuxaogWMVREkgIhM3Ymq2aN9iDqHjY6E00rHGAZ
	JNVXHBttwwBdqw0P90aTYuQTuHQ4d51Qr9sszaLa71mTXBFRSODxjFQSnI4b19PHL1mCey8WH9y
	553n7Yqaqrc0EQ1YCao8TaIdFy/dYLx46TBv6Ym2TCz8VC09GsIzO79741U6aE0AW0tjnB56pcw
	c/E7k2KMQHdA20M7yElbPlTemRNc7bmCUZTcXx/NyDCjNZXzaXNfeRN+P3z9
X-Google-Smtp-Source: AGHT+IGTbPk9dPvPoREsYcLOoknFmq0RVX2PWOyMpPbWJ8k+G1JOY7Wb19hLjnqLwlugSDnBNIwDXA==
X-Received: by 2002:a17:90b:51cf:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-3030fe86471mr27282348a91.13.1742914425185;
        Tue, 25 Mar 2025 07:53:45 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811baf30sm90844895ad.130.2025.03.25.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:53:44 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:53:40 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	PCI <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	shivamurthy.shastri@linutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20250324: x86_64: BUG: kernel NULL pointer dereference
 __pci_enable_msi_range
Message-ID: <Z-LDdPeTsnBi8gAU@macbook.local>
References: <CA+G9fYs4-4y=edxddERXQ_fMsW_nUJU+V0bSMHFDL3St7NiLxQ@mail.gmail.com>
 <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6df035d-74b5-4113-84c3-1a0a18a61e78@stanley.mountain>

On Tue, Mar 25, 2025 at 04:56:33PM +0300, Dan Carpenter wrote:
> If I had to guess, I'd say that it was related to Fixes: d9f2164238d8
> ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag").  I
> suspect d->host_data can be NULL.  I could be wrong, but let's add Roger
> to the CC list just in case.

Indeed, sorry.  There's a patch from Thomas to switch to using
pci_msi_domain_supports() for fetching the flag, as there's no
guarantee all call contexts will have an associated msi_domain_info:

https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Regards, Roger.

