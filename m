Return-Path: <linux-pci+bounces-7602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67A8C8501
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6A283DF6
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985439FE0;
	Fri, 17 May 2024 10:42:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DC39AC3;
	Fri, 17 May 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942575; cv=none; b=OM00GfZ++rC3xClkC69HQtsXfVHLY45/7vVulAZgVeGhtHRxq14iCzaDLlEq/T5RxW1WbnskdfNFZr8hPFMyiuOngNL3SxZq7NkCdjffFex1CIUy8D8/eDuzDCdcFTQDDWLuaCNPWz8bFJEk3axlmMQdtOBm5/ULFI83VBFMKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942575; c=relaxed/simple;
	bh=Aemt4kaweQ75xnr3xTspe+ewCkqJCsB/X3CzCx4kKck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTZSyCQ+PpUOnIs3BUAyzyq+mYTT+AGgXtntZsfhq+/SarijSNkHBrBjUXIqMvMFT1luRnXiWk+H6SF5xoWiMxZ6LDVJ9yq1xVjjTTZ93oJOuxf0ZNrbR5uJiCap4GUpw6/AbeeDJ/5fEt+vboi4aozBWd/xwttmU78FxMNGmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa20adda1dso789467eaf.1;
        Fri, 17 May 2024 03:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715942573; x=1716547373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0mDfCC4qqN0aazXdCGoPDOF18pz36dxsqLie4Zoxhs=;
        b=tv7DFFfvc+9MQKSFWoz+8e+Rxi501KN4k1tHBr6pfFxsACkwwsUdJM7sJCemiiSISM
         cg6ybMuMutnkdSDtld+dfXjjEpvUa8vn2mqspa4vpwVzqCfbNehnCvE7gosHh1N0UQzo
         LNQRjSAmpJaSNOZawb5TwWVa7brfulmVeNYCy1t15rus3SScrZy3WvEW+6Owm5rDYL9X
         UuBGcYQyJnCHrV1kFNN/ekjVJf60iZl4SbbnpFFtqsTmly6cQwV4Sde7qfQ8wRP2O8FR
         8s9oxaejIkBFsR2Rl4nnnrQ03Sul+Ua7tCrCoIS3l3/N042Ra0DaKy+4Ks19fHef56MX
         iYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUDqIkk2NO8bK5RwkTZbVr1QkZ6gdYinihf95P/k+01bvzjnBRDHCvu+YOuMHDzKQlqIkqhjyDJXHDjIdUexQMh1AHw52PcXGvdpNlBcLuCaw4bN+p0mBMqWqhplAAoMz64IoevCK4mnAxguGiYwA+yhBGXJ6B3I0RdS1SOUBUpO1w5TQ==
X-Gm-Message-State: AOJu0YwkgEqtk9vTFwjq3JudWqVQ6h9zbiEAv4nTW8LdL040orpX65vr
	y2AflLtrjR3263KpocrcVLU+fA10smuwcgkOJ/lL4iAgxDJDogL8
X-Google-Smtp-Source: AGHT+IEGuM95PCywDHNTrOTy4omJ1d+kOqj5/hZObD0Ewg6JwkTZdpKln98/P1LK93tW0DEzPEdhtA==
X-Received: by 2002:a05:6358:6f0b:b0:183:7d27:c08d with SMTP id e5c5f4694b2df-193bcff582fmr2235260055d.32.1715942573507;
        Fri, 17 May 2024 03:42:53 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6584e7897bdsm3292328a12.21.2024.05.17.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:42:53 -0700 (PDT)
Date: Fri, 17 May 2024 19:42:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
	"Andrew F. Davis" <afd@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,am65: Fix remaining binding
 warnings
Message-ID: <20240517104251.GK202520@rocinante>
References: <8032b018-c870-403a-9dd9-63440de1da07@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8032b018-c870-403a-9dd9-63440de1da07@siemens.com>

Hello,

> This adds the missing num-viewport, phys and phy-name properties to the
> schema. Based on driver code, num-viewport is required for the root
> complex, phys are optional. Their number corresponds to the number of
> lanes. The AM65x supports up to 2 lanes.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: ti,am65: Fix remaining binding warnings
      https://git.kernel.org/pci/pci/c/64e098b59b8a

	Krzysztof

