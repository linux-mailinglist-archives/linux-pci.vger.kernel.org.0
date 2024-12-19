Return-Path: <linux-pci+bounces-18744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B299F712D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 01:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B19B1893653
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C32111;
	Thu, 19 Dec 2024 00:04:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A717C;
	Thu, 19 Dec 2024 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566644; cv=none; b=lhtX4ENakRr4C6kD+LfauVxXEmtudikECPK1KQ8P7VDZplyAmJUwWkF787okMBFSAbLATD04dfvTxgJ4E/1ArwlA8WwaJ5HEA0yi7i3uGsG6EQS9Ak53V69KGsUnBzpuYgZH7WWe0tgz+x1gkLKc7naOfeQ/HpWvXCWFFcEsxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566644; c=relaxed/simple;
	bh=nVJ7c/2AQigjE8wzPQTg0dqwmM6wHh4VDdgX8Sd8YQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkmukIxRki899RAqsO1w5JIokTtFxSetDT9nTGVAUTsxizVCAF/AH6Odw4kDmBJEIuRtDU8texKXqFV5qz/WH/t3i0zFLI0Iz+2Z6SQ/RFqlkao/0JYsFC0tHRg0nywStM+vWK1Ijiue8p/uRdkR/XsRcrQksBbjzlyecE9lk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728eccf836bso206512b3a.1;
        Wed, 18 Dec 2024 16:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734566643; x=1735171443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h2qt7cX4wkOJdidtitj675lsDv11ElI+DmsZjJn27k=;
        b=MXkgG7WjACbJ4Dtd8bFAF5XyctlBlTe1PgOuwAmuvBZdE+R+NRlVwOHq7+4fSN5FYh
         UkdIM3X2w2zk2YsrwV8FhQ2K5jROAhgV0XqIFbnFgfekn/Nq9/GLi60OeRVKB99EvKSg
         A/t+MgocD+cEds3Bv0D5oRehwrzEm0YdzdlqPNeWAUU2XRFQLx2zmGHsJG/j5As40z9O
         SEAICmnNi0ObPHBdWlMtY+si8tq0AaMCGgnbCOq8Qybu4DPbwlU+xmhl2KjhnE89JWk/
         Q6vfACdo2JR2wTWqrnYAK9HKuRnqDrj7iRQOKP6JKZ9LvkVdKeUu4LWuTeUbtl9kDWLx
         wltg==
X-Forwarded-Encrypted: i=1; AJvYcCW/kIiyRfa/k9Xu6jFC93Vhj1Brpef+ICBWAP+PxDmDUWSUPda/YGeeZf2o0NUNPNqJQ9dQ6jzxYfMQ@vger.kernel.org, AJvYcCW0A/QtZFVOj+Y4x6BMX2xW7pZOkJMjVZOUgeh+qGCpLEQ8zFOPpUS58oGVfyxywZbtWRfxDdMBhMHR@vger.kernel.org, AJvYcCXbXtzIl5SMkkrI++csA+bzrDUYIi7hsz3ZioqtjB5OZOoU2WW81Twd9Xr2ccaqVMCkLvfOmAutB07IZLXs@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpNjNR/kiBNcmxFBZkirYCgmmfwTsmBa4E+LM4zw1+7Oc7qG3
	6pDOa1y6TWJ+Lbr8ixOiLZ5F2sFHAIRCnovyr1DwnZ0NswxKzoLi
X-Gm-Gg: ASbGnctlwyQ0X1cuHVV4NlnPUc9QM/wQPzaEFa7wupFuore1orjWLNPMXQKtD4TOxZL
	GE5ZGzCY2lVp1/oX4vNL2C8zHQ3U57hoMtKHpSzkpiQPvcIi1SFegWSIXsOZngoYmKtQ0M7eJ6t
	11zg80yYW9PHdCb5rzdtmvbyU/r2HBvQK8kLBRoiWQKIcBVrY4mktLzcKYeY41xTdHzo8Eymgnq
	Yp1Y8Ntksai869FbZlTnmTRD+8fTLoMeB0sUg1VxotsZFWwgU9HOaSmmoM+RuVDfUjcYSWZXXV5
	Vi76TS89fMDmL1c=
X-Google-Smtp-Source: AGHT+IGdNF79Ot5u4D3U5W5J4oLFxdfqxI4VcpJ6oovCpaAvbnw6UlehMxVCYzUAjwiivmehIBRWZg==
X-Received: by 2002:a05:6a20:a124:b0:1e1:c8ce:e7a4 with SMTP id adf61e73a8af0-1e5c764799amr1933761637.20.1734566642596;
        Wed, 18 Dec 2024 16:04:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fbac8sm45302b3a.159.2024.12.18.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:04:02 -0800 (PST)
Date: Thu, 19 Dec 2024 09:04:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	bharat.kumar.gogada@amd.com, michal.simek@amd.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for CPM5 controller 1
Message-ID: <20241219000400.GF1444967@rocinante>
References: <20240922061318.2653503-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922061318.2653503-1-thippesw@amd.com>

Hello,

> This patch series introduces support for the second Root Port controller in
> the Xilinx Versal Premium CPM5 block. The Versal Premium platform features
> two Type-A Root Port controllers operating at Gen5 speed. However, the
> error interrupt registers and their corresponding bits are located at
> different offsets for Controller 0 and Controller 1.
> 
> To handle these differences, the series includes:
> 
> A new compatible string for the second Root Port controller in the device
> tree bindings.
> 
> Driver updates to manage platform-specific interrupt registers and offsets
> for both controllers using the new compatible string.

Applied to controller/xilinx-cpm, thank you!

[01/02] dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1
        https://git.kernel.org/pci/pci/c/5c911b4659d5

[02/02] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port Controller 1
        https://git.kernel.org/pci/pci/c/

	Krzysztof

