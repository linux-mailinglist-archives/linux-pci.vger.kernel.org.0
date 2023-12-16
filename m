Return-Path: <linux-pci+bounces-1091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8C815BDD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0269B1F2335A
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA973528B;
	Sat, 16 Dec 2023 21:31:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745331E493;
	Sat, 16 Dec 2023 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3a64698b3so2641065ad.0;
        Sat, 16 Dec 2023 13:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702762283; x=1703367083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4443SmRtx3Ll3c6RsS4u7u/jos4/hCHtDUV3C2hmXnY=;
        b=ruWak0qXMU4i9nSrAfVcUfb/j0W+HxFQBXb+jGRpqxX23fHiGViYg35TQTniNwGnwn
         /ikHdC9HWNxLXnc6iOeYsq2D20Xj743tY5QeFiTzbD5cKmTs0r5oad3cKaJnGqpE1LSR
         LE+XBz/Oujek338Bh7DBdTz/NH5H2nzs14IvOEEDtAfixFKJ2VQ9Rp2c30MztkZGrrTW
         7nZ9OAwvOjlNNSByvSy7DqAPKDU0iNqQRouInn5AiQdZ2Wf/mBAabtaBJAaj5neH7gIt
         cRNTA0MtkWzs7OunOB2A8z6C07ypUr5wpuatxcQMEWoEvgZxp18S9jyEz4Zl27i7lfyD
         3dkA==
X-Gm-Message-State: AOJu0YwVNR+dfhDF1aPSwOVEvzxyHpWB9rSIpRFSJ2bVnG8u3zWpNhnD
	EPQJPHVqlgilbY1XOMOFtls=
X-Google-Smtp-Source: AGHT+IHuutMIArrggGyEjyRV5foQfX/Zzbo6BZkznmf4+W8PKBLVKdrscCfYxVHd7AFcFGqzZvyrLw==
X-Received: by 2002:a17:902:ea0e:b0:1d0:cec3:4568 with SMTP id s14-20020a170902ea0e00b001d0cec34568mr17170399plg.54.1702762282829;
        Sat, 16 Dec 2023 13:31:22 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001cf7bd9ade5sm16235198plv.3.2023.12.16.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 13:31:22 -0800 (PST)
Date: Sun, 17 Dec 2023 06:31:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, colnor+dt@kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Message-ID: <20231216213121.GB3302836@rocinante>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>

Hello,

> Current driver is supports up to 16 buses. The following code fixes 
> to support up to 256 buses.
> 
> update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB ECAM
> region to detect 256 buses.
> 
> Update ecam size to 256MB in device tree binding example.
> 
> Remove unwanted code.

Applied to controller/xilinx-ecam, thank you!

[01/04] PCI: xilinx-nwl: Remove redundant code that sets Type 1 header fields
        https://git.kernel.org/pci/pci/c/a2492ff1fcb9
[02/04] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in the DT example
        https://git.kernel.org/pci/pci/c/22f38a244273
[03/04] PCI: xilinx-nwl: Rename the NWL_ECAM_VALUE_DEFAULT macro
        https://git.kernel.org/pci/pci/c/177692115f6f
[04/04] PCI: xilinx-nwl: Modify ECAM size to enable support for 256 buses
        https://git.kernel.org/pci/pci/c/2fccd11518f1

	Krzysztof

