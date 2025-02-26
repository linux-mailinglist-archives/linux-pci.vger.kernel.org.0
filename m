Return-Path: <linux-pci+bounces-22408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EAA4567D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2218957CB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286A19CD17;
	Wed, 26 Feb 2025 07:17:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DD18DB11;
	Wed, 26 Feb 2025 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554248; cv=none; b=pILhAga3Mo5MS4VGaawjDbitBCu8fzdAyPXVUBE3yXLFIUwK2I+2D6D3GaPSa97mVq0TcFO9+YDGPZyxI05cQYtjX5It74PR8XlY7S6uACWmwZPPs9i0hI9Ca3MqvEGCtNu+awJwsLmiREfqEJ23UVd5X/zrPoiZWJund/cuNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554248; c=relaxed/simple;
	bh=6JW0ahoUz3pEDfR+wAMH5W/AP2CrzMgP842FYPHgu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvw8qZ2T4GP0lAdBGMwUa8uER/VK2sz2wGpUrFbmJZaqNVRi3MK16pBpJSujJpBXs3fximL3OK5dZxh0lC8rYCiVqOhJ5xxCppaqVZ5j6ZGprfnJFR3z0qBUJ1vfnyJKMFLPrclJsC3j7RJkuBp2w1fw0+TJD1y2lPcHH/U99ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22100006bc8so113949085ad.0;
        Tue, 25 Feb 2025 23:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740554246; x=1741159046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW9bMldGg6LIlvvDvWC6cOazlkyZmVjqHW01ty4hQt4=;
        b=JZdi4aXSze2dYUZFS+4GTtismX1f5A3D51ZJ23IanOydPneDh2aUB2AfVvsFavteRs
         x3YqTdsdHr93WemdrZMTVqQsrcIKL0rjGWwJ+oehSBOB19NGFFdlbXSCoiQG81KP1wH3
         kKxsYVCKR7qRxGjoLRP9CyfyiIVdgYCBhJ+zc5eokOLpWSaPT79AbafbZFKKtYc/q+ed
         g7GeTVwiD0bQe5ROsQI8UVvZQa8t8G+XGypQRtvtOw2eLSIqxjGfw76CGkRJZnxXhFUP
         wS8CiVUWU9UPJJ+YHltaaoowU2gaUnPBVz5oHhMOWdrXI+RkK8S12Z/zLjmZgAk2W6Kg
         9GGg==
X-Forwarded-Encrypted: i=1; AJvYcCWF8mqiuYp/+/UJbWEMjevoM1Yyj/TrvASQaBG1tgvVkq9AoGqnUAruGgXo3rdbOdjq/eiEH2t7NZj4s6o=@vger.kernel.org, AJvYcCX6F9HRhudlQ1ywkEZCWWvAuZn1SJBsMHYsziq8TakbU5bLN56M2JYqrjC8T6qmoNg5zoe/jLqKWAoo@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiWO8FKvA8lQElyiDy4iNPUPRjFa9LM9pw34cIBkmKSXv6J3v
	+haLuZj/AbbUxS7sj0884cG/qgNnAKqdkUIOt6n4qwxhIQ6AXDOovlZxd2abtUc=
X-Gm-Gg: ASbGncsQvFGVCCGjK2dbeCGVY7apVR0cTP6yr92S1vZfvR4M6UvorCVl5IcQuj87gYL
	YtTipwzX9+tOd4NUq0u4k/kZPRJ3TfhF0OSaoL1g9kxKqFzsiDhC8e+k49KsS/MvD73gdmfH/oF
	JhFgUnh+f3GstztQxaoB+tMV8V3Q0flWJHj4mH0nfVBG7Agb6HnOjJ0PYAfoPlWTo/2sJbGYuoG
	TaFICjXAEH+9alXCsqKZDlkoyHJaLuU/QS6Uc8Am5s+Kaf1vHZn4GTm6VdOr8VQNASqkXno0wP/
	l4D8f5K/T2DhMl5YlFlJFcw92QtSDgr9TEwPRRuz0bFa60n2tqtqZUWpVfAX
X-Google-Smtp-Source: AGHT+IFfZzOSgnxkpJdX8VC3XmknHk+nW3PGWhl7cjv9dtT/kV2/KI14MuU0c+PmbD+OmNR44vO/Tw==
X-Received: by 2002:a17:903:191:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22307b4bd13mr99685825ad.12.1740554246364;
        Tue, 25 Feb 2025 23:17:26 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0b2292sm25382075ad.252.2025.02.25.23.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 23:17:25 -0800 (PST)
Date: Wed, 26 Feb 2025 16:17:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, shradha.t@samsung.com,
	cassel@kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
Message-ID: <20250226071724.GD951736@rocinante>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>

Hello,

> This series has a couple of fixes for the recently merged debugfs patches.
> This series is rebased on top of pci/controller/dwc branch.

Squashed both patches with the changes already on the branch.

Thank you for both fixes!

	Krzysztof

