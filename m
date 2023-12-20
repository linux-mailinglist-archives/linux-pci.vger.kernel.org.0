Return-Path: <linux-pci+bounces-1249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A481A8AF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 23:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EAA1C21FB1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB50482DC;
	Wed, 20 Dec 2023 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK7VI8aC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4244A983;
	Wed, 20 Dec 2023 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so1393925ad.3;
        Wed, 20 Dec 2023 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703109840; x=1703714640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNHUUsyM1naYIm7Z3rNAieSmn32a7fPMNDK6KWutmoY=;
        b=dK7VI8aC7CHI/07ZW8nR2DtpOwjpVeB0jBvniXy7mdaIb1HyPu7Hiy8rsMlufldm50
         yAWbu+W2B01JVRuLYXM9yI5tB3ukp3sH6C0fjpj8zRAGpPPHmw390DB6NuvEs6A/aNp8
         KBjSLvu+B3s8Z2XGSpeUnMolpfsUfdsbay40xdNHYwLlKc0VGx/xqK0eVFtDavxvmUR2
         GDXyMtiOko12BWZYdSfpit/RNRkeIlRdtHPAvajBMgKxP/SAEcSzK4bfCGwFrbve+cPU
         BHSK6A8ENQmsbG3rB1rVjHPOH6EAOaYYPkH+tC58hhiDapRUBtAJdfNj3ZIeODdKCzeP
         0dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703109840; x=1703714640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNHUUsyM1naYIm7Z3rNAieSmn32a7fPMNDK6KWutmoY=;
        b=QgRQSLr6jKEbF8kYydZvHeH+ko7sjIScj6fXf0AqcHKQueKB/hHWLyASTMl3o57XjY
         De4Bd57u4qLzNPxYB3Ffx9wbscUVQdSJDJgG9uQekPaclcWz29wTe8HKhPfJhgTnrKLL
         8dYtpFhE3zYEJE8dG2fGMDtoIb6xLJMDKb4l8zC3XXeYYqkgR+wDOnSu/y4gs9nGT3im
         HFgU7a0UAnI8sYHjOOPkdl6oZ8zgBsdxEx4O82+lB2UgtiR8DmnhmqTyWKDIZtI0w3Iz
         uFU3F6YwUhaMKenTEdRQf7X2ClmVDawz3+xJtHaAPL0EmvGEf8TSGm0YOduq+Fus9Dgc
         IVMw==
X-Gm-Message-State: AOJu0Ywv8S3I6nJRLyAj1hciWa+Y55MWuWv8n+JbAQLOqQiMWBXiexbb
	dLEJmM54FhypH6GrZohylb0=
X-Google-Smtp-Source: AGHT+IHxTN5KazZ5x584+OE2ul+IQzkJSSv1VEd1vLT4hZwHexZ6Q1bbQI271QpPzi6nD9r/LhOn3Q==
X-Received: by 2002:a17:902:e851:b0:1d3:c8ff:4f6e with SMTP id t17-20020a170902e85100b001d3c8ff4f6emr4874600plg.103.1703109840154;
        Wed, 20 Dec 2023 14:04:00 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9d7:3461:3155:35d4])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b001d3f2850a15sm204724plg.89.2023.12.20.14.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:03:59 -0800 (PST)
Date: Wed, 20 Dec 2023 14:03:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Esther Shimanovich <eshima@google.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZYNkzdw7FzlTQqty@google.com>
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
 <ZYIWHjr0U08tIHOk@google.com>
 <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>
 <ZYJFq6T3uGJVv0Nh@google.com>
 <CAK5fCsAAXLaXBCy_pBEaynog=xjuZNSP2b0edwrcZ_3Vo4xxCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK5fCsAAXLaXBCy_pBEaynog=xjuZNSP2b0edwrcZ_3Vo4xxCQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 02:46:20PM -0500, Esther Shimanovich wrote:
> > Again, maybe PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE?
> 
> Question--- PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE is defined in
> "drivers/thunderbolt/nhi.h" as opposed to "include/linux/pci_ids.h".
> It seems like the ids in "drivers/thunderbolt/nhi.h" are specifically
> for use within the thunderbolt driver only. Would you want me to move
> it into pci_ids.h so that I could use it here? Or could I ignore this
> suggestion? My personal inclination is that that would make more sense
> to do in a separate refactoring patch.

I'll leave that decision to PCI maintainers.

Thanks.

-- 
Dmitry

