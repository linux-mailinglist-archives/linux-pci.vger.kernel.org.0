Return-Path: <linux-pci+bounces-28128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D92ABE124
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23C6189EC46
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337B268C55;
	Tue, 20 May 2025 16:50:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F425228B;
	Tue, 20 May 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759846; cv=none; b=dCYJ/a5yVL/RDmRtTKByC3AHsBav/x7RByDEFY+l5Edf5p0IP7kb5C09oY5fApPKYopbOd2+yIrzlFlpJcr0BrYmzvmhPnY5Xdd3bL6ab/zAr5u1Fn//RVeA2cr2wMz3BLwO92pqbiU3fYje4LzvyF835+ZDxtVs4kT7mPu4fGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759846; c=relaxed/simple;
	bh=fP3WnGbVpbjKLLP+WumUgq3kLsREfVjEBNjJ/qtRChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF0XEKRP3DMcb/MUZl66r1W8tS5xMGLSO/d1GO3njbgflqCjHNn6+hQtzOfrihGNBumoyo9SV8B5L7BqQQHQR4H9e7hLtp8dNFuGaLf7mVNLqpJ+GmOafGFwicb8dZuai9hXSFYje880PXpEyJ4ILXM5bZI/YtQI6+1glNMXJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5931552b3a.0;
        Tue, 20 May 2025 09:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759845; x=1748364645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCBUuwBl8iFbAAN/KUsLEzXhGpRUp+BR6OrbKlR7sTg=;
        b=HKn5Cf5pWMZDUac8Fuzx/Zn7t8gzvnKSbhN7QawGqVpmxfYuPXL/zrDSB62wFh/MkI
         +RBSRz9G/YpGVYg9jw6cmRGmfAs+tA61Hl0Gu1E7CtqRrTN5QeXWo6i8pWMdeQxJ9wkA
         Hk/tkakyHX4ARl2RrnMkG8PgFclzeNaevv/bMJDEIDSq0NLW4TQi7hheyuGIST028T7l
         LJ4o42CMt7jo6uv6yi26BXdOxrauNs4uIxvD+J86cch7X/N39vk0ApDEMQtjDRI2J5wA
         c9GmImMPl3BjkHbaHNN6u/A8V6oOQl4Sf5crNmFpRSYhMxfpNmWcwU7Fn4Dd33RVgkv8
         sIEg==
X-Forwarded-Encrypted: i=1; AJvYcCVJfqV03KAiLcJIpbE21ccNF8BzdM71WhnnNQ+PbHg113iRQ4wCfgOqJhQUj+v4VeJup6mGAt0gPx18@vger.kernel.org, AJvYcCWDJ1n6dxfo2zStTXhaIt+TYCfgQaX3dLhnw83cw5CYEZykVquoIkNIB05Tv4O2qptz3tPfTawvvrtI5/CVQ5K4nmk=@vger.kernel.org, AJvYcCXngIFm/RYku7kK7KhJ165GHa8eSKy/JlX+DuIpG79GAHmbn8iQad9ew4XEcMP2PfGhEsGuX9Nwrnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3KYSyk5r1LjNbqY11FQ+z0HIMRnK1vKE9km6kFCV5k/gy5Ir
	Kjg7HrY92TCmY8M7Re1Lg50aHh+uncicl1qgjt4m4dzRZcNc0X4zTct7
X-Gm-Gg: ASbGnctBETWEu2LoezP+s4uGQjpltpJT1q1jMUM/q6qV7iTNs41rDAE9hp+Khm9zgPR
	miSVs3nWEy7ZyelR4gPqqAs/64Bb16P0OquE+RGe7b8VGwVox0+un7DRlblX0BIx1r2rDxh2K5e
	jh2Fn85ihMU0O1FsiMXOfIXuby+3v+JZ2PSRXYZEqYmgFBnh/hM7f2noA3LnzZv0m7+Uc/iTjgC
	Bze5kYkaFUvagrwX1mXgF4QfyqoqC32rrBr8uXYRUiy1MPLj6kQ+asl4vcfk0ANdzO36pfHMNHe
	A5skQFLLw9+KjbHOwA/wsk/bAZIbCGnHfLqE9O0wH/bDCKUnykzec/yDlECPNSucsebIs5rfDrw
	cdQCvOZdYkg==
X-Google-Smtp-Source: AGHT+IEw6XKMxP6OGG6/UxL8ZYVTnYc0oOWD9/Zun/nIQqLzQQC0jnHV/hAcscDTtTLQZIjDi7ns1w==
X-Received: by 2002:a05:6a00:18a7:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-742a97769efmr26725344b3a.3.1747759844656;
        Tue, 20 May 2025 09:50:44 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742b6c3989asm6727984b3a.122.2025.05.20.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:50:44 -0700 (PDT)
Date: Wed, 21 May 2025 01:50:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: bhelgaas@google.com, corbet@lwn.net, manivannan.sadhasivam@linaro.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] PCI: rcar-gen4: Add a document about the firmware
Message-ID: <20250520165042.GA1228552@rocinante>
References: <20250507100947.608875-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507100947.608875-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. So, add a document about the firmware
> how to get.

Applied to controller/rcar-gen4, thank you!

[1/1] PCI: rcar-gen4: Add a document about the firmware
      https://git.kernel.org/pci/pci/c/2bdf6ffe9f66

	Krzysztof

