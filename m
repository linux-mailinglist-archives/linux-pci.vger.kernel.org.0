Return-Path: <linux-pci+bounces-1832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14262827774
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26C02844E1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148154BEB;
	Mon,  8 Jan 2024 18:27:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340954BD7;
	Mon,  8 Jan 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d542701796so5575345ad.1;
        Mon, 08 Jan 2024 10:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738446; x=1705343246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foK6GojmVN5cHJkPZwe/GjKQwChqN60GolaCvetvTnQ=;
        b=Jr08JsocOAL6GPQ0196Ery6UMVU6mC3rj/MZ+yi/LHdE0wMKv2G6UhlLBwTpOAjcSv
         ByMVKBOsnc76YQXgogX2YnHPhP9NHlfnlrlMIhI5PUWgfSRfX7nZAoz8sBvtttDeW6Uu
         Y9zpb5T3ToYc4V7VvVx1AasTf6ZJXxvCSJhNJHZZyJcKPDb/YfdCgqZi/khu87wal76s
         LGkQiNAkqx76pk9WC3MIrIuMTIwU0sNs0JjPgUqQHrjZXdE39mVSORdHBiQQCpxDnOXb
         r+ZxVQV11RguyEl/F0GZFKKkVvzJvVCokjjwvXHb5CCxQGlCZ3NgDtrOn5UCVo96dY7A
         8VVQ==
X-Gm-Message-State: AOJu0YyDPv8D6DM9TPCtz2egYUR99r8pUi1JmjCp+7S7Ck1aO3dkYuQz
	oVnF0ujZ7a9oJFKXm5EtsmU=
X-Google-Smtp-Source: AGHT+IFZvfVF9hWJMJ7E58jI4gNUXscahK/pXAC7nJ10yV9YVSmbN1dji7Yjp31xMJwqtlcp7cas1w==
X-Received: by 2002:a17:90a:a004:b0:28c:4b9:4fcc with SMTP id q4-20020a17090aa00400b0028c04b94fccmr1345664pjp.74.1704738446622;
        Mon, 08 Jan 2024 10:27:26 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090aaa0d00b0028d19ddb1afsm282269pjq.33.2024.01.08.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:27:26 -0800 (PST)
Date: Tue, 9 Jan 2024 03:27:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH next] PCI: xilinx-xdma: Fix error code in
 xilinx_pl_dma_pcie_init_irq_domain()
Message-ID: <20240108182724.GA2638520@rocinante>
References: <20231030072757.3236546-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030072757.3236546-1-harshit.m.mogalapalli@oracle.com>

Hello,

> Return -ENOMEM instead of zero(success) when it fails to get IRQ domain.

Applied to controller/xilinx, thank you!

[1/1] PCI: xilinx-xdma: Fix error code in xilinx_pl_dma_pcie_init_irq_domain()
      https://git.kernel.org/pci/pci/c/2324be17b5e0

	Krzysztof

