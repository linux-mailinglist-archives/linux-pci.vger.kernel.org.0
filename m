Return-Path: <linux-pci+bounces-27102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EBEAA78C9
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405403B8EB3
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774825FA2D;
	Fri,  2 May 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfT8qh63"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1622566DE
	for <linux-pci@vger.kernel.org>; Fri,  2 May 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207901; cv=none; b=pJeDgKbIutigvNgsBWUIp67/41rIBBh2RQILz7n4bD9nPRyjyFCzLSe0qa+0MXBWBkoGZFPjqDwvFJIxCIbrutYQ+lvgfK1vvlOMqYdnlbRjJpI5R+lyuosgpngU1NkkjtxOcco7ZtzCS9IPn75ipL6ydI741pRvbbzjTYTrFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207901; c=relaxed/simple;
	bh=XmCGPi5E/4vdLYqfzcEUuIa7Pjd6veLPx7s/gT1s0z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmw+646gq0inTQPgEjIROQSFil0VtpsrbuBSDpywgHlfhhQt0sFEE0K0Qsc9HYt/E0gRWR6izkMAtYjYRn4K7uGpkFn0IwdB0wpxZDr2detl0ghwD8XncPrTmU2hYcjPMcs17L5muLIzClreRJxQyEqErEeqEEhAWsLRKo/RyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfT8qh63; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2243803b776so41026115ad.0
        for <linux-pci@vger.kernel.org>; Fri, 02 May 2025 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746207899; x=1746812699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY8M+VLKea8pjpC946v5/t8PrnnUb0Gzxs+7tzVnLLg=;
        b=ZfT8qh63//vQIKv+aV+pTKMNJSSjvLT94HkI9it5Jn5Lrufb7peCm8wUTuJpnfo/ye
         UthcD5b7RleAhGAsixdB2GixpqQjAB9+HqsNmWbGlezGFqSx22VFJTJiSvyrox/n6Icf
         K77bNvG8zu4fY+r/AfpLe6xuF9JCrjvc3chodM/LzqN0ACA8W5wOwNb80cchg+M/n/9W
         BtopYKzjhNzoz/Mjj1rnJQ/MQ5uZZD+DWG+enEdFTzfQhmWwYc69OTs/2/s4v/guugbZ
         AO7otwmEVRO+NBtCq0408ZJf3H7uzWZHmPE7A2OvDNw3geQtrYk0HefqjR5gx+4izAzk
         lwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746207899; x=1746812699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY8M+VLKea8pjpC946v5/t8PrnnUb0Gzxs+7tzVnLLg=;
        b=lLBdjX4xv8adc3ES4CPqGOZmKz15G6n8oygwVa2YUeMUkt+xl61zspXDfIsHes/Mwi
         ZdM5eG2ywFNMAKcuNlFyakBffyyUBq2egYvZKTi1xbJlyBBBdLina9uNz2Rjf8xajK+I
         4TBNubYq+hqnH6DXz+6uePuD81uei71rr/cCJy2uPtqJJcLC4UYso2sP1ofOeHPN3UEh
         rQQxdnkkGPUCGJHgPAKHMoSrMRXLqgWMU7tomkgDSFluK8BdGs0MV7b3wPDmXC9spPmC
         6/mhTqq5i05+W6mo/HdZ8xpW713JZT9fWj6DVGWn8fRHNV+1s/dMyM4jt3hUCo9S59zE
         7mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGQpVKybIyyNkxJf+uUZ++Vb+RK4siUBfBZwezdbnygw2JhQhzb14ZWrWnBI5Kx5k24VRODQynIhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYPuRn38//YtO4ugNwkPrpaKyE4XliwCyiMHEBdc1vukRfn2F
	XX5XfT18w14teBS6zVuXBXjs8PYrzRtCt1VeGfv7DcrBtmbuRBHuCAbBzrfgcg==
X-Gm-Gg: ASbGncsYnrfLKoMJZC35Fdsq/C/HQnQ/cdZl83rkDHHTX1+tlRwiaWwqnOQ/bwUWfXd
	VxGnvroDE36Ff1sJ0qK39ZlrXEF4/rSTlaF1u/2xVTMz86LsKLocZEZr2Q2dq/CXmY2rUx6tOh8
	/P75JM/70M1UBnfIStVsWuvm+DaLQHpcf6UibU/a/ykARwzRlcIQ+PxWRyQ5s9ulfyc8Wmaw1lP
	yxhJY4EH954yqg1CvEQh9EZRIwUGcXg5iN1rc2tKabB55RbRmef9+fKMGR3kN+nPyfVPunrUhBf
	gTWuALb/57qe3ELnLVQD1RCLoj2CkRaxoQwx/WDUNDYqarTRUT9dqGdA
X-Google-Smtp-Source: AGHT+IHXWlUErao4J1U1mlwJYk9ATwc8DlkGhI6ADj3IGLu/xR9EZ4EkOFgQ2fo9wnmS3hLmuShE4g==
X-Received: by 2002:a17:903:187:b0:223:517a:d2a3 with SMTP id d9443c01a7336-22e1032f5a2mr56701275ad.17.1746207898939;
        Fri, 02 May 2025 10:44:58 -0700 (PDT)
Received: from thinkpad.. ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eae99sm10608815ad.19.2025.05.02.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:44:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	christophe.jaillet@wanadoo.fr,
	thierry.reding@gmail.com,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jonathanh@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [v3] PCI: tegra194: Fix debugfs directory creation when CONFIG_PCIEASPM is disabled
Date: Fri,  2 May 2025 23:14:50 +0530
Message-ID: <174620787968.116062.4174884576928380234.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407124331.69459-1-18255117159@163.com>
References: <20250407124331.69459-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Apr 2025 20:43:31 +0800, Hans Zhang wrote:
> Previously, the debugfs directory was unconditionally created in
> tegra_pcie_config_rp() regardless of the CONFIG_PCIEASPM setting.
> This led to unnecessary directory creation when ASPM support was disabled.
> 
> Move the debugfs directory creation into init_debugfs() which is
> conditionally compiled based on CONFIG_PCIEASPM. This ensures:
> - The directory is only created when ASPM-related debugfs entries are
>   needed.
> - Proper error handling for directory creation failures.
> - Avoids cluttering debugfs with empty directories when ASPM is disabled.
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra194: Fix debugfs directory creation when CONFIG_PCIEASPM is disabled
      commit: ed798ff1c52f6fe232ce2e24e68fb63f5470ab97

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

