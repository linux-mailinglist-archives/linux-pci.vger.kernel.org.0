Return-Path: <linux-pci+bounces-7593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35768C8494
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BB91C22F25
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7929437;
	Fri, 17 May 2024 10:11:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9682E403;
	Fri, 17 May 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940702; cv=none; b=l18+J30KvOZdfDosj0hOzvXagy0RCa30siZNyrp+ZyAY4sRs/IKB4qHF/8/lw0KnSFzjVgPJVhydsK69ovugjnyDqInMadR7xoxvvqxCo7HmbWV9q3JmjZlLD3ox6x3CIjcIsbU/tJh0WfrT3KxjO/whHNYZ8laqoAWnPrvwY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940702; c=relaxed/simple;
	bh=acUQ7zfQHCjjyy18et9/Vc+lz19clZyuRtK6vl/UTgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvAbBXztaNBg0TeJUzlKLxWBKMIcPpCsCaEzedDD6gHxdZRbwtss5GDcCJ/Qtysm7N9HKNt8jft5Oe4TtQ9yQInKF0XhJwDTyqR4VQodO8BvcE4Yj/xFe2jDkjNGW5YnuRupu9pNkm95ty4aiU6FmjQzQ64Empg7D/c3yqwVQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso1102252b3a.3;
        Fri, 17 May 2024 03:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715940700; x=1716545500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtlmPlf9OZqt8E6ku+EUKnOMZnaMtANpSbkCvNOAF4Q=;
        b=XWmeMUKrm3nJHWaHK7PrGlr9smyGLPHwy5B9066IYadAzElAAoc553/cK1IrXsXxo8
         NEuxqddUKAtKJRUWIV+VgGuYYAPicN28fVCe3tdYxhuTetPfAbRUVUN1mHHSNZPk/qw2
         56YItOjUkS/gbwYtBkz7m1H3C8gd1VT8dMyNaEj3mrDSda2gv2W0FYudL6vkHSfVW+7s
         DAwFi9c+KrzWDYFejSzmqQUt/XXEExTZt72/rrLqxq2Sei6nBxZOthw3q9QCBUPGQdJ3
         BxcRK/ElZcWr6+4rNrjBs20C0JvPnTphWdZp0BnU5ZxfH4pt1V81WdKyqIwQO08vAIgH
         phVg==
X-Forwarded-Encrypted: i=1; AJvYcCWp3V694MDKBu626f+5g1N3/gSnxd3MHjYeWL6QUTTmy8bVaTZh3c7jL9c3peC4nI/PS5UVgowdJlQ8XCuhr0zkAE/lP5czHDhgihLcO7nRWExP76MuvxU1ulF0iYrW5LMB5YrjVEK+OoQXpU33KjR+C59a+XWuDxiFL08ML5CfMkdk
X-Gm-Message-State: AOJu0YypF6Fu3LrTTr8yYrN+E85DsXvpDrgGHMAzMmcpcPF2/uNZAUrq
	SkDQf+roeyUU3SZu5fWIch3CR2um4AxP9TpJvD+HPaP9LhW5shS6
X-Google-Smtp-Source: AGHT+IE4Q+aqTkzmnEiYSPmcay2pCxc8SkhdJVeC7hYR8imFr0vc/RHNCBOhku19oeJm3wNgDAo3cA==
X-Received: by 2002:aa7:88c6:0:b0:6ea:dfbf:13d4 with SMTP id d2e1a72fcca58-6f4e02cadacmr27743031b3a.18.1715940700045;
        Fri, 17 May 2024 03:11:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b254cfsm14366680b3a.200.2024.05.17.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:11:39 -0700 (PDT)
Date: Fri, 17 May 2024 19:11:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Message-ID: <20240517101138.GC202520@rocinante>
References: <20240418084924.1724703-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418084924.1724703-1-alexander.stein@ew.tq-group.com>

Hello,

> With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
> mechanism to notify EPC events to EPF") the linkup callback has been
> removed and replaced by EPC event notifications.
> 
> With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
> function-specific attrs") a new (optional) add_cfs callback was added.
> Update documentation accordingly.

Applied to misc, thank you!

[1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
      https://git.kernel.org/pci/pci/c/e21fd57bf0c8

	Krzysztof

