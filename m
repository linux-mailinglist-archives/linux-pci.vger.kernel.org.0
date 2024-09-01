Return-Path: <linux-pci+bounces-12566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA79678B3
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4882B22443
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1D181B87;
	Sun,  1 Sep 2024 16:34:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F7537FF;
	Sun,  1 Sep 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208474; cv=none; b=l+laypASOWwnz4s/WdkNRhLF//1GBeBu7h8vWtXYejTXVaw9H0zOZHxvzgTcg/NVy/eEFmMgGySFZxRqrK/rsDdXhzIJMKWgfyrtYPaRKru6QJa0sHNxkEtOQ6AXD1+RLHP6AKLFiN7XC4ZTW1xCV1uZZ1V1O7aWuTvqBtrOtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208474; c=relaxed/simple;
	bh=cFygrlWX03Fc7DzVN3oG5eavHuzgxg1G8IXpcreIfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKMpHZezn+TyCMQxLiq43+IOX4n8AYZ3LsCLHvAoj6sq+rA2oP2YtcGu6B1YohKfOSF0oyPSO4IQ9WchbzoarSx2jopK0819s9iwul6xOevTOD54DMJwHcsl0U7XP31n5WhuwfwJclfUwP2uI9QFzdwhvRHqDq4lGda4WWP7JCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e01780b85aso501288eaf.2;
        Sun, 01 Sep 2024 09:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208470; x=1725813270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTp58pLZILxilG/TSa0eywC/sXEwB1GPNx1xi4fjUmY=;
        b=tAEO9W3tDD/4HFo1Soz3+sT7EVvXHrjbYhuEGPI8wY5roxBju5Dr2EkEhWUHIcDUKF
         rRRe3nZi3jUvWGPd1i/G/FEWBU+Z2nJ7d4hc18lfVSvap9KzHvEquNb5g+oBPCrMCLcQ
         xst6i5T6JxQRpOF6xvsRMSA+aso+BC9qUW5JHtB0jv0ZumNCLKQq0bWk+G4zuBD4vNYA
         UgFa4rm3YGGAqzEPztLpDc1NPaAQb0Ilv9EjDldmNgOlb3LBNWaJoHw0VkAvXDHPOGPc
         6tkYUQXEzMyiyJynw7HKqqpwsOXwSIjaS2pNcM2Sdl90Ltd8zEiunHGusDFs9ax95YH1
         uixg==
X-Forwarded-Encrypted: i=1; AJvYcCVd8U3Vd+IjDskhBxgoiy+juOnhF+8OwvCW6nT9T+wW2LuiMFzCKHm5TKeyojXvtyN9zJyPPMALZaI1@vger.kernel.org, AJvYcCVdtJ4rFwenL18jDhPklusCSFoIK8kDDOAsbdaoWloizE+jcFwJPp/J6G4TtPs7BIVlxPGR4X5Zxib7iAHC@vger.kernel.org, AJvYcCWLve3USgxycQVkwFRivvwbElItV/QhlZPtISeGo60ZUk5ZedVApT+kPlw3XmPHm52kEarf8LKmsrwjud55@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5D3CVdHJVk/Wip2pp3EhzRBwVbfubE5fzAmnPSX/9eZqWudI
	as4gXrOcbMaAAHwN/i22fA6k/2lt6Qgc/iglqlgypgnblPNsfYGR/mWdIjKWBeE=
X-Google-Smtp-Source: AGHT+IF/cOWLig6V9x65WK7XYxRdovkpMyQrkPe3k678tNYrSdgvKSgNIyyD1FFwrmcHTFFiqL618g==
X-Received: by 2002:a05:6358:7e4f:b0:1a6:799b:b06c with SMTP id e5c5f4694b2df-1b7e397efe3mr1047119055d.23.1725208470028;
        Sun, 01 Sep 2024 09:34:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4e1c38990sm201310a12.44.2024.09.01.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:34:29 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:34:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240901163428.GB235729@rocinante>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
 <20240813202547.GC1922056@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813202547.GC1922056@rocinante>

Hello,

[...]
> Applied to controller/qcom, thank you!

Based on the conversation here, I removed this patch from the branch.

	Krzysztof

