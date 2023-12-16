Return-Path: <linux-pci+bounces-1084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4F8154DA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A23E1C240EB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84606367;
	Sat, 16 Dec 2023 00:10:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055B364;
	Sat, 16 Dec 2023 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so1176230b3a.0;
        Fri, 15 Dec 2023 16:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685423; x=1703290223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spo3/hZ8bxeF7fEaxgEqhtcJSHCMuSQdfr9Oa59N2+g=;
        b=VWztCs0S28TFq3v2j81ALjPSQNRhnkN0CX5tScJsDOdmWRjoqKuC7RFdLYCsgF/5uN
         yJUSo/lVOeGBfyP75Aw9948mHVwO5Fazs/f51tDKHHnqUj+r4NZLW9+A53tGe57cejfM
         T4nfDXQvhCh6fP+1T2UAqXD8OU8WCMXtIY+bG2RjzbMeUArbxpCs7TP5hi8CZxurLHVl
         A0u9y1zu004XDLlUYDlN/mnlJNZgVt6/4Tp8qIu7w+TPpHC5i+xPxyouYB8h621ZJNlo
         ZfF6eGx5e5csycYK3+RttFs7iwpMGc5Y/EElRAirEgsZOm3OdornmvAvmA46Via45PSa
         q3EQ==
X-Gm-Message-State: AOJu0YwAzSuTg/6Kk79UTcqcJPCgNkqjAZNctnKgZjvpoZFvYHoyvvQZ
	Uj0hs3vZCc4DXg1Z3PWnYx8qg9SqO46i5LPU
X-Google-Smtp-Source: AGHT+IE98CQysK2x+uTIv983lVLMgiO6PyltLPUOTrydctMMoJ3tXdlhdw3rQ75gjZBsCZj6K2+4YA==
X-Received: by 2002:a05:6a20:5525:b0:18f:cf73:3573 with SMTP id ko37-20020a056a20552500b0018fcf733573mr11872782pzb.121.1702685423442;
        Fri, 15 Dec 2023 16:10:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id e8-20020a056a001a8800b006cdda8519aasm14007334pfv.169.2023.12.15.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:10:22 -0800 (PST)
Date: Sat, 16 Dec 2023 09:10:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] dt-bindings: PCI: dwc: rockchip: document optional pcie
 reference clock input
Message-ID: <20231216001021.GD1570493@rocinante>
References: <20231206145041.667900-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206145041.667900-1-heiko@sntech.de>

Hello,

> On some boards the 100MHz PCIe reference clock to both controller and
> devices is controllable. Add that clock to the list of clocks.
> 
> The clock is optional, so the minItems stays the same.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: dwc: rockchip: Document optional PCIe reference clock input
      https://git.kernel.org/pci/pci/c/639f666cf84e

	Krzysztof

