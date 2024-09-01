Return-Path: <linux-pci+bounces-12564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC4967838
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475AC1F20FF7
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0FA183CB1;
	Sun,  1 Sep 2024 16:29:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EB44C97;
	Sun,  1 Sep 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208156; cv=none; b=gmxPH/i+70qyc74HRfRedvzZ+flG8OYvUeIq0GWlLo5A8meizA4Y/DNf7N9wX0df6yyuKx29CG4ilEq+nToWwEvVeSkZEDYCxfB3Rqs9qQQpU1ub4MA1CF6ChSwJgeTfvJwc5BbxuLC8YrRXwtf07rd5CwLFf8ogpUBdO/+Ng2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208156; c=relaxed/simple;
	bh=EtLy3hQ2xvVykP8FrNndhx0mClZ6YC1ocIgQ9wkyQ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASqQlZaGyUrXRheSoKaN0bM/OcsV+heSBouI+QHdyEsqV02wD522H4+z6+gRboCZ37TbFK1r4d9rT/0uSMl4anpJ+y4WJ/XT4LY652M7gNN1B45CEbYiVjbJBsb65bwk1gjJ4qvSLF9XlaoYmdjxKAMqE2nvuyf+OnYn4RfGh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8a1aa5606so480104a91.0;
        Sun, 01 Sep 2024 09:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208154; x=1725812954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP6a0ObVRJ45bjmxA06dysPPH+I7+nzgYg6tCWWzUuk=;
        b=qDbY76rUdMTruN73KEsEnegJgdwwHEFNadAPKUEEVnze5KYxuqE0GKOhabgCZP7jnj
         iIPOtXhQvu83DdFlKC6oL8+7EEwHGTcX1gKbLK+0m8876gFNUSlskhQUVI+lur1XzkHF
         7jveWlU8UUAYZC2CpJRQeWBx6uioAocIXIjUOsOxzJ57crWw2nS05dYXrV9rDBKlPHQd
         aKSa4SnVjSYbKTgjtaBFrzpIX2x2Sj4FqqVUVLP2gp6CnGcF1Jumvtuj3x07Piub5CdX
         uT83okb/sJW9DLr41vVMl6XQHyUQqizIfDWBVjrsRlXDknPb+A4Q7qTNaxSfexFThE9d
         j4qg==
X-Forwarded-Encrypted: i=1; AJvYcCUZItn/JHQMxrx0MmcqtOfmsEMndZ7zXnxNIsGRDtCOIRFuP4nOmaJ4resUGgksM++1nTrbNe52jE8d@vger.kernel.org, AJvYcCW4VGRIe5sEY2W5a7qy+d+xn9ddVW5oR7T3n+XTvLy22zardWwhxBCfQe6xqML0l1XMk+yddc6qwPMlurTr@vger.kernel.org, AJvYcCXKU9WKw2sW0w04mrE+lBROr67nL3JVMdmBEmf/An/7LrUaSvfGDlxxeHUGDovKSQwvK+YX6jdsE/4WhQY4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1GYkviYdDJ75Tav2djMBF8w4Tpc7ozxZ1d9pWdYfnJm56aSg
	GqRC7B+1XUQSbNFExVnGwUUp/JHk9uwWNw91O8/Z0wGRn47mhR4B
X-Google-Smtp-Source: AGHT+IGC/ioEAJKa0p262HLZjiMbGlLJUOLGrDG8EGhClFFV22vNNlaG2OxZjXHFWJbKQQ0Ca1wI6Q==
X-Received: by 2002:a17:902:d50d:b0:205:4a37:b2ac with SMTP id d9443c01a7336-2054a37b550mr28296875ad.34.1725208154477;
        Sun, 01 Sep 2024 09:29:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd669sm54310585ad.82.2024.09.01.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:29:13 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:29:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Use OPP only if the platform supports it
Message-ID: <20240901162912.GA204820@rocinante>
References: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
 <20240813202456.GB1922056@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813202456.GB1922056@rocinante>

[...]
> Applied to controller/qcom, thank you!

Bjorn included the patch as part of his recent Pull Request with assorted
PCI tree fixes, as such, I removed this patch from the branch, since it's
upstream already.

	Krzysztof

