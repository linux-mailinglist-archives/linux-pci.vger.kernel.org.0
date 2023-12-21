Return-Path: <linux-pci+bounces-1271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB981BDEB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C21A1F215A0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1458224;
	Thu, 21 Dec 2023 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18STg2lH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B68634F1
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso733188b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 10:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703182024; x=1703786824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=18STg2lHDWhpuSII5K1FcEUHLyvSbL8INBxmL23u7PwQSZpafJt0MsaJZv06tcZybn
         zqCCsGtr7XVa0CVMDnS4JO9n+UbID9imOkgu0Zn36G+6IO1DA+xmhK3gl9FwLdwRBebE
         XFK/7sH8efpikJ51F4nW1RFhKhhW0neBC4u0Ino5rMaeKWAJ+X4agoxF+AXU1z1w8/Qj
         MrwCR/sG+wwX83wYIOLTSJ7uvrQ2MYCNUFMUNYH+Lx6haiG8C4f6yX8Nw063mRJUK8cz
         wNc5l2bdmIOH/o7sf9bYc/0Ix8tYvnJ7fWJ8ewaZVE7iS+yoAjA/yTTfzV1e91kjvJ60
         Vg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182024; x=1703786824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=ZWQ1YFXKfQD6M5CN9c+/JxeOXgo6+Vl5uLPdbbVvZuX2QjL99jUyMkEbtc7gAriue9
         EGOaqgXh9NLtVqJvbtu92B8rWCpaSrypLGiAGgBaFb5W9EAZNxH1pJFNaj2FFjJmrVAv
         C+94VxX44/YOK0j8Iq5MHu57c26UAZhWtMZT9s20l8xi13ki8y7J6c4cy7469Xxsqu6S
         6UKjeqPcn8ePKI+9Ob4YUyQicOYO3azk7cyWijVU2ee2vhZTecls0ml4Jg9krhgwoN22
         nUCHK+HdGjyUQpbwivNtTVfZDR23GuBqHFI8EPV1EcNP5s5h7DXGzc+NUdhSqpKgsWDc
         FxLg==
X-Gm-Message-State: AOJu0Yyjwx5A+dPvkaMrL1iPkEUD4Pn2XPaQZs39mh/yMEmX94dSSF80
	qDeZo9CH0VnqdNQ/39sOCBnKLvuh9nMp
X-Google-Smtp-Source: AGHT+IEJQjBUfQdslgeewUC7rfZtdfRw4OuCOm9jyo/dTU6lUFNwffTLTWdirNNsVwAzQKyEY41D7Q==
X-Received: by 2002:a05:6a00:270a:b0:6d9:83e9:a948 with SMTP id x10-20020a056a00270a00b006d983e9a948mr45541pfv.1.1703182024224;
        Thu, 21 Dec 2023 10:07:04 -0800 (PST)
Received: from google.com (105.201.198.35.bc.googleusercontent.com. [35.198.201.105])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a00198400b006d94291679asm1890528pfl.78.2023.12.21.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:07:03 -0800 (PST)
Date: Thu, 21 Dec 2023 23:36:55 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>
Cc: linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <ZYR-vyZM0ySFTp0G@google.com>
References: <20231221174051.35420-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221174051.35420-1-ajayagarwal@google.com>

Adding Robin and Serge.

