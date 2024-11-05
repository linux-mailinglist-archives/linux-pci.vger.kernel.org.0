Return-Path: <linux-pci+bounces-16084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075309BD839
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01392842B6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79A216203;
	Tue,  5 Nov 2024 22:12:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE331FBCA3;
	Tue,  5 Nov 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844737; cv=none; b=SjQC1VGT+MuZeMyZNVI6HK1UgTMnHbfTfCFoI3S6dB69+MKW1zbcMhgitqHajp2BxarykNPzDlDHx1MJ+5AAOgKOvvAw4/sRb5ckIoDmp5ZWGN40+SCx1q1WlhOL8/5JdNW7XpxtHftAsBcLpvwdilKou+McAdtTN0l10axpDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844737; c=relaxed/simple;
	bh=cd+NpLk0DVP4MnNZwOfkwMmMxg0c4b8a5Oo85O8W3SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVoodeY8SylT7UF1uXnyod8PL9KiTzKK7A44lvRgN94zbtspocj+OXOSJvTHEP/HLsxpgWtmmoQhZi5jx9fZeWKnQdNPQVt+G5FQjUQv8Ayso5WZZsEl9plLn2ewDAvt9FePZSx56cNHVnde7s4w5W86nOaBKcolN+weKt1ikLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e52582cf8so5204962b3a.2;
        Tue, 05 Nov 2024 14:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844735; x=1731449535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ksD1ZvJrcU44thyxRfGTGYSQMrepj3N5lKWUPdqxZ4=;
        b=JSo0gLyXqO/6fmMnHRO2roIqY61xSq14ZTyMmHkrC1KDNH8yIc8uxWijq2fD3yfWtx
         55/cjnxCjtgddL1sHQ2Ou10kMa8sWqYC74/5aH+AHIp6bt8rBJkj4Dk7rLST2nJtRPKn
         1mBs0SgXdnajhrW28d0YCrNdXZdrdUTi2sVW6uTnopCcONb706BGJ4wbonBLn9UoS435
         z/UfMawwXm37VtCOxOENPIUW0P2TQWDQMuFf5p8RtXC6t8E4bhPs2eeqAoU9s3RKIDZW
         h4Q5tt3rI9VoXwIMHBO9FuBll3MYWZVu4L2syd8N4k0Iq255+DH9/obmPlBRdOGLnGHx
         T5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCURcVUJHkHLaA5LCoqI3Gj3WQQ0qZ7DwLN9axbnm+t6Ob7Ts56EungrqUTZbRCIRsuPRIicFZlN+hD/@vger.kernel.org, AJvYcCVIAeKaoBjKvai4o2QoEIqgwtz0EB+tfdKEQi2S1KkW8mR9/7thXR5+gokH1++mDMjNeIWCa0o8cgtAHaG4@vger.kernel.org, AJvYcCWt29ugU0MSj6DGUmI15J8clI6NUKksViGwzCKSFa5wmwfcGH54IrIGxgc0L6eQLS/kxQsXYBCY8rSG@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSNbUlwh51A5j4VzPa4Epx9TEwETgT5ttJ+Xg7jAVMbtPL9sN
	vYWLkKfd9lQ5b80x7zDr/xd092v0u2vTsgPB0bZQ/OlTDR+N13j1
X-Google-Smtp-Source: AGHT+IF29PlhC1/J3xdbpFkXUMNCkz2+BRJ9IFwswl1OWFPanYs98/Dws5pyMh0FKH4nDQt+cwuxEA==
X-Received: by 2002:a05:6a20:431b:b0:1db:e922:9eaf with SMTP id adf61e73a8af0-1dbe922b072mr9595005637.27.1730844734882;
        Tue, 05 Nov 2024 14:12:14 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452ac9b1sm9596817a12.31.2024.11.05.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:12:14 -0800 (PST)
Date: Wed, 6 Nov 2024 07:12:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells"
 from example
Message-ID: <20241105221212.GA878254@rocinante>
References: <20241105213217.442809-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105213217.442809-1-robh@kernel.org>

Hello,

> "#interrupt-cells" is not valid without a corresponding "interrupt-map"
> or "interrupt-controller" property. As the example has neither, drop
> "#interrupt-cells". This fixes a dtc interrupt_provider warning.

Applied to dt-bindings, thank you!

[01/01] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells" from example
        https://git.kernel.org/pci/pci/c/718c157a0b94

	Krzysztof

