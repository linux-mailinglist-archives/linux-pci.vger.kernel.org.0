Return-Path: <linux-pci+bounces-1727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C5825E3F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 06:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CB91C2286C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3B17E1;
	Sat,  6 Jan 2024 05:02:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249E611F;
	Sat,  6 Jan 2024 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dc20b4595bso198617a34.0;
        Fri, 05 Jan 2024 21:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704517371; x=1705122171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK8r7/aM3L9XGWvRGZnPsTvaAInBVrLl4heKm8vHNzI=;
        b=YS0puHaFODOKXkObKOiStsMLaw57hNaLQZ0xw8zI3bruD0ap1YkD34FRGKS5MD2esZ
         rU9yZEvXZxsbqGcgdAilSGr+69T/GVi+uDcEykLFKza29M/s28IZx1lsVmehUPBM/tTs
         gj1A8L/cKXBj/NnD4kavAOeZUrnt+XuVhT1C7SIgAi93h+qL8LNGr9OU11bVT5UC1C1k
         wXOxS2boDfWrituJuVI3hCvPwaXMEbdJvbJDDnSPj9EKGc/HdqXB21CsBjAQO37ZkQDN
         tETNKjXE8pxLKDWnkT2etcYIcQwg8caHRN2FvNEPCppOpmSWXATUzBvy+7O7Vpo8foYR
         Sc1g==
X-Gm-Message-State: AOJu0Yw1xdtcyRXT8RhCqLMT3i6BoyCjKwkFhjAezLJYiEnA061ZN2wd
	0VtLdbaZr5iNtS6AlXaIvSk=
X-Google-Smtp-Source: AGHT+IGh4zH5m14dFcFkW/DJT9SQlTB83E+Xq0ErohPZJ1em1dUH8frKAoF1I8TghwO6vOchOVVyRw==
X-Received: by 2002:a05:6359:7302:b0:175:78d3:1b44 with SMTP id ux2-20020a056359730200b0017578d31b44mr402339rwb.46.1704517370687;
        Fri, 05 Jan 2024 21:02:50 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090ab11500b0028d19ddb1afsm1089597pjq.33.2024.01.05.21.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:02:49 -0800 (PST)
Date: Sat, 6 Jan 2024 14:02:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Joseph <tjoseph@cadence.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: cadence: Make TI J721E depend on ARCH_K3
Message-ID: <20240106050247.GA1227754@rocinante>
References: <20240104213910.1426843-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104213910.1426843-1-pbrobinson@gmail.com>

Hello,

> The J721E PCIe is hardware specific to TI SoC parts so add a dependency
> on that so it's available for those SoC parts and for compile testing but
> not necessarily everyone who enables the Cadence PCIe controller.

Applied to controller/cadence, thank you!

[1/1] PCI: j721e: Make TI J721E depend on ARCH_K3
      https://git.kernel.org/pci/pci/c/177c9ac6ab3f

	Krzysztof

