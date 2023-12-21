Return-Path: <linux-pci+bounces-1269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C981BDBC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1648828900B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF2634E4;
	Thu, 21 Dec 2023 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzeil83X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F95990A
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d32c5ce32eso15975745ad.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703181627; x=1703786427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=Jzeil83Xn4K9hZ4+AMHtNpx2T5N5jrSPQ4TjsAqc1HEyC/pY2pSlB7RSt9zB6jIPSV
         Yay5mhZ2EYGh6bUJMsxll+EQYZdho4jlLlx7mok4ijq/Jhl4i92CHaUk4QxKxAbdbTVw
         CInHwBEldS2oTDOk13OSucTRcffAHgaq9QkqClXU+gzNVHRea4E+ehjk2G+ETVI9+110
         ECe6qrTIC6OVZhY5HLTLrgb41SpqQvi4xOUwuNpyugoK91c3u/YZUZ+g+HszchYdBF3A
         4TwkTHZT05g1xzXVTq+SSdtrfhCA8v6kSgOwFwYpgO4JDp2RdBoZNhk6Y8VOZ1+776LK
         uNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181627; x=1703786427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMddChRlr9v8be9OTXtAYjq28vcnPDK3YNQiOmsqEBc=;
        b=TDLCyss6oi2h+xaB9awK1BcFpGvOOsakvZlUHGTFRUDNwJK4hs+IljFtktm0A+MEXZ
         Hp4ugHIAmEmKzXsYSPdX0YgJ5rizeI3Ld2NXDjCYO7GKmFnEvH9wUQScr05gVtYXyjZZ
         3y5pAQyo7oT9bLgsKZ6N+VMvf2vGsn1/mJBxuTh60qnb7Gum4tcXkqssrHoVSSrEz2NE
         yKHuwuinv7gnKUiVz0RQ7coV32vuHuxUMstzxBzn94gaJLK6HTEX1XUlSXW3C1FU0+yN
         6kSoC5JKYUAKDcIikQ79PbwL1okMWoTdhNJfgYSSLiBTcJJMvhICQDGanvE+csDEEuk/
         rdxg==
X-Gm-Message-State: AOJu0Yw/N0ciL0tvwuTgEU7iLey3p6qz0ddWZkCr7XGzdBfevvkvAtyd
	YfCXEcWvkZ/p49S4OUm8EVtsc+lcbFDb
X-Google-Smtp-Source: AGHT+IH+M3kmM1CdMIp9omKflLTDyhqNSFeIAYOun/O5Va051O93tCthb9Md1D1B2Ez0iPSKEAH47w==
X-Received: by 2002:a17:90a:c7d5:b0:28b:d2fa:1725 with SMTP id gf21-20020a17090ac7d500b0028bd2fa1725mr77683pjb.43.1703181627291;
        Thu, 21 Dec 2023 10:00:27 -0800 (PST)
Received: from google.com (105.201.198.35.bc.googleusercontent.com. [35.198.201.105])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b0028ae9cb6ce0sm6029388pjb.6.2023.12.21.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:00:27 -0800 (PST)
Date: Thu, 21 Dec 2023 23:30:18 +0530
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
Cc: linux-pci@vger.kernel.org, 'Robin Murphy <robin.murphy@arm.com>,
	'@google.com, ' Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <ZYR9MslXd7hw2vki@google.com>
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

