Return-Path: <linux-pci+bounces-1825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F790827157
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349B51F2341D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE946546;
	Mon,  8 Jan 2024 14:30:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57846549;
	Mon,  8 Jan 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d509222c11so2397425ad.1;
        Mon, 08 Jan 2024 06:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724209; x=1705329009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVMqThbVP0Q8RE+595KzEmSzoEzPpkpeb2mdqe/54Po=;
        b=CSKjqIRpIVC32YXnPiIi9gEcDdvhzJhJUcIcv3c0KMpBjZKHbiIM1ffjg0Unje7sOI
         rVcQCeJu4F6cw7G9by8zUTTWKn5I157zDflfaSX6LOdTdYhMo6xWqUXXPuwKOuEYHwCq
         0QTIROhOm4ydWCzyoaC3Mv1nMJpJaLEXfrAw9eozjLhHnSjMPs14auwJw7K6G4OT89NA
         pfqiWEg4SKlIf2aP9FikWq/lDadyn5tZCLAO7lMNn5ROaswUfw7fuCin/NkDYHsiAY1r
         v7Sjp1dJgZ3WQcEwLnUULoF9I6sPK7+dcvZ3BJ6a9eKEfp+Rjqi9NvQZylreAmjaoVgD
         VGKw==
X-Gm-Message-State: AOJu0YzO5KHyV+39daqPPiszMyn4sW/NxE71ywY/X0IAL4lcyeTZ5Tam
	qMmKdtkaM24HKr8Tg+6VA8s=
X-Google-Smtp-Source: AGHT+IE3fdqzVYISbL4ZtM/lxTCygtaE0GCar9x98h7e8R949MP4dVwbh+1fDeut8mKc+f/isMwbKQ==
X-Received: by 2002:a17:902:ce81:b0:1d5:2197:46e9 with SMTP id f1-20020a170902ce8100b001d5219746e9mr1033721plg.117.1704724208990;
        Mon, 08 Jan 2024 06:30:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001d09c5424d4sm6321570plf.297.2024.01.08.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:30:08 -0800 (PST)
Date: Mon, 8 Jan 2024 23:30:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, qizhong.cheng@mediatek.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] PCI: mediatek: Clear interrupt status before
 dispatching handler
Message-ID: <20240108143006.GA2602112@rocinante>
References: <20231211094923.31967-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211094923.31967-1-jianjun.wang@mediatek.com>

Hello,

> We found a failure when used iperf tool for wifi performance testing,
> there are some MSIs received while clearing the interrupt status,
> these MSIs cannot be serviced.
> 
> The interrupt status can be cleared even the MSI status still remaining,
> as an edge-triggered interrupts, its interrupt status should be cleared
> before dispatching to the handler of device.

Applied to controller/mediatek, thank you!

[1/1] PCI: mediatek: Clear interrupt status before dispatching handler
      https://git.kernel.org/pci/pci/c/4fea201e110e

	Krzysztof

