Return-Path: <linux-pci+bounces-16011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD89BC108
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8948A1C2081B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140461FA270;
	Mon,  4 Nov 2024 22:38:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E31FC3
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759917; cv=none; b=GBNdo4H7esESgj0D3f708SEbxFYuKZ/HWDbSFPWQKskUuCWreMp4XT41O1v2apZqZHCGqgl8riMr7ZuZBm66FbHRjz/9QMaqKV7tHZHQvvLe+yd61eqHTm810WPkwO7s+9fCWhikzMm0qxB+IN+TlZPrkmfqy1SSkUvYALS3ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759917; c=relaxed/simple;
	bh=fW5lvfm8EvULebV7Ipl6S2szIvsgHVjjJlaNyHnomFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUwqmCuO2GX2sVH14tjLuP3u3o040yb1B8gPKYfMDII0fLp8UL1Nlvp3Fdpv8bg2Hd7iK8Oc9aCdZEXFLJWVzsh7ygPRDtwFrMyNXWMIbdy5y2d8vCctG69swGe4GKMGs65va1Zu5SaZzNYXQa6uNvaM17Kzi28cRZNevjgVFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720c286bcd6so3797595b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 14:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759915; x=1731364715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wb9/0/4o7NF1IyNIk/ahu+xiUt04lwvN4lWhhHhbuM=;
        b=dp+HweB+kIqov/w1bCRz4/BPJ1BsdktDREYgu2XQPdtVglcJwW3LHmCXcJaTJ6xs2L
         vJJ7kfuNXxRdzmDBym/dVIO3RcAxGGkKEBw29Mo/cWBqhJ3BgVafyQCnmVnEOSR+lsly
         /B2Ub68rH9pUcs/+IKGJocD0oghWQKXzb0fitQZVlZF64hqkoEPXarE9zRy31maxuX7t
         luQnijBBbNNwtWFhyOFPoA02+B46WbumZFvbXc00oKroF9WbFnEZdx8lEoVMQzvfZ801
         oS7zB/xEHdHtC+NQXxvOU+1nDHvJvArOeXq27dliPdb3LSo1i7JYxrpUsPwuxTnYXOeI
         qCEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCDbGWWTPt7c5rOSup3F3mRjlwqgeN6X/XR1LLQA/md4tsQve9kmkY+xQYEJ+VCgr5HwAmALS1Xes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoWT54WAtc0qE7eD+YtAOsu3BY7xmVcRIIN4ZVzqERr9fLiYU
	Su+/EIUQ/8+//mzV5kEwN1SlJvsRHZhgK3r18rNFkrKrnFQtMP53
X-Google-Smtp-Source: AGHT+IG3NulVuHRaxyNQ8C6ARtVd9DG00HbVqfIkhBzwLqO/43q9MgaQa9jnjfsul75crhCefBs3SA==
X-Received: by 2002:a05:6a00:844:b0:71e:792b:4517 with SMTP id d2e1a72fcca58-72062f8a78amr22931544b3a.14.1730759914629;
        Mon, 04 Nov 2024 14:38:34 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c58f7sm8362620b3a.140.2024.11.04.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:38:34 -0800 (PST)
Date: Tue, 5 Nov 2024 07:38:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Do not map more memory than needed to
 raise a MSI/MSI-X IRQ
Message-ID: <20241104223832.GA1446835@rocinante>
References: <20241104205144.409236-2-cassel@kernel.org>
 <20241104211354.GB880663@rocinante>
 <ZylE6ivasmzd7uFW@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZylE6ivasmzd7uFW@ryzen>

Hello,

[...]
> > > Feel free to squash this with the patch that it fixes, if you so prefer.
> > 
> > Squashed with the rest of the pending changes, per:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=d2d9f84914e147d6ee399e0ed8d938fea7f0c35c
> > 
> > Let me know if anything needs to be updated there.
> 
> Thank you Krzysztof!

So thing.

> I do not see any point in you adding my Co-developed-by tag since I'm
> the Author: of the original commit (the commit that you squashed with).
[...]

Doh.  Sorry!  For some reason I took it as if it was another of Damien's
patches on the branch.  Apologies!  That said, we should be good now.

> And perhaps:
[...]
> [kwilczynski: squashed patch that fixes memory map sizes]

I'll take this succinct version, thank you! :)

> Since I (embarrassingly) always mapped twice as much memory as needed in
> the original commit.

No worries.

> The squashed commit itself looks correct :)

Thank you for looking over it! Appreciated.

	Krzysztof

