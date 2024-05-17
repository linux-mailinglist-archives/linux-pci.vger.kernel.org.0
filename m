Return-Path: <linux-pci+bounces-7621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58D8C85B8
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CFD1F24AED
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747353D969;
	Fri, 17 May 2024 11:31:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F72BCFD;
	Fri, 17 May 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945469; cv=none; b=WBdQVcK4oBjISmRjavO4L0ll4fbIoq8q5+nsWidCxtu2t9YQulSKUP+LIKreBnh6T1VMeAfWQ26qAQWpocGNBhvbq0Y83ZauRno5q+QE9wgzSDthVu+OGRcx6eAP+zVeXzR1p1un3ENiOz8/htlm1g6w+WHGpKCxL2zOcXA8iL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945469; c=relaxed/simple;
	bh=BA4d3vLBGZjjGwDfxYueaIuKlKe7mr5LJxlHM2kZzOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc3OQqtadIYYinvHZmN1Ta7tPrKL4bqextazPNGiFD8zhzqI83jKVy3oORTNhXe1jESjtY85LB7tE76veG4kfqOZh7aZLiUrBBQ35PJP8bcpatAXwkTH+dilCr6f0PpJ45T+x2/YlI7TP6ObMRmBnEUjaaMrNpW/B1Lx27Xu42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee42b97b32so5745385ad.2;
        Fri, 17 May 2024 04:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945467; x=1716550267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXuBWNkKD3n4KlzVx4D4Nc70Xdl9SdaqCdx/0kE74uk=;
        b=uKl+kCd/9dBreBMTCsPFydgjuK5dE+mdgOADCVt7wgmO94vn3jok0NQcv9N7l+aNyF
         7DdtiddrGYWwUcnKJpzfy1sb9wEhxeVbqyZgtwsSa3q1D7Jxi1AK3gx20rvIUoRvS45y
         0elwjQ/9BacdZ4X9dIg8a0bEdwvJ3VRmJ3cNv9hGXGoSIxOCC5MavXxklTJLjmfk8H1Q
         A/YHhhy3Fge43h8TYLs5r0UGrKMUrvhpQfqSmZu53H1L9UCi6Hce9Ybghv7ffXQbaQF9
         PVT9c/avv30jQGZl1Z4bez2Vjkxea/J/w+bTu5xKswK2/UnpxoNn8OK3J5Ko5wTcVhsj
         k3PA==
X-Forwarded-Encrypted: i=1; AJvYcCW/3v65htk7zBacO3p60xO1iK3Y0E2z4sA01g9QZvky9gW0iTucoGTe3iaz/JtXzxSXHC/G9Q4G+HmVzK45BVvrgbiqemcKKL5uo9BBERJAbQWp5CULNq19sT8RIT7Ba8b6eWjmO2g=
X-Gm-Message-State: AOJu0Yz5NPxlD4oYWfM+joOL8cIypZj6r9EyRBf5ohrp8PdGM/FO/b9B
	yO2lHBn8Ewv5L1nu8gWGw47gTxOLtAhapUQWkzEZwQQc/QSaaEgZ
X-Google-Smtp-Source: AGHT+IHZ3auz3dAuLK7Ymf1E7i7sIchp1TB8ZrektImFg2tJnd785Qsxq3AXVYhD7clXRKKa+LmzAA==
X-Received: by 2002:a17:902:f64e:b0:1f0:8e0a:a74 with SMTP id d9443c01a7336-1f08e0a0b69mr109082445ad.67.1715945467445;
        Fri, 17 May 2024 04:31:07 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16dasm155384455ad.15.2024.05.17.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:31:06 -0700 (PDT)
Date: Fri, 17 May 2024 20:31:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V2] PCI: tegra194: Set EP alignment restriction for
 inbound ATU
Message-ID: <20240517113105.GB202520@rocinante>
References: <20240508092207.337063-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508092207.337063-1-jonathanh@nvidia.com>

Hello,

> Tegra194 and Tegra234 PCIe EP controllers have 64K alignment
> restriction for the inbound ATU. Set the endpoint inbound ATU alignment to
> 64kB in the Tegra194 PCIe driver.

Applied to controller/tegra194, thank you!

[1/1] PCI: tegra194: Set EP alignment restriction for inbound ATU
      https://git.kernel.org/pci/pci/c/ff58a429d70c

	Krzysztof

